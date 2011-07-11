Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37863 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757955Ab1GKRFh convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Jul 2011 13:05:37 -0400
Received: by qwk3 with SMTP id 3so1965960qwk.19
        for <util-linux@vger.kernel.org>; Mon, 11 Jul 2011 10:05:37 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Mon, 11 Jul 2011 19:05:36 +0200
Message-ID: <CAG27Bk2uumAs8nhh1EdHHR+v92vOKqK19WSEaNSjnjwHSCjstw@mail.gmail.com>
Subject: [git pull] fdformat fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following changes since commit 365acc97654d33a01698ada9bf18fbbdce7d88cc:

  fdisk: use a single variable for the current disklabel (2011-07-11
12:01:42 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit fdformat

Sami Kerola (7):
      fdformat: use libc error printing facilities
      fdformat: use long options
      fdformat: integer comparisons & unused parameter
      fdformat: use xalloc.h
      fdformat: include-what-you-use header check
      fdformat: coding style
      docs: add long options to fdformat.8

 disk-utils/fdformat.8 |   18 ++--
 disk-utils/fdformat.c |  253 ++++++++++++++++++++++++++-----------------------
 2 files changed, 147 insertions(+), 124 deletions(-)

diff --git a/disk-utils/fdformat.8 b/disk-utils/fdformat.8
index 7b6e262..0fa9e8d 100644
--- a/disk-utils/fdformat.8
+++ b/disk-utils/fdformat.8
@@ -1,12 +1,11 @@
 .\" Copyright 1992, 1993 Rickard E. Faith (faith@cs.unc.edu)
 .\" May be distributed under the GNU General Public License
-.TH FDFORMAT 8 "1 February 1993" "Linux 0.99" "Linux Programmer's Manual"
+.TH FDFORMAT "8" "July 2011" "util-linux" "System Administration Utilities"
 .SH NAME
 fdformat \- Low-level formats a floppy disk
 .SH SYNOPSIS
 .B fdformat
-.RB [ \-n ]
-.I device
+[\fIoptions\fR] \fIdevice\fR
 .SH DESCRIPTION
 .B fdformat
 does a low level format on a floppy disk.
@@ -25,7 +24,7 @@ minor is shown for informational purposes only):
 /dev/fd0h360  (minor = 20)
 /dev/fd0h720  (minor = 24)
 /dev/fd0H1440 (minor = 28)
-
+.PP
 /dev/fd1d360  (minor = 5)
 /dev/fd1h1200 (minor = 9)
 /dev/fd1D360  (minor = 13)
@@ -37,19 +36,24 @@ minor is shown for informational purposes only):
 /dev/fd1H1440 (minor = 29)
 .RE
 .fi
-
+.PP
 The generic floppy devices, /dev/fd0 and /dev/fd1, will fail to work with
 .B fdformat
 when a non-standard format is being used, or if the format has not been
 autodetected earlier.  In this case, use
 .BR setfdprm (8)
 to load the disk parameters.
-
 .SH OPTIONS
 .TP
-.B \-n
+\fB\-n\fR, \fB\-\-no\-verify\fR
 No verify.  This option will disable the verification that is performed
 after the format.
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Output version information and exit.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help and exit.
 .SH "SEE ALSO"
 .BR fd (4),
 .BR setfdprm (8),
diff --git a/disk-utils/fdformat.c b/disk-utils/fdformat.c
index 4bbb574..d1d8146 100644
--- a/disk-utils/fdformat.c
+++ b/disk-utils/fdformat.c
@@ -6,147 +6,166 @@
  & - more i18n/nls translatable strings marked
  */

-#include <stdio.h>
-#include <string.h>
-#include <fcntl.h>
 #include <errno.h>
-#include <unistd.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <linux/fd.h>
+#include <stdio.h>
 #include <stdlib.h>
-#include <sys/stat.h>
 #include <sys/ioctl.h>
-#include <linux/fd.h>
+#include <sys/stat.h>
+#include <unistd.h>

+#include "c.h"
 #include "nls.h"
+#include "xalloc.h"

 struct floppy_struct param;

 #define SECTOR_SIZE 512
-#define PERROR(msg) { perror(msg); exit(1); }

