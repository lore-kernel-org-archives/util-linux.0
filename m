Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756848AbeEJJwT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 10 May 2018 05:52:19 -0400
Date: Thu, 10 May 2018 11:52:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Nikhil <nik2087@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: blkid -> attempt to access beyond end of device if start sector
 is > 128
Message-ID: <20180510095215.fpxoerxvan7hx3ac@ws.net.home>
References: <CALY=dt+aJC0aXm6j4wg-T-RbOKAv-+q7NuzMaH_fwPO3Hdss2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALY=dt+aJC0aXm6j4wg-T-RbOKAv-+q7NuzMaH_fwPO3Hdss2A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 10, 2018 at 09:00:36AM +0000, Nikhil wrote:
> We have i.Mx35 based embedded system running Linux 4.14.  The distribution
> is built using yocto (rocko branch).  Before we moved on to Linux 4.14 we
> used Linux 2.6, distribution was again built using yocto(danny branch).
> After upgrade to rocko and linux 4.14, we see some error messages on the
> console on executing blkid.  These messages appear for the SD card.  Error
> messages appear only if SD Card is mounted and if the start sector for sd
> card is 129 or more,  doesnt appear is start sector is 128 or less.
> 
> Error Message:
> root@ebboard:~# blkid
> [ 8707.475004] attempt to access beyond end of device
> [ 8707.479894] unknown-block(179,0): rw=0, want=1953793, limit=1953792
> [ 8707.488054] Buffer I/O error on dev mmcblk0p1, logical block 244207,
> async page read
> 
> fdisk output:
> root@ebboard:~# fdisk -ul
> 
> Disk /dev/mmcblk0: 1000 MB, 1000341504 bytes
> 4 heads, 16 sectors/track, 30528 cylinders, total 1953792 sectors
> Units = sectors of 1 * 512 = 512 bytes
> 
>          Device Boot      Start         End      Blocks  Id System
> /dev/mmcblk0p1             129     1953791      976831+  6 FAT16
> 
> If anyone has any idea as to why these warnings are printed depending on
> whether the start sector is > 128  would be very much helpful.  Thanks.

Maybe kernel returns incorrect size for the device, or it's blkid bug.

Can you try

    LIBBLKID_DEBUG=all blkid -p -o udev /dev/mmcblk0p1

or for /dev/mmcblk0 (not sure if kernel reports it for whole-disk
probing or for the partition).

util-linux version ? (blkid -V).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
