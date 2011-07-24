Return-Path: dave@gnu.org
Subject: [PATCH] whereis: update coding style
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Jul 2011 19:06:33 -0400
Message-ID: <1311548793.3367.15.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Sun, 24 Jul 2011 11:11:19 -0400

Like most 20th century Berkeley code, it's horrible:
	- declare global variables in only one place
	- add static attribute where it belongs
	- move funcion declarations so that it doesn't require defining them

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/whereis.c |  360 ++++++++++++++++++++++++--------------------------
 1 files changed, 170 insertions(+), 190 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index a331f45..08b62e6 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -48,16 +48,6 @@
 #include "nls.h"
 #include "c.h"
 
-void zerof(void);
-void getlist(int *, char ***, char ***, int *);
-void lookup(char *);
-void looksrc(char *);
-void lookbin(char *);
-void lookman(char *);
-void findv(char **, int, char *);
-void findin(char *, char *);
-int itsit(char *, char *);
-
 static char *bindirs[] = {
 	"/bin",
 	"/usr/bin",
@@ -133,16 +123,9 @@ static char *srcdirs[] = {
 	0
 };
 
-char	sflag = 1;
-char	bflag = 1;
-char	mflag = 1;
-char	**Sflag;
-int	Scnt;
-char	**Bflag;
-int	Bcnt;
-char	**Mflag;
-int	Mcnt;
-char	uflag;
+static char sflag = 1, bflag = 1, mflag = 1, uflag;
+static char **Sflag, **Bflag, **Mflag;
+static int Scnt, Bcnt, Mcnt, count, print;
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
@@ -164,77 +147,125 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-/*
- * whereis name
- * look for source, documentation and binaries
- */
-int
-main(int argc, char **argv)
+static int
+itsit(char *cp, char *dp)
 {
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-
-	argc--, argv++;
-	if (argc == 0)
-		usage(stderr);
+	int i = strlen(dp);
 
-	do
-		if (argv[0][0] == '-') {
-			register char *cp = argv[0] + 1;
-			while (*cp) switch (*cp++) {
+	if (dp[0] == 's' && dp[1] == '.' && itsit(cp, dp + 2))
+		return 1;
+	if (!strcmp(dp + i - 2, ".Z"))
+		i -= 2;
+	else if (!strcmp(dp + i - 3, ".gz"))
+		i -= 3;
+	else if (!strcmp(dp + i - 4, ".bz2"))
+		i -= 4;
+	while (*cp && *dp && *cp == *dp)
+		cp++, dp++, i--;
+	if (*cp == 0 && *dp == 0)
+		return 1;
+	while (isdigit(*dp))
+		dp++;
+	if (*cp == 0 && *dp++ == '.') {
+		--i;
+		while (i > 0 && *dp)
+			if (--i, *dp++ == '.')
+				return (*dp++ == 'C' && *dp++ == 0);
+		return 1;
+	}
+	return 0;
+}
 
-			case 'f':
-				break;
+static void
+findin(char *dir, char *cp)
+{
+	DIR *dirp;
+	struct dirent *dp;
+	char *d, *dd;
+	size_t l;
+	char dirbuf[1024];
+	struct stat statbuf;
 
-			case 'S':
-				getlist(&argc, &argv, &Sflag, &Scnt);
-				break;
+	dd = strchr(dir, '*');
+	if (!dd) {
+		dirp = opendir(dir);
+		if (dirp == NULL)
+			return;
+		while ((dp = readdir(dirp)) != NULL) {
+			if (itsit(cp, dp->d_name)) {
+				count++;
+				if (print)
+					printf(" %s/%s", dir, dp->d_name);
+			}
+		}
+		closedir(dirp);
+		return;
+	}
 
-			case 'B':
-				getlist(&argc, &argv, &Bflag, &Bcnt);
-				break;
+	l = strlen(dir);
+	if (l < sizeof(dirbuf)) {
+		/* refuse excessively long names */
+		strcpy(dirbuf, dir);
+		d = strchr(dirbuf, '*');
+		*d = 0;
+		dirp = opendir(dirbuf);
+		if (dirp == NULL)
+			return;
+		while ((dp = readdir(dirp)) != NULL) {
+			if (!strcmp(dp->d_name, ".") ||
+			    !strcmp(dp->d_name, ".."))
+				continue;
+			if (strlen(dp->d_name) + l > sizeof(dirbuf))
+				continue;
+			sprintf(d, "%s", dp->d_name);
+			if (stat(dirbuf, &statbuf))
+				continue;
+			if (!S_ISDIR(statbuf.st_mode))
+				continue;
+			strcat(d, dd + 1);
+			findin(dirbuf, cp);
+		}
+		closedir(dirp);
+	}
+	return;
 
-			case 'M':
-				getlist(&argc, &argv, &Mflag, &Mcnt);
-				break;
+}
 
-			case 's':
-				zerof();
-				sflag++;
-				continue;
+static void
+findv(char **dirv, int dirc, char *cp)
+{
+	while (dirc > 0)
+		findin(*dirv++, cp), dirc--;
+}
 
-			case 'u':
-				uflag++;
-				continue;
+static void
+looksrc(char *cp)
+{
+	if (Sflag == 0)
+		findv(srcdirs, ARRAY_SIZE(srcdirs)-1, cp);
+	else
+		findv(Sflag, Scnt, cp);
+}
 
-			case 'b':
-				zerof();
-				bflag++;
-				continue;
+static void
+lookbin(char *cp)
+{
+	if (Bflag == 0)
+		findv(bindirs, ARRAY_SIZE(bindirs)-1, cp);
+	else
+		findv(Bflag, Bcnt, cp);
+}
 
-			case 'm':
-				zerof();
-				mflag++;
-				continue;
-			case 'V':
-				printf(_("%s from %s\n"),
-					program_invocation_short_name,
-					PACKAGE_STRING);
-				return EXIT_SUCCESS;
-			case 'h':
-				usage(stdout);
-			default:
-				usage(stderr);
-			}
-			argv++;
-		} else
-			lookup(*argv++);
-	while (--argc > 0);
-	return EXIT_SUCCESS;
+static void
+lookman(char *cp)
+{
+	if (Mflag == 0)
+		findv(mandirs, ARRAY_SIZE(mandirs)-1, cp);
+	else
+		findv(Mflag, Mcnt, cp);
 }
 
-void
+static void
 getlist(int *argcp, char ***argvp, char ***flagp, int *cntp)
 {
 	(*argvp)++;
@@ -246,17 +277,14 @@ getlist(int *argcp, char ***argvp, char ***flagp, int *cntp)
 	(*argvp)--;
 }
 
-void
+static void
 zerof()
 {
 	if (sflag && bflag && mflag)
 		sflag = bflag = mflag = 0;
 }
 
-int	count;
-int	print;
-
-int
+static int
 print_again(char *cp)
 {
 	if (print)
@@ -287,7 +315,7 @@ print_again(char *cp)
 	return 0;
 }
 
-void
+static void
 lookup(char *cp)
 {
 	register char *dp;
@@ -316,120 +344,72 @@ lookup(char *cp)
 		printf("\n");
 }
 
-void
-looksrc(char *cp)
+/*
+ * whereis name
+ * look for source, documentation and binaries
+ */
+int
+main(int argc, char **argv)
 {
-	if (Sflag == 0)
-		findv(srcdirs, ARRAY_SIZE(srcdirs)-1, cp);
-	else
-		findv(Sflag, Scnt, cp);
-}
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
 
-void
-lookbin(char *cp)
-{
-	if (Bflag == 0)
-		findv(bindirs, ARRAY_SIZE(bindirs)-1, cp);
-	else
-		findv(Bflag, Bcnt, cp);
-}
+	argc--, argv++;
+	if (argc == 0)
+		usage(stderr);
 
-void
-lookman(char *cp)
-{
-	if (Mflag == 0)
-		findv(mandirs, ARRAY_SIZE(mandirs)-1, cp);
-	else
-		findv(Mflag, Mcnt, cp);
-}
+	do
+		if (argv[0][0] == '-') {
+			register char *cp = argv[0] + 1;
+			while (*cp) switch (*cp++) {
 
-void
-findv(char **dirv, int dirc, char *cp)
-{
-	while (dirc > 0)
-		findin(*dirv++, cp), dirc--;
-}
+			case 'f':
+				break;
 
-void
-findin(char *dir, char *cp)
-{
-	DIR *dirp;
-	struct dirent *dp;
-	char *d, *dd;
-	size_t l;
-	char dirbuf[1024];
-	struct stat statbuf;
+			case 'S':
+				getlist(&argc, &argv, &Sflag, &Scnt);
+				break;
 
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
-		return;
-	}
+			case 'B':
+				getlist(&argc, &argv, &Bflag, &Bcnt);
+				break;
 
-	l = strlen(dir);
-	if (l < sizeof(dirbuf)) {
-		/* refuse excessively long names */
-		strcpy(dirbuf, dir);
-		d = strchr(dirbuf, '*');
-		*d = 0;
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
+			case 'M':
+				getlist(&argc, &argv, &Mflag, &Mcnt);
+				break;
+
+			case 's':
+				zerof();
+				sflag++;
 				continue;
-			strcat(d, dd + 1);
-			findin(dirbuf, cp);
-		}
-		closedir(dirp);
-	}
-	return;
 
-}
+			case 'u':
+				uflag++;
+				continue;
 
-int
-itsit(char *cp, char *dp)
-{
-	int i = strlen(dp);
+			case 'b':
+				zerof();
+				bflag++;
+				continue;
 
-	if (dp[0] == 's' && dp[1] == '.' && itsit(cp, dp + 2))
-		return 1;
-	if (!strcmp(dp + i - 2, ".Z"))
-		i -= 2;
-	else if (!strcmp(dp + i - 3, ".gz"))
-		i -= 3;
-	else if (!strcmp(dp + i - 4, ".bz2"))
-		i -= 4;
-	while (*cp && *dp && *cp == *dp)
-		cp++, dp++, i--;
-	if (*cp == 0 && *dp == 0)
-		return 1;
-	while (isdigit(*dp))
-		dp++;
-	if (*cp == 0 && *dp++ == '.') {
-		--i;
-		while (i > 0 && *dp)
-			if (--i, *dp++ == '.')
-				return (*dp++ == 'C' && *dp++ == 0);
-		return 1;
-	}
-	return 0;
+			case 'm':
+				zerof();
+				mflag++;
+				continue;
+			case 'V':
+				printf(_("%s from %s\n"),
+					program_invocation_short_name,
+					PACKAGE_STRING);
+				return EXIT_SUCCESS;
+			case 'h':
+				usage(stdout);
+			default:
+				usage(stderr);
+			}
+			argv++;
+		} else
+			lookup(*argv++);
+	while (--argc > 0);
+	return EXIT_SUCCESS;
 }
-- 
1.7.4.1
