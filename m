Return-Path: util-linux-owner@vger.kernel.org
Received: from kontorsmtp1.one.com ([195.47.247.16]:37435 "EHLO
	kontorsmtp1.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbaBJLDL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Feb 2014 06:03:11 -0500
From: Jesper Dahl Nyerup <nyerup@one.com>
To: util-linux@vger.kernel.org
Cc: nyerup@one.com
Subject: [PATCH] scriptreplay: Add --maxdelay option.
Date: Mon, 10 Feb 2014 11:53:18 +0100
Message-Id: <1392029598-8089-1-git-send-email-nyerup@one.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This option caps the delay between updates, to avoid long pauses in
transcript playback.

Signed-off-by: Jesper Dahl Nyerup <nyerup@one.com>
---
 term-utils/scriptreplay.1 |  6 ++++++
 term-utils/scriptreplay.c | 15 ++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index 20b6d93..329dbc9 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -56,6 +56,12 @@ Speed up the replay displaying this
 of times.  The argument is a floating point number.  It's called divisor
 because it divides the timings by this factor.
 .TP
+.BR \-m , " \-\-maxdelay " \fInumber\fR
+Set the maximal delay between transcript updates to
+.I number
+seconds.  The argument is a floating point number.  This can be used to
+avoid long pauses in the transcript replay.
+.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
 .TP
diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index 46468be..6a29874 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -46,6 +46,7 @@ usage(FILE *out)
 	fputs(_(" -t, --timing <file>     script timing output file\n"
 		" -s, --typescript <file> script terminal session output file\n"
 		" -d, --divisor <num>     speed up or slow down execution with time divisor\n"
+		" -m, --maxdelay <num>    wait at most this many seconds between updates\n"
 		" -V, --version           output version information and exit\n"
 		" -h, --help              display this help and exit\n\n"), out);
 
@@ -130,8 +131,8 @@ main(int argc, char *argv[])
 {
 	FILE *tfile, *sfile;
 	const char *sname = NULL, *tname = NULL;
-	double divi = 1;
-	int c, diviopt = FALSE, idx;
+	double divi = 1, maxdelay = 10;
+	int c, diviopt = FALSE, maxdelayopt = FALSE, idx;
 	unsigned long line;
 	size_t oldblk = 0;
 	char ch;
@@ -140,6 +141,7 @@ main(int argc, char *argv[])
 		{ "timing",	required_argument,	0, 't' },
 		{ "typescript",	required_argument,	0, 's' },
 		{ "divisor",	required_argument,	0, 'd' },
+		{ "maxdelay",	required_argument,	0, 'm' },
 		{ "version",	no_argument,		0, 'V' },
 		{ "help",	no_argument,		0, 'h' },
 		{ NULL,		0, 0, 0 }
@@ -156,7 +158,7 @@ main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((ch = getopt_long(argc, argv, "t:s:d:Vh", longopts, NULL)) != -1)
+	while ((ch = getopt_long(argc, argv, "t:s:d:m:Vh", longopts, NULL)) != -1)
 		switch(ch) {
 		case 't':
 			tname = optarg;
@@ -168,6 +170,10 @@ main(int argc, char *argv[])
 			diviopt = TRUE;
 			divi = getnum(optarg);
 			break;
+		case 'm':
+			maxdelayopt = TRUE;
+			maxdelay = getnum(optarg);
+			break;
 		case 'V':
 			printf(_("%s from %s\n"), program_invocation_short_name,
 						  PACKAGE_STRING);
@@ -219,6 +225,9 @@ main(int argc, char *argv[])
 		}
 		delay /= divi;
 
+		if (maxdelayopt && delay > maxdelay)
+			delay = maxdelay;
+
 		if (delay > SCRIPT_MIN_DELAY)
 			delay_for(delay);
 
-- 
1.8.4

