Return-Path: dave@gnu.org
Subject: [PATCH] whereis: search in path variable
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Jul 2011 00:46:25 -0400
Message-ID: <1311137185.3077.1.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Wed, 20 Jul 2011 00:39:10 -0400

Currently this tool only uses the hardcoded paths for looking up strings for binaries, man pages and source code,
adding those directories found in $PATH makes a nice little enhancement.

dave@offbook:~/projects/util-linux/misc-utils$ export PATH=$PATH:/home/dave/whereis-test
dave@offbook:~/projects/util-linux/misc-utils$ ./whereis stdlib
stdlib: /home/dave/whereis-test/stdlib.h /usr/include/stdlib.h
dave@offbook:~/projects/util-linux/misc-utils$ whereis-old stdlib
stdlib: /usr/include/stdlib.h

This feature was also discussed previously here (http://www.spinics.net/lists/util-linux-ng/msg03429.html)

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/whereis.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 4f841f9..ec75057 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -45,6 +45,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
+
+#include "xalloc.h"
 #include "nls.h"
 #include "c.h"
 
@@ -58,6 +60,7 @@ void findv(char **, int, char *);
 void find(char **, char *);
 void findin(char *, char *);
 int itsit(char *, char *);
+void fillpath(void);
 
 static char *bindirs[] = {
 	"/bin",
@@ -144,6 +147,7 @@ int	Bcnt;
 char	**Mflag;
 int	Mcnt;
 char	uflag;
+char    **dirp, **pathdir = NULL;
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
@@ -172,6 +176,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 int
 main(int argc, char **argv)
 {
+	int i;
+
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
@@ -179,6 +185,9 @@ main(int argc, char **argv)
 	argc--, argv++;
 	if (argc == 0)
 		usage(stderr);
+	
+	fillpath();
+	dirp = pathdir;
 
 	do
 		if (argv[0][0] == '-') {
@@ -232,9 +241,51 @@ main(int argc, char **argv)
 		} else
 			lookup(*argv++);
 	while (--argc > 0);
+
+	free(pathdir);
+
 	return EXIT_SUCCESS;
 }
 
+int inpath(const char *str)
+{
+	int i;
+
+	for (i = 0; i < sizeof(bindirs)/sizeof(char *) - 1 ; i++)
+		if (!strcmp(bindirs[i], str))
+			return 1;
+	
+	for (i = 0; i < sizeof(mandirs)/sizeof(char *) - 1; i++)
+		if (!strcmp(mandirs[i], str))
+			return 1;
+		
+	for (i = 0; i < sizeof(srcdirs)/sizeof(char *) - 1; i++)
+		if (!strcmp(srcdirs[i], str))
+			return 1;
+	
+	return 0;
+}
+
+void fillpath(void)
+{
+	char *key=NULL, *tmp=NULL, *tok=NULL, *path = getenv("PATH");
+	int i = 0;
+
+	if (!path)
+		return;
+
+	for (tmp = path; ;tmp = NULL) {
+		tok = strtok_r(tmp, ":", &key);
+		if (!tok)
+			break;
+		if (inpath(tok)) /* make sure we don't repeat the search path */
+			continue;
+
+		pathdir = xrealloc(pathdir, (i + 1) * sizeof(char *));
+		pathdir[i++] = tok;
+	}
+}
+
 void
 getlist(int *argcp, char ***argvp, char ***flagp, int *cntp)
 {
@@ -356,6 +407,8 @@ find(char **dirs, char *cp)
 {
 	while (*dirs)
 		findin(*dirs++, cp);
+	while(*dirp)
+		findin(*dirp++, cp);
 }
 
 void
-- 
1.7.4.1
