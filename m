Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:49133 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbBVOmE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:04 -0500
Received: by mail-wg0-f51.google.com with SMTP id y19so21178837wgg.10
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:03 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/16] lib/strutils: move parse_switch() from setterm(1) to library
Date: Sun, 22 Feb 2015 14:41:37 +0000
Message-Id: <1424616106-580-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

To allow sharing the code with other utilities.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/strutils.h   |  2 ++
 lib/strutils.c       |  8 ++++++++
 term-utils/setterm.c | 14 --------------
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/strutils.h b/include/strutils.h
index 4d8463a..ee8c7cb 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -36,6 +36,8 @@ extern void strtotimeval_or_err(const char *str, struct timeval *tv,
 
 extern int isdigit_string(const char *str);
 
+extern int parse_switch(const char *arg, const char *a, const char *b);
+
 #ifndef HAVE_MEMPCPY
 extern void *mempcpy(void *restrict dest, const void *restrict src, size_t n);
 #endif
diff --git a/lib/strutils.c b/lib/strutils.c
index c4f9600..f6154aa 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -181,6 +181,14 @@ int isdigit_string(const char *str)
 	return p && p > str && !*p;
 }
 
+int parse_switch(const char *arg, const char *a, const char *b)
+{
+	if (strcmp(arg, a) == 0)
+		return 1;
+	else if (strcmp(arg, b) == 0)
+		return 0;
+	errx(STRTOXX_EXIT_CODE, _("argument error: %s"), arg);
+}
 
 #ifndef HAVE_MEMPCPY
 void *mempcpy(void *restrict dest, const void *restrict src, size_t n)
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 76fedba..253f84f 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -178,20 +178,6 @@ struct setterm_control {
 	    opt_powerdown:1, opt_blength:1, opt_bfreq:1;
 };
 
-/* Command line parsing routines.
- *
- * Note that it is an error for a given option to be invoked more than once.
- */
-
-static int parse_switch(const char *arg, const char *t, const char *f)
-{
-	if (strcmp(arg, t) == 0)
-		return 1;
-	else if (strcmp(arg, f) == 0)
-		return 0;
-	errx(EXIT_FAILURE, _("argument error: %s"), arg);
-}
-
 static int parse_febg_color(const char *arg)
 {
 	int color;
-- 
2.3.0

