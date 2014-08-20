Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:49426 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751258AbaHTTTN (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Aug 2014 15:19:13 -0400
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave04.hostedemail.com (Postfix) with ESMTP id BBD6EB1D34
	for <util-linux@vger.kernel.org>; Wed, 20 Aug 2014 19:12:40 +0000 (UTC)
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6C8D39EA13
	for <util-linux@vger.kernel.org>; Wed, 20 Aug 2014 19:12:04 +0000 (UTC)
Received: from amanda.local.lan (pool-74-109-236-220.pitbpa.fios.verizon.net [74.109.236.220])
	(Authenticated sender: r.bowers@onedingo.com)
	by omf06.hostedemail.com (Postfix) with ESMTPA
	for <util-linux@vger.kernel.org>; Wed, 20 Aug 2014 19:12:03 +0000 (UTC)
Date: Wed, 20 Aug 2014 15:12:02 -0400
From: Robert Bowers <r.bowers@onedingo.com>
To: util-linux@vger.kernel.org
Subject: fdisk interactive 'v' usage does not always work
Message-ID: <20140820151202.79f70dc5@amanda.local.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello.

Using fdisk from util-linux 2.25 is doing what is best shown in an example.

# truncate -s 16M bin
# losetup -f bin
(use this to find where it looped)
# losetup -a
/dev/loop0: [65024]:292804 (/root/bin)
# fdisk /dev/loop0

Welcome to fdisk (util-linux 2.25).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x7235e130.

Command (m for help): v
Remaining 32767 unallocated 512-byte sectors.

Command (m for help): n

(now just accept all the defaults)

Partition type
p primary (0 primary, 0 extended, 4 free)
e extended (container for logical partitions)
Select (default p):

Using default response p.
Partition number (1-4, default 1):
First sector (2048-32767, default 2048):
Last sector, +sectors or +size{K,M,G,T,P} (2048-32767, default 32767):

Created a new partition 1 of type 'Linux' and of size 15 MiB.

Command (m for help): v

Command (m for help):

---

It used to print
Remaining 2047 unallocated 512-byte sectors.
for a layout like this but now prints nothing.
