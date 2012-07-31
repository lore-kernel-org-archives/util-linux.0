Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:49645 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab2GaFw5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 31 Jul 2012 01:52:57 -0400
Message-ID: <501772B7.2040504@bernhard-voelker.de>
Date: Tue, 31 Jul 2012 07:52:55 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: tests: blkid/md-raid1-part fails
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The above mentioned test fails here (OpenSuSE-12.1 64-bit).

That's in diff/blkid/md-raid1-part:

--- /media/sdb5/berny/git/util-linux/tests/expected/blkid/md-raid1-part	2012-07-27 09:54:03.769967754 +0200
+++ /media/sdb5/berny/git/util-linux/tests/output/blkid/md-raid1-part	2012-07-31 07:18:24.057815522 +0200
@@ -44,7 +44,7 @@


 ID_FS_VERSION=0.90.0
-ID_PART_ENTRY_DISK=8:16
+ID_PART_ENTRY_DISK=8:112
 ID_PART_ENTRY_NUMBER=1
 ID_PART_ENTRY_OFFSET=2048
 ID_PART_ENTRY_SCHEME=dos
@@ -56,7 +56,7 @@


 ID_FS_VERSION=0.90.0
-ID_PART_ENTRY_DISK=8:16
+ID_PART_ENTRY_DISK=8:112
 ID_PART_ENTRY_NUMBER=2
 ID_PART_ENTRY_OFFSET=53248
 ID_PART_ENTRY_SCHEME=dos

What's wrong with that minor number?

Have a nice day,
Berny
