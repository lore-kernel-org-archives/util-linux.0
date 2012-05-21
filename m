Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:46008 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750766Ab2EUU2H (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 21 May 2012 16:28:07 -0400
Subject: Re: [PATCH 5/6] fdisk: introduce fdisk context
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
In-Reply-To: <1337631275.2596.1.camel@offbook>
References: <1337530296.2677.16.camel@offbook>
	 <20120521094054.GA14560@x2.net.home>  <1337631275.2596.1.camel@offbook>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 May 2012 22:28:03 +0200
Message-ID: <1337632083.2596.5.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2012-05-21 at 22:14 +0200, Davidlohr Bueso wrote:
> On Mon, 2012-05-21 at 11:40 +0200, Karel Zak wrote:
> > On Sun, May 20, 2012 at 06:11:36PM +0200, Davidlohr Bueso wrote:
> > > +struct fdisk_context *fdisk_new_context_from_filename(const char *fname)
> > > +{
> > > +	int fd;
> > > +	struct fdisk_context *cxt = NULL;
> > > +
> > > +	/*
> > > +	 * Attempt to open the device with r-w permissions
> > > +	 * by default, otherwise try read-only.
> > > +	 */
> > > +	if ((fd = open(fname, O_RDWR)) < 0)
> > > +		if ((fd = open(fname, O_RDONLY)) < 0)
> > > +			goto ret;
> > 
> >             return NULL;
> > 
> > > +	cxt = calloc(1, sizeof(*cxt));
> > > +	if (!cxt)
> > > +		goto ret;
> > > +
> > > +	cxt->dev_fd = fd;
> > > +	cxt->dev_path = strdup(fname);
> > > +	if (!cxt->dev_path)
> > > +		return NULL;
> > 
> >         goto fail;
> > 
> >  Please, think about it as about library, it meas without memory and
> >  fd leaks :-)
> > 
> > > +ret:
> > > +	return cxt;
> > > +}
> > > +
> > 
> >    return cxt;
> > 
> > fail:
> >    errsv = errno;
> >    fdisk_free_context(cxt);
> >    errno = errsv;
> >    return NULL;
> 
> From: Davidlohr Bueso <dave@gnu.org>
> Date: Mon, 21 May 2012 22:12:33 +0200
> Subject: [PATCH] fdisk: introduce fdisk context

*sigh* Please ignore this previous patch, it doesn't return cxt from the
init function (/me hits himself). This one is ok, based on your
comments. Thanks and sorry about the noise.

From: Davidlohr Bueso <dave@gnu.org>
Date: Mon, 21 May 2012 22:26:32 +0200
Subject: [PATCH] fdisk: fdisk: introduce fdisk context

This is the first patch that adds the initial parts of the new fdisk internal API. Two functions are created to both init and deinit the fdisk
context. Only the device's descriptor and path are added as a start and these are replaced throughout fdisk.c and label specific code.

All logic that opens the file does it with fdisk_new_context_from_filename(), and this enforces always opening the device with rw, then, if
unsuccesfull, with read-only. This changes the current logic that opens the device with certain permissions depending on the user given options.
For example, -l opens the device read-only.

This patch passed regression tests and local modifications for sgi/dos/sun disk labels.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/Makefile.am     |    1 +
 fdisk/fdisk.c         |   82 ++++++++++++++++++++++--------------------------
 fdisk/fdisk.h         |    9 +++++
 fdisk/fdiskbsdlabel.c |   44 +++++++++++++-------------
 fdisk/fdiskdoslabel.c |    6 ++--
 fdisk/fdisksgilabel.c |   24 +++++++-------
 fdisk/fdisksunlabel.c |   18 +++++-----
 fdisk/utils.c         |   76 +++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 170 insertions(+), 90 deletions(-)
 create mode 100644 fdisk/utils.c

diff --git a/fdisk/Makefile.am b/fdisk/Makefile.am
index 7851bd1..e9be841 100644
--- a/fdisk/Makefile.am
+++ b/fdisk/Makefile.am
@@ -20,6 +20,7 @@ if !ARCH_M68K
 sbin_PROGRAMS = fdisk
 dist_man_MANS = fdisk.8
 fdisk_SOURCES = \
