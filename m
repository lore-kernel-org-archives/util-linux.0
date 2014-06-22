Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:59859 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbaFVKcW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Jun 2014 06:32:22 -0400
Received: by mail-wi0-f173.google.com with SMTP id cc10so2674146wib.6
        for <util-linux@vger.kernel.org>; Sun, 22 Jun 2014 03:32:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/6] rename: continue despite something failed
Date: Sun, 22 Jun 2014 11:31:56 +0100
Message-Id: <1403433117-32652-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
References: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Try to do all file operations even when one or some of them fail.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/rename.c | 55 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index b945aaa..250070b 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -29,20 +29,26 @@ for i in $@; do N=`echo "$i" | sed "s/$FROM/$TO/g"`; mv "$i" "$N"; done
 
 static int do_rename(char *from, char *to, char *s, int verbose, int symtarget)
 {
-	char *newname, *where, *p, *q, *target = NULL;
-	int flen, tlen, slen;
+	char *newname = NULL, *where, *p, *q, *target = NULL;
+	int flen, tlen, slen, ret = 0;
 	struct stat sb;
 
 	if (symtarget) {
-		if (lstat(s, &sb) == -1)
-			err(EXIT_FAILURE, _("%s: lstat failed"), s);
-
-		if (!S_ISLNK(sb.st_mode))
-			errx(EXIT_FAILURE, _("%s: not a symbolic link"), s);
+		if (lstat(s, &sb) == -1) {
+			warn(_("%s: lstat failed"), s);
+			return 1;
+		}
+		if (!S_ISLNK(sb.st_mode)) {
+			warnx(_("%s: not a symbolic link"), s);
+			return 1;
+		}
 
 		target = xmalloc(sb.st_size + 1);
-		if (readlink(s, target, sb.st_size + 1) < 0)
-			err(EXIT_FAILURE, _("%s: readlink failed"), s);
+		if (readlink(s, target, sb.st_size + 1) < 0) {
+			warn(_("%s: readlink failed"), s);
+			ret = 1;
+			goto out;
+		}
 
 		target[sb.st_size] = '\0';
 		where = strstr(target, from);
@@ -82,22 +88,31 @@ static int do_rename(char *from, char *to, char *s, int verbose, int symtarget)
 	*q = 0;
 
 	if (symtarget) {
-		if (0 > unlink(s))
-			err(EXIT_FAILURE, _("%s: unlink failed"), s);
-		if (symlink(newname, s) != 0)
-			err(EXIT_FAILURE, _("%s: symlinking to %s failed"), s, newname);
+		if (0 > unlink(s)) {
+			warn(_("%s: unlink failed"), s);
+			ret = 1;
+			goto out;
+		}
+		if (symlink(newname, s) != 0) {
+			warn(_("%s: symlinking to %s failed"), s, newname);
+			ret = 1;
+			goto out;
+		}
 		if (verbose)
 			printf("%s: `%s' -> `%s'\n", s, target, newname);
 	} else {
-		if (rename(s, newname) != 0)
-			err(EXIT_FAILURE, _("%s: rename to %s failed"), s, newname);
+		if (rename(s, newname) != 0) {
+			warn(_("%s: rename to %s failed"), s, newname);
+			ret = 1;
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
@@ -119,7 +134,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 int main(int argc, char **argv)
 {
 	char *from, *to;
-	int i, c, symtarget=0, verbose = 0;
+	int i, c, ret = 0, symtarget = 0, verbose = 0;
 
 	static const struct option longopts[] = {
 		{"verbose", no_argument, NULL, 'v'},
@@ -163,7 +178,7 @@ int main(int argc, char **argv)
 	to = argv[1];
 
 	for (i = 2; i < argc; i++)
-		do_rename(from, to, argv[i], verbose, symtarget);
+		ret |= do_rename(from, to, argv[i], verbose, symtarget);
 
-	return EXIT_SUCCESS;
+	return ret;
 }
-- 
2.0.0

