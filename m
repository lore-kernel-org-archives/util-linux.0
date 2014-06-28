Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:45538 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbaF1SaO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 28 Jun 2014 14:30:14 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so6295992wgh.21
        for <util-linux@vger.kernel.org>; Sat, 28 Jun 2014 11:30:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/7] rename: continue despite something failed
Date: Sat, 28 Jun 2014 19:30:07 +0100
Message-Id: <1403980209-15694-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Try to do all file operations even when one or some of them fail, and
use exit value to inform what happen.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/rename.1 | 20 +++++++++++++++
 misc-utils/rename.c | 72 +++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/misc-utils/rename.1 b/misc-utils/rename.1
index 4705957..30d9c71 100644
--- a/misc-utils/rename.1
+++ b/misc-utils/rename.1
@@ -55,6 +55,26 @@ the command will perform the action without any questions.  For example, the
 result can be quite drastic when the command is run as root in the /lib
 directory.  Always make a backup before running the command, unless you truly
 know what you are doing.
+.SH "EXIT STATUS"
+.RS
+.PD 0
+.TP
+.B 0
+all requested rename operations were successful
+.TP
+.B 1
+all rename operations failed
+.TP
+.B 2
+some rename operations failed
+.TP
+.B 4
+nothing was renamed
+.TP
+.B 64
+unanticipated error occurred
+.PD
+.RE
 .SH "SEE ALSO"
 .BR mv (1)
 .SH AVAILABILITY
diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index b945aaa..3270aa5 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -27,22 +27,32 @@ for i in $@; do N=`echo "$i" | sed "s/$FROM/$TO/g"`; mv "$i" "$N"; done
 #include "c.h"
 #include "closestream.h"
 
+#define RENAME_EXIT_SOMEOK	2
+#define RENAME_EXIT_NOTHING	4
+#define RENAME_EXIT_UNEXPLAINED	64
+
 static int do_rename(char *from, char *to, char *s, int verbose, int symtarget)
 {
-	char *newname, *where, *p, *q, *target = NULL;
-	int flen, tlen, slen;
+	char *newname = NULL, *where, *p, *q, *target = NULL;
+	int flen, tlen, slen, ret = 1;
 	struct stat sb;
 
 	if (symtarget) {
-		if (lstat(s, &sb) == -1)
-			err(EXIT_FAILURE, _("%s: lstat failed"), s);
-
-		if (!S_ISLNK(sb.st_mode))
-			errx(EXIT_FAILURE, _("%s: not a symbolic link"), s);
+		if (lstat(s, &sb) == -1) {
+			warn(_("%s: lstat failed"), s);
+			return 2;
+		}
+		if (!S_ISLNK(sb.st_mode)) {
+			warnx(_("%s: not a symbolic link"), s);
+			return 2;
+		}
 
 		target = xmalloc(sb.st_size + 1);
-		if (readlink(s, target, sb.st_size + 1) < 0)
-			err(EXIT_FAILURE, _("%s: readlink failed"), s);
+		if (readlink(s, target, sb.st_size + 1) < 0) {
+			warn(_("%s: readlink failed"), s);
+			ret = 2;
+			goto out;
+		}
 
 		target[sb.st_size] = '\0';
 		where = strstr(target, from);
@@ -82,22 +92,31 @@ static int do_rename(char *from, char *to, char *s, int verbose, int symtarget)
 	*q = 0;
 
 	if (symtarget) {
-		if (0 > unlink(s))
-			err(EXIT_FAILURE, _("%s: unlink failed"), s);
-		if (symlink(newname, s) != 0)
-			err(EXIT_FAILURE, _("%s: symlinking to %s failed"), s, newname);
+		if (0 > unlink(s)) {
+			warn(_("%s: unlink failed"), s);
+			ret = 2;
+			goto out;
+		}
+		if (symlink(newname, s) != 0) {
+			warn(_("%s: symlinking to %s failed"), s, newname);
+			ret = 2;
+			goto out;
+		}
 		if (verbose)
 			printf("%s: `%s' -> `%s'\n", s, target, newname);
 	} else {
-		if (rename(s, newname) != 0)
-			err(EXIT_FAILURE, _("%s: rename to %s failed"), s, newname);
+		if (rename(s, newname) != 0) {
+			warn(_("%s: rename to %s failed"), s, newname);
+			ret = 2;
+			goto out;
+		}
 		if (verbose)
 			printf("`%s' -> `%s'\n", s, newname);
 	}
-
+ out:
 	free(newname);
 	free(target);
-	return 1;
+	return ret;
 }
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
@@ -119,7 +138,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 int main(int argc, char **argv)
 {
 	char *from, *to;
-	int i, c, symtarget=0, verbose = 0;
+	int i, c, ret = 0, symtarget = 0, verbose = 0;
 
 	static const struct option longopts[] = {
 		{"verbose", no_argument, NULL, 'v'},
@@ -163,7 +182,18 @@ int main(int argc, char **argv)
 	to = argv[1];
 
 	for (i = 2; i < argc; i++)
-		do_rename(from, to, argv[i], verbose, symtarget);
-
-	return EXIT_SUCCESS;
+		ret |= do_rename(from, to, argv[i], verbose, symtarget);
+
+	switch (ret) {
+	case 0:
+		return RENAME_EXIT_NOTHING;
+	case 1:
+		return EXIT_SUCCESS;
+	case 2:
+		return EXIT_FAILURE;
+	case 3:
+		return RENAME_EXIT_SOMEOK;
+	default:
+		return RENAME_EXIT_UNEXPLAINED;
+	}
 }
-- 
2.0.1

