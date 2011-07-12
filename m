Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53440 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab1GLInQ convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 12 Jul 2011 04:43:16 -0400
Received: by qyk29 with SMTP id 29so1840727qyk.19
        for <util-linux@vger.kernel.org>; Tue, 12 Jul 2011 01:43:15 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Tue, 12 Jul 2011 10:43:15 +0200
Message-ID: <CAG27Bk2h5RGntizYO_NzZ80XK=2RHmioxJzkLcX5n3BxrWWcVQ@mail.gmail.com>
Subject: [git pull] mkfs.bfs fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following changes since commit bfa8d39b5826b928deb6d84aee3a4a1d6557364c:

  build-sys: fix spaces versus tabs conflict (2011-07-11 15:12:06 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit mkfs.bfs

Sami Kerola (7):
      mkfs.bfs: use libc error facilities
      mkfs.bfs: add long options
      mkfs.bfs: use xstrdup from xalloc.h
      mkfs.bfs: validate numeric user inputs
      mkfs.bfs: include-what-you-use header check
      mkfs.bfs: coding style fix
      docs: add long options to mkfs.bfs.8

 disk-utils/Makefile.am |    2 +-
 disk-utils/mkfs.bfs.8  |   38 +++++---
 disk-utils/mkfs.bfs.c  |  245 ++++++++++++++++++++++++-----------------------
 3 files changed, 148 insertions(+), 137 deletions(-)

diff --git a/disk-utils/Makefile.am b/disk-utils/Makefile.am
index 7d018b5..604a65c 100644
--- a/disk-utils/Makefile.am
+++ b/disk-utils/Makefile.am
@@ -17,7 +17,7 @@ sbin_PROGRAMS = mkfs mkswap fsck.minix mkfs.minix mkfs.bfs

 fsck_minix_SOURCES = fsck.minix.c minix.h $(top_srcdir)/lib/ismounted.c
 mkfs_minix_SOURCES = mkfs.minix.c minix.h mkfs.h $(utils_common)
$(top_srcdir)/lib/strutils.c
-mkfs_bfs_SOURCES = mkfs.bfs.c $(utils_common)
+mkfs_bfs_SOURCES = mkfs.bfs.c $(utils_common) $(top_srcdir)/lib/strutils.c

 swaplabel_SOURCES = swaplabel.c $(utils_common)
 swaplabel_LDADD = $(uuid_ldadd)
diff --git a/disk-utils/mkfs.bfs.8 b/disk-utils/mkfs.bfs.8
index 741fca9..616c358 100644
--- a/disk-utils/mkfs.bfs.8
+++ b/disk-utils/mkfs.bfs.8
@@ -1,42 +1,48 @@
 .\" Copyright 1999 Andries E. Brouwer (aeb@cwi.nl)
 .\" May be freely distributed.
-.TH MKFS.BFS 8 "12 Sept 1999" "Util-linux 2.9x" "Linux System
Administrator's Manual"
+.TH MKFS.BFS "8" "July 2011" "util-linux" "System Administration Utilities"
 .SH NAME
 mkfs.bfs \- make an SCO bfs filesystem
 .SH SYNOPSIS
 .B mkfs.bfs
-.RB [ \-N
-.IR nr-of-inodes ]
-.RB [ \-V
-.IR volume-name ]
-.RB [ \-F
-.IR fsname ]
-.I device
-.RI [ size-in-blocks ]
+[\fIoptions\fR] \fIdevice \fR[\fIblock-count\fR]
 .SH DESCRIPTION
 .B mkfs.bfs
 creates an SCO bfs file-system on a block device
 (usually a disk partition or a file accessed via the loop device).
-
+.PP
 The
-.I size-in-blocks
+.I block-count
 parameter is the desired size of the file system, in blocks.
 If nothing is specified, the entire partition will be used.
 .SH OPTIONS
 .TP
-.B \-N
+\fB\-N\fR, \fB\-\-inodes\fR=\fINUM\fR
 Specify the desired number of inodes (at most 512).
 If nothing is specified some default number in the range 48-512 is picked
 depending on the size of the partition.
 .TP
-.BI \-V " volume-label"
+\fB\-V\fR, \fB\-\-vname\fR=\fINAME\fR
 Specify the volume label. I have no idea if/where this is used.
 .TP
-.BI \-F " fsname"
+\fB\-F\fR, \fB\-\-fname\fR=\fINAME\fR
 Specify the fsname. I have no idea if/where this is used.
 .TP
-.B \-v
-Be verbose.
+\fB\-v\fR, \fB\-\-verbose\fR
+Explain what is being done.
+.TP
+\fB\-c\fR
+This option is silently ignored.
+.TP
+\fB\-l\fR
+This option is silently ignored.
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Output version information and exit.
+\fB\-V\fR works only when specified as an only option.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help and exit.
 .SH "EXIT CODES"
 The exit code returned by
 .B mkfs.bfs
diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
index 58f5352..3d87fd0 100644
--- a/disk-utils/mkfs.bfs.c
+++ b/disk-utils/mkfs.bfs.c
@@ -1,21 +1,24 @@
 /*
  *  mkfs.bfs - Create SCO BFS filesystem - aeb, 1999-09-07
  *
- *  Usage: mkfs.bfs [-N nr-of-inodes] [-V volume-name] [-F fsname] device
  */

+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <stdarg.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
 #include <string.h>
+#include <sys/stat.h>
 #include <time.h>
-#include "nls.h"
+#include <unistd.h>
+
 #include "blkdev.h"
+#include "c.h"
+#include "nls.h"
+#include "strutils.h"
+#include "xalloc.h"

 #define BFS_ROOT_INO		2
 #define BFS_NAMELEN		14
@@ -24,72 +27,72 @@

 /* superblock - 512 bytes */
 struct bfssb {
-        unsigned int s_magic;
-        unsigned int s_start;	  /* byte offset of start of data */
-        unsigned int s_end;       /* sizeof(slice)-1 */
-
-        /* for recovery during compaction */
-        int s_from, s_to;         /* src and dest block of current transfer */
-        int s_backup_from, s_backup_to;
-
-        /* labels - may well contain garbage */
-        char s_fsname[6];
-        char s_volume[6];
-        char s_pad[472];
+	unsigned int s_magic;
+	unsigned int s_start;	/* byte offset of start of data */
+	unsigned int s_end;	/* sizeof(slice)-1 */
+
+	/* for recovery during compaction */
+	int s_from, s_to;	/* src and dest block of current transfer */
+	int s_backup_from, s_backup_to;
+
+	/* labels - may well contain garbage */
+	char s_fsname[6];
+	char s_volume[6];
+	char s_pad[472];
 };

 /* inode - 64 bytes */
 struct bfsi {
-        unsigned short i_ino;
-        unsigned char i_pad1[2];
-        unsigned long i_first_block;
-        unsigned long i_last_block;
-        unsigned long i_bytes_to_end;
-        unsigned long i_type;           /* 1: file, 2: the unique dir */
-        unsigned long i_mode;
-        unsigned long i_uid, i_gid;
-        unsigned long i_nlinks;
-        unsigned long i_atime, i_mtime, i_ctime;
-        unsigned char i_pad2[16];
+	unsigned short i_ino;
+	unsigned char i_pad1[2];
+	unsigned long i_first_block;
+	unsigned long i_last_block;
+	unsigned long i_bytes_to_end;
+	unsigned long i_type;	/* 1: file, 2: the unique dir */
+	unsigned long i_mode;
+	unsigned long i_uid, i_gid;
+	unsigned long i_nlinks;
+	unsigned long i_atime, i_mtime, i_ctime;
+	unsigned char i_pad2[16];
 };

 #define BFS_DIR_TYPE	2

 /* directory entry - 16 bytes */
 struct bfsde {
-        unsigned short d_ino;
-        char d_name[BFS_NAMELEN];
+	unsigned short d_ino;
+	char d_name[BFS_NAMELEN];
 };

-
-static char *progname;
-
-static void
-fatal(char *s, ...) {
-    va_list p;
-
-    va_start(p, s);
-    fflush(stdout);
-    fprintf(stderr, "\n%s: ", progname);
-    vfprintf(stderr, s, p);
-    va_end(p);
-    fprintf(stderr, "\n");
-    exit(1);
+static void __attribute__ ((__noreturn__)) usage(FILE * out)
+{
+	fprintf(out,
+		_("Usage: %s [options] device [block-count]\n"),
+		program_invocation_short_name);
+	fprintf(out, _("\nOptions:\n"
+		       " -N, --inodes=NUM    specify desired number of inodes\n"
+		       " -V, --vname=NAME    specify volume name\n"
+		       " -F, --fname=NAME    specify file system name\n"
+		       " -v, --verbose       explain what is being done\n"
+		       " -c                  this option is silently ignored\n"
+		       " -l                  this option is silently ignored\n"
+		       " -V, --version       output version information and exit\n"
+		       "                     -V as version must be only option\n"
+		       " -h, --help          display this help and exit\n\n"));
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }

-static void
-usage(void) {
-	fprintf(stderr, _(
-		"Usage: %s [-v] [-N nr-of-inodes] [-V volume-name]\n"
-		"       [-F fsname] device [block-count]\n"),
-		progname);
-	exit(1);
+static void __attribute__ ((__noreturn__)) print_version(void)
+{
+	printf(_("%s (%s)\n"), program_invocation_short_name, PACKAGE_STRING);
+	exit(EXIT_SUCCESS);
 }

-int
-main(int argc, char *argv[]) {
+int main(int argc, char **argv)
+{
 	char *device, *volume, *fsname;
-	int inodes;
+	long inodes;
 	unsigned long long total_blocks, ino_bytes, ino_blocks, data_blocks;
 	unsigned long long user_specified_total_blocks = 0;
 	int verbose = 0;
@@ -100,106 +103,109 @@ main(int argc, char *argv[]) {
 	struct stat statbuf;
 	time_t now;
 	int c, i, len;
-	char *p;

-	progname = argv[0];
-	if ((p = strrchr(progname, '/')) != NULL)
-		progname = p+1;
+	enum { VERSION_OPTION = CHAR_MAX + 1 };
+	static const struct option longopts[] = {
+		{"inodes", required_argument, NULL, 'N'},
+		{"vname", required_argument, NULL, 'V'},
+		{"fname", required_argument, NULL, 'F'},
+		{"verbose", no_argument, NULL, 'v'},
+		{"version", no_argument, NULL, VERSION_OPTION},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};

 	if (argc < 2)
-		usage();
+		usage(stderr);

-	if (argc == 2 &&
-	    (!strcmp(argv[1], "-V") || !strcmp(argv[1], "--version"))) {
-		printf(_("%s (%s)\n"), progname, PACKAGE_STRING);
-		exit(0);
-	}
+	if (argc == 2 && !strcmp(argv[1], "-V"))
+		print_version();

 	volume = fsname = "      ";	/* is there a default? */
 	inodes = 0;

-	while ((c = getopt(argc, argv, "vF:N:V:cl:")) != -1) {
+	while ((c = getopt_long(argc, argv, "N:V:F:vhcl", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'N':
-			inodes = atol(optarg);
+			inodes = strtol_or_err(optarg, _("invalid number of inodes"));
 			break;

 		case 'V':
 			len = strlen(optarg);
 			if (len <= 0 || len > 6)
-				fatal(_("volume name too long"));
-			volume = strdup(optarg);
+				errx(EXIT_FAILURE, _("volume name too long"));
+			volume = xstrdup(optarg);
 			break;

 		case 'F':
 			len = strlen(optarg);
 			if (len <= 0 || len > 6)
-				fatal(_("fsname name too long"));
-			fsname = strdup(optarg);
+				errx(EXIT_FAILURE, _("fsname name too long"));
+			fsname = xstrdup(optarg);
 			break;

 		case 'v':
 			verbose = 1;
 			break;

-			/* when called via mkfs we may get options c,l,v */
 		case 'c':
 		case 'l':
+			/* when called via mkfs we may get options c,l,v */
 			break;

+		case VERSION_OPTION:
+			print_version();
+		case 'h':
+			usage(stdout);
 		default:
-			usage();
+			usage(stderr);
 		}
 	}

 	if (optind == argc)
-		usage();
+		usage(stderr);

 	device = argv[optind++];

-	if (stat(device, &statbuf) == -1) {
-		perror(device);
-		fatal(_("cannot stat device %s"), device);
-	}
+	if (stat(device, &statbuf) < 0)
+		err(EXIT_FAILURE, _("cannot stat device %s"), device);

 	if (!S_ISBLK(statbuf.st_mode))
-		fatal(_("%s is not a block special device"), device);
+		errx(EXIT_FAILURE, _("%s is not a block special device"), device);

 	fd = open(device, O_RDWR | O_EXCL);
-	if (fd == -1) {
-		perror(device);
-		fatal(_("cannot open %s"), device);
-	}
+	if (fd < 0)
+		err(EXIT_FAILURE, _("cannot open %s"), device);

-	if (optind == argc-1)
-		user_specified_total_blocks = atoll(argv[optind]);
+	if (optind == argc - 1)
+		user_specified_total_blocks =
+			strtoll_or_err(argv[optind], _("invalid block-count"));
 	else if (optind != argc)
-		usage();
+		usage(stderr);

 	if (blkdev_get_sectors(fd, &total_blocks) == -1) {
-		if (!user_specified_total_blocks) {
-			perror("blkdev_get_sectors");
-			fatal(_("cannot get size of %s"), device);
-		}
+		if (!user_specified_total_blocks)
+			err(EXIT_FAILURE, _("cannot get size of %s"), device);
 		total_blocks = user_specified_total_blocks;
 	} else if (user_specified_total_blocks) {
 		if (user_specified_total_blocks > total_blocks)
-			fatal(_("blocks argument too large, max is %llu"),
-			      total_blocks);
+			errx(EXIT_FAILURE,
+			     _("blocks argument too large, max is %llu"),
+			     total_blocks);
 		total_blocks = user_specified_total_blocks;
 	}

 	if (!inodes) {
 		/* pick some reasonable default */
-		inodes = 8*(total_blocks/800);
+		inodes = 8 * (total_blocks / 800);
 		if (inodes < 48)
 			inodes = 48;
-		if (inodes > 512)
+		if (512 < inodes)
 			inodes = 512;
 	} else {
 		/* believe the user */
-		if (inodes > 512)
-			fatal(_("too many inodes - max is 512"));
+		if (512 < inodes)
+			errx(EXIT_FAILURE, _("too many inodes - max is 512"));
 	}

 	ino_bytes = inodes * sizeof(struct bfsi);
@@ -208,8 +214,9 @@ main(int argc, char *argv[]) {

 	/* mimic the behaviour of SCO's mkfs - maybe this limit is needed */
 	if (data_blocks < 32)
-		fatal(_("not enough space, need at least %llu blocks"),
-		      ino_blocks + 33);
+		errx(EXIT_FAILURE,
+		     _("not enough space, need at least %llu blocks"),
+		     ino_blocks + 33);

 	memset(&sb, 0, sizeof(sb));
 	sb.s_magic = BFS_SUPER_MAGIC;
@@ -224,29 +231,29 @@ main(int argc, char *argv[]) {
 		fprintf(stderr, _("Volume: <%-6s>\n"), volume);
 		fprintf(stderr, _("FSname: <%-6s>\n"), fsname);
 		fprintf(stderr, _("BlockSize: %d\n"), BFS_BLOCKSIZE);
-		if (ino_blocks==1)
-			fprintf(stderr, _("Inodes: %d (in 1 block)\n"),
+		if (ino_blocks == 1)
+			fprintf(stderr, _("Inodes: %lu (in 1 block)\n"),
 				inodes);
 		else
-			fprintf(stderr, _("Inodes: %d (in %lld blocks)\n"),
+			fprintf(stderr, _("Inodes: %lu (in %llu blocks)\n"),
 				inodes, ino_blocks);
 		fprintf(stderr, _("Blocks: %lld\n"), total_blocks);
 		fprintf(stderr, _("Inode end: %d, Data end: %d\n"),
-			sb.s_start-1, sb.s_end);
+			sb.s_start - 1, sb.s_end);
 	}

 	if (write(fd, &sb, sizeof(sb)) != sizeof(sb))
-		fatal(_("error writing superblock"));
+		errx(EXIT_FAILURE, _("error writing superblock"));

 	memset(&ri, 0, sizeof(ri));
 	ri.i_ino = BFS_ROOT_INO;
 	ri.i_first_block = 1 + ino_blocks;
 	ri.i_last_block = ri.i_first_block +
-		(inodes * sizeof(de) - 1) / BFS_BLOCKSIZE;
+	    (inodes * sizeof(de) - 1) / BFS_BLOCKSIZE;
 	ri.i_bytes_to_end = ri.i_first_block * BFS_BLOCKSIZE
-		+ 2 * sizeof(struct bfsde) - 1;
+	    + 2 * sizeof(struct bfsde) - 1;
 	ri.i_type = BFS_DIR_TYPE;
-	ri.i_mode = S_IFDIR | 0755; 	/* or just 0755 */
+	ri.i_mode = S_IFDIR | 0755;	/* or just 0755 */
 	ri.i_uid = 0;
 	ri.i_gid = 1;			/* random */
 	ri.i_nlinks = 2;
@@ -256,30 +263,28 @@ main(int argc, char *argv[]) {
 	ri.i_ctime = now;

 	if (write(fd, &ri, sizeof(ri)) != sizeof(ri))
-		fatal(_("error writing root inode"));
+		errx(EXIT_FAILURE, _("error writing root inode"));

 	memset(&ri, 0, sizeof(ri));
-	for (i=1; i<inodes; i++)
+	for (i = 1; i < inodes; i++)
 		if (write(fd, &ri, sizeof(ri)) != sizeof(ri))
-			fatal(_("error writing inode"));
+			errx(EXIT_FAILURE, _("error writing inode"));

-	if (lseek(fd, (1 + ino_blocks)*BFS_BLOCKSIZE, SEEK_SET) == -1)
-		fatal(_("seek error"));
+	if (lseek(fd, (1 + ino_blocks) * BFS_BLOCKSIZE, SEEK_SET) == -1)
+		errx(EXIT_FAILURE, _("seek error"));

 	memset(&de, 0, sizeof(de));
 	de.d_ino = BFS_ROOT_INO;
 	memcpy(de.d_name, ".", 1);
 	if (write(fd, &de, sizeof(de)) != sizeof(de))
-		fatal(_("error writing . entry"));
+		errx(EXIT_FAILURE, _("error writing . entry"));

 	memcpy(de.d_name, "..", 2);
 	if (write(fd, &de, sizeof(de)) != sizeof(de))
-		fatal(_("error writing .. entry"));
+		errx(EXIT_FAILURE, _("error writing .. entry"));

-	if (close(fd) == -1) {
-		perror(device);
-		fatal(_("error closing %s"), device);
-	}
+	if (close(fd) < 0)
+		err(EXIT_FAILURE, _("error closing %s"), device);

-	return 0;
+	return EXIT_SUCCESS;
 }

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
