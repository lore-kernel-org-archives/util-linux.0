Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36158 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdCSKUH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 19 Mar 2017 06:20:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id l37so14478736wrc.3
        for <util-linux@vger.kernel.org>; Sun, 19 Mar 2017 03:20:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/5] tests: do not use plain 0 as NULL [smatch scan]
Date: Sun, 19 Mar 2017 10:10:42 +0000
Message-Id: <20170319101045.3018-3-kerolasa@iki.fi>
In-Reply-To: <20170319101045.3018-1-kerolasa@iki.fi>
References: <20170319101045.3018-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Likewise commit 87918040658f2fa9b1bf78f1f8f4f5c065a2e3a3.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/colors.c                    | 10 +++++-----
 lib/cpuset.c                    |  8 ++++----
 libfdisk/samples/mkpart.c       |  8 ++++----
 libsmartcols/samples/fromfile.c | 24 ++++++++++++------------
 libsmartcols/samples/title.c    |  6 +++---
 libsmartcols/samples/tree.c     | 20 ++++++++++----------
 misc-utils/test_uuidd.c         |  2 +-
 7 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/lib/colors.c b/lib/colors.c
index dda617057..b2742e4e9 100644
--- a/lib/colors.c
+++ b/lib/colors.c
@@ -830,11 +830,11 @@ int colormode_or_err(const char *str, const char *errmsg)
 int main(int argc, char *argv[])
 {
 	static const struct option longopts[] = {
-		{ "mode",	required_argument, 0, 'm' },
-		{ "color",	required_argument, 0, 'c' },
-		{ "color-scheme", required_argument, 0, 'C' },
-		{ "name",	required_argument, 0, 'n' },
-		{ NULL, 0, 0, 0 }
+		{ "mode",	required_argument, NULL, 'm' },
+		{ "color",	required_argument, NULL, 'c' },
+		{ "color-scheme", required_argument, NULL, 'C' },
+		{ "name",	required_argument, NULL, 'n' },
+		{ NULL, 0, NULL, 0 }
 	};
 	int c, mode = UL_COLORMODE_UNDEF;	/* default */
 	const char *color = "red", *name = NULL, *color_scheme = NULL;
diff --git a/lib/cpuset.c b/lib/cpuset.c
index 89cd0f14c..fbe99e2a5 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -333,10 +333,10 @@ int main(int argc, char *argv[])
 	int ncpus = 2048, rc, c;
 
 	static const struct option longopts[] = {
-	    { "ncpus", 1, 0, 'n' },
-	    { "mask",  1, 0, 'm' },
-	    { "range", 1, 0, 'r' },
-	    { NULL,    0, 0, 0 }
+	    { "ncpus", 1, NULL, 'n' },
+	    { "mask",  1, NULL, 'm' },
+	    { "range", 1, NULL, 'r' },
+	    { NULL,    0, NULL, 0 }
 	};
 
 	while ((c = getopt_long(argc, argv, "n:m:r:", longopts, NULL)) != -1) {
diff --git a/libfdisk/samples/mkpart.c b/libfdisk/samples/mkpart.c
index dc476dbe9..4ca3ed35d 100644
--- a/libfdisk/samples/mkpart.c
+++ b/libfdisk/samples/mkpart.c
@@ -55,10 +55,10 @@ int main(int argc, char *argv[])
 	unsigned int sectorsize;
 
 	static const struct option longopts[] = {
-		{ "label",  required_argument, 0, 'x' },
-		{ "device", required_argument, 0, 'd' },
-		{ "help",   no_argument, 0, 'h' },
-		{ NULL, 0, 0, 0 },
+		{ "label",  required_argument, NULL, 'x' },
+		{ "device", required_argument, NULL, 'd' },
+		{ "help",   no_argument, NULL, 'h' },
+		{ NULL, 0, NULL, 0 },
 	};
 
 	setlocale(LC_ALL, "");	/* just to have enable UTF8 chars */
diff --git a/libsmartcols/samples/fromfile.c b/libsmartcols/samples/fromfile.c
index 1a90e2d4b..674f01206 100644
--- a/libsmartcols/samples/fromfile.c
+++ b/libsmartcols/samples/fromfile.c
@@ -222,18 +222,18 @@ int main(int argc, char *argv[])
 	int parent_col = -1, id_col = -1;
 
 	static const struct option longopts[] = {
-		{ "maxout", 0, 0, 'm' },
-		{ "column", 1, 0, 'c' },
-		{ "nlines", 1, 0, 'n' },
-		{ "width",  1, 0, 'w' },
-		{ "tree-parent-column", 1, 0, 'p' },
-		{ "tree-id-column",	1, 0, 'i' },
-		{ "json",   0, 0, 'J' },
-		{ "raw",    0, 0, 'r' },
-		{ "export", 0, 0, 'E' },
-		{ "colsep",  1, 0, 'C' },
-		{ "help",   0, 0, 'h' },
-		{ NULL, 0, 0, 0 },
+		{ "maxout", 0, NULL, 'm' },
+		{ "column", 1, NULL, 'c' },
+		{ "nlines", 1, NULL, 'n' },
+		{ "width",  1, NULL, 'w' },
+		{ "tree-parent-column", 1, NULL, 'p' },
+		{ "tree-id-column",	1, NULL, 'i' },
+		{ "json",   0, NULL, 'J' },
+		{ "raw",    0, NULL, 'r' },
+		{ "export", 0, NULL, 'E' },
+		{ "colsep",  1, NULL, 'C' },
+		{ "help",   0, NULL, 'h' },
+		{ NULL, 0, NULL, 0 },
 	};
 
 	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
diff --git a/libsmartcols/samples/title.c b/libsmartcols/samples/title.c
index 852316095..2d33b563a 100644
--- a/libsmartcols/samples/title.c
+++ b/libsmartcols/samples/title.c
@@ -60,9 +60,9 @@ int main(int argc, char *argv[])
 	int c;
 
 	static const struct option longopts[] = {
-		{ "maxout", 0, 0, 'm' },
-		{ "width",  1, 0, 'w' },
-		{ NULL, 0, 0, 0 },
+		{ "maxout", 0, NULL, 'm' },
+		{ "width",  1, NULL, 'w' },
+		{ NULL, 0, NULL, 0 },
 	};
 
 	setlocale(LC_ALL, "");	/* just to have enable UTF8 chars */
diff --git a/libsmartcols/samples/tree.c b/libsmartcols/samples/tree.c
index c809b2d85..fcb175135 100644
--- a/libsmartcols/samples/tree.c
+++ b/libsmartcols/samples/tree.c
@@ -162,16 +162,16 @@ int main(int argc, char *argv[])
 
 
 	static const struct option longopts[] = {
-		{ "ascii",	0, 0, 'i' },
-		{ "csv",        0, 0, 'c' },
-		{ "list",       0, 0, 'l' },
-		{ "noheadings",	0, 0, 'n' },
-		{ "pairs",      0, 0, 'p' },
-		{ "json",       0, 0, 'J' },
-		{ "raw",        0, 0, 'r' },
-		{ "range-start",1, 0, 'S' },
-		{ "range-end",  1, 0, 'E' },
-		{ NULL, 0, 0, 0 },
+		{ "ascii",	0, NULL, 'i' },
+		{ "csv",        0, NULL, 'c' },
+		{ "list",       0, NULL, 'l' },
+		{ "noheadings",	0, NULL, 'n' },
+		{ "pairs",      0, NULL, 'p' },
+		{ "json",       0, NULL, 'J' },
+		{ "raw",        0, NULL, 'r' },
+		{ "range-start",1, NULL, 'S' },
+		{ "range-end",  1, NULL, 'E' },
+		{ NULL, 0, NULL, 0 },
 	};
 
 	setlocale(LC_ALL, "");	/* just to have enable UTF8 chars */
diff --git a/misc-utils/test_uuidd.c b/misc-utils/test_uuidd.c
index 13a9880b1..d590f9632 100644
--- a/misc-utils/test_uuidd.c
+++ b/misc-utils/test_uuidd.c
@@ -146,7 +146,7 @@ static void *create_uuids(thread_t *th)
 		obj->pid = th->proc->pid;
 		obj->idx = th->index + i;;
 	}
-	return 0;
+	return NULL;
 }
 
 static void *thread_body(void *arg)
-- 
2.12.0

