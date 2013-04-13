Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37083 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab3DMTz3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:29 -0400
Received: by mail-wi0-f177.google.com with SMTP id hm14so506102wib.10
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/33] hexdump: add long options to the command
Date: Sat, 13 Apr 2013 20:54:36 +0100
Message-Id: <1365882901-11429-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Includes update to bash completion, and manual as well.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/hexdump | 22 ++++++++++++++----
 text-utils/hexdump.1    | 24 +++++++++----------
 text-utils/hexsyntax.c  | 61 ++++++++++++++++++++++++++++++++-----------------
 3 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/bash-completion/hexdump b/bash-completion/hexdump
index 0c91187..aa6f8ce 100644
--- a/bash-completion/hexdump
+++ b/bash-completion/hexdump
@@ -5,25 +5,37 @@ _hexdump_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
-		'-e')
+		'-e'|'--format')
 			COMPREPLY=( $(compgen -W "format" -- $cur) )
 			return 0
 			;;
-		'-n')
+		'-n'|'--length')
 			COMPREPLY=( $(compgen -W "length" -- $cur) )
 			return 0
 			;;
-		'-s')
+		'-s'|'--skip')
 			COMPREPLY=( $(compgen -W "offset" -- $cur) )
 			return 0
 			;;
-		'-V')
+		'-V'|'--version'|'-h'|'--help')
 			return 0
 			;;
 	esac
 	case $cur in
 		-*)
-			OPTS="-b -c -C -d -o -x -e -f -n -s -v -V"
+			OPTS="	--one-byte-octal
+				--one-byte-char
+				--canonical
+				--two-bytes-decimal
+				--two-bytes-octal
+				--two-bytes-hex
+				--format
+				--format-file
+				--length
+				--skip
+				--no-squeezing
+				--version
+				--help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index 903100d..e8afdba 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -31,7 +31,7 @@
 .\"
 .\"	from: @(#)hexdump.1	8.2 (Berkeley) 4/18/94
 .\"
-.TH HEXDUMP "1" "September 2011" "util-linux" "User Commands"
+.TH HEXDUMP "1" "April 2013" "util-linux" "User Commands"
 .SH NAME
 hexdump \- display file contents in ascii, decimal, hexadecimal, or octal
 .SH SYNOPSIS
@@ -49,17 +49,17 @@ suffixes KiB=1024, MiB=1024*1024, and so on for GiB, TiB, PiB, EiB, ZiB and YiB
 (the "iB" is optional, e.g. "K" has the same meaning as "KiB") or the suffixes
 KB=1000, MB=1000*1000, and so on for GB, TB, PB, EB, ZB and YB.
 .TP
-.B \-b
+\fB\-b\fR, \fB\-\-one\-byte\-octal\fR
 \fIOne-byte octal display\fR.  Display the input offset in hexadecimal,
 followed by sixteen space-separated, three-column, zero-filled bytes of input
 data, in octal, per line.
 .TP
-.B \-c
+\fB\-c\fR, \fB\-\-one\-byte\-char\fR
 \fIOne-byte character display\fR.  Display the input offset in hexadecimal,
 followed by sixteen space-separated, three-column, space-filled characters of
 input data per line.
 .TP
-.B \-C
+\fB\-C\fR, \fB\-\-canonical\fR
 \fICanonical hex+ASCII display\fR.  Display the input offset in hexadecimal,
 followed by sixteen space-separated, two-column, hexadecimal bytes, followed
 by the same sixteen bytes in
@@ -68,35 +68,35 @@ format enclosed in
 .RB ' | '
 characters.
 .TP
-.B \-d
+\fB\-d\fR, \fB\-\-two\-bytes\-decimal\fR
 \fITwo-byte decimal display\fR.  Display the input offset in hexadecimal,
 followed by eight space-separated, five-column, zero-filled, two-byte units
 of input data, in unsigned decimal, per line.
 .TP
-.BI \-e \ format_string
+\fB\-e\fR, \fB\-\-format\fR \fIformat_string\fR
 Specify a format string to be used for displaying data.
 .TP
