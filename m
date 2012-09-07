Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15238 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864Ab2IGMkA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Sep 2012 08:40:00 -0400
Message-ID: <5049EB15.3080309@draigBrady.com>
Date: Fri, 07 Sep 2012 13:39:49 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>,
        Ludwig Nussel <ludwig.nussel@suse.de>
Subject: Re: runuser(1) and su(1) -g/-G
References: <20120904151843.GA6389@x2.net.home> <20120905123822.GZ1899@rampage> <20120905212804.GD1899@rampage> <20120907120716.GD23242@x2.net.home>
In-Reply-To: <20120907120716.GD23242@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09/07/2012 01:07 PM, Karel Zak wrote:
> On Wed, Sep 05, 2012 at 05:28:04PM -0400, Dave Reisner wrote:
>>> I think we're missing out on an opportunity with runuser. su insists on
>>> starting a shell which, among other subtle problems, leads to the
>>> largeer problem of quoting and escaping the command passed to the -c
>>> flag. I think we should do something like this:
>
>   good point
>
>>> - separate out argument parsing to runuser and su
>>> - remove most of the flags from runuser (-f, -c, -l, -, -s), add a -u
>>>    flag (optional, for user)
>>> - create a single common entry point for creating a session
>>> - separate out the run command logic
>
>   well, we still need to initialize the session and it would be also
>   to have independent PAM setting for "login-like-session" (-l - options).
>
>>> With a name like runuser, I would expect that its purpose would be to
>>> simply run commands (and not necessarily get a shell for a user, as is
>>> done with su). runuser could take non-option arguments as argv for the
>>> new command so that we'd have examples like this:
>>>
>>>    runuser -u notroot vi /etc/fstab
>>>    runuser notroot foocmd embedded '"quotes"'
>>>    runuser -u notroot foocmd has args "with spaces" sometimes
>>>
>>> If you still desperately want to abuse the command to create a shell for
>>> a user, then you just do that:
>>>
>>>    runuser -u notroot -- /bin/sh -
>
>   well, but it will NOT use /etc/pam.d/runuser-l
>
>   I agree that -f -s -c are unnecessary (and -c is wrong at all...). It
>   would be probably better to support:
>
>      runuser [-u] notroot [<command>  [arg]]
>
>   and if<command>  is not specified then start a shell, and if -l is
>   specified create a login-like session.
>
>> Hrmm... I had no idea that runuser was an existing command in the RedHat
>> world, which makes my idea of a "mulligan" less feasible. Boo.
>
>   Well, that's question if we (upstream) have to care about one crazy
>   distro specific command. Maybe we can introduce a new command (with a
>   different name) and ignore the original runuser. For good reason the
>   command has not been accepted by coreutils upstream.
>
>   Any suggestion for the new name?
>
>      runuid
>      runid
>      execuser
>
>   I have no problem to revert the runuser patch, really ;-) It was
>   probably too hasty decision to merge whole my su branch.
>
>      Karel
>

I'd not really studied the runuser interface to be honest,
and yes I agree that it's quite crufty.
Maybe we could keep the runuser name and say
the prefered form is to specify -u $USER, which
will _not_ start a shell. The old interface without
-u being retained for backwards compat?

For reference, I'm copying in below some info from the coreutils list
from when we were discussing the transition of su to util-linux,
which references other utils in this space.

==== info from coreutils ===

Note Fedora and Suse use su from coreutils
while debian use their own:
http://pkg-shadow.alioth.debian.org/

Note also Fedora has `runuser` which is based on su:
http://pkgs.fedoraproject.org/gitweb/?p=coreutils.git;a=blob;f=coreutils-8.7-runuser.patch;hb=HEAD

There was also a very related request for
`runuser` like functionality to be generally available:
http://bugs.gnu.org/8700

It's probably worth bringing runuser with su,
no matter where they end up. So with su being removed in favor
of the util-linux implementation, `runuser` is being implemented there too.
I.E. it will be available outside of redhat/fedora/centos/...
in util-linux >= 2.23, and so should address http://bugs.gnu.org/8700
[well maybe not given the above discussion]

Note from previous comments in this thread,
it seems like allowing runser to be built (as an option?)
without requiring PAM, would be useful.

For reference, here are utils with similar functionality:

chid,really
   Mentioned in feature request from debian
     http://bugs.gnu.org/8700

chroot --userspec=U:G --groups=G1,G2,G3 /
   since coreutils v7.4-16-gc45c51f
   beware of CVE-2005-4890

setuidgid
   coreutils internal only
   http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=blob;f=src/setuidgid.c;hb=HEAD

sg from pwdutils
   http://pubs.opengroup.org/onlinepubs/9699919799/utilities/newgrp.html

sudo -u -g

runas from titantools


cheers,
Pádraig.
