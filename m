Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36822 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdCJRw3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 10 Mar 2017 12:52:29 -0500
Received: by mail-qk0-f180.google.com with SMTP id 1so178477935qkl.3
        for <util-linux@vger.kernel.org>; Fri, 10 Mar 2017 09:52:28 -0800 (PST)
Received: from gmail.com (housegordon.org. [104.236.108.240])
        by smtp.gmail.com with ESMTPSA id t30sm6779244qtt.56.2017.03.10.09.52.26
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Mar 2017 09:52:26 -0800 (PST)
Date: Fri, 10 Mar 2017 17:51:57 +0000
From: Assaf Gordon <assafgordon@gmail.com>
To: util-linux@vger.kernel.org
Subject: correct usage of unshare+nsenter for persistent namespaces?
Message-ID: <20170310175156.GB21783@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel and all,

I'd like to ask you advice regarding proper usage of unshare+nsenter
to create persistent containers. I understand unshare(1) is rather 
low-level, but it would like to still be able to understand how to use 
it.

Apologise in advance for the long email, but I hope it will
result in better documentation (or at least better understanding for 
me).

There are many bits and pieces of information
around (man pages and blogs and stack-overflow, etc.),
but I haven't been able to find an authoritative example
of using it to create a contained re-entrant persistent environment.
(If I missed it, please do point me to it).





Step 1: preparations
--------------------

All my testing was done stock Debian 8.7,
with kernel 3.16.39-1+deb8u1,
and util-linux 2.29.2 compiled from source.
All commands run as 'root'.

Extrapolating from unshare's man page about creating
a persistent environment:

    basedir=/var/namespaces/ns1
    mkdir -p $basedir
    mount --bind $basedir $basedir
    mount --make-private $basedir
    for i in uts mnt pid net ipc user ;
    do
     touch $basedir/$i
    done

Are these correct?



Step 2: creating shared namespace
---------------------------------

(for now, I'm ignoring user-namespace, as it brings
its own complications.)

Starting a new environment using the following:

    unshare --uts=$basedir/uts \
            --mount=$basedir/mnt \
            --ipc=$basedir/ipc \
            --pid=$basedir/pid \
            --net=$basedir/net \
            --mount-proc \
            --fork \
            sh -c 'hostname foobar ; exec /bin/bash -il'

And indeed I get a prompt inside the container:

    root@foobar# ps ax
    PID TTY      STAT   TIME COMMAND
     1 pts/2    S      0:00 /bin/bash -il
     8 pts/2    R+     0:00 ps ax


    root@foobar# ifconfig -a
    lo        Link encap:Local Loopback
              LOOPBACK  MTU:65536  Metric:1
              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:0 
              RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)



On the outside host, I see the mounts and the namespaces:

    # findmnt -O TARGET
    [...]
    └─/var/namespaces/ns1
     ├─/var/namespaces/ns1/ipc
     ├─/var/namespaces/ns1/uts
     ├─/var/namespaces/ns1/net
     ├─/var/namespaces/ns1/pid
     └─/var/namespaces/ns1/mnt

    # lsns
    NS        TYPE  NPROCS   PID USER     COMMAND
    [...]
    4026532329 mnt        2 19221 root     unshare --uts=..
    4026532330 uts        2 19221 root     unshare --uts=..
    4026532331 ipc        2 19221 root     unshare --uts=..
    4026532332 pid        1 19223 root     /bin/bash -il
    4026532334 net        2 19221 root     unshare --uts=..


Step 3: Re-entering
-------------------

Trying to enter based on PID works:

    # nsenter -t 19223 -m -u -i -n -p \
          sh -c 'hostname ; echo ; ps ax ; echo ; ifconfig -a'
    foobar

      PID TTY      STAT   TIME COMMAND
        1 pts/2    S+     0:00 /bin/bash -il
       15 pts/1    S+     0:00 sh -c hostname ; ps ax
       17 pts/1    R+     0:00 ps ax

    lo        Link encap:Local Loopback
          LOOPBACK  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)


However trying to enter by the persistent mounts does not
re-enter the pid/net namespace:

    # nsenter --uts=$basedir/uts \
              --mount=$basedir/mnt \
              --ipc=$basedir/ipc \
              --pid=$basedir/pid \
              --net=$basedir/net \
              sh -c 'hostname ; echo ; ps ax ; echo ; ifconfig -a'
    foobar

    Error, do this: mount -t proc proc /proc

    Warning: cannot open /proc/net/dev (No such file or directory).
    Limited output.

Listing /proc inside the container shows it only lists PID 1
(the running '/bin/bash' from the original 'unshare' invocation).

Based on naive reading of unshare(1) man page (with the example of 
persistent UTS at the bottom), I assumed the above two examples with 
PID and with persistent mount points should be equivalent.

Is this a kernel limitation ?



Step 4: PID namespace is never persistent?
------------------------------------------

IIUC, this is a kernel limitation:
If the program which is PID1 inside the container
terminates, there is no way to re-enter the PID namespace
(http://man7.org/linux/man-pages/man7/pid_namespaces.7.html).

Is that correct?

If so, perhaps it would be helpful to add a caveat in the
unshare/nsenter man pages, saying the PID namespace will
not persist if the process termintes?

And if this is the case, would the following
work to create a re-entrant persistent namespace:

    unshare --uts=$basedir/uts \
            --mount=$basedir/mnt \
            --ipc=$basedir/ipc \
            --pid=$basedir/pid \
            --net=$basedir/net \
            --mount-proc \
            --fork \
            sleep inf

Obviosuly sleep(1) is not a good PID1, but is it conceptually correct
way to ensure the PID namespace is persistent?

There are already some examples of minimal 'init' for containers:
  https://github.com/Yelp/dumb-init
  https://github.com/krallin/tini
  and most minimal: https://gist.github.com/rofl0r/6168719 

I wonder if you will be willing to consider a patch to add
something like 'unshare --do-nothing-init' which
will simply create a process that does nothing except handling signals
and never terminates, to facilitate truly persistent namespaces with 
unshare(1) ? (if so I'm happy to try and write it).


Thank you for reaing so far.
regards,
 - assaf

P.S.
I have more questions about proper usage of user-namespace and 
switch_root/pivot_root, but I'll save them for later :)


P.P.S.

The download URL in the 2.92.2 announcement was http://ftp.kernel.org/
and it seems broken:
  $ host ftp.kernel.org
  Host ftp.kernel.org not found: 3(NXDOMAIN)
The working URL seems like 'www.kernel.org' (www. instead of ftp.):
  https://www.kernel.org/pub/linux/utils/util-linux/

