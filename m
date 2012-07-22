Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:45005 "EHLO
	homiemail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752128Ab2GVRFF (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Jul 2012 13:05:05 -0400
Subject: [PATCH 01/10] fdisk: API: add error handling
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Jul 2012 19:04:58 +0200
Message-ID: <1342976698.2863.11.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Although the fdisk (and family) program is exposed to multiple scenarios where things can go wrong and fail,
the API is not capable of reporting these errors in a detailed way. This patch adds generic error handling
to it, by defining different errors (non-zero values), and its string representation. Since most errors are
fatal, the current fatal() function has been adapted to the API, but users can, of course, still build their
own ones.

Also note that the return value of the probing functions have also been modified: when the label is detected
it returns 0, otherwise FDISK_ERROR_PROBE.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c                |   35 +++-------------
 fdisks/fdisk.h                |   33 +++++++++-----
 fdisks/fdiskaixlabel.c        |    4 +-
 fdisks/fdiskbsdlabel.c        |   20 +++++-----
 fdisks/fdiskdoslabel.c        |    4 +-
 fdisks/fdiskmaclabel.c        |    4 +-
 fdisks/fdisksgilabel.c        |   12 +++---
 fdisks/fdisksunlabel.c        |    8 ++--
 fdisks/utils.c                |   90 ++++++++++++++++++++++++++++++++++-------
 tests/expected/fdisk/oddinput |    4 +-
 10 files changed, 131 insertions(+), 83 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 32b6de9..3b9bd7b 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -159,27 +159,6 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-void fatal(struct fdisk_context *cxt, enum failure why)
-{
-	close(cxt->dev_fd);
-	switch (why) {
-		case unable_to_read:
-			err(EXIT_FAILURE, _("unable to read %s"), cxt->dev_path);
-
-		case unable_to_seek:
-			err(EXIT_FAILURE, _("unable to seek on %s"), cxt->dev_path);
-
-		case unable_to_write:
-			err(EXIT_FAILURE, _("unable to write %s"), cxt->dev_path);
-
-		case ioctl_error:
-			err(EXIT_FAILURE, _("BLKGETSIZE ioctl failed on %s"), cxt->dev_path);
-
-		default:
-			err(EXIT_FAILURE, _("fatal error"));
-	}
-}
-
 struct partition *
 get_part_table(int i) {
 	return ptes[i].part_table;
@@ -1758,11 +1737,10 @@ gpt_warning(char *dev)
 /* Print disk geometry and partition table of a specified device (-l option) */
 static void print_partition_table_from_option(char *device, unsigned long sector_size)
 {
-	int gb;
-
-	struct fdisk_context *cxt = fdisk_new_context_from_filename(device, 1);	/* read-only */
+	int gb, errcode;
+	struct fdisk_context *cxt = fdisk_new_context_from_filename(device, 1, &errcode);	
 	if (!cxt)
-		err(EXIT_FAILURE, _("cannot open %s"), device);
+		errx(EXIT_FAILURE, _("%s: %s"), fdisk_error_name(errcode), device);
 	if (sector_size)  /* passed -b option, override autodiscovery */
 		cxt->phy_sector_size = cxt->sector_size = sector_size;
 	/* passed CHS option(s), override autodiscovery */
@@ -1960,7 +1938,7 @@ static sector_t get_dev_blocks(char *dev)
 
 int main(int argc, char **argv)
 {
-	int c, optl = 0, opts = 0;
+	int errcode, c, optl = 0, opts = 0;
 	unsigned long sector_size = 0;
 	struct fdisk_context *cxt = NULL;
 
@@ -2062,9 +2040,10 @@ int main(int argc, char **argv)
 	if (argc-optind != 1)
 		usage(stderr);
 
-	cxt = fdisk_new_context_from_filename(argv[optind], 0);
+	cxt = fdisk_new_context_from_filename(argv[optind], 0, &errcode);
 	if (!cxt)
-		err(EXIT_FAILURE, _("cannot open %s"), argv[optind]);
+		errx(EXIT_FAILURE, _("%s: %s"), fdisk_error_name(errcode), 
+		    argv[optind]);
 	if (sector_size)	/* passed -b option, override autodiscovery */
 		cxt->phy_sector_size = cxt->sector_size = sector_size;
 	/* passed CHS option(s), override autodiscovery */
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 64a8147..8107aa8 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -90,16 +90,24 @@ enum menutype {
 	EXPERT_MENU,
 };
 
-enum failure {
-	ioctl_error,
-	unable_to_read,
-	unable_to_seek,
-	unable_to_write
-};
-
 typedef unsigned long long sector_t;
 
 /*
+ * fdisk error codes.
+ */
+enum fdisk_error {
+	FDISK_SUCCESS,
+	FDISK_ERROR_OPEN,
+	FDISK_ERROR_MEM,
+	FDISK_ERROR_READ,
+	FDISK_ERROR_SEEK,
+	FDISK_ERROR_WRITE,
+	FDISK_ERROR_IOCTL,
+	FDISK_ERROR_PROBE,
+	FDISK_ERROR_UNKNOWN
+};
+
+/*
  * Legacy CHS based geometry
  */
 struct fdisk_geometry {
@@ -144,19 +152,20 @@ extern const struct fdisk_label mac_label;
 extern const struct fdisk_label sun_label;
 extern const struct fdisk_label sgi_label;
 
-extern struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly);
+extern struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly, int *errcode);
 extern int fdisk_dev_has_topology(struct fdisk_context *cxt);
 extern int fdisk_dev_sectsz_is_default(struct fdisk_context *cxt);
 extern void fdisk_free_context(struct fdisk_context *cxt);
 extern void fdisk_mbr_zeroize(struct fdisk_context *cxt);
 extern void fdisk_geom_set_cyls(struct fdisk_context *cxt);
+extern const char *fdisk_error_name(enum fdisk_error errcode);
+extern void fdisk_error_fatal(struct fdisk_context *cxt, enum fdisk_error errcode);
 
 /* prototypes for fdisk.c */
 extern char *disk_device, *line_ptr;
 extern int fd, partitions;
 extern unsigned int display_in_cyl_units, units_per_sector;
 extern void change_units(struct fdisk_context *cxt);
-extern void fatal(struct fdisk_context *cxt, enum failure why);
 extern int  get_partition(struct fdisk_context *cxt, int warn, int max);
 extern void list_types(struct systypes *sys);
 extern int read_line (int *asked);
@@ -242,21 +251,21 @@ static inline void seek_sector(struct fdisk_context *cxt, sector_t secno)
 {
 	off_t offset = (off_t) secno * cxt->sector_size;
 	if (lseek(cxt->dev_fd, offset, SEEK_SET) == (off_t) -1)
-		fatal(cxt, unable_to_seek);
+		fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
 }
 
 static inline void read_sector(struct fdisk_context *cxt, sector_t secno, unsigned char *buf)
 {
 	seek_sector(cxt, secno);
 	if (read(cxt->dev_fd, buf, cxt->sector_size) != (ssize_t) cxt->sector_size)
-		fatal(cxt, unable_to_read);
+		fdisk_error_fatal(cxt, FDISK_ERROR_READ);
 }
 
 static inline void write_sector(struct fdisk_context *cxt, sector_t secno, unsigned char *buf)
 {
 	seek_sector(cxt, secno);
 	if (write(cxt->dev_fd, buf, cxt->sector_size) != (ssize_t) cxt->sector_size)
-		fatal(cxt, unable_to_write);
+		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
 }
 
 static inline sector_t get_start_sect(struct partition *p)
diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
index ebf9365..f590e3a 100644
--- a/fdisks/fdiskaixlabel.c
+++ b/fdisks/fdiskaixlabel.c
@@ -54,7 +54,7 @@ static int aix_probe_label(struct fdisk_context *cxt)
     if (aixlabel->magic != AIX_LABEL_MAGIC &&
 	aixlabel->magic != AIX_LABEL_MAGIC_SWAPPED) {
 	other_endian = 0;
-	return 0;
+	return FDISK_ERROR_PROBE;
     }
     other_endian = (aixlabel->magic == AIX_LABEL_MAGIC_SWAPPED);
     disklabel = AIX_LABEL;
@@ -62,7 +62,7 @@ static int aix_probe_label(struct fdisk_context *cxt)
     volumes = 15;
     aix_info();
     aix_nolabel(cxt);		/* %% */
-    return 1;
+    return 0;
 }
 
 const struct fdisk_label aix_label =
diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
index 548a86d..fe91fe8 100644
--- a/fdisks/fdiskbsdlabel.c
+++ b/fdisks/fdiskbsdlabel.c
@@ -112,8 +112,8 @@ static struct xbsd_disklabel xbsd_dlabel;
 static int
 osf_probe_label(struct fdisk_context *cxt) {
 	if (xbsd_readlabel (cxt, NULL, &xbsd_dlabel) == 0)
-		return 0;
-	return 1;
+		return FDISK_ERROR_PROBE;
+	return 0;
 }
 
 int
@@ -548,9 +548,9 @@ xbsd_write_bootstrap (struct fdisk_context *cxt)
 #endif
 
   if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE, SEEK_SET) == -1)
