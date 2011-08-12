Return-Path: dave@gnu.org
Subject: [PATCH v2] whereis: search in path
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Aug 2011 13:55:42 -0400
Message-ID: <1313171742.3305.3.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Sorry for the delay, lots of things on my plate these days. Below is the patch with the mentioned fixes.

From: Davidlohr Bueso <dave@gnu.org>
Date: Fri, 12 Aug 2011 13:49:59 -0400

Currently this tool only uses the hardcoded paths for looking up strings for binaries, man pages and source code.
Adding directories found in $PATH makes a nice little enhancement to support a wider range of lookups.

This feature was also discussed previously here (http://www.spinics.net/lists/util-linux-ng/msg03429.html)

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/whereis.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 68 insertions(+), 1 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 08b62e6..6393a70 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -37,6 +37,10 @@
  * - added Native Language Support
  */
 
+/* 2011-08-12 Davidlohr Bueso <dave@gnu.org>
+ * - added $PATH lookup
+ */
+
 #include <sys/param.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -45,6 +49,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
+
+#include "xalloc.h"
 #include "nls.h"
 #include "c.h"
 
@@ -124,7 +130,7 @@ static char *srcdirs[] = {
 };
 
 static char sflag = 1, bflag = 1, mflag = 1, uflag;
-static char **Sflag, **Bflag, **Mflag;
+static char **Sflag, **Bflag, **Mflag, **dirp, **pathdir;
 static int Scnt, Bcnt, Mcnt, count, print;
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
@@ -231,11 +237,68 @@ findin(char *dir, char *cp)
 
 }
 
+static int inpath(const char *str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(bindirs) - 1 ; i++)
+		if (!strcmp(bindirs[i], str))
+			return 1;
+	
+	for (i = 0; i < ARRAY_SIZE(mandirs) - 1; i++)
+		if (!strcmp(mandirs[i], str))
+			return 1;
+		
+	for (i = 0; i < ARRAY_SIZE(srcdirs) - 1; i++)
+		if (!strcmp(srcdirs[i], str))
+			return 1;
+	
+	return 0;
+}
+
+static void fillpath(void)
+{
+	char *key=NULL, *tmp=NULL, *tok=NULL, *pathcp, *path = getenv("PATH");
+	int i = 0;
+
+
+	if (!path)
+		return;
+	pathcp = xstrdup(path);
+
+	for (tmp = pathcp; ;tmp = NULL, tok) {
+		tok = strtok_r(tmp, ":", &key);
+		if (!tok)
+			break;
+		
+		/* make sure we don't repeat the search path */
+		if (inpath(tok))
+			continue;
+
+		pathdir = xrealloc(pathdir, (i + 1) * sizeof(char *));
+		pathdir[i++] = xstrdup(tok);
+	}
+
+	pathdir = xrealloc(pathdir, (i + 1) * sizeof(char *));
+	pathdir[i] = NULL;
+
+	dirp = pathdir;
+	free(pathcp);
+}
+
+static void freepath(void)
+{
+	free(pathdir);
+}
+
 static void
 findv(char **dirv, int dirc, char *cp)
 {
+
 	while (dirc > 0)
 		findin(*dirv++, cp), dirc--;
+	while (*dirp)
+		findin(*dirp++, cp);
 }
 
 static void
@@ -359,6 +422,8 @@ main(int argc, char **argv)
 	if (argc == 0)
 		usage(stderr);
 
+	fillpath();
+
 	do
 		if (argv[0][0] == '-') {
 			register char *cp = argv[0] + 1;
@@ -411,5 +476,7 @@ main(int argc, char **argv)
 		} else
 			lookup(*argv++);
 	while (--argc > 0);
+
+	freepath();
 	return EXIT_SUCCESS;
 }
-- 
1.7.4.1
