Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33230 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbcEAW4R (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 May 2016 18:56:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id r12so14854009wme.0
        for <util-linux@vger.kernel.org>; Sun, 01 May 2016 15:56:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] scriptreplay: avoid re-implementing strtod_or_err()
Date: Sun,  1 May 2016 23:56:05 +0100
Message-Id: <1462143365-17916-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462143365-17916-1-git-send-email-kerolasa@iki.fi>
References: <1462143365-17916-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And use isnan() to detect NaN.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/Makemodule.am  |  1 +
 term-utils/scriptreplay.c | 17 ++++-------------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index ea1affc..8ddb068 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -21,6 +21,7 @@ if BUILD_SCRIPTREPLAY
 usrbin_exec_PROGRAMS += scriptreplay
 dist_man_MANS += term-utils/scriptreplay.1
 scriptreplay_SOURCES = term-utils/scriptreplay.c
+scriptreplay_LDADD = $(LDADD) libcommon.la
 endif # BUILD_SCRIPTREPLAY
 
 
diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index 51985cd..1461335 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -30,6 +30,7 @@
 
 #include "closestream.h"
 #include "nls.h"
+#include "strutils.h"
 #include "c.h"
 
 #define SCRIPT_MIN_DELAY 0.0001		/* from original sripreplay.pl */
@@ -60,21 +61,11 @@ usage(FILE *out)
 static double
 getnum(const char *s)
 {
-	double d;
-	char *end;
+	const double d = strtod_or_err(s, _("failed to parse number"));
 
-	errno = 0;
-	d = strtod(s, &end);
-
-	if (end && *end != '\0')
-		errx(EXIT_FAILURE, _("expected a number, but got '%s'"), s);
-
-	if ((d == HUGE_VAL || d == -HUGE_VAL) && ERANGE == errno)
-		err(EXIT_FAILURE, _("divisor '%s'"), s);
-
-	if (!(d==d)) { /* did they specify "nan"? */
+	if (isnan(d)) {
 		errno = EINVAL;
-		err(EXIT_FAILURE, _("divisor '%s'"), s);
+		err(EXIT_FAILURE, "%s: %s", _("failed to parse number"), s);
 	}
 	return d;
 }
-- 
2.8.0

