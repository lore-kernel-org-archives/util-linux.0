Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:57030 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab2JHHIy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:08:54 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2368146wey.19
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:08:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/14] pg: use libc error printing facilities
Date: Mon,  8 Oct 2012 08:08:11 +0100
Message-Id: <1349680100-18120-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/pg.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/text-utils/pg.c b/text-utils/pg.c
index f9b6ac8..9f95eac 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -119,7 +119,6 @@ void		(*oldint)(int);		/* old SIGINT handler */
 void		(*oldquit)(int);	/* old SIGQUIT handler */
 void		(*oldterm)(int);	/* old SIGTERM handler */
 char		*tty;			/* result of ttyname(1) */
-char		*progname;		/* program name */
 unsigned	ontty;			/* whether running on tty device */
 unsigned	exitstatus;		/* exit status */
 int		pagelen = 23;		/* lines on a single screen page */
@@ -244,15 +243,14 @@ static void usage(FILE * out)
 static void
 needarg(char *s)
 {
-	fprintf(stderr, _("%s: option requires an argument -- %s\n"),
-		progname, s);
+	warnx(_("option requires an argument -- %s"), s);
 	usage(stderr);
 }
 
 static void
 invopt(char *s)
 {
-	fprintf(stderr, _("%s: illegal option -- %s\n"), progname, s);
+	warnx(_("illegal option -- %s"), s);
 	usage(stderr);
 }
 
@@ -932,30 +930,18 @@ static void
 tmperr(FILE *f, char *ftype)
 {
 	if (ferror(f))
-		fprintf(stderr, _("%s: Read error from %s file\n"),
-			progname, ftype);
+		warn(_("Read error from %s file"), ftype);
 	else if (feof(f))
 		/*
 		 * Most likely '\0' in input.
 		 */
-		fprintf(stderr, _("%s: Unexpected EOF in %s file\n"),
-			progname, ftype);
+		warnx(_("Unexpected EOF in %s file"), ftype);
 	else
-		fprintf(stderr, _("%s: Unknown error in %s file\n"),
-			progname, ftype);
+		warn(_("Unknown error in %s file"), ftype);
 	quit(++exitstatus);
 }
 
 /*
- * perror()-like, but showing the program's name.
- */
-static void
-pgerror(int eno, char *string)
-{
-	fprintf(stderr, "%s: %s: %s\n", progname, string, strerror(eno));
-}
-
-/*
  * Read the file and respond to user input.
  * Beware: long and ugly.
  */
@@ -1023,7 +1009,7 @@ pgfile(FILE *f, char *name)
 		while ((sz = fread(b, sizeof *b, READBUF, f)) != 0)
 			write_all(1, b, sz);
 		if (ferror(f)) {
-			pgerror(errno, name);
+			warn("%s", name);
 			exitstatus++;
 		}
 		return;
@@ -1036,7 +1022,7 @@ pgfile(FILE *f, char *name)
 	}
 	find = tmpfile();
 	if (fbuf == NULL || find == NULL) {
-		fprintf(stderr, _("%s: Cannot create tempfile\n"), progname);
+		warn(_("Cannot create tempfile"));
 		quit(++exitstatus);
 	}
 	if (searchfor) {
@@ -1088,12 +1074,12 @@ pgfile(FILE *f, char *name)
 					p = fgets(b, READBUF, f);
 					if (nobuf)
 						if ((fpos = ftello(f)) == -1)
-							pgerror(errno, name);
+							warn("%s", name);
 					canjump = 0;
 				}
 				if (p == NULL || *b == '\0') {
 					if (ferror(f))
-						pgerror(errno, name);
+						warn("%s", name);
 					eofline = fline;
 					eof = 1;
 					break;
@@ -1465,7 +1451,7 @@ found_bw:
 				 * Shell escape.
 				 */
 				if (rflag) {
-					mesg(progname);
+					mesg(program_invocation_short_name);
 					mesg(_(": !command not allowed in "
 					       "rflag mode.\n"));
 				} else {
@@ -1494,7 +1480,7 @@ found_bw:
 						my_sigset(SIGTERM, oldterm);
 						execl(p, p, "-c",
 							cmd.cmdline + 1, NULL);
-						pgerror(errno, p);
+						warn("%s", p);
 						_exit(0177);
 						/*NOTREACHED*/
 					case -1:
@@ -1641,7 +1627,7 @@ parse_arguments(int arg, int argc, char **argv)
 		else {
 			input = fopen(argv[arg], "r");
 			if (input == NULL) {
-				pgerror(errno, argv[arg]);
+				warn("%s", argv[arg]);
 				exitstatus++;
 				continue;
 			}
@@ -1667,7 +1653,6 @@ main(int argc, char **argv)
 	int arg, i;
 	char *p;
 
-	progname = basename(argv[0]);
 	xasprintf(&copyright,
 		  _("%s %s Copyright (c) 2000-2001 Gunnar Ritter. All rights reserved.\n"),
 		  program_invocation_short_name, PACKAGE_VERSION);
-- 
1.7.12.2

