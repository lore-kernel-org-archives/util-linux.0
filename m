Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:38524 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab3DMTzS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:18 -0400
Received: by mail-we0-f172.google.com with SMTP id r3so2852949wey.3
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/33] cfdisk: add long options to the command
Date: Sat, 13 Apr 2013 20:54:32 +0100
Message-Id: <1365882901-11429-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Includes update to bash completion, and manual as well.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/cfdisk | 24 ++++++++++++-----
 fdisks/cfdisk.8        | 18 ++++++-------
 fdisks/cfdisk.c        | 71 ++++++++++++++++++++++++++++++--------------------
 3 files changed, 70 insertions(+), 43 deletions(-)

diff --git a/bash-completion/cfdisk b/bash-completion/cfdisk
index 6cd9d6f..65039ee 100644
--- a/bash-completion/cfdisk
+++ b/bash-completion/cfdisk
@@ -5,25 +5,37 @@ _cfdisk_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
-		'-c')
+		'-c'|'--cylinders')
 			COMPREPLY=( $(compgen -W "cylinders" -- $cur) )
 			return 0
 			;;
-		'-h')
+		'-h'|'--heads')
 			COMPREPLY=( $(compgen -W "heads" -- $cur) )
 			return 0
 			;;
-		'-s')
+		'-s'|'--sectors')
 			COMPREPLY=( $(compgen -W "sectors" -- $cur) )
 			return 0
 			;;
-		'-v')
+		'-P'|'--print')
+			COMPREPLY=( $(compgen -W "r s t" -- $cur) )
+			return 0
+			;;
+		'-v'|'-V'|'--version'|'--help')
 			return 0
 			;;
 	esac
 	case $cur in
 		-*)
-			OPTS="-a -z -c -h -s"
+			OPTS="	--cylinders
+				--heads
+				--sectors
+				--guess
+				--print
+				--zero
+				--arrow
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
@@ -31,7 +43,7 @@ _cfdisk_module()
 	local DEV TYPE DEVICES=''
 	while read DEV TYPE; do
 		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
-	done < <(lsblk -pnro name,type)
+	done <<<"$(lsblk -pnro "name,type")"
 	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 	return 0
 }
diff --git a/fdisks/cfdisk.8 b/fdisks/cfdisk.8
index be88fdb..efd33ce 100644
--- a/fdisks/cfdisk.8
+++ b/fdisks/cfdisk.8
@@ -11,7 +11,7 @@
 .\" permission notice identical to this one.
 .\"
 .\" " for hilit mode
-.TH CFDISK 8 "July 2009" "util-linux" "System Administration"
+.TH CFDISK 8 "April 2013" "util-linux" "System Administration"
 .SH NAME
 cfdisk \- display or manipulate disk partition table
 .SH SYNOPSIS
@@ -397,18 +397,18 @@ When in a sub-menu or at a prompt to enter a filename, you can hit the
 key to return to the main command line.
 .SH OPTIONS
 .TP
-.B \-a
+\fB\-a\fR, \fB\-\-arrow\fR
 Use an arrow cursor instead of reverse video for highlighting the
 current partition.
 .TP
-.B \-g
+\fB\-g\fR, \fB\-\-guess\fR
 Do not use the geometry given by the disk driver, but try to
 guess a geometry from the partition table.
 .TP
-.B \-v
+\fB\-v\fR, \fB\-V\fR, \fB\-\-version\fR
 Print the version number and copyright.
 .TP
-.B \-z
+\fB\-z\fR, \fB\-\-zero\fR
 Start with zeroed partition table.  This option is useful when you
 want to repartition your entire disk.
 .I Note:
@@ -416,17 +416,17 @@ this option does not zero the partition table on the disk; rather, it
 simply starts the program without reading the existing partition
 table.
 .TP
-.BI \-c " cylinders"
+\fB\-c\fR, \fB\-\-cylinders\fR \fcylinders\fR
 .TP
-.BI \-h " heads"
+\fB\-h\fR, \fB\-\-heads\fR \fIheads\fR
 .TP
-.BI \-s " sectors-per-track"
+\fB\-s\fR, \fB\-\-sectors\fR \fsectors-per-track\fR
 Override the number of cylinders, heads and sectors per track read
 from the BIOS.  If your BIOS or adapter does not supply this
 information or if it supplies incorrect information, use these options
 to set the disk geometry values.
 .TP
-.BI \-P " opt"
+\fB\-P\fR, \fB\-\-print\fR \fIr|s|t\fR
 Prints the partition table in specified formats.
 .I opt
 can be one or more of "r", "s" or "t".  See the
