Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-it0-f47.google.com ([209.85.214.47]:36246 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756774AbeEJJAs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 May 2018 05:00:48 -0400
Received: by mail-it0-f47.google.com with SMTP id e20-v6so2274233itc.1
        for <util-linux@vger.kernel.org>; Thu, 10 May 2018 02:00:48 -0700 (PDT)
MIME-Version: 1.0
From: Nikhil <nik2087@gmail.com>
Date: Thu, 10 May 2018 09:00:36 +0000
Message-ID: <CALY=dt+aJC0aXm6j4wg-T-RbOKAv-+q7NuzMaH_fwPO3Hdss2A@mail.gmail.com>
Subject: blkid -> attempt to access beyond end of device if start sector is > 128
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi

We have i.Mx35 based embedded system running Linux 4.14.  The distribution
is built using yocto (rocko branch).  Before we moved on to Linux 4.14 we
used Linux 2.6, distribution was again built using yocto(danny branch).
After upgrade to rocko and linux 4.14, we see some error messages on the
console on executing blkid.  These messages appear for the SD card.  Error
messages appear only if SD Card is mounted and if the start sector for sd
card is 129 or more,  doesnt appear is start sector is 128 or less.

Error Message:
root@ebboard:~# blkid
[ 8707.475004] attempt to access beyond end of device
[ 8707.479894] unknown-block(179,0): rw=0, want=1953793, limit=1953792
[ 8707.488054] Buffer I/O error on dev mmcblk0p1, logical block 244207,
async page read

fdisk output:
root@ebboard:~# fdisk -ul

Disk /dev/mmcblk0: 1000 MB, 1000341504 bytes
4 heads, 16 sectors/track, 30528 cylinders, total 1953792 sectors
Units = sectors of 1 * 512 = 512 bytes

         Device Boot      Start         End      Blocks  Id System
/dev/mmcblk0p1             129     1953791      976831+  6 FAT16

If anyone has any idea as to why these warnings are printed depending on
whether the start sector is > 128  would be very much helpful.  Thanks.

Regards
Nikhil
