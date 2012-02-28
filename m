Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33189 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qpr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:47 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so1997660vbb.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:47 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 12/13] sulogin: use a more standard usage output
Date: Tue, 28 Feb 2012 11:45:20 -0500
Message-Id: <1330447521-886-13-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/sulogin.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index f276a3e..6cb075c 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -50,6 +50,8 @@
 #  include <selinux/get_context_list.h>
 #endif
 
+#include "c.h"
+#include "nls.h"
 #include "pathnames.h"
 
 static int timeout;
@@ -398,9 +400,20 @@ static void sushell(struct passwd *pwd)
 	perror("/bin/sh");
 }
 
-static void usage(void)
+static void usage(FILE *out)
 {
-	fprintf(stderr, "Usage: sulogin [-e] [-p] [-t timeout] [tty device]\n");
+	fprintf(out, USAGE_HEADER);
+	fprintf(out, _(
+			" %s [options] [tty device]\n"), program_invocation_short_name);
+
+	fprintf(out, USAGE_OPTIONS);
+	fprintf(out, _(
+			" -p        start a login shell\n"
+			" -t SEC    set max time to wait for a password (default: no limit)\n"
+			" -e        examine shadow files directly if getpwnam(3) fails\n"
+			" -h        display this help message\n"));
+
+	fprintf(out, _("\nFor more information see sulogin(8).\n"));
 }
 
 int main(int argc, char **argv)
@@ -417,7 +430,7 @@ int main(int argc, char **argv)
 	 *	See if we have a timeout flag.
 	 */
 	opterr = 0;
-	while ((c = getopt(argc, argv, "ept:")) != EOF) {
+	while ((c = getopt(argc, argv, "ehpt:")) != EOF) {
 		switch(c) {
 		case 't':
 			timeout = atoi(optarg);
@@ -428,8 +441,11 @@ int main(int argc, char **argv)
 		case 'e':
 			opt_e = 1;
 			break;
+		case 'h':
+			usage(stdout);
+			return 0;
 		default:
-			usage();
+			usage(stderr);
 			/* Do not exit! */
 			break;
 		}
-- 
1.7.9.2

