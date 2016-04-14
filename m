Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37490 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbcDNVRh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Apr 2016 17:17:37 -0400
Received: by mail-wm0-f42.google.com with SMTP id n3so6170878wmn.0
        for <util-linux@vger.kernel.org>; Thu, 14 Apr 2016 14:17:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] docs: optinal option arguments should be long-only
Date: Thu, 14 Apr 2016 22:17:30 +0100
Message-Id: <1460668650-8594-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Deprecate adding new short optional option arguments.  They are problematic.

Proposed-by: Ruediger Meier <sweet_f_a@gmx.de>
Acked-by: Karel Zak <kzak@redhat.com>
Reference: https://lists.gnu.org/archive/html/coreutils/2012-11/msg00004.html
Reference: http://marc.info/?l=util-linux-ng&m=146062997618853&w=2
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/boilerplate.c            | 10 +++++-----
 Documentation/howto-man-page.txt       | 20 +++++++++++++++++++-
 Documentation/howto-usage-function.txt |  2 +-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/boilerplate.c b/Documentation/boilerplate.c
index 3ee7d7b..fe2fc13 100644
--- a/Documentation/boilerplate.c
+++ b/Documentation/boilerplate.c
@@ -35,7 +35,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out, _(" %s [options] file...\n"), program_invocation_short_name);
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -n, --no-argument       option does not use argument\n"), out);
-	fputs(_(" -o, --optional[=<arg>]  option argument is optional\n"), out);
+	fputs(_("     --optional[=<arg>]  option argument is optional\n"), out);
 	fputs(_(" -r, --required <arg>    option requires an argument\n"), out);
 	fputs(_(" -z                      no long option\n"), out);
 	fputs(_("     --xyzzy             a long option only\n"), out);
@@ -57,11 +57,11 @@ int main(int argc, char **argv)
 	int c;
 
 	enum {
-		OPT_XYZZY = CHAR_MAX + 1
+		OPT_XYZZY = CHAR_MAX + 1,
+		OPT_OPTIONAL	/* see howto-man-page.txt about short option */
 	};
 	static const struct option longopts[] = {
 		{"no-argument", no_argument, NULL, 'n'},
-		{"optional", optional_argument, NULL, 'o'},
 		{"required", required_argument, NULL, 'r'},
 		{"xyzzy", no_argument, NULL, OPT_XYZZY},
 		{"extremely-long-long-option", no_argument, NULL, 'e'},
@@ -77,10 +77,10 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "no::r:elfVh", longopts, NULL)) != -1)
+	while ((c = getopt_long(argc, argv, "nr:elfVh", longopts, NULL)) != -1)
 		switch (c) {
 		case 'n':
-		case 'o':
+		case OPT_OPTIONAL:
 		case 'r':
 		case OPT_XYZZY:
 		case 'e':
diff --git a/Documentation/howto-man-page.txt b/Documentation/howto-man-page.txt
index ee3cb4e..56b0b86 100644
--- a/Documentation/howto-man-page.txt
+++ b/Documentation/howto-man-page.txt
@@ -33,7 +33,7 @@ Write such here.
 \fB\-n\fR, \fB\-\-no\-argument\fR
 This option does not use an argument.
 .TP
-\fB\-o\fR, \fB\-\-optional\fR[\fI=argument\fR]
+\fB\-\-optional\fR[\fI=argument\fR]
 Tell in this description that the
 .I argument
 is optional, and what happens when it is or is not given.  Notice that the word
@@ -43,6 +43,24 @@ usage text uses the argument
 .IR num ,
 the manual page should say
 .IR number .
+.IP
+Notice that after release v2.28 it was decided that introducing new options
+taking optional arguments should be limited to long-only options.  This is
+done primarily to avoid problematic behaviour of short options.  Imagine for
+example normal option
+.I \-n
+and optional option
+.IR \-o .
+One will expect
+.BI command \ \-no
+and
+.BI command \ \-on
+to be the same, but in fact the former is two separate options while later
+will use
+.I n
+as option argument of
+.I -n
+option.  So it is best to avoid short form of optional options altogether.
 .TP
 \fB\-r\fR, \fB\-\-required\fR \fIargument\fR
 Tell in this description that the
diff --git a/Documentation/howto-usage-function.txt b/Documentation/howto-usage-function.txt
index dd1f4ed..54d3084 100644
--- a/Documentation/howto-usage-function.txt
+++ b/Documentation/howto-usage-function.txt
@@ -45,7 +45,7 @@ Usage:
 
 Options:
  -n, --no-argument       option does not use argument
- -o, --optional[=<arg>]  option argument is optional
+     --optional[=<arg>]  option argument is optional
  -r, --required <arg>    option requires an argument
  -z                      no long option
      --xyzzy             a long option only
-- 
2.8.0