-	  fatal (cxt, unable_to_seek);
+	  fdisk_error_fatal (cxt, FDISK_ERROR_SEEK);
   if (BSD_BBSIZE != write (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
-	  fatal (cxt, unable_to_write);
+	  fdisk_error_fatal (cxt, FDISK_ERROR_WRITE);
 
 #if defined (__alpha__)
   printf (_("Bootstrap installed on %s.\n"), cxt->dev_path);
@@ -716,9 +716,9 @@ xbsd_readlabel (struct fdisk_context *cxt, struct partition *p, struct xbsd_disk
 #endif
 
 	if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE, SEEK_SET) == -1)
-		fatal (cxt, unable_to_seek);
+		fdisk_error_fatal (cxt, FDISK_ERROR_SEEK);
 	if (BSD_BBSIZE != read (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
-		fatal (cxt, unable_to_read);
+		fdisk_error_fatal (cxt, FDISK_ERROR_READ);
 
 	memmove (d,
 	         &disklabelbuffer[BSD_LABELSECTOR * SECTOR_SIZE + BSD_LABELOFFSET],
@@ -763,15 +763,15 @@ xbsd_writelabel (struct fdisk_context *cxt, struct partition *p, struct xbsd_dis
 #if defined (__alpha__) && BSD_LABELSECTOR == 0
   alpha_bootblock_checksum (disklabelbuffer);
   if (lseek (cxt->dev_fd, (off_t) 0, SEEK_SET) == -1)
-	  fatal (cxt, unable_to_seek);
+	  fdisk_error_fatal (cxt, FDISK_ERROR_SEEK);
   if (BSD_BBSIZE != write (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
-	  fatal (cxt, unable_to_write);
+	  fdisk_error_fatal (cxt, FDISK_ERROR_WRITE);
 #else
   if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE + BSD_LABELOFFSET,
 		   SEEK_SET) == -1)
-	  fatal (cxt, unable_to_seek);
+	  fdisk_error_fatal (cxt, FDISK_ERROR_SEEK);
   if (sizeof (struct xbsd_disklabel) != write (cxt->dev_fd, d, sizeof (struct xbsd_disklabel)))
-	  fatal (cxt, unable_to_write);
+	  fdisk_error_fatal (cxt, FDISK_ERROR_WRITE);
 #endif
 
   sync_disks ();
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index a115e66..535afdc 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -321,7 +321,7 @@ static int dos_probe_label(struct fdisk_context *cxt)
 	int i;
 
 	if (!valid_part_table_flag(cxt->mbr))
-		return 0;
+		return FDISK_ERROR_PROBE;
 
 	dos_init(cxt);
 
@@ -349,7 +349,7 @@ static int dos_probe_label(struct fdisk_context *cxt)
 		}
 	}
 
-	return 1;
+	return 0;
 }
 
 /*
diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
index 555245d..98cff26 100644
--- a/fdisks/fdiskmaclabel.c
+++ b/fdisks/fdiskmaclabel.c
@@ -65,7 +65,7 @@ mac_probe_label(struct fdisk_context *cxt)
 			break;
 		default:
 			other_endian = 0;
-			return 0;
+			return FDISK_ERROR_PROBE;
 

 	}
@@ -77,7 +77,7 @@ IS_MAC:
     volumes = 15;	// =?
     mac_info();
     mac_nolabel(cxt);		/* %% */
-    return 1;
+    return 0;
 }
 
 const struct fdisk_label mac_label =
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index 071a84e..e38d98f 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -139,7 +139,7 @@ sgi_probe_label(struct fdisk_context *cxt) {
 	if (sgilabel->magic != SGI_LABEL_MAGIC &&
 	    sgilabel->magic != SGI_LABEL_MAGIC_SWAPPED) {
 		other_endian = 0;
-		return 0;
+		return FDISK_ERROR_PROBE;
 	}
 
 	other_endian = (sgilabel->magic == SGI_LABEL_MAGIC_SWAPPED);
@@ -154,7 +154,7 @@ sgi_probe_label(struct fdisk_context *cxt) {
 	disklabel = SGI_LABEL;
 	partitions= 16;
 	volumes = 15;
-	return 1;
+	return 0;
 }
 
 void
@@ -338,9 +338,9 @@ sgi_write_table(struct fdisk_context *cxt) {
 	assert(two_s_complement_32bit_sum(
 		(unsigned int*)sgilabel, sizeof(*sgilabel)) == 0);
 	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
-		fatal(cxt, unable_to_seek);
+		fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
 	if (write(cxt->dev_fd, sgilabel, SECTOR_SIZE) != SECTOR_SIZE)
-		fatal(cxt, unable_to_write);
+		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
 	if (! strncmp((char *) sgilabel->directory[0].vol_file_name, "sgilabel", 8)) {
 		/*
 		 * keep this habit of first writing the "sgilabel".
@@ -350,9 +350,9 @@ sgi_write_table(struct fdisk_context *cxt) {
 		int infostartblock = SSWAP32(sgilabel->directory[0].vol_file_start);
 		if (lseek(cxt->dev_fd, (off_t) infostartblock*
 				SECTOR_SIZE, SEEK_SET) < 0)
-			fatal(cxt, unable_to_seek);
+			fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
 		if (write(cxt->dev_fd, info, SECTOR_SIZE) != SECTOR_SIZE)
-			fatal(cxt, unable_to_write);
+			fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
 		free(info);
 	}
 }
diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
index 909f159..4123806 100644
--- a/fdisks/fdisksunlabel.c
+++ b/fdisks/fdisksunlabel.c
@@ -86,7 +86,7 @@ static int sun_probe_label(struct fdisk_context *cxt)
 	if (sunlabel->magic != SUN_LABEL_MAGIC &&
 	    sunlabel->magic != SUN_LABEL_MAGIC_SWAPPED) {
 		other_endian = 0;
-		return 0;
+		return FDISK_ERROR_PROBE;
 	}
 
 	init();
@@ -141,7 +141,7 @@ static int sun_probe_label(struct fdisk_context *cxt)
 		}
 	}
 	update_units(cxt);
-	return 1;
+	return 0;
 }
 
 void create_sunlabel(struct fdisk_context *cxt)
@@ -633,9 +633,9 @@ void sun_write_table(struct fdisk_context *cxt)
 		csum ^= *ush++;
 	sunlabel->cksum = csum;
 	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
-		fatal(cxt, unable_to_seek);
+		fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
 	if (write(cxt->dev_fd, sunlabel, SECTOR_SIZE) != SECTOR_SIZE)
-		fatal(cxt, unable_to_write);
+		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
 }
 
 int sun_get_sysid(struct fdisk_context *cxt, int i)
diff --git a/fdisks/utils.c b/fdisks/utils.c
index 94a080f..363f7aa 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -53,32 +53,37 @@ static int __probe_labels(struct fdisk_context *cxt)
 
 	for (i = 0; i < ARRAY_SIZE(labels); i++) {
 		rc = labels[i]->probe(cxt);
-		if (rc) {
+		if (!rc) {
 			DBG(LABEL, dbgprint("detected a %s label\n",
 					    labels[i]->name));
 			goto done;
 		}
 	}
-
 done:
 	return rc;
 }
 
 static int __init_mbr_buffer(struct fdisk_context *cxt)
 {
+	int errcode = 0;
+
 	DBG(TOPOLOGY, dbgprint("initialize MBR buffer"));
 
 	cxt->mbr = calloc(1, MAX_SECTOR_SIZE);
-	if (!cxt->mbr)
-		goto fail;
+	if (!cxt->mbr) {
+		errcode = FDISK_ERROR_MEM;
+		goto done;
+	}
 
 	/* read MBR */
 	if (512 != read(cxt->dev_fd, cxt->mbr, 512))
-		goto fail;
-
-	return 0;
-fail:
-	return -1;
+		/*
+		 * this error is either a legitimate read failure,
+		 * or the device is too small for reading 512 bytes.
+		 */
+		errcode = FDISK_ERROR_READ;
+done:
+	return errcode;
 }
 
 static unsigned long __get_sector_size(int fd)
@@ -254,17 +259,65 @@ void fdisk_init_debug(int mask)
 }
 
 /**
+ * fdisk_error_name:
+ * @errcode: fdisk specific error code
+ *
+ * Returns: Corresponding error message.
+ */
+const char *fdisk_error_name(enum fdisk_error errcode)
+{
+	switch (errcode) {
+	case FDISK_ERROR_OPEN:
+		return "error: cannot open";
+	case FDISK_ERROR_MEM:
+		return "error: no memory";
+	case FDISK_ERROR_READ:
+		return "error: cannot read";
+	case FDISK_ERROR_SEEK:
+		return "error: cannot seek";
+	case FDISK_ERROR_WRITE:
+		return "error: cannot write";
+	case FDISK_ERROR_IOCTL:
+		return "error: ioctl";
+	case FDISK_ERROR_PROBE:
+		return "error: cannot probe";
+	default:
+		return "error: unknown";
+	}
+}
+
+/**
+ * fdisk_error_fatal:
+ * @cxt: fdisk context
+ * @errcode: fdisk specific error code
+ *
+ * Deinitializes the fdisk context and exits, printing an appropiate
+ * error message to standard error. Use only for unrecoverable failures.
+ */
+void __attribute__((__noreturn__))
+fdisk_error_fatal(struct fdisk_context *cxt, enum fdisk_error errcode)
+{
+	fprintf(stderr, _("%s: %s\n"), fdisk_error_name(errcode),
+		                       cxt->dev_path);
+	fdisk_free_context(cxt);
+	exit(EXIT_FAILURE);
+}
+
+/**
  * fdisk_new_context:
  * @filename: path to the device to be handled
  * @readonly: how to open the device
+ * @errcode: specific fdisk error code (returned value)
  *
  * If the @readonly flag is set to false, fdisk will attempt to open
  * the device with read-write mode and will fallback to read-only if
  * unsuccessful.
  *
- * Returns: newly allocated fdisk context
+ * Returns: newly allocated fdisk context. If failure, returns NULL
+ *          and @errcode is set.
  */
-struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly)
+struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly,
+						      int *errcode)
 {
 	int fd, errsv = 0;
 	struct fdisk_context *cxt = NULL;
@@ -272,21 +325,28 @@ struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int rea
 	DBG(CONTEXT, dbgprint("initializing context for %s", fname));
 
 	if (readonly == 1 || (fd = open(fname, O_RDWR)) < 0) {
-		if ((fd = open(fname, O_RDONLY)) < 0)
+		if ((fd = open(fname, O_RDONLY)) < 0) {
+			*errcode = FDISK_ERROR_OPEN;
 			return NULL;
+		}
 		readonly = 1;
 	}
 
 	cxt = calloc(1, sizeof(*cxt));
-	if (!cxt)
+	if (!cxt) {
+		*errcode = FDISK_ERROR_MEM;
 		goto fail;
+	}
 
 	cxt->dev_fd = fd;
 	cxt->dev_path = strdup(fname);
-	if (!cxt->dev_path)
+	if (!cxt->dev_path) {
+		*errcode = FDISK_ERROR_MEM;
 		goto fail;
+	}
 
-	if (__init_mbr_buffer(cxt) < 0)
+	*errcode = __init_mbr_buffer(cxt);
+	if(*errcode)
 		goto fail;
 
 	__discover_topology(cxt);
diff --git a/tests/expected/fdisk/oddinput b/tests/expected/fdisk/oddinput
index d90866b..2c89e31 100644
--- a/tests/expected/fdisk/oddinput
+++ b/tests/expected/fdisk/oddinput
@@ -9,6 +9,6 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 
 Nonexistant file
-lt-fdisk: unable to open _a_file_that_does_not_exist_: No such file or directory
+lt-fdisk: error: cannot open: _a_file_that_does_not_exist_
 Too small file
-lt-fdisk: unable to open oddinput.toosmall: Success
+lt-fdisk: error: cannot read: oddinput.toosmall
-- 
1.7.4.1