-static void format_disk(int ctrl, char *name)
+static void format_disk(int ctrl)
 {
-    struct format_descr descr;
-    int track;
-
-    printf(_("Formatting ... "));
-    fflush(stdout);
-    if (ioctl(ctrl,FDFMTBEG,NULL) < 0) PERROR("\nioctl(FDFMTBEG)");
-    for (track = 0; track < param.track; track++) {
-	descr.track = track;
-	descr.head = 0;
-	if (ioctl(ctrl,FDFMTTRK,(long) &descr) < 0)
-	  PERROR("\nioctl(FDFMTTRK)");
-
-	printf("%3d\b\b\b",track);
+	struct format_descr descr;
+	unsigned int track;
+
+	printf(_("Formatting ... "));
 	fflush(stdout);
-	if (param.head == 2) {
-	    descr.head = 1;
-	    if (ioctl(ctrl,FDFMTTRK,(long) &descr) < 0)
-	      PERROR("\nioctl(FDFMTTRK)");
+	if (ioctl(ctrl, FDFMTBEG, NULL) < 0)
+		err(EXIT_FAILURE, "\nioctl(FDFMTBEG)");
+	for (track = 0; track < param.track; track++) {
+		descr.track = track;
+		descr.head = 0;
+		if (ioctl(ctrl, FDFMTTRK, (long)&descr) < 0)
+			err(EXIT_FAILURE, "\nioctl(FDFMTTRK)");
+
+		printf("%3d\b\b\b", track);
+		fflush(stdout);
+		if (param.head == 2) {
+			descr.head = 1;
+			if (ioctl(ctrl, FDFMTTRK, (long)&descr) < 0)
+				err(EXIT_FAILURE, "\nioctl(FDFMTTRK)");
+		}
 	}
-    }
-    if (ioctl(ctrl,FDFMTEND,NULL) < 0) PERROR("\nioctl(FDFMTEND)");
-    printf(_("done\n"));
+	if (ioctl(ctrl, FDFMTEND, NULL) < 0)
+		err(EXIT_FAILURE, "\nioctl(FDFMTEND)");
+	printf(_("done\n"));
 }

-
 static void verify_disk(char *name)
 {
-    unsigned char *data;
-    int fd,cyl_size,cyl,count;
-
-    cyl_size = param.sect*param.head*512;
-    if ((data = (unsigned char *) malloc(cyl_size)) == NULL) PERROR("malloc");
-    printf(_("Verifying ... "));
-    fflush(stdout);
-    if ((fd = open(name,O_RDONLY)) < 0) PERROR(name);
-    for (cyl = 0; cyl < param.track; cyl++) {
-	int read_bytes;
-
-	printf("%3d\b\b\b",cyl);
+	unsigned char *data;
+	unsigned int cyl;
+	int fd, cyl_size, count;
+
+	cyl_size = param.sect * param.head * 512;
+	data = xmalloc(cyl_size);
+	printf(_("Verifying ... "));
 	fflush(stdout);
-	read_bytes = read(fd,data,cyl_size);
-	if(read_bytes != cyl_size) {
-	    if(read_bytes < 0)
-		    perror(_("Read: "));
-	    fprintf(stderr,
-		    _("Problem reading cylinder %d, expected %d, read %d\n"),
-		    cyl, cyl_size, read_bytes);
-	    free(data);
-	    exit(1);
-	}
-	for (count = 0; count < cyl_size; count++)
-	    if (data[count] != FD_FILL_BYTE) {
-		printf(_("bad data in cyl %d\nContinuing ... "),cyl);
+	if ((fd = open(name, O_RDONLY)) < 0)
+		err(EXIT_FAILURE, _("cannot open file %s"), name);
+	for (cyl = 0; cyl < param.track; cyl++) {
+		int read_bytes;
+
+		printf("%3d\b\b\b", cyl);
 		fflush(stdout);
-		break;
-	    }
-    }
-    free(data);
-    printf(_("done\n"));
-    if (close(fd) < 0) PERROR("close");
+		read_bytes = read(fd, data, cyl_size);
+		if (read_bytes != cyl_size) {
+			if (read_bytes < 0)
+				perror(_("Read: "));
+			fprintf(stderr,
+				_("Problem reading cylinder %d,"
+				  " expected %d, read %d\n"),
+				cyl, cyl_size, read_bytes);
+			free(data);
+			exit(EXIT_FAILURE);
+		}
+		for (count = 0; count < cyl_size; count++)
+			if (data[count] != FD_FILL_BYTE) {
+				printf(_("bad data in cyl %d\n"
+					 "Continuing ... "), cyl);
+				fflush(stdout);
+				break;
+			}
+	}
+	free(data);
+	printf(_("done\n"));
+	if (close(fd) < 0)
+		err(EXIT_FAILURE, "close");
 }

-
-static void usage(char *name)
+static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-    char *this;
+	fprintf(out, _("Usage: %s [options] device\n"),
+		program_invocation_short_name);

-    if ((this = strrchr(name,'/')) != NULL) name = this+1;
-    fprintf(stderr,_("usage: %s [ -n ] device\n"),name);
-    exit(1);
-}
+	fprintf(out, _("\nOptions:\n"
+		       " -n, --no-verify  disable the verification after the format\n"
+		       " -V, --version    output version information and exit\n"
+		       " -h, --help       display this help and exit\n\n"));

