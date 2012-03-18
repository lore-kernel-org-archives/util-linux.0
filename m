Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f53.google.com ([209.85.216.53]:54360 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab2CRDgo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Mar 2012 23:36:44 -0400
Received: by qadc11 with SMTP id c11so304555qad.19
        for <util-linux@vger.kernel.org>; Sat, 17 Mar 2012 20:36:43 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 5/5] findmnt: add -D, --df option to imitate df(1)
Date: Sat, 17 Mar 2012 23:36:33 -0400
Message-Id: <1332041793-7919-5-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
References: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/findmnt.8 |    3 +++
 misc-utils/findmnt.c |   20 ++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index c1734ca..8ad4432 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -49,6 +49,9 @@ Search in
 The output is in the tree-like format.  This is the default.
 .IP "\fB\-c, \-\-canonicalize\fP"
 Canonicalize all printed paths.
+.IP "\fB\-D, \-\-df\fP"
+Imitate the output of df(1). This option is equivalent to
+"-o SOURCE,FSTYPE,SIZE,USED,AVAIL,USE%,TARGET".
 .IP "\fB\-d, \-\-direction \fIword\fP"
 The search direction -
 .IR forward
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 547be66..84092d2 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -890,6 +890,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out, _(
 	" -a, --ascii            use ASCII chars for tree formatting\n"
 	" -c, --canonicalize     canonicalize printed paths\n"
+	" -D, --df               imitate the output of df(1)\n"
 	" -d, --direction <word> direction of search, 'forward' or 'backward'\n"
 	" -e, --evaluate         convert tags (LABEL/UUID) to device names\n"
 	" -F, --tab-file <path>  alternative file for --fstab, --mtab or --kernel options\n"
@@ -936,7 +937,7 @@ int main(int argc, char *argv[])
 	struct libmnt_table *tb = NULL;
 	char **tabfiles = NULL;
 	int direction = MNT_ITER_FORWARD;
-	int i, c, rc = -1, timeout = -1;
+	int i, c, rc = -1, timeout = -1, df_output = 0;
 	int ntabfiles = 0, tabtype = 0;
 
 	/* table.h */
@@ -946,6 +947,7 @@ int main(int argc, char *argv[])
 	    { "ascii",        0, 0, 'a' },
 	    { "canonicalize", 0, 0, 'c' },
 	    { "direction",    1, 0, 'd' },
+	    { "df",           0, 0, 'D' },
 	    { "evaluate",     0, 0, 'e' },
 	    { "first-only",   0, 0, 'f' },
 	    { "fstab",        0, 0, 's' },
@@ -982,7 +984,7 @@ int main(int argc, char *argv[])
 	tt_flags |= TT_FL_TREE;
 
 	while ((c = getopt_long(argc, argv,
-				"acd:ehifF:o:O:p::Pklmnrst:uvRS:T:w:",
+				"acDd:ehifF:o:O:p::Pklmnrst:uvRS:T:w:",
 				longopts, NULL)) != -1) {
 		switch(c) {
 		case 'a':
@@ -991,6 +993,10 @@ int main(int argc, char *argv[])
 		case 'c':
 			flags |= FL_CANONICALIZE;
 			break;
+		case 'D':
+			tt_flags &= ~TT_FL_TREE;
+			df_output = 1;
+			break;
 		case 'd':
 			if (!strcmp(optarg, "forward"))
 				direction = MNT_ITER_FORWARD;
@@ -1100,6 +1106,16 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (df_output) {
+		columns[ncolumns++] = COL_SOURCE;
+		columns[ncolumns++] = COL_FSTYPE;
+		columns[ncolumns++] = COL_SIZE;
+		columns[ncolumns++] = COL_USED;
+		columns[ncolumns++] = COL_AVAIL;
+		columns[ncolumns++] = COL_USEPERC;
+		columns[ncolumns++] = COL_TARGET;
+	}
+
 	/* default columns */
 	if (!ncolumns) {
 		if (flags & FL_POLL)
-- 
1.7.9.4

