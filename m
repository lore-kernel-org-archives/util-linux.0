Return-Path: util-linux-owner@vger.kernel.org
Received: from host-254-7-12-185.cloudsigma.com ([185.12.7.254]:36609 "EHLO
	kathu.ole32.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab3IXQob (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Sep 2013 12:44:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by kathu.ole32.com (Postfix) with ESMTP id BB03F206DF
	for <util-linux@vger.kernel.org>; Tue, 24 Sep 2013 18:22:12 +0200 (CEST)
Received: from kathu.ole32.com ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j-LeLr5QOMVD for <util-linux@vger.kernel.org>;
	Tue, 24 Sep 2013 18:22:11 +0200 (CEST)
Received: from [192.168.0.40] (kamala [217.162.47.94])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by kathu.ole32.com (Postfix) with ESMTPSA id 7FCD42043E
	for <util-linux@vger.kernel.org>; Tue, 24 Sep 2013 18:22:10 +0200 (CEST)
Message-ID: <5241BC33.8050700@breezl.com>
Date: Tue, 24 Sep 2013 18:22:11 +0200
From: butter@breezl.com
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: losetup -d does not move partition devices
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all

On Ubuntu Desktop 13.04 64bit the loop device partitions do not automatically
get deleted when you call "losetup -d DEVICE". This causes other programs
(like lvmdiskscan -l) to report Input/output errors.

Here is how to reproduce the problem:

	LOOPDEV=/dev/loop3
	IMAGEFILE=`pwd`/mydisk.img
	MOUNTPOINT=`pwd`/mnt

	# 1. Create and mount an ext4 partition from a file-based disk image
	dd if=/dev/zero of=$IMAGEFILE bs=1M count=80
	sudo losetup $LOOPDEV $IMAGEFILE
	sudo parted $LOOPDEV mklabel msdos
	sudo parted $LOOPDEV mkpart primary 2048s    43007s
	sudo mkfs -t ext4 ${LOOPDEV}p1
	mkdir $MOUNTPOINT
	sudo mount ${LOOPDEV}p1 $MOUNTPOINT

	# 2. Unmount again => ERROR: the partition device files are not deleted
	sudo umount $MOUNTPOINT
	sudo losetup -d $LOOPDEV
	rmdir $MOUNTPOINT
	rm $IMAGEFILE
	ls -l ${LOOPDEV}*

The last command shows:

	/tmp/test[10:18]% ls -l ${LOOPDEV}*
	brw-rw---- 1 root disk   7, 3 Sep 24 18:18 /dev/loop3
	brw-rw---- 1 root disk 259, 0 Sep 24 18:17 /dev/loop3p1

As no device is connected there is no partition 1! Isn't this a bug?

Regards
BB.
