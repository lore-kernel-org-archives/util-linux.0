Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47344 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759352Ab1LOTDI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:03:08 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2431824eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:03:07 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 11/13] fdisk: Fix bad invalid flag 0x00000 warning message
Date: Thu, 15 Dec 2011 20:02:47 +0100
Message-Id: <1323975769-21929-11-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This splits check_dos_label() and dos_init() off from get_boot() and gets
rid of the invalid flag 0x00000 warning message due to a check for MBR
signs in zeroized buffer:

	memset(MBRbuffer, 0, 512);

	if (what == create_empty_dos)
		goto got_dos_table;
[...]
got_dos_table:
	if (!valid_part_table_flag(MBRbuffer)) {
[...]
	if (!valid_part_table_flag(pe->sectorbuffer))
		fprintf(stderr, _("Warning: invalid flag 0x%04x of partition "
[...]

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |  161 +++++++++++++++++++++++++++------------------------------
 fdisk/fdisk.h |    2 +-
 2 files changed, 78 insertions(+), 85 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index acf0e67..800ed02 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -288,7 +288,7 @@ unsigned long grain = DEFAULT_SECTOR_SIZE,
 	      alignment_offset;
 int has_topology;
 
-enum labeltype disklabel = DOS_LABEL;	/* Current disklabel */
+enum labeltype disklabel;	/* Current disklabel */
 
 jmp_buf listingbuf;
 
@@ -850,6 +850,30 @@ dos_set_mbr_id(void) {
 	dos_print_mbr_id();
 }
 
+static void dos_init(void)
+{
+	int i;
+
+	disklabel = DOS_LABEL;
+	partitions = 4;
+	ext_index = 0;
+	extended_offset = 0;
+
+	for (i = 0; i < 4; i++) {
+		struct pte *pe = &ptes[i];
+
+		pe->part_table = pt_offset(MBRbuffer, i);
+		pe->ext_pointer = NULL;
+		pe->offset = 0;
+		pe->sectorbuffer = MBRbuffer;
+		pe->changed = 0;
+	}
+
+	warn_geometry();
+	warn_limits();
+	warn_alignment();
+}
+
 static void
 create_doslabel(void) {
 	unsigned int id = get_random_id();
@@ -857,19 +881,17 @@ create_doslabel(void) {
 	fprintf(stderr, _("Building a new DOS disklabel with disk identifier 0x%08x.\n"), id);
 	sun_nolabel();  /* otherwise always recognised as sun */
 	sgi_nolabel();  /* otherwise always recognised as sgi */
-	disklabel = DOS_LABEL;
-	partitions = 4;
 
-	/* Zero out the MBR buffer */
-	extended_offset = 0;
+	dos_init();
+	zeroize_mbr_buffer();
+
 	set_all_unchanged();
 	set_changed(0);
-	get_boot(create_empty_dos);
 
 	/* Generate an MBR ID for this disk */
 	dos_write_mbr_id(MBRbuffer, id);
 
-	/* Mark it bootable (unfortunately required) */
+	/* Put MBR signature */
 	write_part_table_flag(MBRbuffer);
 }
 
@@ -1084,6 +1106,42 @@ void zeroize_mbr_buffer(void)
 		memset(MBRbuffer, 0, MAX_SECTOR_SIZE);
 }
 
+static int check_dos_label(void)
+{
+	int i;
+
+	if (!valid_part_table_flag(MBRbuffer))
+		return 0;
+
+	dos_init();
+
+	for (i = 0; i < 4; i++) {
+		struct pte *pe = &ptes[i];
+
+		if (IS_EXTENDED (pe->part_table->sys_ind)) {
+			if (partitions != 4)
+				fprintf(stderr, _("Ignoring extra extended "
+					"partition %d\n"), i + 1);
+			else
+				read_extended(i);
+		}
+	}
+
+	for (i = 3; i < partitions; i++) {
+		struct pte *pe = &ptes[i];
+
+		if (!valid_part_table_flag(pe->sectorbuffer)) {
+			fprintf(stderr,
+				_("Warning: invalid flag 0x%04x of partition "
+				"table %d will be corrected by w(rite)\n"),
+				part_table_flag(pe->sectorbuffer), i + 1);
+			pe->changed = 1;
+		}
+	}
+
+	return 1;
+}
+
 /*
  * Read MBR.  Returns:
  *   -1: no 0xaa55 flag present (possibly entire disk BSD)
@@ -1092,27 +1150,10 @@ void zeroize_mbr_buffer(void)
  */
 static int
 get_boot(enum action what) {
-	int i;
-
-	partitions = 4;
-	ext_index = 0;
-	extended_offset = 0;
-
-	for (i = 0; i < 4; i++) {
-		struct pte *pe = &ptes[i];
-
-		pe->part_table = pt_offset(MBRbuffer, i);
-		pe->ext_pointer = NULL;
-		pe->offset = 0;
-		pe->sectorbuffer = MBRbuffer;
-		pe->changed = (what == create_empty_dos);
-	}
 
+	disklabel = ANY_LABEL;
 	memset(MBRbuffer, 0, 512);
 
-	if (what == create_empty_dos)
-		goto got_dos_table;		/* skip reading disk */
-
 	if (what != try_only) {
 		if ((fd = open(disk_device, O_RDWR)) < 0) {
 			if ((fd = open(disk_device, O_RDONLY)) < 0)
@@ -1133,17 +1174,9 @@ get_boot(enum action what) {
 
 	update_units();
 
-	if (check_sun_label())
-		return 0;
-
-	if (check_sgi_label())
-		return 0;
-
-	if (check_aix_label())
-		return 0;
-
-	if (check_mac_label())
-		return 0;
+	if (!check_dos_label())
+		if (check_sun_label() || check_sgi_label() || check_aix_label() || check_mac_label())
+			return 0;
 
 	if (check_osf_label()) {
 		if (!valid_part_table_flag(MBRbuffer)) {
@@ -1152,61 +1185,21 @@ get_boot(enum action what) {
 		}
 		printf(_("This disk has both DOS and BSD magic.\n"
 			 "Give the 'b' command to go to BSD mode.\n"));
+		return 0;
 	}
 
-got_dos_table:
+	if (disklabel == ANY_LABEL) {
+		if (what == try_only)
+			return -1;
 
-	if (!valid_part_table_flag(MBRbuffer)) {
-		switch(what) {
-		case fdisk:
-			fprintf(stderr,
-				_("Device contains neither a valid DOS "
-				  "partition table, nor Sun, SGI or OSF "
-				  "disklabel\n"));
+		fprintf(stderr,
+			_("Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel\n"));
 #ifdef __sparc__
-			create_sunlabel();
+		create_sunlabel();
 #else
-			create_doslabel();
+		create_doslabel();
 #endif
-			return 0;
-		case try_only:
-		        return -1;
-		case create_empty_dos:
-			break;
-		default:
-			fprintf(stderr, _("Internal error\n"));
-			exit(1);
-		}
-	}
-
-	for (i = 0; i < 4; i++) {
-		struct pte *pe = &ptes[i];
-
-		if (IS_EXTENDED (pe->part_table->sys_ind)) {
-			if (partitions != 4)
-				fprintf(stderr, _("Ignoring extra extended "
-					"partition %d\n"), i + 1);
-			else
-				read_extended(i);
-		}
-	}
-
-	for (i = 3; i < partitions; i++) {
-		struct pte *pe = &ptes[i];
-
-		if (!valid_part_table_flag(pe->sectorbuffer)) {
-			fprintf(stderr,
-				_("Warning: invalid flag 0x%04x of partition "
-				"table %d will be corrected by w(rite)\n"),
-				part_table_flag(pe->sectorbuffer), i + 1);
-			pe->changed = 1;
-		}
 	}
-
-	warn_geometry();
-	warn_limits();
-	warn_alignment();
-
 	return 0;
 }
 
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 6641880..84be09c 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -54,7 +54,7 @@ enum failure {ioctl_error,
 	unable_to_open, unable_to_read, unable_to_seek,
 	unable_to_write};
 
-enum action {fdisk, try_only, create_empty_dos};
+enum action {fdisk, try_only};
 
 struct geom {
 	unsigned int heads;
-- 
1.7.7

