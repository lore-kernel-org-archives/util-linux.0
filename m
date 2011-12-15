Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48629 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759351Ab1LOTDJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:03:09 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2431841eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:03:08 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 12/13] fdisk: improve some messages
Date: Thu, 15 Dec 2011 20:02:48 +0100
Message-Id: <1323975769-21929-12-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c         |    2 +-
 fdisk/fdisksgilabel.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 800ed02..c41da7a 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1193,7 +1193,7 @@ get_boot(enum action what) {
 			return -1;
 
 		fprintf(stderr,
-			_("Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel\n"));
+			_("Device does not contain a recognized partition table\n"));
 #ifdef __sparc__
 		create_sunlabel();
 #else
diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index b432b13..dd3efd0 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -452,7 +452,7 @@ verify_sgi(int verbose)
 		lastblock = sgi_get_num_sectors(Index[0]);
 	} else {
 		if (verbose)
-			printf(_("One Partition (#11) should cover the entire disk.\n"));
+			printf(_("Partition 11 should cover the entire disk.\n"));
 		if (debug>2)
 			printf("sysid=%d\tpartition=%d\n",
 			       sgi_get_sysid(Index[0]), Index[0]+1);
@@ -570,7 +570,7 @@ sgi_set_partition(int i, unsigned int start, unsigned int length, int sys) {
 	sgilabel->partitions[i].start_sector = SSWAP32(start);
 	set_changed(i);
 	if (sgi_gaps() < 0)	/* rebuild freelist */
-		printf(_("Do You know, You got a partition overlap on the disk?\n"));
+		printf(_("Partition overlap on the disk.\n"));
 	if (length)
 		print_partition_size(i + 1, start, start + length, sys);
 }
-- 
1.7.7

