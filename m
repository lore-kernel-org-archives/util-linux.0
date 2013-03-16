Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:65303 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab3CPXk1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Mar 2013 19:40:27 -0400
Received: by mail-wg0-f45.google.com with SMTP id dq12so3994600wgb.0
        for <util-linux@vger.kernel.org>; Sat, 16 Mar 2013 16:40:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/7] whereis: rewrite most of the command
Date: Sat, 16 Mar 2013 23:40:13 +0000
Message-Id: <1363477219-29245-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
References: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The earlier code gave little or no change to fix bugs and improve the
command.  This rewrite attempts to make further patching easier.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/whereis.c | 468 +++++++++++++++++++++++++--------------------------
 1 file changed, 229 insertions(+), 239 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 4194ad5..eeec976 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -49,13 +49,35 @@
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
+#include <assert.h>
 
 #include "xalloc.h"
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
 
-static char *bindirs[] = {
+#define BIN_BIT (1 << 1)
+#define MAN_BIT (1 << 2)
+#define SRC_BIT (1 << 3)
+
+static char uflag = 0;
+
+enum {
+	BIN_DIR = 0,
+	MAN_DIR,
+	SRC_DIR,
+	ALL_DIRS
+};
+
+struct is_here {
+	int type;
+	dev_t st_dev;
+	ino_t st_ino;
+	char *path;
+	struct is_here *next;
+};
+
+static const char *bindirs[] = {
 	"/bin",
 	"/usr/bin",
 	"/sbin",
@@ -110,7 +132,7 @@ static char *bindirs[] = {
 	0
 };
 
-static char *mandirs[] = {
+static const char *mandirs[] = {
 	"/usr/man/*",
 	"/usr/share/man/*",
 	"/usr/X386/man/*",
@@ -120,7 +142,7 @@ static char *mandirs[] = {
 	0
 };
 
-static char *srcdirs[] = {
+static const char *srcdirs[] = {
 	"/usr/src/*",
 	"/usr/src/lib/libc/*",
 	"/usr/src/lib/libc/net/*",
@@ -130,11 +152,7 @@ static char *srcdirs[] = {
 	0
 };
 
-static char sflag = 1, bflag = 1, mflag = 1, uflag;
-static char **Sflag, **Bflag, **Mflag, **pathdir, **pathdir_p;
-static int Scnt, Bcnt, Mcnt, count, print;
-
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(_("\nUsage:\n"), out);
 	fprintf(out,
@@ -156,8 +174,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static int
-itsit(char *cp, char *dp)
+static int itsit(char *cp, char *dp)
 {
 	int i = strlen(dp);
 
@@ -185,86 +202,90 @@ itsit(char *cp, char *dp)
 	return 0;
 }
 
-static void
-findin(char *dir, char *cp)
+static void findin(char *dir, char *cp, int *nr_found, char **wait)
 {
 	DIR *dirp;
 	struct dirent *dp;
-	char *d, *dd;
-	size_t l;
-	char dirbuf[1024];
-	struct stat statbuf;
 
-	dd = strchr(dir, '*');
-	if (!dd) {
-		dirp = opendir(dir);
-		if (dirp == NULL)
-			return;
-		while ((dp = readdir(dirp)) != NULL) {
-			if (itsit(cp, dp->d_name)) {
-				count++;
-				if (print)
-					printf(" %s/%s", dir, dp->d_name);
-			}
-		}
-		closedir(dirp);
+	dirp = opendir(dir);
+	if (dirp == NULL)
 		return;
-	}
-
-	l = strlen(dir);
-	if (l < sizeof(dirbuf)) {
-		/* refuse excessively long names */
-		strcpy(dirbuf, dir);
-		d = strchr(dirbuf, '*');
-		if (d)
-			*d = 0;
-		dirp = opendir(dirbuf);
-		if (dirp == NULL)
-			return;
-		while ((dp = readdir(dirp)) != NULL) {
-			if (!strcmp(dp->d_name, ".") ||
-			    !strcmp(dp->d_name, ".."))
-				continue;
-			if (strlen(dp->d_name) + l > sizeof(dirbuf))
-				continue;
-			sprintf(d, "%s", dp->d_name);
-			if (stat(dirbuf, &statbuf))
-				continue;
-			if (!S_ISDIR(statbuf.st_mode))
-				continue;
-			strcat(d, dd + 1);
-			findin(dirbuf, cp);
+	while ((dp = readdir(dirp)) != NULL)
+		if (itsit(cp, dp->d_name)) {
+			if (*(nr_found) == 0)
+				xasprintf(wait, "%s/%s", dir, dp->d_name);
+			else if (*(nr_found) == 1 && *wait != NULL)
+				printf("%s: %s %s/%s", cp, *wait, dir,
+				       dp->d_name);
+			else if (*(nr_found) == 1)
+				printf("%s: %s/%s", cp, dir, dp->d_name);
+			else
+				printf(" %s/%s", dir, dp->d_name);
+			(*nr_found)++;
 		}
-		closedir(dirp);
-	}
+	closedir(dirp);
 	return;
-
 }
 
-static int inpath(const char *str)
+static void add_dir(struct is_here *dirlist, int type, const char *dir)
 {
-	size_t i;
+	struct stat statbuf;
+	struct is_here *prev = NULL;
 
-	for (i = 0; i < ARRAY_SIZE(bindirs) - 1 ; i++)
-		if (!strcmp(bindirs[i], str))
-			return 1;
+	if (access(dir, R_OK) != 0)
+		return;
+	if (stat(dir, &statbuf))
+		return;
+	if (!S_ISDIR(statbuf.st_mode))
+		return;
+	while (dirlist) {
+		if (dirlist->st_ino == statbuf.st_ino &&
+		    dirlist->st_dev == statbuf.st_dev && dirlist->type == type)
+			return;
+		prev = dirlist;
+		dirlist = dirlist->next;
+	}
+	assert(prev);
+	dirlist = xcalloc(1, sizeof(struct is_here));
+	dirlist->st_ino = statbuf.st_ino;
+	dirlist->st_dev = statbuf.st_dev;
+	dirlist->type = type;
+	dirlist->path = xstrdup(dir);
+	prev->next = dirlist;
+	return;
+}
 
-	for (i = 0; i < ARRAY_SIZE(mandirs) - 1; i++)
-		if (!strcmp(mandirs[i], str))
-			return 1;
+static void add_subdirs(struct is_here *dirlist, int type,
+			const char *dir)
+{
+#define DIRBUF 1024
+	char dirbuf[DIRBUF], *d;
+	DIR *dirp;
+	struct dirent *dp;
 
-	for (i = 0; i < ARRAY_SIZE(srcdirs) - 1; i++)
-		if (!strcmp(srcdirs[i], str))
-			return 1;
+	strncpy(dirbuf, dir, DIRBUF);
+	d = strchr(dirbuf, '*');
+	*d = 0;
 
-	return 0;
+	dirp = opendir(dirbuf);
+	if (dirp == NULL)
+		return;
+	while ((dp = readdir(dirp)) != NULL) {
+		if (!strcmp(dp->d_name, ".") || !strcmp(dp->d_name, ".."))
+			continue;
+		sprintf(d, "%s", dp->d_name);
+		/* a dir definition can have a star in middle of path */
+		strcat(dirbuf, strchr(dir, '*') + 1);
+		add_dir(dirlist, type, dirbuf);
+	}
+	closedir(dirp);
+	return;
 }
 
-static void fillpath(void)
+static void environ_list(const char *env, struct is_here *dirlist,
+			 int type)
 {
-	char *key=NULL, *tok=NULL, *pathcp, *path = getenv("PATH");
-	int i = 0;
-
+	char *key = NULL, *tok = NULL, *pathcp, *path = getenv(env);
 
 	if (!path)
 		return;
@@ -272,150 +293,105 @@ static void fillpath(void)
 
 	for (tok = strtok_r(pathcp, ":", &key); tok;
 	     tok = strtok_r(NULL, ":", &key)) {
-
-		/* make sure we don't repeat the search path */
-		if (inpath(tok))
-			continue;
-
-		pathdir = xrealloc(pathdir, (i + 1) * sizeof(char *));
-		pathdir[i++] = xstrdup(tok);
+		add_dir(dirlist, type, tok);
 	}
-
-	pathdir = xrealloc(pathdir, (i + 1) * sizeof(char *));
-	pathdir[i] = NULL;
-
-	pathdir_p = pathdir;
 	free(pathcp);
+	return;
 }
 
-static void freepath(void)
-{
-	free(pathdir);
-}
-
-static void
-findv(char **dirv, int dirc, char *cp)
-{
-
-	while (dirc > 0)
-		findin(*dirv++, cp), dirc--;
-}
-
-static void
-looksrc(char *cp)
-{
-	if (Sflag == NULL)
-		findv(srcdirs, ARRAY_SIZE(srcdirs)-1, cp);
-	else
-		findv(Sflag, Scnt, cp);
-}
-
-static void
-lookbin(char *cp)
-{
-	if (Bflag == NULL) {
-		findv(bindirs, ARRAY_SIZE(bindirs)-1, cp);
-		while (*pathdir_p)
-			findin(*pathdir_p++, cp);		/* look $PATH */
-	 } else
-		findv(Bflag, Bcnt, cp);
-}
-
-static void
-lookman(char *cp)
+static void construct_list(struct is_here *dirlist, int type,
+			   const char **list)
 {
-	if (Mflag == NULL)
-		findv(mandirs, ARRAY_SIZE(mandirs)-1, cp);
-	else
-		findv(Mflag, Mcnt, cp);
+	size_t i;
+	char *star;
+	for (i = 0; list[i]; i++) {
+		star = strchr(list[i], '*');
+		if (!star)
+			add_dir(dirlist, type, list[i]);
+		else
+			add_subdirs(dirlist, type, list[i]);
+	}
+	return;
 }
 
-static void
-getlist(int *argcp, char ***argvp, char ***flagp, int *cntp)
+static void getlist(int *argcp, char ***argvp, struct is_here *dirlist,
+		   int type)
 {
 	(*argvp)++;
-	*flagp = *argvp;
-	*cntp = 0;
-	for ((*argcp)--; *argcp > 0 && (*argvp)[0][0] != '-'; (*argcp)--)
-		(*cntp)++, (*argvp)++;
-	(*argcp)++;
-	(*argvp)--;
+	for ((*argcp)--; 0 < *argcp && (*argvp)[0][0] != '-'; (*argcp)--) {
+		add_dir(dirlist, type, **argvp);
+		(*argvp)++;
+	}
+	return;
 }
 
-static void
-zerof(void)
+static int check_type(int type, int flags)
 {
-	if (sflag && bflag && mflag)
-		sflag = bflag = mflag = 0;
+	if (type == BIN_DIR && !(flags & BIN_BIT))
+		return 1;
+	if (type == MAN_DIR && !(flags & MAN_BIT))
+		return 1;
+	if (type == SRC_DIR && !(flags & SRC_BIT))
+		return 1;
+	return 0;
 }
 
-static int
-print_again(char *cp)
+static struct is_here *free_dirs(struct is_here *dirlist, int type)
 {
-	if (print)
-		printf("%s:", cp);
-	if (sflag) {
-		looksrc(cp);
-		if (uflag && print == 0 && count != 1) {
-			print = 1;
-			return 1;
+	struct is_here *first, *prev, *next;
+	if (type == ALL_DIRS) {
+		while (dirlist) {
+			next = dirlist->next;
+			free(dirlist->path);
+			free(dirlist);
+			dirlist = next;
 		}
+		return NULL;
 	}
-	count = 0;
-	if (bflag) {
-		lookbin(cp);
-		if (uflag && print == 0 && count != 1) {
-			print = 1;
-			return 1;
-		}
-	}
-	count = 0;
-	if (mflag) {
-		lookman(cp);
-		if (uflag && print == 0 && count != 1) {
-			print = 1;
-			return 1;
+	first = NULL;
+	prev = NULL;
+	while (dirlist) {
+		if (dirlist->type == type) {
+			next = dirlist->next;
+			free(dirlist->path);
+			free(dirlist);
+			dirlist = next;
+			if (prev)
+				prev->next = dirlist;
+			continue;
 		}
+		if (!first)
+			first = dirlist;
+		prev = dirlist;
+		dirlist = dirlist->next;
 	}
-	return 0;
+	return first;
 }
 
-static void
-lookup(char *cp)
+static void lookup(char *argv, struct is_here *dirlist, int flags)
 {
-	register char *dp;
-
-	for (dp = cp; *dp; dp++)
-		continue;
-	for (; dp > cp; dp--) {
-		if (*dp == '.') {
-			*dp = 0;
-			break;
-		}
+	int nr_found;
+	char *wait = NULL;
+
+	nr_found = uflag == 1 ? 0 : 1;
+
+	for (; dirlist; dirlist = dirlist->next) {
+		if (check_type(dirlist->type, flags))
+			continue;
+		if (dirlist->path != NULL)
+			findin(dirlist->path, argv, &nr_found, &wait);
 	}
-	for (dp = cp; *dp; dp++)
-		if (*dp == '/')
-			cp = dp + 1;
-	if (uflag) {
-		print = 0;
-		count = 0;
-	} else
-		print = 1;
-
-	while (print_again(cp))
-		/* all in print_again() */ ;
-
-	if (print)
-		printf("\n");
+	free(wait);
+	if (1 < nr_found)
+		putchar('\n');
+	return;
 }
 
-/*
- * whereis name
- * look for source, documentation and binaries
- */
-int
-main(int argc, char **argv)
+int main(int argc, char **argv)
 {
+	struct is_here *dirlist;
+	char flags = CHAR_MAX;
+
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
@@ -425,60 +401,74 @@ main(int argc, char **argv)
 	if (argc == 0)
 		usage(stderr);
 
+	dirlist = xcalloc(1, sizeof(struct is_here));
+	construct_list(dirlist, BIN_DIR, bindirs);
+	environ_list("PATH", dirlist, BIN_DIR);
+	construct_list(dirlist, MAN_DIR, mandirs);
+	construct_list(dirlist, SRC_DIR, srcdirs);
+
 	do
 		if (argv[0][0] == '-') {
 			register char *cp = argv[0] + 1;
-			while (*cp) switch (*cp++) {
-
-			case 'f':
-				break;
-
-			case 'S':
-				getlist(&argc, &argv, &Sflag, &Scnt);
-				break;
-
-			case 'B':
-				getlist(&argc, &argv, &Bflag, &Bcnt);
-				break;
-
-			case 'M':
-				getlist(&argc, &argv, &Mflag, &Mcnt);
-				break;
-
-			case 's':
-				zerof();
-				sflag++;
-				continue;
-
-			case 'u':
-				uflag++;
-				continue;
-
-			case 'b':
-				zerof();
-				bflag++;
-				continue;
-
-			case 'm':
-				zerof();
-				mflag++;
-				continue;
-			case 'V':
-				printf(UTIL_LINUX_VERSION);
-				return EXIT_SUCCESS;
-			case 'h':
-				usage(stdout);
-			default:
-				usage(stderr);
-			}
+			while (*cp)
+				switch (*cp++) {
+
+				case 'f':
+					break;
+
+				case 'u':
+					uflag = 1;
+					continue;
+
+				case 'B':
+					dirlist = free_dirs(dirlist, BIN_DIR);
+					getlist(&argc, &argv, dirlist, BIN_DIR);
+					break;
+
+				case 'M':
+					dirlist = free_dirs(dirlist, MAN_DIR);
+					getlist(&argc, &argv, dirlist, MAN_DIR);
+					break;
+
+				case 'S':
+					dirlist = free_dirs(dirlist, SRC_DIR);
+					getlist(&argc, &argv, dirlist, SRC_DIR);
+					break;
+
+				case 'b':
+					if (flags == CHAR_MAX)
+						flags = BIN_BIT;
+					else
+						flags |= BIN_BIT;
+					continue;
+
+				case 'm':
+					if (flags == CHAR_MAX)
+						flags = MAN_BIT;
+					else
+						flags |= MAN_BIT;
+					continue;
+
+				case 's':
+					if (flags == CHAR_MAX)
+						flags = SRC_BIT;
+					else
+						flags |= SRC_BIT;
+					continue;
+
+				case 'V':
+					printf(UTIL_LINUX_VERSION);
+					return EXIT_SUCCESS;
+				case 'h':
+					usage(stdout);
+				default:
+					usage(stderr);
+				}
 			argv++;
 		} else {
-			if (Bcnt == 0 && pathdir == NULL)
-				fillpath();
-			lookup(*argv++);
+			lookup(*argv++, dirlist, flags);
 		}
 	while (--argc > 0);
-
-	freepath();
+	free_dirs(dirlist, ALL_DIRS);
 	return EXIT_SUCCESS;
 }
-- 
1.8.2

