Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:40446 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab2JHHI4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:08:56 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so2855816wib.1
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:08:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/14] pg: add const qualifiers where suitable
Date: Mon,  8 Oct 2012 08:08:12 +0100
Message-Id: <1349680100-18120-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Includes a fix also to one assignment warning (see below).

text-utils/pg.c:1477:24: warning: assignment discards 'const' qualifier \
from pointer target type [enabled by default]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/pg.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/text-utils/pg.c b/text-utils/pg.c
index 9f95eac..0168ebc 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -134,7 +134,7 @@ int		fflag;			/* do not split lines */
 int		nflag;			/* no newline for commands required */
 int		rflag;			/* "restricted" pg */
 int		sflag;			/* use standout mode */
-char		*pstring = ":";		/* prompt string */
+const char	*pstring = ":";		/* prompt string */
 char		*searchfor;		/* search pattern from argv[] */
 int		havepagelen;		/* page length is manually defined */
 long		startline;		/* start line from argv[] */
@@ -241,14 +241,14 @@ static void usage(FILE * out)
 }
 
 static void
-needarg(char *s)
+needarg(const char *s)
 {
 	warnx(_("option requires an argument -- %s"), s);
 	usage(stderr);
 }
 
 static void
-invopt(char *s)
+invopt(const char *s)
 {
 	warnx(_("illegal option -- %s"), s);
 	usage(stderr);
@@ -295,7 +295,7 @@ outcap(int i)
  * Write messages to terminal.
  */
 static void
-mesg(char *message)
+mesg(const char *message)
 {
 	if (ontty == 0)
 		return;
@@ -927,7 +927,7 @@ makepat(void)
  * Process errors that occurred in temporary file operations.
  */
 static void
-tmperr(FILE *f, char *ftype)
+tmperr(FILE *f, const char *ftype)
 {
 	if (ferror(f))
 		warn(_("Read error from %s file"), ftype);
@@ -946,7 +946,7 @@ tmperr(FILE *f, char *ftype)
  * Beware: long and ugly.
  */
 static void
-pgfile(FILE *f, char *name)
+pgfile(FILE *f, const char *name)
 {
 	off_t pos, oldpos, fpos;
 	off_t line = 0, fline = 0, bline = 0, oldline = 0, eofline = 0;
@@ -1465,7 +1465,7 @@ found_bw:
 					switch (cpid = fork()) {
 					case 0:
 						p = getenv("SHELL");
-						if (p == NULL) p = "/bin/sh";
+						if (p == NULL) p = xstrdup("/bin/sh");
 						if (!nobuf)
 							fclose(fbuf);
 						fclose(find);
-- 
1.7.12.2

