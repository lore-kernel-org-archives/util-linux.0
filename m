Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34180 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbbDCKGt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 3 Apr 2015 06:06:49 -0400
Date: Fri, 3 Apr 2015 12:06:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Alex Deymo <deymo@chromium.org>
Cc: util-linux@vger.kernel.org
Subject: Re: umount --detach-loop fails but fs is unmounted
Message-ID: <20150403100647.GC3923@ws.net.home>
References: <CAGd9gwi86agrHS3HgFixjZGD3bYjoFabai3G856qw9Rwfo7W-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAGd9gwi86agrHS3HgFixjZGD3bYjoFabai3G856qw9Rwfo7W-A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 27, 2015 at 12:03:26PM -0700, Alex Deymo wrote:
> I'm running into a problem when using -d in umount. I'm using
> util-linux 2.25.1, but didn't see changes in that code in ToT. When
> calling "umount -d" if the passed argument is *not* a loop device (for
> example /dev/loopX or /mnt/foo/bar), it will umount it, but the
> command will fail (return != 0) and print EINVAL error (22).
> Documentation says:
> 
>   -d, --detach-loop
>     When the unmounted device was a loop device, also free this loop device.
> 
> So the command shouldn't fail if you didn't pass a loop device but
> still used -d; right? Is this a problem in the documentation or the
> code?
> 
> * Examples: if you mount your ${image} (an ext4 fs, but whatever) in
> ${mount_point} this way:
> 
>   loop_device=$(sudo losetup --find --show ${image})
>   sudo mount -o rw ${loop_device} ${mount_point}
> 
> 
> The following command fails (error code 1) and does NOT remove the
> loop device, but unmounts the fs properly:
>   sudo umount -d ${mount_point}
> umount: ${mount_point}: filesystem was unmounted, but mount(8) failed:
> Invalid argument

I'm not able to reproduce this problem.

        # rpm -q util-linux
        util-linux-2.25.2-2.fc21.x86_64

        # losetup --find --show /home/archive/fs-images/filesystems/ext2.img
        /dev/loop0

        # mount /dev/loop0 /mnt/test

        # losetup 
        NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE
        /dev/loop0         0      0         0  0 /home/archive/fs-images/filesystems/ext2.img

        # findmnt /mnt/test
        TARGET    SOURCE     FSTYPE OPTIONS
        /mnt/test /dev/loop0 ext3   rw,relatime,seclabel,data=ordered

        # umount -d /mnt/test
        # echo $?
        0

Please, try

   LIBMOUNT_DEBUG=0xffff umount -d ${mount_point}

or/and strace output would be also nice.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