+	utils.c \
 	fdisk.c \
 	fdisk.h \
 	fdiskaixlabel.c \
diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 570333b..71c009c 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -55,6 +55,7 @@
 
 unsigned char *MBRbuffer;
 int MBRbuffer_changed;
+struct fdisk_context *cxt = NULL;
 
 #define hex_val(c)	({ \
 				char _c = (c); \
@@ -130,12 +131,10 @@ get_nr_sects(struct partition *p) {
 	return read4_little_endian(p->size4);
 }
 
-char	*disk_device,			/* must be specified */
-	*line_ptr,			/* interactive input */
+char	*line_ptr,			/* interactive input */
 	line_buffer[LINE_LENGTH];
 
-int	fd,				/* the disk */
-	nowarn = 0,			/* no warnings for fdisk -l/-s */
+int	nowarn = 0,			/* no warnings for fdisk -l/-s */
 	dos_compatible_flag = 0,	/* disabled by default */
 	dos_changed = 0,
 	partitions = 4;			/* maximum partition + 1 */
@@ -183,19 +182,19 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 
 void fatal(enum failure why)
 {
-	close(fd);
+	close(cxt->dev_fd);
 	switch (why) {
 		case unable_to_read:
-			err(EXIT_FAILURE, _("unable to read %s"), disk_device);
+			err(EXIT_FAILURE, _("unable to read %s"), cxt->dev_path);
 
 		case unable_to_seek:
-			err(EXIT_FAILURE, _("unable to seek on %s"), disk_device);
+			err(EXIT_FAILURE, _("unable to seek on %s"), cxt->dev_path);
 
 		case unable_to_write:
-			err(EXIT_FAILURE, _("unable to write %s"), disk_device);
+			err(EXIT_FAILURE, _("unable to write %s"), cxt->dev_path);
 
 		case ioctl_error:
-			err(EXIT_FAILURE, _("BLKGETSIZE ioctl failed on %s"), disk_device);
+			err(EXIT_FAILURE, _("BLKGETSIZE ioctl failed on %s"), cxt->dev_path);
 
 		default:
 			err(EXIT_FAILURE, _("fatal error"));
@@ -460,7 +459,7 @@ get_topology(int fd) {
 	blkid_probe pr;
 
 	pr = blkid_new_probe();
-	if (pr && blkid_probe_set_device(pr, fd, 0, 0) == 0) {
+	if (pr && blkid_probe_set_device(pr, cxt->dev_fd, 0, 0) == 0) {
 		blkid_topology tp = blkid_probe_get_topology(pr);
 
 		if (tp) {
@@ -494,7 +493,7 @@ get_topology(int fd) {
 		 */
 		phy_sector_size = sector_size;
 
-	else if (blkdev_get_sector_size(fd, &arg) == 0) {
+	else if (blkdev_get_sector_size(cxt->dev_fd, &arg) == 0) {
 		sector_size = arg;
 
 		if (!phy_sector_size)
@@ -664,24 +663,13 @@ static int get_boot(int try_only) {
 	disklabel = ANY_LABEL;
 	memset(MBRbuffer, 0, 512);
 
-	if (try_only && (fd = open(disk_device, O_RDONLY)) < 0)
-		err(EXIT_FAILURE, _("unable to open %s"), disk_device);
-	else {
-		if ((fd = open(disk_device, O_RDWR)) < 0) {
-			/* ok, can we read-only the device? */
-			if ((fd = open(disk_device, O_RDONLY)) < 0)
-				err(EXIT_FAILURE, _("unable to open %s"), disk_device);
-			printf(_("You will not be able to write the partition table.\n"));
-		}
-	}
-
-	if (512 != read(fd, MBRbuffer, 512)) {
+	if (512 != read(cxt->dev_fd, MBRbuffer, 512)) {
 		if (try_only)
 			return 1;
 		fatal(unable_to_read);
 	}
 
-	get_geometry(fd, NULL);
+	get_geometry(cxt->dev_fd, NULL);
 	update_units();
 
 	if (!check_dos_label())
@@ -1232,11 +1220,11 @@ list_disk_geometry(void) {
 
 	if (megabytes < 10000)
 		printf(_("\nDisk %s: %ld MB, %lld bytes\n"),
-		       disk_device, megabytes, bytes);
+		       cxt->dev_path, megabytes, bytes);
 	else {
 		long hectomega = (megabytes + 50) / 100;
 		printf(_("\nDisk %s: %ld.%ld GB, %llu bytes\n"),
-		       disk_device, hectomega / 10, hectomega % 10, bytes);
+		       cxt->dev_path, hectomega / 10, hectomega % 10, bytes);
 	}
 	printf(_("%d heads, %llu sectors/track, %d cylinders"),
 	       heads, sectors, cylinders);
@@ -1424,8 +1412,8 @@ list_table(int xtra) {
 	/* Heuristic: we list partition 3 of /dev/foo as /dev/foo3,
 	   but if the device name ends in a digit, say /dev/foo1,
 	   then the partition is called /dev/foo1p3. */
-	w = strlen(disk_device);
-	if (w && isdigit(disk_device[w-1]))
+	w = strlen(cxt->dev_path);
+	if (w && isdigit(cxt->dev_path[w-1]))
 		w++;
 	if (w < 5)
 		w = 5;
@@ -1450,7 +1438,7 @@ list_table(int xtra) {
 				pblocks *= (sector_size / 1024);
                         printf(
 			    "%s  %c %11lu %11lu %11lu%c  %2x  %s\n",
-			partname(disk_device, i+1, w+2),
+			partname(cxt->dev_path, i+1, w+2),
 /* boot flag */		!p->boot_ind ? ' ' : p->boot_ind == ACTIVE_FLAG
 			? '*' : '?',
 /* start */		(unsigned long) cround(get_partition_start(pe)),
@@ -1480,7 +1468,7 @@ x_list_table(int extend) {
 	int i;
 
 	printf(_("\nDisk %s: %d heads, %llu sectors, %d cylinders\n\n"),
-		disk_device, heads, sectors, cylinders);
+		cxt->dev_path, heads, sectors, cylinders);
         printf(_("Nr AF  Hd Sec  Cyl  Hd Sec  Cyl     Start      Size ID\n"));
 	for (i = 0 ; i < partitions; i++) {
 		pe = &ptes[i];
@@ -1695,12 +1683,12 @@ reread_partition_table(int leave) {
 	int i;
 	struct stat statbuf;
 
-	i = fstat(fd, &statbuf);
+	i = fstat(cxt->dev_fd, &statbuf);
 	if (i == 0 && S_ISBLK(statbuf.st_mode)) {
 		sync();
 #ifdef BLKRRPART
 		printf(_("Calling ioctl() to re-read partition table.\n"));
-		i = ioctl(fd, BLKRRPART);
+		i = ioctl(cxt->dev_fd, BLKRRPART);
 #else
 		errno = ENOSYS;
 		i = 1;
@@ -1721,7 +1709,7 @@ reread_partition_table(int leave) {
 		"information.\n"));
 
 	if (leave) {
-		if (fsync(fd) || close(fd)) {
+		if (fsync(cxt->dev_fd) || close(cxt->dev_fd)) {
 			fprintf(stderr, _("\nError closing file\n"));
 			exit(1);
 		}
@@ -1755,7 +1743,7 @@ static void
 print_raw(void) {
 	int i;
 
-	printf(_("Device: %s\n"), disk_device);
+	printf(_("Device: %s\n"), cxt->dev_path);
 	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL)
 		print_buffer(MBRbuffer);
 	else for (i = 3; i < partitions; i++)
@@ -1811,9 +1799,9 @@ move_begin(int i) {
 	}
 }
 
-static void __attribute__ ((__noreturn__)) handle_quit(void)
+static void __attribute__ ((__noreturn__)) handle_quit(struct fdisk_context *cxt)
 {
-	close(fd);
+	fdisk_free_context(cxt);
 	printf("\n");
 	exit(EXIT_SUCCESS);
 }
@@ -1883,7 +1871,7 @@ expert_command_prompt(void)
 				x_list_table(0);
 			break;
 		case 'q':
-			handle_quit();
+			handle_quit(cxt);
 		case 'r':
 			return;
 		case 's':
@@ -1939,7 +1927,10 @@ print_partition_table_from_option(char *device)
 {
 	int gb;
 
-	disk_device = device;
+	cxt = fdisk_new_context_from_filename(device);
+	if (!cxt)
+		err(EXIT_FAILURE, _("unable to open %s"), device);
+
 	gpt_warning(device);
 	gb = get_boot(1);
 	if (gb < 0) { /* no DOS signature */
@@ -1949,7 +1940,7 @@ print_partition_table_from_option(char *device)
 	}
 	else if (!gb)
 		list_table(0);
-	close(fd);
+	fdisk_free_context(cxt);
 }
 
 /*
@@ -2001,7 +1992,7 @@ static void command_prompt(void)
 		/* OSF label, and no DOS label */
 		printf(_("Detected an OSF/1 disklabel on %s, entering "
 			 "disklabel mode.\n"),
-		       disk_device);
+		       cxt->dev_path);
 		bsd_command_prompt();
 		/* If we return we may want to make an empty DOS label? */
 		disklabel = DOS_LABEL;
@@ -2070,7 +2061,7 @@ static void command_prompt(void)
 			list_table(0);
 			break;
 		case 'q':
-			handle_quit();
+			handle_quit(cxt);
 		case 's':
 			create_sunlabel();
 			break;
@@ -2209,8 +2200,11 @@ int main(int argc, char **argv)
 		exit(EXIT_SUCCESS);
 	}
 
-	if (argc-optind == 1)
-		disk_device = argv[optind];
+	if (argc-optind == 1) {
+		cxt = fdisk_new_context_from_filename(argv[optind]);
+		if (!cxt)
+			err(EXIT_FAILURE, _("unable to open %s"), argv[optind]);	
+	}
 	else
 		usage(stderr);
 
@@ -2218,7 +2212,7 @@ int main(int argc, char **argv)
 		"Changes will remain in memory only, until you decide to write them.\n"
 		"Be careful before using the write command.\n\n"), PACKAGE_STRING);
 
-	gpt_warning(disk_device);
+	gpt_warning(cxt->dev_path);
 	get_boot(0);
 
 	command_prompt();
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 82888dc..c43517c 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -63,6 +63,15 @@ struct geom {
 	unsigned int cylinders;
 };
 
+struct fdisk_context {
+	int dev_fd;     /* device descriptor */
+	char *dev_path; /* device path */
+};
+
+extern struct fdisk_context *cxt;
+extern struct fdisk_context *fdisk_new_context_from_filename(const char *fname);
+extern void fdisk_free_context(struct fdisk_context *cxt);
+
 /* prototypes for fdisk.c */
 extern char *disk_device, *line_ptr;
 extern int fd, partitions;
diff --git a/fdisk/fdiskbsdlabel.c b/fdisk/fdiskbsdlabel.c
index 9dfc95a..670e9bc 100644
--- a/fdisk/fdiskbsdlabel.c
+++ b/fdisk/fdiskbsdlabel.c
@@ -153,11 +153,11 @@ bsd_command_prompt (void)
       ss = get_start_sect(xbsd_part);
       if (ss == 0) {
 	fprintf (stderr, _("Partition %s has invalid starting sector 0.\n"),
-		 partname(disk_device, t+1, 0));
+		 partname(cxt->dev_path, t+1, 0));
 	return;
       }
       printf (_("Reading disklabel of %s at sector %d.\n"),
-	      partname(disk_device, t+1, 0), ss + BSD_LABELSECTOR);
+	      partname(cxt->dev_path, t+1, 0), ss + BSD_LABELSECTOR);
       if (xbsd_readlabel (xbsd_part, &xbsd_dlabel) == 0)
 	if (xbsd_create_disklabel () == 0)
 	  return;
@@ -166,7 +166,7 @@ bsd_command_prompt (void)
   }
 
   if (t == 4) {
-    printf (_("There is no *BSD partition on %s.\n"), disk_device);
+    printf (_("There is no *BSD partition on %s.\n"), cxt->dev_path);
     return;
   }
 
@@ -200,7 +200,7 @@ bsd_command_prompt (void)
 	xbsd_print_disklabel (0);
 	break;
       case 'q':
-	close (fd);
+	close (cxt->dev_fd);
 	exit ( EXIT_SUCCESS );
       case 'r':
 	return;
@@ -289,9 +289,9 @@ xbsd_print_disklabel (int show_all) {
 
   if (show_all) {
 #if defined (__alpha__)
-    fprintf(f, "# %s:\n", disk_device);
+    fprintf(f, "# %s:\n", cxt->dev_path);
 #else
-    fprintf(f, "# %s:\n", partname(disk_device, xbsd_part_index+1, 0));
+    fprintf(f, "# %s:\n", partname(cxt->dev_path, xbsd_part_index+1, 0));
 #endif
     if ((unsigned) lp->d_type < BSD_DKMAXTYPES)
       fprintf(f, _("type: %s\n"), xbsd_dktypenames[lp->d_type]);
@@ -381,11 +381,11 @@ xbsd_print_disklabel (int show_all) {
 static void
 xbsd_write_disklabel (void) {
 #if defined (__alpha__)
-	printf (_("Writing disklabel to %s.\n"), disk_device);
+	printf (_("Writing disklabel to %s.\n"), cxt->dev_path);
 	xbsd_writelabel (NULL, &xbsd_dlabel);
 #else
 	printf (_("Writing disklabel to %s.\n"),
-		partname(disk_device, xbsd_part_index+1, 0));
+		partname(cxt->dev_path, xbsd_part_index+1, 0));
 	xbsd_writelabel (xbsd_part, &xbsd_dlabel);
 #endif
 	reread_partition_table(0);	/* no exit yet */
@@ -396,10 +396,10 @@ xbsd_create_disklabel (void) {
 	char c;
 
 #if defined (__alpha__)
-	fprintf (stderr, _("%s contains no disklabel.\n"), disk_device);
+	fprintf (stderr, _("%s contains no disklabel.\n"), cxt->dev_path);
 #else
 	fprintf (stderr, _("%s contains no disklabel.\n"),
-		 partname(disk_device, xbsd_part_index+1, 0));
+		 partname(cxt->dev_path, xbsd_part_index+1, 0));
 #endif
 
 	while (1) {
@@ -545,16 +545,16 @@ xbsd_write_bootstrap (void)
   sector = get_start_sect(xbsd_part);
 #endif
 
-  if (lseek (fd, (off_t) sector * SECTOR_SIZE, SEEK_SET) == -1)
+  if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE, SEEK_SET) == -1)
     fatal (unable_to_seek);
-  if (BSD_BBSIZE != write (fd, disklabelbuffer, BSD_BBSIZE))
+  if (BSD_BBSIZE != write (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
     fatal (unable_to_write);
 
 #if defined (__alpha__)
-  printf (_("Bootstrap installed on %s.\n"), disk_device);
+  printf (_("Bootstrap installed on %s.\n"), cxt->dev_path);
 #else
   printf (_("Bootstrap installed on %s.\n"),
-    partname (disk_device, xbsd_part_index+1, 0));
+    partname (cxt->dev_path, xbsd_part_index+1, 0));
 #endif
 
   sync_disks ();
@@ -636,12 +636,12 @@ xbsd_initlabel (struct partition *p, struct xbsd_disklabel *d,
 	struct xbsd_partition *pp;
 	struct geom g;
 
-	get_geometry (fd, &g);
+	get_geometry (cxt->dev_fd, &g);
 	memset (d, 0, sizeof (struct xbsd_disklabel));
 
 	d -> d_magic = BSD_DISKMAGIC;
 
-	if (strncmp (disk_device, "/dev/sd", 7) == 0)
+	if (strncmp (cxt->dev_path, "/dev/sd", 7) == 0)
 		d -> d_type = BSD_DTYPE_SCSI;
 	else
 		d -> d_type = BSD_DTYPE_ST506;
@@ -715,9 +715,9 @@ xbsd_readlabel (struct partition *p, struct xbsd_disklabel *d)
 	sector = 0;
 #endif
 
-	if (lseek (fd, (off_t) sector * SECTOR_SIZE, SEEK_SET) == -1)
+	if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE, SEEK_SET) == -1)
 		fatal (unable_to_seek);
-	if (BSD_BBSIZE != read (fd, disklabelbuffer, BSD_BBSIZE))
+	if (BSD_BBSIZE != read (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
 		fatal (unable_to_read);
 
 	memmove (d,
@@ -762,15 +762,15 @@ xbsd_writelabel (struct partition *p, struct xbsd_disklabel *d)
 
 #if defined (__alpha__) && BSD_LABELSECTOR == 0
   alpha_bootblock_checksum (disklabelbuffer);
-  if (lseek (fd, (off_t) 0, SEEK_SET) == -1)
+  if (lseek (cxt->dev_fd, (off_t) 0, SEEK_SET) == -1)
     fatal (unable_to_seek);
-  if (BSD_BBSIZE != write (fd, disklabelbuffer, BSD_BBSIZE))
+  if (BSD_BBSIZE != write (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
     fatal (unable_to_write);
 #else
-  if (lseek (fd, (off_t) sector * SECTOR_SIZE + BSD_LABELOFFSET,
+  if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE + BSD_LABELOFFSET,
 		   SEEK_SET) == -1)
     fatal (unable_to_seek);
-  if (sizeof (struct xbsd_disklabel) != write (fd, d, sizeof (struct xbsd_disklabel)))
+  if (sizeof (struct xbsd_disklabel) != write (cxt->dev_fd, d, sizeof (struct xbsd_disklabel)))
     fatal (unable_to_write);
 #endif
 
diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index 34bcde6..4a93691 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -156,7 +156,7 @@ static void read_extended(int ext)
 			return;
 		}
 
-		read_pte(fd, partitions, extended_offset + get_start_sect(p));
+		read_pte(cxt->dev_fd, partitions, extended_offset + get_start_sect(p));
 
 		if (!extended_offset)
 			extended_offset = get_start_sect(p);
@@ -670,7 +670,7 @@ void dos_write_table(void)
 	}
 	if (MBRbuffer_changed) {
 		write_part_table_flag(MBRbuffer);
-		write_sector(fd, 0, MBRbuffer);
+		write_sector(cxt->dev_fd, 0, MBRbuffer);
 	}
 	/* EBR (logical partitions) */
 	for (i = 4; i < partitions; i++) {
@@ -678,7 +678,7 @@ void dos_write_table(void)
 
 		if (pe->changed) {
 			write_part_table_flag(pe->sectorbuffer);
-			write_sector(fd, pe->offset, pe->sectorbuffer);
+			write_sector(cxt->dev_fd, pe->offset, pe->sectorbuffer);
 		}
 	}
 }
diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index 5e851bc..c2ef06d 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -183,7 +183,7 @@ sgi_list_table(int xtra) {
 	int kpi = 0;		/* kernel partition ID */
 	char *type;
 
-	w = strlen(disk_device);
+	w = strlen(cxt->dev_path);
 
 	if (xtra) {
 		printf(_("\nDisk %s (SGI disk label): %d heads, %llu sectors\n"
@@ -191,7 +191,7 @@ sgi_list_table(int xtra) {
 			 "%d extra sects/cyl, interleave %d:1\n"
 			 "%s\n"
 			 "Units = %s of %d * %d bytes\n\n"),
-		       disk_device, heads, sectors, cylinders,
+		       cxt->dev_path, heads, sectors, cylinders,
 		       SSWAP16(sgiparam.pcylcount),
 		       (int) sgiparam.sparecyl, SSWAP16(sgiparam.ilfact),
 		       (char *)sgilabel,
@@ -201,7 +201,7 @@ sgi_list_table(int xtra) {
 		printf(_("\nDisk %s (SGI disk label): "
 			 "%d heads, %llu sectors, %d cylinders\n"
 			 "Units = %s of %d * %d bytes\n\n"),
-		       disk_device, heads, sectors, cylinders,
+		       cxt->dev_path, heads, sectors, cylinders,
 		       str_units(PLURAL), units_per_sector,
                        sector_size);
 	}
@@ -216,7 +216,7 @@ sgi_list_table(int xtra) {
 			printf(
 				"%2d: %s %4s %9ld %9ld %9ld  %2x  %s\n",
 /* fdisk part number */   i+1,
-/* device */              partname(disk_device, kpi, w+2),
+/* device */              partname(cxt->dev_path, kpi, w+2),
 /* flags */               (sgi_get_swappartition() == i) ? "swap" :
 /* flags */               (sgi_get_bootpartition() == i) ? "boot" : "    ", 
 /* start */               (long) scround(start),
@@ -357,9 +357,9 @@ sgi_write_table(void) {
 		sizeof(*sgilabel)));
 	assert(two_s_complement_32bit_sum(
 		(unsigned int*)sgilabel, sizeof(*sgilabel)) == 0);
-	if (lseek(fd, 0, SEEK_SET) < 0)
+	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
 		fatal(unable_to_seek);
-	if (write(fd, sgilabel, SECTOR_SIZE) != SECTOR_SIZE)
+	if (write(cxt->dev_fd, sgilabel, SECTOR_SIZE) != SECTOR_SIZE)
 		fatal(unable_to_write);
 	if (! strncmp((char *) sgilabel->directory[0].vol_file_name, "sgilabel", 8)) {
 		/*
@@ -368,10 +368,10 @@ sgi_write_table(void) {
 		 */
 		sgiinfo *info = fill_sgiinfo();
 		int infostartblock = SSWAP32(sgilabel->directory[0].vol_file_start);
-		if (lseek(fd, (off_t) infostartblock*
+		if (lseek(cxt->dev_fd, (off_t) infostartblock*
 				SECTOR_SIZE, SEEK_SET) < 0)
 			fatal(unable_to_seek);
-		if (write(fd, info, SECTOR_SIZE) != SECTOR_SIZE)
+		if (write(cxt->dev_fd, info, SECTOR_SIZE) != SECTOR_SIZE)
 			fatal(unable_to_write);
 		free(info);
 	}
@@ -702,11 +702,11 @@ create_sgilabel(void)
 
 	other_endian = (BYTE_ORDER == LITTLE_ENDIAN);
 
-	res = blkdev_get_sectors(fd, &llsectors);
+	res = blkdev_get_sectors(cxt->dev_fd, &llsectors);
 
 #ifdef HDIO_GETGEO
-	if (ioctl(fd, HDIO_GETGEO, &geometry) < 0)
-		err(EXIT_FAILURE, _("HDIO_GETGEO ioctl failed on %s"), disk_device);
+	if (ioctl(cxt->dev_fd, HDIO_GETGEO, &geometry) < 0)
+		err(EXIT_FAILURE, _("HDIO_GETGEO ioctl failed on %s"), cxt->dev_path);
 
 	heads = geometry.heads;
 	sectors = geometry.sectors;
@@ -724,7 +724,7 @@ create_sgilabel(void)
 			_("Warning:  BLKGETSIZE ioctl failed on %s.  "
 			  "Using geometry cylinder value of %d.\n"
 			  "This value may be truncated for devices"
-			  " > 33.8 GB.\n"), disk_device, cylinders);
+			  " > 33.8 GB.\n"), cxt->dev_path, cylinders);
 	}
 #endif
 	for (i = 0; i < 4; i++) {
diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index 4a6db35..6944824 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -172,11 +172,11 @@ void create_sunlabel(void)
 	sunlabel->version = SSWAP32(SUN_LABEL_VERSION);
 	sunlabel->num_partitions = SSWAP16(SUN_NUM_PARTITIONS);
 
-	res = blkdev_get_sectors(fd, &llsectors);
+	res = blkdev_get_sectors(cxt->dev_fd, &llsectors);
 	sec_fac = sector_size / 512;
 
 #ifdef HDIO_GETGEO
-	if (!ioctl(fd, HDIO_GETGEO, &geometry)) {
+	if (!ioctl(cxt->dev_fd, HDIO_GETGEO, &geometry)) {
 	        heads = geometry.heads;
 	        sectors = geometry.sectors;
 		if (res == 0) {
@@ -190,7 +190,7 @@ void create_sunlabel(void)
 				_("Warning:  BLKGETSIZE ioctl failed on %s.  "
 				  "Using geometry cylinder value of %d.\n"
 				  "This value may be truncated for devices"
-				  " > 33.8 GB.\n"), disk_device, cylinders);
+				  " > 33.8 GB.\n"), cxt->dev_path, cylinders);
 		}
 	} else
 #endif
@@ -538,7 +538,7 @@ void sun_list_table(int xtra)
 	int i, w;
 	char *type;
 
-	w = strlen(disk_device);
+	w = strlen(cxt->dev_path);
 	if (xtra)
 		printf(
 		_("\nDisk %s (Sun disk label): %u heads, %llu sectors, %d rpm\n"
@@ -547,7 +547,7 @@ void sun_list_table(int xtra)
 		"Label ID: %s\n"
 		"Volume ID: %s\n"
 		"Units = %s of %d * 512 bytes\n\n"),
-		       disk_device, heads, sectors, SSWAP16(sunlabel->rpm),
+		       cxt->dev_path, heads, sectors, SSWAP16(sunlabel->rpm),
 		       cylinders, SSWAP16(sunlabel->acyl),
 		       SSWAP16(sunlabel->pcyl),
 		       SSWAP16(sunlabel->apc),
@@ -559,7 +559,7 @@ void sun_list_table(int xtra)
 		printf(
 	_("\nDisk %s (Sun disk label): %u heads, %llu sectors, %u cylinders\n"
 	"Units = %s of %d * 512 bytes\n\n"),
-		       disk_device, heads, sectors, cylinders,
+		       cxt->dev_path, heads, sectors, cylinders,
 		       str_units(PLURAL), units_per_sector);
 
 	printf(_("%*s Flag    Start       End    Blocks   Id  System\n"),
@@ -573,7 +573,7 @@ void sun_list_table(int xtra)
 			uint32_t len = SSWAP32(part->num_sectors);
 			printf(
 			    "%s %c%c %9lu %9lu %9lu%c  %2x  %s\n",
-/* device */		  partname(disk_device, i+1, w),
+/* device */		  partname(cxt->dev_path, i+1, w),
 /* flags */		  (tag->flag & SSWAP16(SUN_FLAG_UNMNT)) ? 'u' : ' ',
 			  (tag->flag & SSWAP16(SUN_FLAG_RONLY)) ? 'r' : ' ',
 /* start */		  (unsigned long) scround(start),
@@ -634,9 +634,9 @@ void sun_write_table(void)
 	while(ush < (unsigned short *)(&sunlabel->cksum))
 		csum ^= *ush++;
 	sunlabel->cksum = csum;
-	if (lseek(fd, 0, SEEK_SET) < 0)
+	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
 		fatal(unable_to_seek);
-	if (write(fd, sunlabel, SECTOR_SIZE) != SECTOR_SIZE)
+	if (write(cxt->dev_fd, sunlabel, SECTOR_SIZE) != SECTOR_SIZE)
 		fatal(unable_to_write);
 }
 
diff --git a/fdisk/utils.c b/fdisk/utils.c
new file mode 100644
index 0000000..5138c04
--- /dev/null
+++ b/fdisk/utils.c
@@ -0,0 +1,76 @@
+/*
+ *  Copyright (C) 2012 Davidlohr Bueso <dave@gnu.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "common.h"
+#include "fdisk.h"
+
+/**
+ * fdisk_new_context:
+ *
+ * Returns: newly allocated fdisk context
+ */
+struct fdisk_context *fdisk_new_context_from_filename(const char *fname)
+{
+	int fd, errsv = 0;
+	struct fdisk_context *cxt = NULL;
+
+	/*
+	 * Attempt to open the device with r-w permissions
+	 * by default, otherwise try read-only.
+	 */
+	if ((fd = open(fname, O_RDWR)) < 0)
+		if ((fd = open(fname, O_RDONLY)) < 0)
+			return NULL;
+
+	cxt = calloc(1, sizeof(*cxt));
+	if (!cxt)
+		goto fail;
+
+	cxt->dev_fd = fd;
+	cxt->dev_path = strdup(fname);
+	if (!cxt->dev_path)
+		goto fail;
+
+	return cxt;
+fail:
+	errsv = errno;
+	fdisk_free_context(cxt);
+	errno = errsv;
+	return NULL;
+}
+
+/**
+ * fdisk_free_context:
+ * @cxt: fdisk context
+ *
+ * Deallocates context struct.
+ */
+void fdisk_free_context(struct fdisk_context *cxt)
+{
+	if (!cxt)
+		return;
+
+	close(cxt->dev_fd);
+	free(cxt->dev_path);
+	free(cxt);
+}
-- 
1.7.4.1