+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}

-int main(int argc,char **argv)
+int main(int argc, char **argv)
 {
-    int ctrl;
-    int verify;
-    struct stat st;
-    char *progname, *p;
-
-    progname = argv[0];
-    if ((p = strrchr(progname, '/')) != NULL)
-	    progname = p+1;
-
-    setlocale(LC_ALL, "");
-    bindtextdomain(PACKAGE, LOCALEDIR);
-    textdomain(PACKAGE);
-
-    if (argc == 2 &&
-	(!strcmp(argv[1], "-V") || !strcmp(argv[1], "--version"))) {
-	    printf(_("%s (%s)\n"), progname, PACKAGE_STRING);
-	    exit(0);
-    }
-
-    verify = 1;
-    if (argc > 1 && argv[1][0] == '-') {
-	if (argv[1][1] != 'n') usage(progname);
-	verify = 0;
-	argc--;
-	argv++;
-    }
-    if (argc != 2) usage(progname);
-    if (stat(argv[1],&st) < 0) PERROR(argv[1]);
-    if (!S_ISBLK(st.st_mode)) {
-	fprintf(stderr,_("%s: not a block device\n"),argv[1]);
-	exit(1);
-	/* do not test major - perhaps this was an USB floppy */
-    }
-    if (access(argv[1],W_OK) < 0) PERROR(argv[1]);
-
-    ctrl = open(argv[1],O_WRONLY);
-    if (ctrl < 0)
-	    PERROR(argv[1]);
-    if (ioctl(ctrl,FDGETPRM,(long) &param) < 0)
-	    PERROR(_("Could not determine current format type"));
-    printf(_("%s-sided, %d tracks, %d sec/track. Total capacity %d kB.\n"),
-	   (param.head == 2) ? _("Double") : _("Single"),
-	   param.track, param.sect,param.size >> 1);
-    format_disk(ctrl, argv[1]);
-    close(ctrl);
-
-    if (verify)
-	    verify_disk(argv[1]);
-    return 0;
+	int ch;
+	int ctrl;
+	int verify;
+	struct stat st;
+
+	static const struct option longopts[] = {
+		{"no-verify", no_argument, NULL, 'n'},
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
+	while ((ch = getopt_long(argc, argv, "nVh", longopts, NULL)) != -1)
+		switch (ch) {
+		case 'n':
+			verify = 0;
+			break;
+		case 'V':
+			printf(_("%s from %s\n"), program_invocation_short_name,
+			       PACKAGE_STRING);
+			exit(EXIT_SUCCESS);
+		case 'h':
+			usage(stdout);
+		default:
+			usage(stderr);
+		}
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc < 1)
+		usage(stderr);
+	if (stat(argv[0], &st) < 0)
+		err(EXIT_FAILURE, _("cannot stat file %s"), argv[0]);
+	if (!S_ISBLK(st.st_mode))
+		/* do not test major - perhaps this was an USB floppy */
+		errx(EXIT_FAILURE, _("%s: not a block device"), argv[0]);
+	if (access(argv[0], W_OK) < 0)
+		err(EXIT_FAILURE, _("cannot access file %s"), argv[0]);
+
+	ctrl = open(argv[0], O_WRONLY);
+	if (ctrl < 0)
+		err(EXIT_FAILURE, _("cannot open file %s"), argv[0]);
+	if (ioctl(ctrl, FDGETPRM, (long)&param) < 0)
+		err(EXIT_FAILURE, _("Could not determine current format type"));
+
+	printf(_("%s-sided, %d tracks, %d sec/track. Total capacity %d kB.\n"),
+	       (param.head == 2) ? _("Double") : _("Single"),
+	       param.track, param.sect, param.size >> 1);
+	format_disk(ctrl);
+	close(ctrl);
+
+	if (verify)
+		verify_disk(argv[0]);
+	return EXIT_SUCCESS;
 }

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
