Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:56639 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238AbbBJVbT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Feb 2015 16:31:19 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 7C25DAC27
	for <util-linux@vger.kernel.org>; Tue, 10 Feb 2015 21:31:18 +0000 (UTC)
Message-ID: <54DA78A6.4000303@suse.cz>
Date: Tue, 10 Feb 2015 22:31:18 +0100
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] script: Introduce --interactive command line option
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

New command line option allows to skip logging for non-interactive shells.
It is especially useful if script is used in a shell initialization sequence.

---
 term-utils/script.1 |  6 ++++++
 term-utils/script.c | 15 ++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/term-utils/script.1 b/term-utils/script.1
index 4573f07..9daacd4 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -82,6 +82,12 @@ being done using `cat foo'.
 Allow the default output destination, i.e. the typescript file, to be a hard
 or symbolic link.  The command will follow a symbolic link.
 .TP
+\fB\-i\fR, \fB\-\-interactive\fR
+Log only if script is called in internal shell.  If it is called in a
+non-interactive shell, then if command is provided, execute it without
+logging, otherwise silently exit.  This is useful for users calling script
+from the shell initialization sequence.
+.TP
 \fB\-q\fR, \fB\-\-quiet\fR
 Be quiet (do not write start and done messages to either standard output
 or the typescript file).
diff --git a/term-utils/script.c b/term-utils/script.c
index ed8e83d..f81e37e 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -114,6 +114,7 @@ int	aflg = 0;
 char	*cflg = NULL;
 int	eflg = 0;
 int	fflg = 0;
+int	iflg = 0;
 int	qflg = 0;
 int	tflg = 0;
 int	forceflg = 0;
@@ -153,6 +154,7 @@ usage(FILE *out)
 		" -e, --return            return exit code of the child process\n"
 		" -f, --flush             run flush after each write\n"
 		"     --force             use output file even when it is a link\n"
+		" -i, --interactive       log only interactive shells\n"
 		" -q, --quiet             be quiet\n"
 		" -t, --timing[=<file>]   output timing data to stderr (or to FILE)\n"
 		" -V, --version           output version information and exit\n"
@@ -184,6 +186,7 @@ main(int argc, char **argv) {
 		{ "return",	no_argument,	   NULL, 'e' },
 		{ "flush",	no_argument,	   NULL, 'f' },
 		{ "force",	no_argument,	   NULL, FORCE_OPTION, },
+		{ "interactive",no_argument,	   NULL, 'i' },
 		{ "quiet",	no_argument,	   NULL, 'q' },
 		{ "timing",	optional_argument, NULL, 't' },
 		{ "version",	no_argument,	   NULL, 'V' },
@@ -197,7 +200,7 @@ main(int argc, char **argv) {
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((ch = getopt_long(argc, argv, "ac:efqt::Vh", longopts, NULL)) != -1)
+	while ((ch = getopt_long(argc, argv, "ac:efiqt::Vh", longopts, NULL)) != -1)
 		switch(ch) {
 		case 'a':
 			aflg = 1;
@@ -214,6 +217,9 @@ main(int argc, char **argv) {
 		case FORCE_OPTION:
 			forceflg = 1;
 			break;
+		case 'i':
+			iflg = 1;
+			break;
 		case 'q':
 			qflg = 1;
 			break;
@@ -242,6 +248,13 @@ main(int argc, char **argv) {
 
 	isterm = isatty(STDIN_FILENO);
 
+	if (iflg && !isterm) {
+		if (cflg)
+			doexec();
+		else
+			return EXIT_SUCCESS;
+	}
+
 	if (argc > 0)
 		fname = argv[0];
 	else {
-- 
2.2.2

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
