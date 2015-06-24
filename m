Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34515 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbFXIPm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:42 -0400
Received: by wicnd19 with SMTP id nd19so127223475wic.1
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/12] fsck.minix: introduce long options to the command
Date: Wed, 24 Jun 2015 09:15:18 +0100
Message-Id: <1435133719-2971-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/fsck.minix |  12 ++--
 disk-utils/fsck.minix.8    |  29 +++++----
 disk-utils/fsck.minix.c    | 150 ++++++++++++++++++++++-----------------------
 3 files changed, 96 insertions(+), 95 deletions(-)

diff --git a/bash-completion/fsck.minix b/bash-completion/fsck.minix
index b2b2860..ac4571e 100644
--- a/bash-completion/fsck.minix
+++ b/bash-completion/fsck.minix
@@ -1,16 +1,16 @@
 _fsck.minix_module()
 {
-	local cur prev OPTS
+	local cur OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
-	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	case $prev in
-		'-V'|'--version')
+	case $cur in
+		-*)
+			OPTS="--list --auto --repair --verbose --super --uncleared --force --help --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
 	esac
-	OPTS="-l -a -r -v -s -m -f --version"
-	COMPREPLY=( $(compgen -W "${OPTS[*]} $(lsblk -pnro name)" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
 complete -F _fsck.minix_module fsck.minix
diff --git a/disk-utils/fsck.minix.8 b/disk-utils/fsck.minix.8
index b672ab7..84d54bb 100644
--- a/disk-utils/fsck.minix.8
+++ b/disk-utils/fsck.minix.8
@@ -1,16 +1,15 @@
 .\" Copyright 1992, 1993, 1994 Rickard E. Faith (faith@cs.unc.edu)
 .\" May be freely distributed.
-.TH FSCK.MINIX 8 "July 1996" "util-linux" "System Administration"
+.TH FSCK.MINIX 8 "June 2015" "util-linux" "System Administration"
 .SH NAME
 fsck.minix \- check consistency of Minix filesystem
 .SH SYNOPSIS
 .B fsck.minix
-.RB [ \-larvsmf ]
+[options]
 .I device
 .SH DESCRIPTION
 .B fsck.minix
-performs a consistency check for the Linux MINIX filesystem.  The current
-version supports the 14 character and 30 character filename options.
+performs a consistency check for the Linux MINIX filesystem.
 
 The program
 assumes the filesystem is quiescent.
@@ -51,31 +50,37 @@ on a mounted filesystem (i.e., the root filesystem), make sure nothing is
 writing to the disk, and that no files are "zombies" waiting for deletion.
 .SH OPTIONS
 .TP
-.B \-l
+\fB\-l\fR, \fB\-\-list\fR
 List all filenames.
 .TP
-.B \-r
+\fB\-r\fR, \fB\-\-repair\fR
 Perform interactive repairs.
 .TP
-.B \-a
+\fB\-a\fR, \fB\-\-auto\fR
 Perform automatic repairs.  (This option implies
-.B \-r
+.B \-\-repair
 and serves to answer all of the questions asked with the default.)  Note
 that this can be extremely dangerous in the case of extensive filesystem
 damage.
 .TP
-.B \-v
+\fB\-v\fR, \fB\-\-verbose\fR
 Be verbose.
 .TP
-.B \-s
+\fB\-s\fR, \fB\-\-super\fR
 Output super-block information.
 .TP
-.B \-m
+\fB\-m\fR, \fB\-\-uncleared\fR
 Activate MINIX-like "mode not cleared" warnings.
 .TP
-.B \-f
+\fB\-f\fR, \fB\-\-force\fR
 Force a filesystem check even if the filesystem was marked as valid (this
 marking is done by the kernel when the filesystem is unmounted).
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Display version information and exit.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help text and exit.
 .SH "SEE ALSO"
 .BR fsck (8),
 .BR fsck.ext2 (8),
diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 57e5be9..f73ac4a 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -76,17 +76,6 @@
  * unless you can be sure nobody is writing to it (and remember that the
  * kernel can write to it when it searches for files).
  *
- * Usuage: fsck [-larvsm] device
- *	-l for a listing of all the filenames
- *	-a for automatic repairs (not implemented)
- *	-r for repairs (interactive) (not implemented)
- *	-v for verbose (tells how many files)
- *	-s for super-block info
- *	-m for minix-like "mode not cleared" warnings
- *	-f force filesystem check even if filesystem marked as valid
- *
- * The device may be a block device or a image of one, but this isn't
- * enforced (but it's not much fun on a character device :-).
  */
 
 #include <stdio.h>
@@ -101,6 +90,7 @@
 #include <mntent.h>
 #include <sys/stat.h>
 #include <signal.h>
+#include <getopt.h>
 
 #include "c.h"
 #include "exitcodes.h"
@@ -181,33 +171,31 @@ fatalsig(int sig) {
 	raise(sig);
 }
 
-static void
+static void __attribute__((__noreturn__))
 leave(int status) {
 	reset();
 	exit(status);
 }
 
 static void
-usage(void) {
-	fputs(USAGE_HEADER, stderr);
-	fprintf(stderr,
-		_(" %s [options] <device>\n"), program_invocation_short_name);
-
-	fputs(USAGE_SEPARATOR, stderr);
-	fputs(_("Check the consistency of a Minix filesystem.\n"), stderr);
-
-	fputs(USAGE_OPTIONS, stderr);
-	fputs(_(" -l  list all filenames\n"), stderr);
-	fputs(_(" -a  automatic repair\n"), stderr);
-	fputs(_(" -r  interactive repair\n"), stderr);
-	fputs(_(" -v  be verbose\n"), stderr);
-	fputs(_(" -s  output super-block information\n"), stderr);
-	fputs(_(" -m  activate mode not cleared warnings\n"), stderr);
-	fputs(_(" -f  force check\n"), stderr);
-	fputs(USAGE_SEPARATOR, stderr);
-	fputs(USAGE_VERSION, stderr);
-	fprintf(stderr, USAGE_MAN_TAIL("fsck.minix(8)"));
-	leave(FSCK_EX_USAGE);
+usage(FILE *out) {
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] <device>\n"), program_invocation_short_name);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Check the consistency of a Minix filesystem.\n"), out);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -l, --list       list all filenames\n"), out);
+	fputs(_(" -a, --auto       automatic repair\n"), out);
+	fputs(_(" -r, --repair     interactive repair\n"), out);
+	fputs(_(" -v, --verbose    be verbose\n"), out);
+	fputs(_(" -s, --super      output super-block information\n"), out);
+	fputs(_(" -m, --uncleared  activate mode not cleared warnings\n"), out);
+	fputs(_(" -f, --force      force check\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("fsck.minix(8)"));
+	leave(out == stderr ? FSCK_EX_USAGE : FSCK_EX_OK);
 }
 
 static void die(const char *fmt, ...)
@@ -1259,62 +1247,70 @@ main(int argc, char **argv) {
 	struct termios tmp;
 	int count;
 	int retcode = FSCK_EX_OK;
+	int i;
+	static const struct option longopts[] = {
+		{"list", no_argument, NULL, 'l'},
+		{"auto", no_argument, NULL, 'a'},
+		{"repair", no_argument, NULL, 'r'},
+		{"verbose", no_argument, NULL, 'v'},
+		{"super", no_argument, NULL, 's'},
+		{"uncleared", no_argument, NULL, 'm'},
+		{"force", no_argument, NULL, 'f'},
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
-		exit(FSCK_EX_OK);
-	}
-
 	if (INODE_SIZE * MINIX_INODES_PER_BLOCK != MINIX_BLOCK_SIZE)
 		die(_("bad inode size"));
 	if (INODE2_SIZE * MINIX2_INODES_PER_BLOCK != MINIX_BLOCK_SIZE)
 		die(_("bad v2 inode size"));
 
-	while (argc-- > 1) {
-		argv++;
-		if (argv[0][0] != '-') {
-			if (device_name)
-				usage();
-			else
-				device_name = argv[0];
-		} else
-			while (*++argv[0])
-				switch (argv[0][0]) {
-				case 'l':
-					list = 1;
-					break;
-				case 'a':
-					automatic = 1;
-					repair = 1;
-					break;
-				case 'r':
-					automatic = 0;
-					repair = 1;
-					break;
-				case 'v':
-					verbose = 1;
-					break;
-				case 's':
-					show = 1;
-					break;
-				case 'm':
-					warn_mode = 1;
-					break;
-				case 'f':
-					force = 1;
-					break;
-				default:
-					usage();
-				}
-	}
-	if (!device_name)
-		usage();
+	while ((i = getopt_long(argc, argv, "larvsmfVh", longopts, NULL)) != -1)
+		switch (i) {
+		case 'l':
+			list = 1;
+			break;
+		case 'a':
+			automatic = 1;
+			repair = 1;
+			break;
+		case 'r':
+			automatic = 0;
+			repair = 1;
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		case 's':
+			show = 1;
+			break;
+		case 'm':
+			warn_mode = 1;
+			break;
+		case 'f':
+			force = 1;
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return FSCK_EX_OK;
+		case 'h':
+			usage(stdout);
+		default:
+			usage(stderr);
+		}
+	argc -= optind;
+	argv += optind;
+	if (0 < argc) {
+		device_name = argv[0];
+	} else
+		usage(stderr);
+
 	check_mount();		/* trying to check a mounted filesystem? */
 	if (repair && !automatic) {
 		if (!isatty(STDIN_FILENO) || !isatty(STDOUT_FILENO))
-- 
2.4.4

