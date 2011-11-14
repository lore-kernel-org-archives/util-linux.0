Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39779 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab1KNNsF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Nov 2011 08:48:05 -0500
Received: by eye27 with SMTP id 27so5003936eye.19
        for <util-linux@vger.kernel.org>; Mon, 14 Nov 2011 05:48:03 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 3/3] fdisk: split delete_partition() off from dos_delete_partition()
Date: Mon, 14 Nov 2011 14:47:19 +0100
Message-Id: <1321278439-9392-3-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1321278439-9392-1-git-send-email-cosoleto@gmail.com>
References: <1321278439-9392-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This accidentally fixes a mistake printing the "Partition n is deleted"
message as the 'i' variable get decremented or incremented in case of
logical partitions.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |   36 ++++++++++++++++++++++--------------
 1 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 5b8e24a..d299c4c 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1584,25 +1584,16 @@ toggle_dos_compatibility_flag(void) {
 	update_sector_offset();
 }
 
-static void
-delete_partition(int i) {
+static void dos_delete_partition(int i)
+{
 	struct pte *pe = &ptes[i];
 	struct partition *p = pe->part_table;
 	struct partition *q = pe->ext_pointer;
 
-/* Note that for the fifth partition (i == 4) we don't actually
- * decrement partitions.
- */
-
-	if (warn_geometry())
-		return;		/* C/H/S not set */
-	pe->changed = 1;
+	/* Note that for the fifth partition (i == 4) we don't actually
+	   decrement partitions. */
 
-	if (disklabel == SUN_LABEL)
-		sun_delete_partition(i);
-	else if (disklabel == SGI_LABEL)
-		sgi_delete_partition(i);
-	else if (i < 4) {
+	if (i < 4) {
 		if (IS_EXTENDED (p->sys_ind) && i == ext_index) {
 			partitions = 4;
 			ptes[ext_index].ext_pointer = NULL;
@@ -1646,6 +1637,23 @@ delete_partition(int i) {
 			/* the only logical: clear only */
 			clear_partition(ptes[i].part_table);
 	}
+}
+
+static void
+delete_partition(int i)
+{
+	if (warn_geometry())
+		return;		/* C/H/S not set */
+
+	ptes[i].changed = 1;
+
+	if (disklabel == DOS_LABEL)
+		dos_delete_partition(i);
+	else if (disklabel == SUN_LABEL)
+		sun_delete_partition(i);
+	else if (disklabel == SGI_LABEL)
+		sgi_delete_partition(i);
+
 	printf(_("Partition %d is deleted\n"), i + 1);
 }
 
-- 
1.7.3.4

