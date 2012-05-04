Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:54238 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754928Ab2EDLf2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 May 2012 07:35:28 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0M3H008FRXJ2LVB0@damascus.uab.es> for
 util-linux@vger.kernel.org; Fri, 04 May 2012 13:35:26 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0M3H00H4JXJ2NKM1@damascus.uab.es>
 forutil-linux@vger.kernel.org; Fri, 04 May 2012 13:35:26 +0200 (CEST)
Date: Fri, 04 May 2012 13:35:32 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH] fdisk: fix segfault on bsd label
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1336131332.17719.1.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Commit 8db8295d824cd0c8cba9385e4635d6e311d69d3f added a regression that causes the program to crash when
touching the partition structure (pte) for BSD/OSF labels. Since DOS has its own initialization function,
allow BSD labels to use it as well.

Steps to reproduce:

$> fdisk bsd.img (obtained from blkid regression test files)
Command (m for help): p
...
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Segmentation fault

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
As discussed, this is a temporary fix, a nicer way of initializing bsd structures will be implemented in the short future. 

 fdisk/fdisk.c         |    2 ++
 fdisk/fdiskdoslabel.c |    2 +-
 fdisk/fdiskdoslabel.h |    1 +
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index acc84d1..dccaf27 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -763,6 +763,8 @@ static int get_boot(int try_only) {
 			return 0;
 
 	if (check_osf_label()) {
+		/* intialize partitions for BSD as well */
+		dos_init();
 		if (!valid_part_table_flag(MBRbuffer)) {
 			disklabel = OSF_LABEL;
 			return 0;
diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index 6a9a044..b91702a 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -54,7 +54,7 @@ static void clear_partition(struct partition *p)
 	set_nr_sects(p,0);
 }
 
-static void dos_init(void)
+void dos_init(void)
 {
 	int i;
 
diff --git a/fdisk/fdiskdoslabel.h b/fdisk/fdiskdoslabel.h
index f5568df..1897b6c 100644
--- a/fdisk/fdiskdoslabel.h
+++ b/fdisk/fdiskdoslabel.h
@@ -48,5 +48,6 @@ extern void dos_set_mbr_id(void);
 extern void dos_delete_partition(int i);
 extern int check_dos_label(void);
 extern int is_dos_partition(int t);
+extern void dos_init(void);
 
 #endif
-- 
1.7.8.3