-.BI \-f \ format_file
+\fB\-r\fR, \fB\-\-format\-file\fR \fIfile\fR
 Specify a file that contains one or more newline separated format strings.
 Empty lines and lines whose first non-blank character is a hash mark (\&#)
 are ignored.
 .TP
-.BI \-n \ length
+\fB\-n\fR, \fB\-\-length\fR \fIlength\fR
 Interpret only
 .I length
 bytes of input.
 .TP
-.B \-o
+\fB\-o\fR, \fB\-\-two\-bytes\-octal\fR
 \fITwo-byte octal display\fR.  Display the input offset in hexadecimal,
 followed by eight space-separated, six-column, zero-filled, two-byte
 quantities of input data, in octal, per line.
 .TP
-.BI \-s \ offset
+\fB\-s\fR, \fB\-\-skip\fR \fIoffset\fR
 Skip
 .I offset
 bytes from the beginning of the input.
 .TP
-.B \-v
+\fB\-v\fR, \fB\-\-no\-squeezing\fR
 The
 .B \-v
 option causes
@@ -107,7 +107,7 @@ option, any number of groups of output lines which would be identical to the
 immediately preceding group of output lines (except for the input offsets),
 are replaced with a line comprised of a single asterisk.
 .TP
-.B \-x
+\fB\-x\fR, \fB\-\-two\-bytes\-hex\fR
 \fITwo-byte hexadecimal display\fR.  Display the input offset in hexadecimal,
 followed by eight space-separated, four-column, zero-filled, two-byte
 quantities of input data, in hexadecimal, per line.
diff --git a/text-utils/hexsyntax.c b/text-utils/hexsyntax.c
index b0e4fb7..2910ca5 100644
--- a/text-utils/hexsyntax.c
+++ b/text-utils/hexsyntax.c
@@ -42,6 +42,7 @@
 #include <errno.h>
 #include <err.h>
 #include <limits.h>
+#include <getopt.h>
 #include "hexdump.h"
 #include "nls.h"
 #include "strutils.h"
@@ -56,8 +57,25 @@ newsyntax(int argc, char ***argvp)
 	int ch;
 	char **argv;
 
+	static const struct option longopts[] = {
+		{"one-byte-octal", no_argument, NULL, 'b'},
+		{"one-byte-char", required_argument, NULL, 'c'},
+		{"canonical", required_argument, NULL, 'C'},
+		{"two-bytes-decimal", no_argument, NULL, 'd'},
+		{"two-bytes-octal", required_argument, NULL, 'o'},
+		{"two-bytes-hex", no_argument, NULL, 'x'},
+		{"format", required_argument, NULL, 'e'},
+		{"format-file", required_argument, NULL, 'f'},
+		{"length", required_argument, NULL, 'n'},
+		{"skip", required_argument, NULL, 's'},
+		{"no-squeezing", no_argument, NULL, 'v'},
+		{"help", no_argument, NULL, 'h'},
+		{"version", no_argument, NULL, 'V'},
+		{NULL, no_argument, NULL, 0}
+	};
+
 	argv = *argvp;
-	while ((ch = getopt(argc, argv, "bcCde:f:n:os:vxV")) != -1) {
+	while ((ch = getopt_long(argc, argv, "bcCde:f:n:os:vxhV", longopts, NULL)) != -1) {
 		switch (ch) {
 		case 'b':
 			add("\"%07.7_Ax\n\"");
@@ -99,10 +117,10 @@ newsyntax(int argc, char ***argvp)
 			add("\"%07.7_Ax\n\"");
 			add("\"%07.7_ax \" 8/2 \"   %04x \" \"\\n\"");
 			break;
+		case 'h':
+			usage(stdout);
 		case 'V':
-			printf(_("%s from %s\n"),
-					program_invocation_short_name,
-					PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
 			break;
 		default:
@@ -120,23 +138,24 @@ newsyntax(int argc, char ***argvp)
 
 void __attribute__((__noreturn__)) usage(FILE *out)
 {
-	fprintf(out, _("\nUsage:\n"
-		       " %s [options] file...\n"),
-		       program_invocation_short_name);
-	fprintf(out, _(
-		       "\nOptions:\n"
-		       " -b              one-byte octal display\n"
-		       " -c              one-byte character display\n"
-		       " -C              canonical hex+ASCII display\n"
-		       " -d              two-byte decimal display\n"
-		       " -o              two-byte octal display\n"
-		       " -x              two-byte hexadecimal display\n"
-		       " -e format       format string to be used for displaying data\n"
-		       " -f format_file  file that contains format strings\n"
-		       " -n length       interpret only length bytes of input\n"
-		       " -s offset       skip offset bytes from the beginning\n"
-		       " -v              display without squeezing similar lines\n"
-		       " -V              output version information and exit\n\n"));
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] file...\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -b, --one-byte-octal      one-byte octal display\n"), out);
+	fputs(_(" -c, --one-byte-char       one-byte character display\n"), out);
+	fputs(_(" -C, --canonical           canonical hex+ASCII display\n"), out);
+	fputs(_(" -d, --two-bytes-decimal   two-byte decimal display\n"), out);
+	fputs(_(" -o, --two-bytes-octal     two-byte octal display\n"), out);
+	fputs(_(" -x, --two-bytes-hex       two-byte hexadecimal display\n"), out);
+	fputs(_(" -e, --format format       format string to be used for displaying data\n"), out);
+	fputs(_(" -f, --format-file <file>  file that contains format strings\n"), out);
+	fputs(_(" -n, --length <length>     interpret only length bytes of input\n"), out);
+	fputs(_(" -s, --skip <offset>       skip offset bytes from the beginning\n"), out);
+	fputs(_(" -v, --no-squeezing        output identical lines\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("hexdump(1)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.8.2.1

