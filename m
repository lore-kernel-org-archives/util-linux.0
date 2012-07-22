Return-Path: dave@gnu.org
Subject: [PATCH 05/10] fdisk: API: add write to label operations
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Jul 2012 19:05:10 +0200
Message-ID: <1342976710.2863.15.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Note that sun labels are no longer checked to see if there were changes.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c         |   23 +++++------------------
 fdisks/fdisk.h         |   10 +++-------
 fdisks/fdiskaixlabel.c |    1 +
 fdisks/fdiskbsdlabel.c |   30 ++++++++++++++++--------------
 fdisks/fdiskdoslabel.c |   24 ++++++++++++++++++++----
 fdisks/fdiskdoslabel.h |    1 -
 fdisks/fdiskmaclabel.c |    1 +
 fdisks/fdisksgilabel.c |   15 +++++++++------
 fdisks/fdisksgilabel.h |    1 -
 fdisks/fdisksunlabel.c |    9 ++++++---
 fdisks/fdisksunlabel.h |    1 -
 fdisks/utils.c         |   13 +++++++++++++
 12 files changed, 74 insertions(+), 55 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 27002f6..7212840 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -1458,24 +1458,11 @@ static void new_partition(struct fdisk_context *cxt)
 	dos_new_partition(cxt);
 }
 
