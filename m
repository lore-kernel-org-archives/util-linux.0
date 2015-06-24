Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33360 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbbFXIPb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:31 -0400
Received: by wgck11 with SMTP id k11so29416022wgc.0
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/12] mkfs.minix: introduce long options to the command
Date: Wed, 24 Jun 2015 09:15:09 +0100
Message-Id: <1435133719-2971-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/mkfs.minix |  16 +++----
 disk-utils/mkfs.minix.8    |  28 +++++++-----
 disk-utils/mkfs.minix.c    | 107 +++++++++++++++++++++++----------------------
 3 files changed, 78 insertions(+), 73 deletions(-)

diff --git a/bash-completion/mkfs.minix b/bash-completion/mkfs.minix
index 3a3602e..e725fd6 100644
--- a/bash-completion/mkfs.minix
+++ b/bash-completion/mkfs.minix
@@ -5,25 +5,23 @@ _mkfs.minix_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
-		'-i')
+		'-i'|'--inodes')
 			COMPREPLY=( $(compgen -W "inodes" -- $cur) )
 			return 0
 			;;
-		'-l')
-			COMPREPLY=( $(compgen -W "badblocks-file" -- $cur) )
+		'-l'|'--badblocks')
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
 			return 0
 			;;
-		'-n')
-			COMPREPLY=( $(compgen -W "14 30" -- $cur) )
-			return 0
-			;;
-		'-V'|'--version')
+		'-n'|'--namelength')
+			COMPREPLY=( $(compgen -W "14 30 60" -- $cur) )
 			return 0
 			;;
 	esac
 	case $cur in
 		-*)
-			OPTS="-c -i -l -n -1 -2 -3"
+			OPTS="--namelength --inodes --check --badblocks --help --version -1 -2 -3"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/disk-utils/mkfs.minix.8 b/disk-utils/mkfs.minix.8
index 2deeaf1..e46a768 100644
--- a/disk-utils/mkfs.minix.8
+++ b/disk-utils/mkfs.minix.8
@@ -1,17 +1,11 @@
 .\" Copyright 1992, 1993, 1994 Rickard E. Faith (faith@cs.unc.edu)
 .\" May be freely distributed.
-.TH MKFS.MINIX 8 "June 2011" "util-linux" "System Administration"
+.TH MKFS.MINIX 8 "June 2015" "util-linux" "System Administration"
 .SH NAME
 mkfs.minix \- make a Minix filesystem
 .SH SYNOPSIS
 .B mkfs.minix
-.RB [ \-c | \-l
-.IR filename ]
-.RB [ \-n
-.IR namelength ]
-.RB [ \-i
-.IR inodecount ]
-.RB [ \-v ]
+[options]
 .I device
 .RI [ size-in-blocks ]
 .SH DESCRIPTION
@@ -31,6 +25,9 @@ is usually of the following form:
 .RE
 .fi
 
+The device may be a block device or a image file of one, but this is not
+enforced.  Expect not much fun on a character device :-).
+.PP
 The
 .I size-in-blocks
 parameter is the desired size of the file system, in blocks.
@@ -40,20 +37,20 @@ Only block counts strictly greater than 10 and strictly less than
 65536 are allowed.
 .SH OPTIONS
 .TP
-.B \-c
+\fB\-c\fR, \fB\-\-check\fR
 Check the device for bad blocks before creating the filesystem.  If any
 are found, the count is printed.
 .TP
-.BI \-n " namelength"
+\fB\-n\fR, \fB\-\-namelength\fR \fIlength\fR
 Specify the maximum length of filenames.
 Currently, the only allowable values are 14 and 30.
 The default is 30.  Note that kernels older than 0.99p7
 only accept namelength 14.
 .TP
-.BI \-i " inodecount"
+\fB\-i\fR, \fB\-\-inodes\fR \fInumber\fR
 Specify the number of inodes for the filesystem.
 .TP
-.BI \-l " filename"
+\fB\-l\fR, \fB\-\-badblocks\fR \fIfilename\fR
 Read the list of bad blocks from
 .IR filename .
 The file has one bad-block number per line.  The count of bad blocks read
@@ -67,6 +64,13 @@ Make a Minix version 2 filesystem.
 .TP
 .B \-3
 Make a Minix version 3 filesystem.
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Display version information and exit.  The long option cannot be combined
+with other options.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help text and exit.
 .SH "EXIT CODES"
 The exit code returned by
 .B mkfs.minix
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 564f2b4..9e4212f 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -52,18 +52,6 @@
  * 06.20.15  -  Do not infinite loop or crash on large devices
  *              Joshua Hudson <joshudson@gmail.com>
  *
