Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:39666 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbbKPXmH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Nov 2015 18:42:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1ZyTPO-0008JZ-Uy
	for util-linux@vger.kernel.org; Tue, 17 Nov 2015 00:42:03 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 17 Nov 2015 00:42:02 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 17 Nov 2015 00:42:02 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: user namespaces: user mapping
Date: Tue, 17 Nov 2015 00:41:56 +0100
Message-ID: <n2dpk4$p47$1@ger.gmane.org>
References: <n2besp$j56$1@ger.gmane.org> <20151116041931.GC5949@vapier.lan>
 <n2ctjg$1d0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <n2ctjg$1d0$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

U.Mutlu wrote on 11/16/2015 04:43 PM:
> Mike Frysinger wrote on 11/16/2015 05:19 AM:
>> On 16 Nov 2015 03:26, U.Mutlu wrote:
>>
>>> The other solution via user namespace is IMHO overkill and in my case
>>> impractical and irritating because user gets a root-prompt (#)
>>> eventhough it is only inside the user namespace.
>>
>> so remap it to your own user instead of to root
>
> Sorry, I forgot the dangers of mounting into existing mount namespace.
> Yes, user namespace seems to be the way to go, so I tried the sample from
> man user_namespaces:
>
> $ ./userns_child_exec -v -p -m -U -z bash
> ./userns_child_exec: PID of child created by clone() is 2950
> ERROR: write /proc/2950/gid_map: Operation not permitted
> About to exec bash
>
> Am I on the right track with the above method for user remapping?
>
> It's maybe that under Debian another sysctl-setting is needed
> for this to work, I'll need to do some research on the net.
> If someone here knows the solution let me know pls.

I did some research on the net, and the findings are:
  - user namespaces have their own security holes
  - a workaround exists, but then a new problem happens: loop devices cannot 
be accessed

Here's the output of a modified (fixed) version of the above pgm,
but mount still not working, even with root-prompt inside the namespace:

$ ./userns_child_exec -v -m -U -z bash
uid=1003 gid=1006 pid=7728
./userns_child_exec: PID of child created by clone() is 7729
uid=1003 gid=1006 pid=7729
map_file=/proc/7729/setgroups map_val=deny
map_file=/proc/7729/uid_map map_val=0 1003 1
map_file=/proc/7729/gid_map map_val=0 1006 1
About to exec bash

# mount -o loop ../mount-test/theFile.img mnt
mount: /home/user/tmp/test/mount-test/theFile.img: failed to setup loop 
device: Permission denied

# ls -l /dev/loop*
brw-rw---- 1 nobody nogroup  7,   0 Nov 16 20:01 /dev/loop0
brw-rw---- 1 nobody nogroup  7,   1 Nov 16 20:14 /dev/loop1
brw-rw---- 1 nobody nogroup  7,   2 Nov 16 15:29 /dev/loop2
brw-rw---- 1 nobody nogroup  7,   3 Nov 16 15:29 /dev/loop3
brw-rw---- 1 nobody nogroup  7,   4 Nov 16 15:29 /dev/loop4
brw-rw---- 1 nobody nogroup  7,   5 Nov 16 15:29 /dev/loop5
brw-rw---- 1 nobody nogroup  7,   6 Nov 16 15:29 /dev/loop6
brw-rw---- 1 nobody nogroup  7,   7 Nov 16 15:29 /dev/loop7
crw-rw---- 1 nobody nogroup 10, 237 Nov 16 15:29 /dev/loop-control

Does the user need to create his own loop device(s)?

Hmm. it looks like there is (currently?) a big mess with user namespaces:
https://code.google.com/p/chromium/issues/detail?id=457362


