Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51301 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645Ab1F2MD3 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 Jun 2011 08:03:29 -0400
Received: by qwk3 with SMTP id 3so572530qwk.19
        for <util-linux@vger.kernel.org>; Wed, 29 Jun 2011 05:03:28 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Wed, 29 Jun 2011 14:03:28 +0200
Message-ID: <BANLkTikVaACBzs+Y7kKjn-L=RefF=xehgw@mail.gmail.com>
Subject: [git pull] mkfs fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following changes since commit 37b94458bd0f4a178233ad0366a727bf5bde879f:

  sfdisk: fix coding style. (2011-06-29 12:47:38 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit mkfs

Sami Kerola (4):
      mkfs: add long options
      docs: add long options to mkfs.8
      mkfs: include-what-you-use header check
      mkfs: coding style fixes

 disk-utils/mkfs.8 |   44 ++++++-------
 disk-utils/mkfs.c |  189 +++++++++++++++++++++++++++++++---------------------
 2 files changed, 133 insertions(+), 100 deletions(-)

diff --git a/disk-utils/mkfs.8 b/disk-utils/mkfs.8
index 6a39633..88699c1 100644
--- a/disk-utils/mkfs.8
+++ b/disk-utils/mkfs.8
@@ -1,15 +1,12 @@
 .\" -*- nroff -*-
 .TH MKFS 8 "Jun 1995" "Version 1.9"
+.TH MKFS "8" "June 2011" "util-linux" "System Administration Utilities"
 .SH NAME
 mkfs \- build a Linux file system
 .SH SYNOPSIS
+.SH SYNOPSIS
 .B mkfs
-.RB [ \-V ]
-.RB [ \-t
-.IR fstype ]
-.RI [ fs-options ]
-.I filesys
-.RI [ blocks ]
+[\fIoptions\fR] [\fI-t type fs-options\fR] \fIdevice \fR[\fIsize\fR]
 .SH DESCRIPTION
 .B mkfs
 is used to build a Linux file system on a device, usually
@@ -19,8 +16,9 @@ is either the device name (e.g.
 .IR /dev/hda1 ,
 .IR /dev/sdb2 ),
 or a regular file that shall contain the file system.
-.I blocks
-is the number of blocks to be used for the file system.
+The
+.I size
+argument is the number of blocks to be used for the file system.
 .PP
 The exit code returned by
 .B mkfs
@@ -49,14 +47,7 @@ Please see the file system-specific builder manual pages for
 further details.
 .SH OPTIONS
 .TP
-.B -V
-Produce verbose output, including all file system-specific commands
-that are executed.
-Specifying this option more than once inhibits execution of any
-file system-specific commands.
-This is really only useful for testing.
-.TP
-.BI -t \ fstype
+\fB\-t\fR, \fB\-\-type\fR=\fITYPE\fR
 Specifies the type of file system to be built.
 If not specified, the default file system type
 (currently ext2) is used.
@@ -67,20 +58,25 @@ system builder.
 Although not guaranteed, the following options are supported
 by most file system builders.
 .TP
-.B -c
-Check the device for bad blocks before building the file system.
+\fB\-V\fR, \fB\-\-verbose\fR
+Produce verbose output, including all file system-specific commands
+that are executed.
+Specifying this option more than once inhibits execution of any
+file system-specific commands.
+This is really only useful for testing.
 .TP
-.BI -l \ filename
-Read the bad blocks list from
-.I filename
+\fB\-V\fR, \fB\-\-version\fR
+output version information and exit
+\fB\-V\fR will output version information only when it is the
+only parameter.
 .TP
-.B -v
-Produce verbose output.
+\fB\-h\fR, \fB\-\-help\fR
+Display help and exit.
 .SH BUGS
 All generic options must precede and not be combined with
 file system-specific options.
 Some file system-specific programs do not support the
-.I -v
+.I -V
 (verbose) option, nor return meaningful exit codes.
 Also, some file system-specific programs do not automatically
 detect the device size and require the
diff --git a/disk-utils/mkfs.c b/disk-utils/mkfs.c
index e22c512..ce845a5 100644
--- a/disk-utils/mkfs.c
+++ b/disk-utils/mkfs.c
@@ -2,8 +2,6 @@
  * mkfs		A simple generic frontend for the for the mkfs program
  *		under Linux.  See the manual page for details.
  *
- * Usage:	mkfs [-V] [-t fstype] [fs-options] device [size]
- *
  * Authors:	David Engel, <david@ods.com>
  *		Fred N. van Kempen, <waltje@uWalt.NL.Mugnet.ORG>
  *		Ron Sommeling, <sommel@sci.kun.nl>
@@ -15,91 +13,130 @@
  *	
  */

-
+#include <getopt.h>
+#include <limits.h>
 #include <stdio.h>
-#include <unistd.h>
+#include <stdlib.h>
 #include <string.h>
-#include <nls.h>
+#include <unistd.h>

+#include "c.h"
+#include "nls.h"
 #include "xalloc.h"

 #ifndef DEFAULT_FSTYPE
-# define DEFAULT_FSTYPE		"ext2"
+#define DEFAULT_FSTYPE	"ext2"
 #endif

 #define SEARCH_PATH	"PATH=" FS_SEARCH_PATH
 #define PROGNAME	"mkfs.%s"


-int main(int argc, char *argv[])
+static void __attribute__ ((__noreturn__)) usage(FILE * out)
+{
+	fprintf(out,
+		_("Usage: %s [options] [-t type fs-options] device [size]\n"),
+		program_invocation_short_name);
+
+	fprintf(out, _("\nOptions:\n"
+		       " -t, --type=TYPE  file system type, when undefined ext2 is used\n"
+		       "     fs-options   parameters to real file system builder\n"
+		       "     device       path to a device\n"
+		       "     size         number of blocks on the device\n"
+		       " -V, --verbose    explain what is done\n"
+		       "                  defining -V more than once will cause a dry-run\n"
+		       " -V, --version    output version information and exit\n"
+		       "                  -V as version must be only option\n"
+		       " -h, --help       display this help and exit\n"));
+
+	fprintf(out, _("\nFor more information see mkfs(8).\n"));
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+static void __attribute__ ((__noreturn__)) print_version(void)
+{
+	printf(_("%s (%s)\n"),
+	       program_invocation_short_name, PACKAGE_STRING);
+	exit(EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
 {
-  char *progname;	/* name of executable to be called */
-  char *fstype = NULL;
-  int i, more = 0, verbose = 0;
-  char *oldpath, *newpath;
-  char *program_name, *p;
-
-  program_name = argv[0];
-  if ((p = strrchr(program_name, '/')) != NULL)
-	  program_name = p+1;
-
-  setlocale(LC_ALL, "");
-  bindtextdomain(PACKAGE, LOCALEDIR);
-  textdomain(PACKAGE);
-
-  if (argc == 2 &&
-      (!strcmp(argv[1], "-V") || !strcmp(argv[1], "--version"))) {
-	  printf(_("%s (%s)\n"), program_name, PACKAGE_STRING);
-	  exit(EXIT_SUCCESS);
-  }
-
-  /* Check commandline options. */
-  opterr = 0;
-  while ((more == 0) && ((i = getopt(argc, argv, "Vt:")) != -1))
-    switch (i) {
-    case 'V':
-      verbose++;
-      break;
-    case 't':
-      fstype = optarg;
-      break;
-    default:
-      optind--;
-      more = 1;
-      break;		/* start of specific arguments */
-    }
-  if (optind == argc)
-	  errx(EXIT_FAILURE, _("Usage: mkfs [-V] [-t fstype] [fs-options]
device [size]"));
-
-  /* If -t wasn't specified, use the default */
-  if (fstype == NULL)
-    fstype = DEFAULT_FSTYPE;
-
-  /* Set PATH and program name */
-  oldpath = getenv("PATH");
-  if (!oldpath)
-	  oldpath = "/bin";
-
-  newpath = xmalloc(strlen(oldpath) + sizeof(SEARCH_PATH) + 3);
-  sprintf(newpath, "%s:%s\n", SEARCH_PATH, oldpath);
-  putenv(newpath);
-
-  progname = xmalloc(sizeof(PROGNAME) + strlen(fstype) + 1);
-  sprintf(progname, PROGNAME, fstype);
-  argv[--optind] = progname;
-
-  if (verbose) {
-    printf(_("mkfs (%s)\n"), PACKAGE_STRING);
-    i = optind;
-    while (argv[i])
-      printf("%s ", argv[i++]);
-    printf("\n");
-    if (verbose > 1)
-      return 0;
-  }
-
-  /* Execute the program */
-  execvp(progname, argv+optind);
-  perror(progname);
-  return 1;
+	char *progname;		/* name of executable to be called */
+	char *fstype = NULL;
+	int i, more = 0, verbose = 0;
+	char *oldpath, *newpath;
+
+	enum { VERSION_OPTION = CHAR_MAX + 1 };
+
+	static const struct option longopts[] = {
+		{"type", required_argument, NULL, 't'},
+		{"version", no_argument, NULL, VERSION_OPTION},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
+	if (argc == 2 && !strcmp(argv[1], "-V"))
+		print_version();
+
+	/* Check commandline options. */
+	opterr = 0;
+	while ((more == 0)
+	       && ((i = getopt_long(argc, argv, "Vt:h", longopts, NULL))
+		   != -1))
+		switch (i) {
+		case 'V':
+			verbose++;
+			break;
+		case 't':
+			fstype = optarg;
+			break;
+		case 'h':
+			usage(stdout);
+		case VERSION_OPTION:
+			print_version();
+		default:
+			optind--;
+			more = 1;
+			break;	/* start of specific arguments */
+		}
+	if (optind == argc)
+		usage(stderr);
+
+	/* If -t wasn't specified, use the default */
+	if (fstype == NULL)
+		fstype = DEFAULT_FSTYPE;
+
+	/* Set PATH and program name */
+	oldpath = getenv("PATH");
+	if (!oldpath)
+		oldpath = "/bin";
+
+	newpath = xmalloc(strlen(oldpath) + sizeof(SEARCH_PATH) + 3);
+	sprintf(newpath, "%s:%s\n", SEARCH_PATH, oldpath);
+	putenv(newpath);
+
+	progname = xmalloc(sizeof(PROGNAME) + strlen(fstype) + 1);
+	sprintf(progname, PROGNAME, fstype);
+	argv[--optind] = progname;
+
+	if (verbose) {
+		printf(_("mkfs (%s)\n"), PACKAGE_STRING);
+		i = optind;
+		while (argv[i])
+			printf("%s ", argv[i++]);
+		printf("\n");
+		if (verbose > 1)
+			return EXIT_SUCCESS;
+	}
+
+	/* Execute the program */
+	execvp(progname, argv + optind);
+	perror(progname);
+	return EXIT_FAILURE;
 }

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
