Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout11.t-online.de ([194.25.134.85]:59580 "EHLO
	mailout11.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935529Ab3DJJqa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 10 Apr 2013 05:46:30 -0400
Date: 10 Apr 2013 11:26:00 +0200
From: Hullen@t-online.de (Helmut Hullen)
To: util-linux@vger.kernel.org
Message-ID: <CUaVkFE9CXB@helmut.hullen.de>
Subject: wipefs and zfs
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: helmut@hullen.de
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hallo, util-linux,

I've just accidently damaged a mix of 3 btrfs disks and 4 zfs disks (no  
big problem - it's my playground).

Running "wipefs" on the btrfs disks seems to work as expected.

But what about "wipefs" for the zfs disks?

        wipefs /dev/sdd1

tells

offset               type
----------------------------------------------------------------
0x65000              zfs_member   [raid]
                     LABEL: zm1
                     UUID:  18067835215330778964

and "wipefs -o 0x65000 /dev/sdd1" seems to run in an endless loop.

Viele Gruesse!
Helmut
