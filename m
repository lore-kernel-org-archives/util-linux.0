Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57199 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932937Ab1EaX2s convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 31 May 2011 19:28:48 -0400
Received: by vxi39 with SMTP id 39so3695182vxi.19
        for <util-linux@vger.kernel.org>; Tue, 31 May 2011 16:28:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110531111003.GB25562@nb.net.home>
References: <20110405123650.GW22289@paradies.suse.de>
	<BANLkTin=pcsJ-b2y=GN3BpXsx8p+zgnJWA@mail.gmail.com>
	<4DE4B565.6040504@draigBrady.com>
	<20110531111003.GB25562@nb.net.home>
Date: Wed, 1 Jun 2011 00:28:46 +0100
Message-ID: <BANLkTimyv2MLLb7iJbxa9U+=jFAgg3mSrA@mail.gmail.com>
Subject: Re: Using /proc/mounts in mountlist.c for linux
From: James Youngman <jay@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigbrady.com>,
        Philipp Thomas <pth@suse.de>, bug-gnulib@gnu.org,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

2011/5/31 Karel Zak <kzak@redhat.com>:
> On Tue, May 31, 2011 at 10:31:17AM +0100, Pádraig Brady wrote:
>> On 31/05/11 01:14, James Youngman wrote:
>> > On Tue, Apr 5, 2011 at 1:36 PM, Philipp Thomas <pth@suse.de> wrote:
>> >> GNU find will not recognize file systems of type autofs on newer Linux
>> >> kernels as autofs entries are only listed in /proc/mounts and mountlist.c
>> >> includes glibc mntent.h which takes the _PATH_MOUNTED from paths.h and that
>> >> is /etc/mtab.
>> >>
>> >> After a longer discussion, we (SUSE) chose to patch mountlist.c in findutils
>> >> to use proc/mounts instead of /etc/mtab which fixed ou problem.
>> >>
>> >> Would gnulib accept the attached patch to mountlist.c?
>> >
>> > I don't know if this patch was accepted, but it shouldn't be.   The
>> > problem is that /proc/mounts has incomplete data for /.   This will
>> > break gnulib's mountlist, at least with the current form of the patch,
>> > because mountlist will have an incorrect idea of the type of the root
>> > filesystem.   Here's an example showing the problem:
>> >
>> > ~$ cat tryit.sh
>> > #! /bin/sh
>> > f() {
>> >     echo "$1"
>> >     ( ls -l /etc/mtab; find / -maxdepth 0 -printf '%p %F\n' ) |
>> >     sed -e 's_^_    _'
>> > }
>> >
>> > set -e
>> > cd /etc
>> > f "regular /etc/mtab"
>> >
>> > mv mtab mtab.old; ln -s ../proc/mounts mtab
>> > f "with /proc/mounts"
>> > rm mtab; mv mtab.old mtab
>> > ~$ sudo sh tryit.sh
>> > regular /etc/mtab
>> >     -rw-r--r-- 1 root root 1869 May 30 23:53 /etc/mtab
>> >     / ext3
>> > with /proc/mounts
>> >     lrwxrwxrwx 1 root root 14 May 31 01:12 /etc/mtab -> ../proc/mounts
>> >     / rootfs
>
>
>  That's strange, why for "/" it does not search in the file (mtab) in reverse
>  order?
>
> example A)
>
>         # mount -t ext3 /dev/sda6 /mnt/test
>         # mount -t ext4 /dev/mapper/kzak-home /mnt/test
>
>  ... so I have two entries for the same mountpoint:
>
>         # grep /mnt/test /proc/mounts
>         /dev/sda6 /mnt/test ext3  rw,relatime,errors=continue,barrier=0,data=ordered 0 0
>         /dev/mapper/kzak-home /mnt/test ext4 rw,relatime,barrier=1,data=ordered 0 0
>
>
>  this is correct (ext4 is the second entry):
>
>         # find /mnt/test -maxdepth 0 -printf '%p %F\n'
>         /mnt/test ext4
>
>
> example B)
>
>  the same thing with root FS:
>
>         # grep -E '(/dev/sda4|rootfs)' /proc/mounts
>         rootfs / rootfs rw 0 0
>         /dev/sda4 / ext3  rw,noatime,errors=continue,user_xattr,acl,barrier=0,data=ordered 0 0
>
>  ... so I have two entries for the same mountpoint:
>
>
>         # find / -maxdepth 0 -printf '%p %F\n'
>         / rootfs
>
>  why does it return the first entry? It seems like obvious bug. You
>  have to read entries in the mtab file in reverse order.

I find this claim most surprising, since getmntent is intended for use
on both /etc/mtab and /etc/fstab and it reads them forwards.   As a
system administrator, I would consider it a bug for there to be a
duplicate entry in /etc/mtab, and if as a sysadmin I had actually
somehow put two similar entries into /etc/fstab, I'd expect mount(8)
to use the first match (and mount -a to use all matches).

>  Anyway, /proc/self/mountinfo is definitely more sexy... :-)
>
>    Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>