- * Usage:  mkfs [-c | -l filename ] [-12v3] [-nXX] [-iXX] device [size-in-blocks]
- *
- *	-c for readablility checking (SLOW!)
- *      -l for getting a list of bad blocks from a file.
- *	-n for namelength (currently the kernel only uses 14 or 30)
- *	-i for number of inodes
- *      -1 for v1 filesystem
- *	-2,-v for v2 filesystem
- *      -3 for v3 filesystem
- *
- * The device may be a block device or a image of one, but this isn't
- * enforced (but it's not much fun on a character device :-). 
  */
 
 #include <stdio.h>
@@ -109,7 +97,6 @@ static char *inode_buffer = NULL;
 #define Inode (((struct minix_inode *) inode_buffer) - 1)
 #define Inode2 (((struct minix2_inode *) inode_buffer) - 1)
 
-static char *program_name = "mkfs";
 static char *device_name;
 static int DEV = -1;
 static unsigned long long BLOCKS;
@@ -146,11 +133,23 @@ static char *zone_map;
 #define mark_zone(x) (setbit(zone_map,(x)-get_first_zone()+1))
 #define unmark_zone(x) (clrbit(zone_map,(x)-get_first_zone()+1))
 
-
-static void __attribute__((__noreturn__))
-usage(void) {
-	errx(MKFS_EX_USAGE, _("Usage: %s [-c | -l filename] [-nXX] [-iXX] /dev/name [blocks]"),
-	     program_name);
+static void __attribute__((__noreturn__)) usage(FILE *out)
+{
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] /dev/name [blocks]\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -1                      use Minix version 1\n"), out);
+	fputs(_(" -2, -v                  use Minix version 2\n"), out);
+	fputs(_(" -3                      use Minix version 3\n"), out);
+	fputs(_(" -n, --namelength <num>  maximum length of filenames\n"), out);
+	fputs(_(" -i, --inodes <num>      number of inodes for the filesystem\n"), out);
+	fputs(_(" -c, --check             check the device for bad blocks\n"), out);
+	fputs(_(" -l, --badblocks <file>  list of bad blocks from file\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("mkfs.minix(8)"));
+	exit(out == stderr ? MKFS_EX_USAGE : MKFS_EX_OK);
 }
 
 /*
@@ -538,7 +537,7 @@ static void setup_tables(void) {
 	if (MINIX_MAX_INODES < first_zone_data())
 		errx(MKFS_EX_ERROR,
 		     _("First data block at %jd, which is too far (max %d).\n"
-		       "Try specifying fewer inodes by passing -i <inodes>"),
+		       "Try specifying fewer inodes by passing --inodes <num>"),
 		     first_zone_data(),
 		     MINIX_MAX_INODES);
 	imaps = get_nimaps();
@@ -666,40 +665,41 @@ int main(int argc, char ** argv) {
 	char * tmp;
 	struct stat statbuf;
 	char * listfile = NULL;
-	char * p;
-
-	if (argc && *argv)
-		program_name = *argv;
-	if ((p = strrchr(program_name, '/')) != NULL)
-		program_name = p+1;
+	static const struct option longopts[] = {
+		{"namelength", required_argument, NULL, 'n'},
+		{"inodes", required_argument, NULL, 'i'},
+		{"check", no_argument, NULL, 'c'},
+		{"badblocks", required_argument, NULL, 'l'},
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	if (argc == 2 &&
-	    (!strcmp(argv[1], "-V") || !strcmp(argv[1], "--version"))) {
-		printf(UTIL_LINUX_VERSION);
-		exit(MKFS_EX_OK);
-	}
-
 	if (INODE_SIZE * MINIX_INODES_PER_BLOCK != MINIX_BLOCK_SIZE)
 		errx(MKFS_EX_ERROR, _("%s: bad inode size"), device_name);
 	if (INODE2_SIZE * MINIX2_INODES_PER_BLOCK != MINIX_BLOCK_SIZE)
 		errx(MKFS_EX_ERROR, _("%s: bad inode size"), device_name);
 
-	opterr = 0;
-	while ((i = getopt(argc, argv, "ci:l:n:v123")) != -1)
+	while ((i = getopt_long(argc, argv, "1v23n:i:cl:Vh", longopts, NULL)) != -1)
 		switch (i) {
-		case 'c':
-			check=1; break;
-		case 'i':
-			req_nr_inodes = strtoul_or_err(optarg,
-					_("failed to parse number of inodes"));
+		case '1':
+			fs_version = 1;
+			break;
+		case 'v': /* kept for backwards compatiblitly */
+			warnx(_("-v is ambiguous, use '-2' instead"));
+		case '2':
+			fs_version = 2;
+			break;
+		case '3':
+			fs_version = 3;
+			namelen = 60;
+			dirsize = 64;
 			break;
-		case 'l':
-			listfile = optarg; break;
 		case 'n':
 			i = strtoul_or_err(optarg,
 					_("failed to parse maximum length of filenames"));
@@ -708,24 +708,27 @@ int main(int argc, char ** argv) {
 			else if (i == 30)
 				magic = MINIX_SUPER_MAGIC2;
 			else
-				usage();
+				usage(stderr);
 			namelen = i;
 			dirsize = i+2;
 			break;
-		case '1':
-			fs_version = 1;
+		case 'i':
+			req_nr_inodes = strtoul_or_err(optarg,
+					_("failed to parse number of inodes"));
 			break;
-		case '2':
-		case 'v': /* kept for backwards compatiblitly */
-			fs_version = 2;
+		case 'c':
+			check=1;
 			break;
-		case '3':
-			fs_version = 3;
-			namelen = 60;
-			dirsize = 64;
+		case 'l':
+			listfile = optarg;
 			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return MKFS_EX_OK;
+		case 'h':
+			usage(stdout);
 		default:
-			usage();
+			usage(stderr);
 		}
 	argc -= optind;
 	argv += optind;
@@ -738,7 +741,7 @@ int main(int argc, char ** argv) {
 		BLOCKS = strtoul_or_err(argv[0], _("failed to parse number of blocks"));
 
 	if (!device_name) {
-		usage();
+		usage(stderr);
 	}
 	check_mount();		/* is it already mounted? */
 	tmp = root_block;
-- 
2.4.4

