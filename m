Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49007 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755204AbbBOUkY (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Feb 2015 15:40:24 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 7E13E20856
	for <util-linux@vger.kernel.org>; Sun, 15 Feb 2015 15:40:23 -0500 (EST)
Message-Id: <1424032823.1090725.227824713.20C2D28B@webmail.messagingengine.com>
From: grantksupport@operamail.com
To: util-linux@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain
Subject: blikid reports gdisk-created Bios Boot Partition, created with NO fs,
 has fs TYPE=ext4. Bug/why?
Date: Sun, 15 Feb 2015 12:40:23 -0800
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I'd originally posted this to linux-ext4, got redirected here ...

I create a GPT Bios Boot Partition on a clean disk

	sgdisk -z /dev/sdc
	sgdisk -o /dev/sdc
	sgdisk -n 1:2048:+1M    -t 1:ef02  -c 1:"BIOS Boot"           /dev/sdc

IIUC, at this point, the partition should exist with NO filesystem.

But, if I check with blkid

	blkid /dev/sdc1
		/dev/sdc1: LABEL="RAID_BOOT" UUID="8a828baa-f315-4456-88d2-ff14849eb705" TYPE="ext4" PARTLABEL="BIOS Boot" PARTUUID="2b3b10b1-a458-481e-872c-bada7d244b13" 

Note that it IDs the filesystem type as

	TYPE="ext4"

Why?

Bios Boot Partition should have NO filesystem.

Is blkid correct?  Is there, or isn't there a fs on that partition?

if there isn't, what's causint the 'false' report?

If there IS, how do I make sure there isn't?

grant
