Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:58049 "EHLO
	homiemail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752500Ab2KNIEy (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Nov 2012 03:04:54 -0500
Message-ID: <1352880292.2577.5.camel@offbook>
Subject: [PATCH 3/3] fdisk: dos: always write mbr
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Wed, 14 Nov 2012 00:04:52 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There's no harm when writing the MBR, changed or not. This also
allows us to get rid of the 'MBRbuffer_changed' global variable.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c         |    9 ++++++---
 fdisks/fdisk.h         |    2 --
 fdisks/fdiskdoslabel.c |   23 ++++++++++-------------
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 7db25af..d79b55a 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -51,8 +51,6 @@
 
 #include "gpt.h"
 
-int MBRbuffer_changed;
-
 #define hex_val(c)	({ \
 				char _c = (c); \
 				isdigit(_c) ? _c - '0' : \
@@ -498,13 +496,18 @@ static int is_partition_table_changed(void)
 
 static void maybe_exit(int rc, int *asked)
 {
+	int i, mbr_changed = 0;
 	char line[LINE_LENGTH];
 
 	putchar('\n');
 	if (asked)
 		*asked = 0;
 
-	if (is_partition_table_changed() || MBRbuffer_changed) {
+	for (i = 0; i < 4; i++)
+		if (ptes[i].changed)
+			mbr_changed = 1;
+
+	if (is_partition_table_changed() || mbr_changed) {
 		fprintf(stderr, _("Do you really want to quit? "));
 
 		if (!fgets(line, LINE_LENGTH, stdin) || rpmatch(line) == 1)
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 53ef6bc..639d7db 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -283,8 +283,6 @@ extern const char * str_units(int);
 
 extern sector_t get_nr_sects(struct partition *p);
 
-extern int MBRbuffer_changed;
-
 /* start_sect and nr_sects are stored little endian on all machines */
 /* moreover, they are not aligned correctly */
 static inline void
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index e813a21..f83b794 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -332,7 +332,6 @@ void dos_set_mbr_id(struct fdisk_context *cxt)
 		return;
 
 	mbr_set_id(cxt->firstsector, new_id);
-	MBRbuffer_changed = 1;
 	dos_print_mbr_id(cxt);
 }
 
@@ -798,20 +797,18 @@ static int write_sector(struct fdisk_context *cxt, sector_t secno,
 
 static int dos_write_disklabel(struct fdisk_context *cxt)
 {
-	int i, rc = 0;
+	int i, rc = 0, mbr_changed = 0;
 
-	/* MBR (primary partitions) */
-	if (!MBRbuffer_changed) {
-		for (i = 0; i < 4; i++)
-			if (ptes[i].changed)
-				MBRbuffer_changed = 1;
-	}
-	if (MBRbuffer_changed) {
+	for (i = 0; i < 4; i++)
+		if (ptes[i].changed)
+			mbr_changed = 1;
+
+	if (mbr_changed)
 		mbr_set_magic(cxt->firstsector);
-		rc = write_sector(cxt, 0, cxt->firstsector);
-		if (rc)
-			goto done;
-	}
+	rc = write_sector(cxt, 0, cxt->firstsector);
+	if (rc)
+		goto done;
+
 	/* EBR (logical partitions) */
 	for (i = 4; i < partitions; i++) {
 		struct pte *pe = &ptes[i];
-- 
1.7.9.5




