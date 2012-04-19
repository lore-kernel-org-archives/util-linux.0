Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58187 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297Ab2DSTK6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 19 Apr 2012 15:10:58 -0400
Received: by eekc41 with SMTP id c41so2334108eek.19
        for <util-linux@vger.kernel.org>; Thu, 19 Apr 2012 12:10:57 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] wdctl: align with other util-linux commands
Date: Thu, 19 Apr 2012 21:10:54 +0200
Message-Id: <1334862654-32253-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* Add watchdog device path to pathnames.h
* Check output stream status at exit.
* Adjust usage() notation to follow howto file.
* Retire numeric return value.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/pathnames.h |    2 ++
 sys-utils/wdctl.c   |   10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index 88bec08..ba8de01 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -146,6 +146,8 @@
 /* deprecated */
 #define _PATH_RAWDEVCTL_OLD	"/dev/rawctl"
 
+/* wdctl path */
+#define _PATH_WATCHDOG_DEV	"/dev/watchdog"
 
 #endif /* PATHNAMES_H */
 
diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 179aff2..4c6f874 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -28,6 +28,8 @@
 
 #include "nls.h"
 #include "c.h"
+#include "closestream.h"
+#include "pathnames.h"
 
 static const struct {
 	uint32_t flag;
@@ -55,7 +57,8 @@ static void usage(int status)
 	      _(" %s [options]\n"), program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -d, --device=	 device to use (/dev/watchdog)\n"), out);
+	fprintf(out,
+	      _(" -d, --device <path>   device to use (default is %s)\n"), _PATH_WATCHDOG_DEV);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -94,12 +97,13 @@ int main(int argc, char *argv[])
 	};
 
 	int c, status, sec, fd;
-	const char *device = "/dev/watchdog";
+	const char *device = _PATH_WATCHDOG_DEV;
 	struct watchdog_info ident;
 
 	setlocale(LC_MESSAGES, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
+	atexit(close_stdout);
 
 	while((c = getopt_long(argc, argv, "hVd:", longopts, NULL)) != -1) {
 
@@ -176,5 +180,5 @@ int main(int argc, char *argv[])
 
 	close(fd);
 
-	return 0;
+	return EXIT_SUCCESS;
 }
-- 
1.7.10

