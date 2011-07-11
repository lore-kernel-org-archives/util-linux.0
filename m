Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46365 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab1GKMyE convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Jul 2011 08:54:04 -0400
Received: by qwk3 with SMTP id 3so1837619qwk.19
        for <util-linux@vger.kernel.org>; Mon, 11 Jul 2011 05:54:04 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Mon, 11 Jul 2011 14:54:04 +0200
Message-ID: <CAG27Bk0MvKRCW1d_fQ3-k2s4HXTdy-S1NyVC4UFM2Boxig9usA@mail.gmail.com>
Subject: [git pull] isosize fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following changes since commit 37b94458bd0f4a178233ad0366a727bf5bde879f:

  sfdisk: fix coding style. (2011-06-29 12:47:38 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit isosize

Sami Kerola (6):
      isosize: remove global variables
      isosize: use long options
      isosize: check user input to be numeric
      isosize: include-what-you-use header check
      isosize: fix coding style
      docs: isosize.8 add long options

 disk-utils/Makefile.am |    1 +
 disk-utils/isosize.8   |   16 ++--
 disk-utils/isosize.c   |  221 +++++++++++++++++++++++++-----------------------
 3 files changed, 122 insertions(+), 116 deletions(-)

diff --git a/disk-utils/Makefile.am b/disk-utils/Makefile.am
index cf4a3e8..6b937bd 100644
--- a/disk-utils/Makefile.am
+++ b/disk-utils/Makefile.am
@@ -27,6 +27,7 @@ mkswap_SOURCES = mkswap.c $(utils_common)
$(top_srcdir)/lib/wholedisk.c $(top_sr
 mkswap_LDADD = $(uuid_ldadd)
 mkswap_CFLAGS = $(AM_CFLAGS) $(uuid_cflags)

+isosize_SOURCES = isosize.c $(top_srcdir)/lib/strutils.c
 usrbin_exec_PROGRAMS = isosize
 usrsbin_exec_PROGRAMS =

diff --git a/disk-utils/isosize.8 b/disk-utils/isosize.8
index ea878cf..160f8eb 100644
--- a/disk-utils/isosize.8
+++ b/disk-utils/isosize.8
@@ -1,12 +1,9 @@
-.TH ISOSIZE "8" "December 2000" "sg3_utils-0.91" SG_UTILS
+.TH ISOSIZE "8" "June 2011" "util-linux" "System Administration Utilities"
 .SH NAME
 isosize \- outputs the length of an iso9660 file system
 .SH SYNOPSIS
 .B isosize
-.RB [ \-x ]
-.RB [ \-d
-.IR <num> ]
-.IR <iso9660_image_file> ...
+[\fIoptions\fR] \fIiso9660_image_file\fR
 .SH DESCRIPTION
 .\" Add any additional description here
 .PP
@@ -15,19 +12,20 @@ is contained in given file. That file may be a
normal file or
 a block device (e.g. /dev/hdd or /dev/sr0). In the absence of
 any switches (or errors) it will output the size of the iso9660
 file system in bytes. This can now be a large number (>> 4 GB).
+.SH OPTIONS
 .TP
-.B \-x
+\fB\-x\fR, \fB\-\-sectors\fR
 output in humanly readable form the block count and the block
 size. Output uses the term "sectors" for "blocks".
 .TP
-.BI \-d\  <num>
+\fB\-d\fR, \fB\-\-divisor\fR=\fINUM\fR
 only has affect when
 .B \-x
 is not given. The number output (if no errors)
 is the iso9660 file size in bytes divided by
-.IR <num> .
+.IR NUM .
 So if
-.I <num>
+.I NUM
 is the block size then the output number will be the block count.
 .PP
 The size of the file (or block device) holding a iso9660 file
diff --git a/disk-utils/isosize.c b/disk-utils/isosize.c
index 2bdc74a..7bfa81d 100644
--- a/disk-utils/isosize.c
+++ b/disk-utils/isosize.c
@@ -23,132 +23,128 @@
 #include <getopt.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <string.h>
 #include <errno.h>

 #include "nls.h"
 #include "c.h"
+#include "strutils.h"

 #define ISODCL(from, to) (to - from + 1)

-int xflag;
-
-static int
-isonum_721 (unsigned char * p) {
-        return ((p[0] & 0xff)
-                | ((p[1] & 0xff) << 8));
+static int isonum_721(unsigned char *p)
+{
+	return ((p[0] & 0xff)
+		| ((p[1] & 0xff) << 8));
 }

-static int
-isonum_722 (unsigned char * p) {
-        return ((p[1] & 0xff)
-                | ((p[0] & 0xff) << 8));
+static int isonum_722(unsigned char *p)
+{
+	return ((p[1] & 0xff)
+		| ((p[0] & 0xff) << 8));
 }

-static int
-isonum_723 (unsigned char * p) {
-        int le = isonum_721 (p);
-        int be = isonum_722 (p+2);
-        if (xflag && le != be)
+static int isonum_723(unsigned char *p, int xflag)
+{
+	int le = isonum_721(p);
+	int be = isonum_722(p + 2);
+	if (xflag && le != be)
 		/* translation is useless */
-                fprintf(stderr, "723error: le=%d be=%d\n", le, be);
-        return (le);
+		warnx("723error: le=%d be=%d", le, be);
+	return (le);
 }

-static int
-isonum_731 (unsigned char * p) {
-    return ((p[0] & 0xff)
-            | ((p[1] & 0xff) << 8)
-            | ((p[2] & 0xff) << 16)
-            | ((p[3] & 0xff) << 24));
+static int isonum_731(unsigned char *p)
+{
+	return ((p[0] & 0xff)
+		| ((p[1] & 0xff) << 8)
+		| ((p[2] & 0xff) << 16)
+		| ((p[3] & 0xff) << 24));
 }

-static int
-isonum_732 (unsigned char * p) {
-    return ((p[3] & 0xff)
-            | ((p[2] & 0xff) << 8)
-            | ((p[1] & 0xff) << 16)
-            | ((p[0] & 0xff) << 24));
+static int isonum_732(unsigned char *p)
+{
+	return ((p[3] & 0xff)
+		| ((p[2] & 0xff) << 8)
+		| ((p[1] & 0xff) << 16)
+		| ((p[0] & 0xff) << 24));
 }

-
-static int
-isonum_733 (unsigned char * p) {
-    int le = isonum_731 (p);
-    int be = isonum_732 (p+4);
-    if (xflag && le != be)
-	    /* translation is useless */
-            fprintf(stderr, "733error: le=%d be=%d\n", le, be);
-    return (le);
+static int isonum_733(unsigned char *p, int xflag)
+{
+	int le = isonum_731(p);
+	int be = isonum_732(p + 4);
+	if (xflag && le != be)
+		/* translation is useless */
+		warn("733error: le=%d be=%d", le, be);
+	return (le);
 }

-struct iso_primary_descriptor {
-    unsigned char type                      [ISODCL (  1,   1)]; /* 711 */
-    unsigned char id                        [ISODCL (  2,   6)];
-    unsigned char version                   [ISODCL (  7,   7)]; /* 711 */
-    unsigned char unused1                   [ISODCL (  8,   8)];
-    unsigned char system_id                 [ISODCL (  9,  40)]; /* auchars */
-    unsigned char volume_id                 [ISODCL ( 41,  72)]; /* duchars */
-    unsigned char unused2                   [ISODCL ( 73,  80)];
-    unsigned char volume_space_size         [ISODCL ( 81,  88)]; /* 733 */
-    unsigned char unused3                   [ISODCL ( 89, 120)];
-    unsigned char volume_set_size           [ISODCL (121, 124)]; /* 723 */
-    unsigned char volume_sequence_number    [ISODCL (125, 128)]; /* 723 */
-    unsigned char logical_block_size        [ISODCL (129, 132)]; /* 723 */
-    unsigned char path_table_size           [ISODCL (133, 140)]; /* 733 */
-    unsigned char type_l_path_table         [ISODCL (141, 144)]; /* 731 */
-    unsigned char opt_type_l_path_table     [ISODCL (145, 148)]; /* 731 */
-    unsigned char type_m_path_table         [ISODCL (149, 152)]; /* 732 */
-    unsigned char opt_type_m_path_table     [ISODCL (153, 156)]; /* 732 */
-    unsigned char root_directory_record     [ISODCL (157, 190)]; /* 9.1 */
-    unsigned char volume_set_id             [ISODCL (191, 318)]; /* duchars */
-    unsigned char publisher_id              [ISODCL (319, 446)]; /* achars */
-    unsigned char preparer_id               [ISODCL (447, 574)]; /* achars */
-    unsigned char application_id            [ISODCL (575, 702)]; /* achars */
-    unsigned char copyright_file_id         [ISODCL (703, 739)]; /*
7.5 dchars */
-    unsigned char abstract_file_id          [ISODCL (740, 776)]; /*
7.5 dchars */
-    unsigned char bibliographic_file_id     [ISODCL (777, 813)]; /*
7.5 dchars */
-    unsigned char creation_date             [ISODCL (814, 830)]; /* 8.4.26.1 */
-    unsigned char modification_date         [ISODCL (831, 847)]; /* 8.4.26.1 */
-    unsigned char expiration_date           [ISODCL (848, 864)]; /* 8.4.26.1 */
-    unsigned char effective_date            [ISODCL (865, 881)]; /* 8.4.26.1 */
-    unsigned char file_structure_version    [ISODCL (882, 882)]; /* 711 */
-    unsigned char unused4                   [ISODCL (883, 883)];
-    unsigned char application_data          [ISODCL (884, 1395)];
-    unsigned char unused5                   [ISODCL (1396, 2048)];
+struct iso_primary_descriptor
+{
+	unsigned char type			[ISODCL (   1,	  1)]; /* 711 */
+	unsigned char id			[ISODCL (   2,	  6)];
+	unsigned char version			[ISODCL (   7,	  7)]; /* 711 */
+	unsigned char unused1			[ISODCL (   8,	  8)];
+	unsigned char system_id			[ISODCL (   9,	 40)]; /* auchars */
+	unsigned char volume_id			[ISODCL (  41,	 72)]; /* duchars */
+	unsigned char unused2			[ISODCL (  73,	 80)];
+	unsigned char volume_space_size		[ISODCL (  81,	 88)]; /* 733 */
+	unsigned char unused3			[ISODCL (  89,	120)];
+	unsigned char volume_set_size		[ISODCL ( 121,	124)]; /* 723 */
+	unsigned char volume_sequence_number	[ISODCL ( 125,	128)]; /* 723 */
+	unsigned char logical_block_size	[ISODCL ( 129,	132)]; /* 723 */
+	unsigned char path_table_size		[ISODCL ( 133,	140)]; /* 733 */
+	unsigned char type_l_path_table		[ISODCL ( 141,	144)]; /* 731 */
+	unsigned char opt_type_l_path_table	[ISODCL ( 145,	148)]; /* 731 */
+	unsigned char type_m_path_table		[ISODCL ( 149,	152)]; /* 732 */
+	unsigned char opt_type_m_path_table	[ISODCL ( 153,	156)]; /* 732 */
+	unsigned char root_directory_record	[ISODCL ( 157,	190)]; /* 9.1 */
+	unsigned char volume_set_id		[ISODCL ( 191,	318)]; /* duchars */
+	unsigned char publisher_id		[ISODCL ( 319,	446)]; /* achars */
+	unsigned char preparer_id		[ISODCL ( 447,	574)]; /* achars */
+	unsigned char application_id		[ISODCL ( 575,	702)]; /* achars */
+	unsigned char copyright_file_id		[ISODCL ( 703,	739)]; /* 7.5 dchars */
+	unsigned char abstract_file_id		[ISODCL ( 740,	776)]; /* 7.5 dchars */
+	unsigned char bibliographic_file_id	[ISODCL ( 777,	813)]; /* 7.5 dchars */
+	unsigned char creation_date		[ISODCL ( 814,	830)]; /* 8.4.26.1 */
+	unsigned char modification_date		[ISODCL ( 831,	847)]; /* 8.4.26.1 */
+	unsigned char expiration_date		[ISODCL ( 848,	864)]; /* 8.4.26.1 */
+	unsigned char effective_date		[ISODCL ( 865,	881)]; /* 8.4.26.1 */
+	unsigned char file_structure_version	[ISODCL ( 882,	882)]; /* 711 */
+	unsigned char unused4			[ISODCL ( 883,	883)];
+	unsigned char application_data		[ISODCL ( 884, 1395)];
+	unsigned char unused5			[ISODCL (1396, 2048)];
 };

-int divisor = 0;
-
-static void
-isosize(char *filenamep) {
+static void isosize(char *filenamep, int xflag, long divisor)
+{
 	int fd, nsecs, ssize;
 	struct iso_primary_descriptor ipd;

 	if ((fd = open(filenamep, O_RDONLY)) < 0)
 		err(EXIT_FAILURE, _("failed to open %s"), filenamep);

-	if (lseek(fd, 16 << 11, 0) == (off_t)-1)
+	if (lseek(fd, 16 << 11, 0) == (off_t) - 1)
 		err(EXIT_FAILURE, _("seek error on %s"), filenamep);

 	if (read(fd, &ipd, sizeof(ipd)) < 0)
 		err(EXIT_FAILURE, _("read error on %s"), filenamep);

-	nsecs = isonum_733(ipd.volume_space_size);
-	ssize = isonum_723(ipd.logical_block_size); /* nowadays always 2048 */
+	nsecs = isonum_733(ipd.volume_space_size, xflag);
+	/* isonum_723 returns nowadays always 2048 */
+	ssize = isonum_723(ipd.logical_block_size, xflag);

 	if (xflag) {
-		printf (_("sector count: %d, sector size: %d\n"),
-			nsecs, ssize);
+		printf(_("sector count: %d, sector size: %d\n"), nsecs, ssize);
 	} else {
 		long long product = nsecs;

 		if (divisor == 0)
-			printf ("%lld\n", product * ssize);
+			printf("%lld\n", product * ssize);
 		else if (divisor == ssize)
-			printf ("%d\n", nsecs);
+			printf("%d\n", nsecs);
 		else
-			printf ("%lld\n", (product * ssize) / divisor);
+			printf("%lld\n", (product * ssize) / divisor);
 	}

 	close(fd);
@@ -156,55 +152,66 @@ isosize(char *filenamep) {

 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
-	fprintf(out, _("Usage: %s [-x] [-d <num>] iso9660-image\n"),
+	fprintf(out, _("\nUsage:\n"
+		       " %s [options] iso9660_image_file\n"),
 		program_invocation_short_name);

+	fprintf(out, _("\nOptions:\n"
+		       " -d, --divisor=NUM      devide bytes NUM\n"
+		       " -x, --sectors          show sector count and size\n"
+		       " -V, --version          output version information and exit\n"
+		       " -H, --help             display this help and exit\n\n"));
+
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }

-int
-main(int argc, char * argv[]) {
-	int j, ct;
+int main(int argc, char **argv)
+{
+	int j, ct, opt, xflag = 0;
+	long divisor = 0;
+
+	static const struct option longopts[] = {
+		{"divisor", no_argument, 0, 'd'},
+		{"sectors", no_argument, 0, 'x'},
+		{"version", no_argument, 0, 'V'},
+		{"help", no_argument, 0, 'h'},
+		{NULL, 0, 0, 0}
+	};

 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);

-	if (argc >= 2 &&
-	    (!strcmp(argv[1], "-V") || !strcmp(argv[1], "--version"))) {
-		printf(_("%s (%s)\n"), program_invocation_short_name, PACKAGE_STRING);
-		return EXIT_SUCCESS;
-	}
-
-	for (;;) {
-		int opt;
-
-		opt = getopt(argc, argv, "xd:");
-		if (opt == -1)
-			break;
+	while ((opt = getopt_long(argc, argv, "d:xVh", longopts, NULL)) != -1)
 		switch (opt) {
 		case 'd':
-			divisor = atoi(optarg);
+			divisor =
+			    strtol_or_err(optarg,
+					  _("invalid divisor argument"));
 			break;
 		case 'x':
 			xflag = 1;
 			break;
+		case 'V':
+			printf(_("%s (%s)\n"), program_invocation_short_name,
+			       PACKAGE_STRING);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
 		default:
 			usage(stderr);
 		}
-	}

 	ct = argc - optind;

-	if (ct <= 0) {
+	if (ct <= 0)
 		usage(stderr);
-	}

 	for (j = optind; j < argc; j++) {
 		if (ct > 1)
 			printf("%s: ", argv[j]);
-		isosize(argv[j]);
+		isosize(argv[j], xflag, divisor);
 	}

-	return 0;
+	return EXIT_SUCCESS;
 }

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
