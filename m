Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35537 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdGOVU4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Jul 2017 17:20:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id u23so16610706wma.2
        for <util-linux@vger.kernel.org>; Sat, 15 Jul 2017 14:20:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/5] ldattach: simplify debugging function when vwarnx(3) is available
Date: Sat, 15 Jul 2017 22:20:43 +0100
Message-Id: <20170715212046.1655-3-kerolasa@iki.fi>
In-Reply-To: <20170715212046.1655-1-kerolasa@iki.fi>
References: <20170715212046.1655-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The vwarnx(3) is probably not available in all libc implementations, in such
cases use the earlier printout as a fallback.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac         |  1 +
 sys-utils/ldattach.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index c76c2a0f3..38b968878 100644
--- a/configure.ac
+++ b/configure.ac
@@ -428,6 +428,7 @@ AC_CHECK_FUNCS([ \
 	sysinfo \
 	timegm \
 	usleep \
+	vwarnx \
 	warn \
 	warnx \
 ])
diff --git a/sys-utils/ldattach.c b/sys-utils/ldattach.c
index eb04b5e33..d33d68535 100644
--- a/sys-utils/ldattach.c
+++ b/sys-utils/ldattach.c
@@ -137,11 +137,15 @@ static void dbg(char *fmt, ...)
 	if (debug == 0)
 		return;
 	fflush(NULL);
-	fprintf(stderr, "%s: ", program_invocation_short_name);
 	va_start(args, fmt);
+#ifdef HAVE_VWARNX
+	vwarnx(fmt, args);
+#else
+	fprintf(stderr, "%s: ", program_invocation_short_name);
 	vfprintf(stderr, fmt, args);
-	va_end(args);
 	fprintf(stderr, "\n");
+#endif
+	va_end(args);
 	fflush(NULL);
 	return;
 }
@@ -252,7 +256,7 @@ static int my_cfsetspeed(struct termios *ts, int speed)
 
 static void handler(int s)
 {
-	dbg("got SIG %i -> exiting\n", s);
+	dbg("got SIG %i -> exiting", s);
 	exit(EXIT_SUCCESS);
 }
 
-- 
2.13.3

