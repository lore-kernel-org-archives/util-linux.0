Return-Path: util-linux-owner@vger.kernel.org
Received: from forward12h.cmail.yandex.net ([87.250.230.154]:35948 "EHLO
        forward12h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752088AbcKSLGV (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 19 Nov 2016 06:06:21 -0500
Received: from mxback2g.mail.yandex.net (mxback2g.mail.yandex.net [77.88.29.163])
        by forward12h.cmail.yandex.net (Yandex) with ESMTP id F35E121214
        for <util-linux@vger.kernel.org>; Sat, 19 Nov 2016 13:58:30 +0300 (MSK)
From: Constantine Kharlamov <hi-angel@ya.ru>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: sfdisk: -X option doesn't work
MIME-Version: 1.0
Message-Id: <5303721479553110@web15g.yandex.ru>
Date: Sat, 19 Nov 2016 13:58:30 +0300
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I've a disk that been GPT-formatted before, but now there's just MBR:

	$ sudo sfdisk -l /dev/sdc     
	Disk /dev/sdc: 14.9 GiB, 16025444352 bytes, 31299696 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0x79215d34

	Device     Boot Start      End  Sectors  Size Id Type
	/dev/sdc1        2048 31299695 31297648 14.9G 83 Linux

Fine, but magically, both "/dev/disk/by-label/" and lsblk shows names/labels that been there before the disk reformatted into MBR!

	$ sudo lsblk -o name,mountpoint,label,size,uuid /dev/sdc
	NAME   MOUNTPOINT LABEL               SIZE UUID
	sdc               Ubuntu 15.10 amd64 14.9G 2015-10-21-16-17-40-00
	└─sdc1            Ubuntu 15.10 amd64 14.9G 502229b0-6d02-46ee-8fd1-b3321f11e53f

It causes errors with grub-install like "Attempting to install GRUB to a disk with multiple partition labels.  This is not supported yet..". So I want to just remove those names. But "sgdisk" sees that GPT table is invalid, and tries to reconstruct it from MBR, whilst I'd need to force it into thinking like it is valid, so that it see the damn names.

Thankfully, there's sfdisk with -X option:

	$ sudo sfdisk -lX gpt /dev/sdc 
	Disk /dev/sdc: 14.9 GiB, 16025444352 bytes, 31299696 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0x79215d34

	Device     Boot Start      End  Sectors  Size Id Type
	/dev/sdc1        2048 31299695 31297648 14.9G 83 Linux

It worked… Or not? "Disklabel" says "dos", and most importantly, I see no partition names.

Turns out, sfdisk would print the same information for pretty much anything, i.e. even for "sfdisk -X foo", so the option just doesn't work.
