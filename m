Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:64117 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbaF1SaR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 28 Jun 2014 14:30:17 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so4223688wib.7
        for <util-linux@vger.kernel.org>; Sat, 28 Jun 2014 11:30:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/7] rename: use function pointer to select file or symlink operation
Date: Sat, 28 Jun 2014 19:30:08 +0100
Message-Id: <1403980209-15694-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1403980209-15694-1-git-send-email-kerolasa@iki.fi>
References: <1403980209-15694-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add separate functions to different functionality, and add a function for
the stuff that is in common for both.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/rename.c | 142 +++++++++++++++++++++++++---------------------------
 1 file changed, 67 insertions(+), 75 deletions(-)

diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 3270aa5..9064bc3 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -31,94 +31,85 @@ for i in $@; do N=`echo "$i" | sed "s/$FROM/$TO/g"`; mv "$i" "$N"; done
 #define RENAME_EXIT_NOTHING	4
 #define RENAME_EXIT_UNEXPLAINED	64
 
-static int do_rename(char *from, char *to, char *s, int verbose, int symtarget)
+static int string_replace(char *from, char *to, char *s, char *orig, char **newname)
 {
-	char *newname = NULL, *where, *p, *q, *target = NULL;
-	int flen, tlen, slen, ret = 1;
-	struct stat sb;
-
-	if (symtarget) {
-		if (lstat(s, &sb) == -1) {
-			warn(_("%s: lstat failed"), s);
-			return 2;
-		}
-		if (!S_ISLNK(sb.st_mode)) {
-			warnx(_("%s: not a symbolic link"), s);
-			return 2;
-		}
-
-		target = xmalloc(sb.st_size + 1);
-		if (readlink(s, target, sb.st_size + 1) < 0) {
-			warn(_("%s: readlink failed"), s);
-			ret = 2;
-			goto out;
-		}
-
-		target[sb.st_size] = '\0';
-		where = strstr(target, from);
-	} else {
-		char *file;
-
-		file = rindex(s, '/');
-		if (file == NULL)
-			file = s;
-		where = strstr(file, from);
-	}
-	if (where == NULL) {
-		free(target);
-		return 0;
-	}
-
-	flen = strlen(from);
-	tlen = strlen(to);
-	if (symtarget) {
-		slen = strlen(target);
-		p = target;
-	} else {
-		slen = strlen(s);
-		p = s;
-	}
-	newname = xmalloc(tlen + slen + 1);
-
-	q = newname;
+	char *p, *q, *where;
+
+	where = strstr(s, from);
+	if (where == NULL)
+		return 1;
+	p = orig;
+	*newname = xmalloc(strlen(orig) + strlen(to) + 1);
+	q = *newname;
 	while (p < where)
 		*q++ = *p++;
 	p = to;
 	while (*p)
 		*q++ = *p++;
-	p = where + flen;
+	p = where + strlen(from);
 	while (*p)
 		*q++ = *p++;
 	*q = 0;
+	return 0;
+}
 
-	if (symtarget) {
-		if (0 > unlink(s)) {
-			warn(_("%s: unlink failed"), s);
-			ret = 2;
-			goto out;
-		}
-		if (symlink(newname, s) != 0) {
-			warn(_("%s: symlinking to %s failed"), s, newname);
-			ret = 2;
-			goto out;
-		}
-		if (verbose)
-			printf("%s: `%s' -> `%s'\n", s, target, newname);
-	} else {
-		if (rename(s, newname) != 0) {
-			warn(_("%s: rename to %s failed"), s, newname);
-			ret = 2;
-			goto out;
-		}
-		if (verbose)
-			printf("`%s' -> `%s'\n", s, newname);
+static int do_symlink(char *from, char *to, char *s, int verbose)
+{
+	char *newname = NULL, *target = NULL;
+	int ret = 1;
+	struct stat sb;
+
+	if (lstat(s, &sb) == -1) {
+		warn(_("%s: lstat failed"), s);
+		return 2;
+	}
+	if (!S_ISLNK(sb.st_mode)) {
+		warnx(_("%s: not a symbolic link"), s);
+		return 2;
+	}
+	target = xmalloc(sb.st_size + 1);
+	if (readlink(s, target, sb.st_size + 1) < 0) {
+		warn(_("%s: readlink failed"), s);
+		free(target);
+		return 2;
+	}
+	target[sb.st_size] = '\0';
+	if (string_replace(from, to, target, target, &newname))
+		ret = 0;
+	else if (0 > unlink(s)) {
+		warn(_("%s: unlink failed"), s);
+		ret = 2;
+	} else if (symlink(newname, s) != 0) {
+		warn(_("%s: symlinking to %s failed"), s, newname);
+		ret = 2;
 	}
- out:
+	if (verbose && ret == 1)
+		printf("%s: `%s' -> `%s'\n", s, target, newname);
 	free(newname);
 	free(target);
 	return ret;
 }
 
+static int do_file(char *from, char *to, char *s, int verbose)
+{
+	char *newname = NULL, *file;
+	int ret = 1;
+
+	file = rindex(s, '/');
+	if (file == NULL)
+		file = s;
+	if (string_replace(from, to, file, s, &newname))
+		return 0;
+	else if (rename(s, newname) != 0) {
+		warn(_("%s: rename to %s failed"), s, newname);
+		ret = 2;
+	}
+	if (verbose && ret == 1)
+		printf("`%s' -> `%s'\n", s, newname);
+	free(newname);
+	return ret;
+}
+
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
@@ -138,7 +129,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 int main(int argc, char **argv)
 {
 	char *from, *to;
-	int i, c, ret = 0, symtarget = 0, verbose = 0;
+	int i, c, ret = 0, verbose = 0;
+	int (*do_rename)(char *from, char *to, char *s, int verbose) = do_file;
 
 	static const struct option longopts[] = {
 		{"verbose", no_argument, NULL, 'v'},
@@ -159,7 +151,7 @@ int main(int argc, char **argv)
 			verbose = 1;
 			break;
 		case 's':
-			symtarget = 1;
+			do_rename = do_symlink;
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -182,7 +174,7 @@ int main(int argc, char **argv)
 	to = argv[1];
 
 	for (i = 2; i < argc; i++)
-		ret |= do_rename(from, to, argv[i], verbose, symtarget);
+		ret |= do_rename(from, to, argv[i], verbose);
 
 	switch (ret) {
 	case 0:
-- 
2.0.1

