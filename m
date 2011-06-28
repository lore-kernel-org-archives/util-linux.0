Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44903 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810Ab1F1Knd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Jun 2011 06:43:33 -0400
Received: by ewy4 with SMTP id 4so20585ewy.19
        for <util-linux@vger.kernel.org>; Tue, 28 Jun 2011 03:43:31 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/4] script: option --force added
Date: Tue, 28 Jun 2011 12:43:23 +0200
Message-Id: <1309257806-1418-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The --force will allow default output destination, e.g.
typescript file, to be hard or symbolic link.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.1 |    3 +++
 term-utils/script.c |   21 ++++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/term-utils/script.1 b/term-utils/script.1
index 725bdb2..f618ec3 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -84,6 +84,9 @@ termination on signal termination exit code is 128+n.
 Flush output after each write. This is nice for telecooperation:
 One person does `mkfifo foo; script -f foo' and another can
 supervise real-time what is being done using `cat foo'.
+.It Fl Fl force
+Allow default output destination, e.g. typescript file, to be
+hard or symbolic link. The command will follow symbolic link.
 .It Fl q, Fl Fl quiet
 Be quiet.
 .It Fl t, Fl Fl timing[=FILE]
diff --git a/term-utils/script.c b/term-utils/script.c
index 603d392..1753849 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -101,6 +101,7 @@ int	eflg = 0;
 int	fflg = 0;
 int	qflg = 0;
 int	tflg = 0;
+int	forceflg = 0;
 
 int die;
 int resized;
@@ -109,14 +110,13 @@ static void
 die_if_link(char *fn) {
 	struct stat s;
 
+	if (forceflg)
+		return;
 	if (lstat(fn, &s) == 0 && (S_ISLNK(s.st_mode) || s.st_nlink > 1))
-	        /* FIXME: there is no [options] to allow/force this to happen.  */
 		errx(EXIT_FAILURE,
-			_("Warning: `%s' is a link.\n"
-			  "Use `%s [options] %s' if you really "
-			  "want to use it.\n"
-			  "Program not started.\n"),
-			fn, program_invocation_short_name, fn);
+		     _("error: output file `%s' is a link\n"
+		       "Use --force if you really want to use it.\n"
+		       "Program not started."), fn);
 }
 
 static void __attribute__((__noreturn__))
@@ -132,6 +132,7 @@ usage(FILE *out)
 		" -c, --command COMMAND   run command rather than interactive shell\n"
 		" -r, --return            return exit code of the child process\n"
 		" -f, --flush             run flush after each write\n"
+		"     --force             use output file even it would be a link\n"
 		" -q, --quiet             be quiet\n"
 		" -t, --timing=FILE       output timing data to stderr, or to file\n"
 		" -V, --version           output version information and exit\n"
@@ -157,11 +158,14 @@ main(int argc, char **argv) {
 	int ch;
 	FILE *timingfd = stderr;
 
+	enum { FORCE_OPTION = CHAR_MAX + 1 };
+
 	static const struct option longopts[] = {
 		{ "append",	no_argument,	   0, 'a' },
 		{ "command",	required_argument, 0, 'c' },
 		{ "return",	no_argument,	   0, 'e' },
 		{ "flush",	no_argument,	   0, 'f' },
+		{ "force",	no_argument,	   0, FORCE_OPTION, },
 		{ "quiet",	no_argument,	   0, 'q' },
 		{ "timing",	optional_argument, 0, 't' },
 		{ "version",	no_argument,	   0, 'V' },
@@ -175,7 +179,7 @@ main(int argc, char **argv) {
 	textdomain(PACKAGE);
 
 	while ((ch = getopt_long(argc, argv, "ac:efqt::Vh", longopts, NULL)) != -1)
-		switch((char)ch) {
+		switch(ch) {
 		case 'a':
 			aflg++;
 			break;
@@ -188,6 +192,9 @@ main(int argc, char **argv) {
 		case 'f':
 			fflg++;
 			break;
+		case FORCE_OPTION:
+			forceflg = 1;
+			break;
 		case 'q':
 			qflg++;
 			break;
-- 
1.7.5.2

