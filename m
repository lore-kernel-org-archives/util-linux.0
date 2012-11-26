Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:60253 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab2KZPvP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 Nov 2012 10:51:15 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so3499918wer.19
        for <util-linux@vger.kernel.org>; Mon, 26 Nov 2012 07:51:13 -0800 (PST)
From: "=?UTF-8?q?Jan=20=28yac=29=20Mat=C4=9Bjka?=" <yac@blesmrt.net>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q? "Jan=20(yac)=20Mat=C4=9Bjka" ?= <JMatejka@suse.cz>
Subject: [PATCH] + rename --symlink option for renaming symlink target
Date: Mon, 26 Nov 2012 16:50:08 +0100
Message-Id: <1353945008-24493-1-git-send-email-JMatejka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: "Jan (yac) Matějka" <JMatejka@suse.cz>

---
 misc-utils/rename.1 |    3 ++
 misc-utils/rename.c |   69 +++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/misc-utils/rename.1 b/misc-utils/rename.1
index 5f86b23..1ce6c12 100644
--- a/misc-utils/rename.1
+++ b/misc-utils/rename.1
@@ -21,6 +21,9 @@ Give visual feedback which files where renamed, if any.
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
 .TP
+\fB\-s\fR, \fB\-\-symlink\fR
+Peform rename on symlink target
+.TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
 .SH EXAMPLES
diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index b17e03b..c71fab1 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -18,27 +18,55 @@ for i in $@; do N=`echo "$i" | sed "s/$FROM/$TO/g"`; mv "$i" "$N"; done
 #include <stdlib.h>
 #include <errno.h>
 #include <getopt.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 
 #include "nls.h"
 #include "xalloc.h"
 #include "c.h"
 #include "closestream.h"
 
-static int do_rename(char *from, char *to, char *s, int verbose)
+static int do_rename(char *from, char *to, char *s, int verbose, int symlink_)
 {
-	char *newname, *where, *p, *q;
+	char *newname, *where, *p, *q, *target;
 	int flen, tlen, slen;
+	struct stat sb;
+
+	if (symlink_) {
+		if (lstat(s, &sb) == -1) {
+			err(EXIT_FAILURE, _("lstat failed"));
+		}
+
+		if(!S_ISLNK(sb.st_mode))
+			/* Check the file is symlink before allocating the size of it */
+			errx(EXIT_FAILURE, _("%s is not a symbolic link"), s);
+
+		target = xmalloc(sb.st_size + 1);
+		if(0 > readlink(s, target, sb.st_size+1)) {
+			err(EXIT_FAILURE, _("readlink %s failed"), s);
+		}
+		target[sb.st_size] = '\0';
+
+		where = strstr(target, from);
+	}else{
+		where = strstr(s, from);
+	}
 
-	where = strstr(s, from);
 	if (where == NULL)
 		return 0;
 
 	flen = strlen(from);
 	tlen = strlen(to);
-	slen = strlen(s);
+	if(symlink_) {
+		slen = strlen(target);
+		p = target;
+	}else{
+		slen = strlen(s);
+		p = s;
+	}
 	newname = xmalloc(tlen + slen + 1);
 
-	p = s;
 	q = newname;
 	while (p < where)
 		*q++ = *p++;
@@ -50,11 +78,21 @@ static int do_rename(char *from, char *to, char *s, int verbose)
 		*q++ = *p++;
 	*q = 0;
 
-	if (rename(s, newname) != 0)
-		err(EXIT_FAILURE, _("renaming %s to %s failed"),
-		    s, newname);
-	if (verbose)
-		printf("`%s' -> `%s'\n", s, newname);
+	if(symlink_) {
+		if (0 > unlink(s))
+			err(EXIT_FAILURE, _("unlinking %s failed"), s);
+		if (symlink(newname, s) != 0)
+			err(EXIT_FAILURE, _("symlinking %s to %s failed"), s, newname);
+		if (verbose)
+			printf("%s: `%s' -> `%s'\n", s, target, newname);
+	}else{
+		if (rename(s, newname) != 0)
+			err(EXIT_FAILURE, _("renaming %s to %s failed"),
+				s, newname);
+		if (verbose)
+			printf("`%s' -> `%s'\n", s, newname);
+	}
+
 
 	free(newname);
 	return 1;
@@ -70,6 +108,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_("\nOptions:\n"), out);
 	fputs(_(" -v, --verbose    explain what is being done\n"
 		" -V, --version    output version information and exit\n"
+		" -s, --symlink    act on symlink target\n"
 		" -h, --help       display this help and exit\n\n"), out);
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
@@ -78,12 +117,13 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 int main(int argc, char **argv)
 {
 	char *from, *to;
-	int i, c, verbose = 0;
+	int i, c, symlink=0, verbose = 0;
 
 	static const struct option longopts[] = {
 		{"verbose", no_argument, NULL, 'v'},
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
+		{"symlink", no_argument, NULL, 's'},
 		{NULL, 0, NULL, 0}
 	};
 
@@ -92,11 +132,14 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "vVh", longopts, NULL)) != -1)
+	while ((c = getopt_long(argc, argv, "vsVh", longopts, NULL)) != -1)
 		switch (c) {
 		case 'v':
 			verbose = 1;
 			break;
+		case 's':
+			symlink = 1;
+			break;
 		case 'V':
 			printf(_("%s from %s\n"),
 			       program_invocation_short_name,
@@ -120,7 +163,7 @@ int main(int argc, char **argv)
 	to = argv[1];
 
 	for (i = 2; i < argc; i++)
-		do_rename(from, to, argv[i], verbose);
+		do_rename(from, to, argv[i], verbose, symlink);
 
 	return EXIT_SUCCESS;
 }
-- 
1.7.8.6