diff --git a/fdisks/cfdisk.c b/fdisks/cfdisk.c
index 136ff9d..db9e233 100644
--- a/fdisks/cfdisk.c
+++ b/fdisks/cfdisk.c
@@ -2737,27 +2737,25 @@ copyright(void) {
     fprintf(stderr, _("Copyright (C) 1994-2002 Kevin E. Martin & aeb\n"));
 }
 
-static void
-usage(char *prog_name) {
-    /* Unfortunately, xgettext does not handle multi-line strings */
-    /* so, let's use explicit \n's instead */
-    fprintf(stderr, _("\n"
-"Usage:\n"
-"Print version:\n"
-"        %s -v\n"
-"Print partition table:\n"
-"        %s -P {r|s|t} [options] device\n"
-"Interactive use:\n"
-"        %s [options] device\n"
-"\n"
-"Options:\n"
-"-a: Use arrow instead of highlighting;\n"
-"-z: Start with a zero partition table, instead of reading the pt from disk;\n"
-"-c C -h H -s S: Override the kernel's idea of the number of cylinders,\n"
-"                the number of heads and the number of sectors/track.\n\n"),
-    prog_name, prog_name, prog_name);
 
+static void __attribute__ ((__noreturn__)) usage(FILE *out)
+{
+    fputs(USAGE_HEADER, out);
+    fprintf(out, _(" %s [options] device\n"), program_invocation_short_name);
+    fputs(USAGE_OPTIONS, out);
+    fputs(_(" -c, --cylinders <number>  set the number of cylinders to use\n"), out);
+    fputs(_(" -h, --heads <number>      set the number of heads to use\n"), out);
+    fputs(_(" -s, --sectors <number>    set the number of sectors to use\n"), out);
+    fputs(_(" -g, --guess               guess a geometry from partition table\n"), out);
+    fputs(_(" -P, --print <r|s|t>       print partition table in specified format\n"), out);
+    fputs(_(" -z, --zero                start with zeroed partition table\n"), out);
+    fputs(_(" -a, --arrow               use arrow for highlighting the current partition\n"), out);
+    fputs(USAGE_SEPARATOR, out);
+    fputs(_("     --help     display this help and exit\n"), out);
+    fputs(USAGE_VERSION, out);
+    fprintf(out, USAGE_MAN_TAIL("cfdisk(8)"));
     copyright();
+    exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
 int
@@ -2766,12 +2764,29 @@ main(int argc, char **argv)
     int c;
     int i, len;
 
+    enum {
+	OPT_HELP = CHAR_MAX + 1,
+    };
+
+    static const struct option longopts[] = {
+	{"cylinders", required_argument, 0, 'c'},
+	{"heads", required_argument, 0, 'h'},
+	{"sectors", required_argument, 0, 's'},
+	{"guess", no_argument, 0, 'g'},
+	{"print", required_argument, 0, 'P'},
+	{"zero", no_argument, 0, 'z'},
+	{"arrow", no_argument, 0, 'a'},
+	{"help", no_argument, 0, OPT_HELP},
+	{"version", no_argument, 0, 'V'},
+	{NULL, no_argument, 0, '0'},
+    };
+
     setlocale(LC_ALL, "");
     bindtextdomain(PACKAGE, LOCALEDIR);
     textdomain(PACKAGE);
     atexit(close_stdout);
 
-    while ((c = getopt(argc, argv, "ac:gh:s:vzP:")) != -1)
+    while ((c = getopt_long(argc, argv, "ac:gh:s:vVzP:", longopts, NULL)) != -1)
 	switch (c) {
 	case 'a':
 	    arrow_cursor = TRUE;
@@ -2801,9 +2816,10 @@ main(int argc, char **argv)
 	    }
 	    break;
 	case 'v':
-	    fprintf(stderr, "cfdisk (%s)\n", PACKAGE_STRING);
+	case 'V':
+	    printf(UTIL_LINUX_VERSION);
 	    copyright();
-	    exit(0);
+	    return EXIT_SUCCESS;
 	case 'z':
 	    zero_table = TRUE;
 	    break;
@@ -2821,21 +2837,20 @@ main(int argc, char **argv)
 		    print_only |= PRINT_PARTITION_TABLE;
 		    break;
 		default:
-		    usage(argv[0]);
-		    exit(1);
+		    usage(stderr);
 		}
 	    }
 	    break;
+	case OPT_HELP:
+	    usage(stdout);
 	default:
-	    usage(argv[0]);
-	    exit(1);
+	    usage(stderr);
 	}
 
     if (argc-optind == 1)
 	disk_device = argv[optind];
     else if (argc-optind != 0) {
-	usage(argv[0]);
-	exit(1);
+	usage(stderr);
     } else if ((fd = open(DEFAULT_DEVICE, O_RDONLY)) < 0)
 	disk_device = ALTERNATE_DEVICE;
     else close(fd);
-- 
1.8.2.1