-static void
-write_table(struct fdisk_context *cxt) {
-	int i;
-
-	if (disklabel == DOS_LABEL)
-		dos_write_table(cxt);
-	else if (disklabel == SGI_LABEL)
-		/* no test on change? the printf below might be mistaken */
-		sgi_write_table(cxt);
-	else if (disklabel == SUN_LABEL) {
-		int needw = 0;
-
-		for (i=0; i<8; i++)
-			if (ptes[i].changed)
-				needw = 1;
-		if (needw)
-			sun_write_table(cxt);
-	}
+static void write_table(struct fdisk_context *cxt)
+{
+	int errcode = fdisk_label_write_table(cxt);
+	if (errcode)
+		fdisk_error_fatal(cxt, errcode);
 
 	printf(_("The partition table has been altered!\n\n"));
 	reread_partition_table(cxt, 1);
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 816e127..577303b 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -145,6 +145,8 @@ struct fdisk_label {
 
 	/* probe disk label */
 	int (*probe)(struct fdisk_context *cxt);
+	/* write in-memory changes to disk */
+	int (*write)(struct fdisk_context *cxt);
 	/* delete partition */
 	void (*part_delete)(struct fdisk_context *cxt, int partnum);
 };
@@ -169,6 +171,7 @@ extern const char *fdisk_error_name(enum fdisk_error errcode);
 extern void fdisk_error_fatal(struct fdisk_context *cxt, enum fdisk_error errcode);
 extern int fdisk_label_change(struct fdisk_context *cxt, const char *name);
 extern int fdisk_label_partition_delete(struct fdisk_context *cxt, int partnum);
+extern int fdisk_label_write_table(struct fdisk_context *cxt);
 
 /* prototypes for fdisk.c */
 extern char *disk_device, *line_ptr;
@@ -273,13 +276,6 @@ static inline void read_sector(struct fdisk_context *cxt, sector_t secno, unsign
 		fdisk_error_fatal(cxt, FDISK_ERROR_READ);
 }
 
-static inline void write_sector(struct fdisk_context *cxt, sector_t secno, unsigned char *buf)
-{
-	seek_sector(cxt, secno);
-	if (write(cxt->dev_fd, buf, cxt->sector_size) != (ssize_t) cxt->sector_size)
-		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
-}
-
 static inline sector_t get_start_sect(struct partition *p)
 {
 	return read4_little_endian(p->start4);
diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
index 45f3aa9..d264027 100644
--- a/fdisks/fdiskaixlabel.c
+++ b/fdisks/fdiskaixlabel.c
@@ -69,5 +69,6 @@ const struct fdisk_label aix_label =
 {
 	.name = "aix",
 	.probe = aix_probe_label,
+	.write = NULL,
 	.part_delete = NULL,
 };
diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
index c7f3f86..b827a5b 100644
--- a/fdisks/fdiskbsdlabel.c
+++ b/fdisks/fdiskbsdlabel.c
@@ -63,7 +63,6 @@
 
 static void xbsd_delete_part (struct fdisk_context *cxt, int partnum);
 static void xbsd_new_part (struct fdisk_context *cxt);
-static void xbsd_write_disklabel (struct fdisk_context *cxt);
 static int xbsd_create_disklabel (struct fdisk_context *cxt);
 static void xbsd_edit_disklabel (void);
 static void xbsd_write_bootstrap (struct fdisk_context *cxt);
@@ -140,6 +139,21 @@ is_bsd_partition_type(int type) {
 }
 #endif
 
+static int xbsd_write_disklabel (struct fdisk_context *cxt)
+{
+#if defined (__alpha__)
+	printf (_("Writing disklabel to %s.\n"), cxt->dev_path);
+	xbsd_writelabel (cxt, NULL, &xbsd_dlabel);
+#else
+	printf (_("Writing disklabel to %s.\n"),
+		partname(cxt->dev_path, xbsd_part_index+1, 0));
+	xbsd_writelabel (cxt, xbsd_part, &xbsd_dlabel);
+#endif
+	reread_partition_table(cxt, 0);	/* no exit yet */
+
+	return 0;
+}
+
 void
 bsd_command_prompt (struct fdisk_context *cxt)
 {
@@ -376,19 +390,6 @@ xbsd_print_disklabel (struct fdisk_context *cxt, int show_all) {
   }
 }
 
-static void
-xbsd_write_disklabel (struct fdisk_context *cxt) {
-#if defined (__alpha__)
-	printf (_("Writing disklabel to %s.\n"), cxt->dev_path);
-	xbsd_writelabel (cxt, NULL, &xbsd_dlabel);
-#else
-	printf (_("Writing disklabel to %s.\n"),
-		partname(cxt->dev_path, xbsd_part_index+1, 0));
-	xbsd_writelabel (cxt, xbsd_part, &xbsd_dlabel);
-#endif
-	reread_partition_table(cxt, 0);	/* no exit yet */
-}
-
 static int
 xbsd_create_disklabel (struct fdisk_context *cxt) {
 	char c;
@@ -846,5 +847,6 @@ const struct fdisk_label bsd_label =
 {
 	.name = "bsd",
 	.probe = osf_probe_label,
+	.write = xbsd_write_disklabel,
 	.part_delete = xbsd_delete_part,
 };
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index e32088e..65609c5 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -657,9 +657,18 @@ void dos_new_partition(struct fdisk_context *cxt)
 	}
 }
 
-void dos_write_table(struct fdisk_context *cxt)
+static int write_sector(struct fdisk_context *cxt, sector_t secno,
+			       unsigned char *buf)
 {
-	int i;
+	seek_sector(cxt, secno);
+	if (write(cxt->dev_fd, buf, cxt->sector_size) != (ssize_t) cxt->sector_size)
+		return FDISK_ERROR_WRITE;
+	return 0;
+}
+
+static int dos_write_table(struct fdisk_context *cxt)
+{
+	int i, rc = 0;
 
 	/* MBR (primary partitions) */
 	if (!MBRbuffer_changed) {
@@ -669,7 +678,9 @@ void dos_write_table(struct fdisk_context *cxt)
 	}
 	if (MBRbuffer_changed) {
 		write_part_table_flag(cxt->mbr);
-		write_sector(cxt, 0, cxt->mbr);
+		rc = write_sector(cxt, 0, cxt->mbr);
+		if (rc)
+			goto done;
 	}
 	/* EBR (logical partitions) */
 	for (i = 4; i < partitions; i++) {
@@ -677,14 +688,19 @@ void dos_write_table(struct fdisk_context *cxt)
 
 		if (pe->changed) {
 			write_part_table_flag(pe->sectorbuffer);
-			write_sector(cxt, pe->offset, pe->sectorbuffer);
+			rc = write_sector(cxt, pe->offset, pe->sectorbuffer);
+			if (rc)
+				goto done;
 		}
 	}
+done:
+	return rc;
 }
 
 const struct fdisk_label dos_label =
 {
 	.name = "dos",
 	.probe = dos_probe_label,
+	.write = dos_write_table,
 	.part_delete = dos_delete_partition,
 };
diff --git a/fdisks/fdiskdoslabel.h b/fdisks/fdiskdoslabel.h
index 4aa16e5..8a2c6dd 100644
--- a/fdisks/fdiskdoslabel.h
+++ b/fdisks/fdiskdoslabel.h
@@ -50,6 +50,5 @@ extern int is_dos_partition(int t);
 extern void dos_init(struct fdisk_context *cxt);
 extern void dos_add_partition(struct fdisk_context *cxt, int n, int sys);
 extern void dos_new_partition(struct fdisk_context *cxt);
-extern void dos_write_table(struct fdisk_context *cxt);
 
 #endif
diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
index 198a2d0..19c99f6 100644
--- a/fdisks/fdiskmaclabel.c
+++ b/fdisks/fdiskmaclabel.c
@@ -84,5 +84,6 @@ const struct fdisk_label mac_label =
 {
 	.name = "mac",
 	.probe = mac_probe_label,
+	.write = NULL,
 	.part_delete = NULL,
 };
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index 51b0e1f..39ba58d 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -329,8 +329,8 @@ create_sgiinfo(struct fdisk_context *cxt) {
 
 sgiinfo *fill_sgiinfo(void);
 
-void
-sgi_write_table(struct fdisk_context *cxt) {
+static int sgi_write_table(struct fdisk_context *cxt)
+{
 	sgilabel->csum = 0;
 	sgilabel->csum = SSWAP32(two_s_complement_32bit_sum(
 		(unsigned int*)sgilabel,
@@ -338,9 +338,9 @@ sgi_write_table(struct fdisk_context *cxt) {
 	assert(two_s_complement_32bit_sum(
 		(unsigned int*)sgilabel, sizeof(*sgilabel)) == 0);
 	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
-		fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
+		return FDISK_ERROR_SEEK;
 	if (write(cxt->dev_fd, sgilabel, SECTOR_SIZE) != SECTOR_SIZE)
-		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
+		return FDISK_ERROR_WRITE;
 	if (! strncmp((char *) sgilabel->directory[0].vol_file_name, "sgilabel", 8)) {
 		/*
 		 * keep this habit of first writing the "sgilabel".
@@ -350,11 +350,13 @@ sgi_write_table(struct fdisk_context *cxt) {
 		int infostartblock = SSWAP32(sgilabel->directory[0].vol_file_start);
 		if (lseek(cxt->dev_fd, (off_t) infostartblock*
 				SECTOR_SIZE, SEEK_SET) < 0)
-			fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
+			return FDISK_ERROR_SEEK;
 		if (write(cxt->dev_fd, info, SECTOR_SIZE) != SECTOR_SIZE)
-			fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
+			return FDISK_ERROR_WRITE;
 		free(info);
 	}
+
+	return 0;
 }
 
 static int
@@ -882,5 +884,6 @@ const struct fdisk_label sgi_label =
 {
 	.name = "sgi",
 	.probe = sgi_probe_label,
+	.write = sgi_write_table,
 	.part_delete = sgi_delete_partition,
 };
diff --git a/fdisks/fdisksgilabel.h b/fdisks/fdisksgilabel.h
index 98cf093..14f488f 100644
--- a/fdisks/fdisksgilabel.h
+++ b/fdisks/fdisksgilabel.h
@@ -120,7 +120,6 @@ extern void	sgi_add_partition( struct fdisk_context *cxt, int n, int sys );
 extern void	create_sgilabel( struct fdisk_context *cxt );
 extern void	create_sgiinfo(struct fdisk_context *cxt);
 extern int	verify_sgi(struct fdisk_context *cxt, int verbose );
-extern void	sgi_write_table( struct fdisk_context *cxt );
 extern void	sgi_set_ilfact( void );
 extern void	sgi_set_rspeed( void );
 extern void	sgi_set_pcylcount( void );
diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
index c74ffbb..2cae2dd 100644
--- a/fdisks/fdisksunlabel.c
+++ b/fdisks/fdisksunlabel.c
@@ -625,7 +625,7 @@ void sun_set_pcylcount(struct fdisk_context *cxt)
 				 _("Number of physical cylinders")));
 }
 
-void sun_write_table(struct fdisk_context *cxt)
+static int sun_write_table(struct fdisk_context *cxt)
 {
 	unsigned short *ush = (unsigned short *)sunlabel;
 	unsigned short csum = 0;
@@ -634,9 +634,11 @@ void sun_write_table(struct fdisk_context *cxt)
 		csum ^= *ush++;
 	sunlabel->cksum = csum;
 	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
-		fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
+		return FDISK_ERROR_SEEK;
 	if (write(cxt->dev_fd, sunlabel, SECTOR_SIZE) != SECTOR_SIZE)
-		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
+		return FDISK_ERROR_WRITE;
+
+	return 0;
 }
 
 int sun_get_sysid(struct fdisk_context *cxt, int i)
@@ -648,5 +650,6 @@ const struct fdisk_label sun_label =
 {
 	.name = "sun",
 	.probe = sun_probe_label,
+	.write = sun_write_table,
 	.part_delete = sun_delete_partition,
 };
diff --git a/fdisks/fdisksunlabel.h b/fdisks/fdisksunlabel.h
index 47aa30a..0ede6e3 100644
--- a/fdisks/fdisksunlabel.h
+++ b/fdisks/fdisksunlabel.h
@@ -82,7 +82,6 @@ extern int sun_change_sysid(struct fdisk_context *cxt, int i, uint16_t sys);
 extern void sun_list_table(struct fdisk_context *cxt, int xtra);
 extern void verify_sun(struct fdisk_context *cxt);
 extern void add_sun_partition(struct fdisk_context *cxt, int n, int sys);
-extern void sun_write_table(struct fdisk_context *cxt);
 extern void sun_set_alt_cyl(struct fdisk_context *cxt);
 extern void sun_set_ncyl(struct fdisk_context *cxt, int cyl);
 extern void sun_set_xcyl(struct fdisk_context *cxt);
diff --git a/fdisks/utils.c b/fdisks/utils.c
index c8b8f7e..9b5092d 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -82,6 +82,19 @@ done:
 }
 
 /**
+ * fdisk_label_write_table:
+ * @cxt: fdisk context
+ *
+ * Write in-memory changes to disk
+ *
+ * Returns 0 on success, otherwise, a corresponding error.
+ */
+int fdisk_label_write_table(struct fdisk_context *cxt)
+{
+	return cxt->label->write(cxt);
+}	
+
+/**
  * fdisk_label_partition_delete:
  * @cxt: fdisk context
  * @partnum: partition number to delete
-- 
1.7.4.1
