Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33717 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbJCSbM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Oct 2015 14:31:12 -0400
Received: by wiclk2 with SMTP id lk2so71338991wic.0
        for <util-linux@vger.kernel.org>; Sat, 03 Oct 2015 11:31:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/4] uuidd: slice up the usage text and normalize its layout
Date: Sat,  3 Oct 2015 19:31:04 +0100
Message-Id: <1443897067-6005-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1443897067-6005-1-git-send-email-kerolasa@iki.fi>
References: <1443897067-6005-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidd.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 9d6d08d..76f5e41 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -69,28 +69,26 @@ struct uuidd_cxt_t {
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
-	fprintf(out,
-	      _(" %s [options]\n"), program_invocation_short_name);
-
+	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("A daemon for generating UUIDs.\n"), out);
-
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -p, --pid <path>        path to pid file\n"
-		" -s, --socket <path>     path to socket\n"
-		" -T, --timeout <sec>     specify inactivity timeout\n"
-		" -k, --kill              kill running daemon\n"
-		" -r, --random            test random-based generation\n"
-		" -t, --time              test time-based generation\n"
-		" -n, --uuids <num>       request number of uuids\n"
-		" -P, --no-pid            do not create pid file\n"
-		" -F, --no-fork           do not daemonize using double-fork\n"
-		" -S, --socket-activation do not create listening socket\n"
-		" -d, --debug             run in debugging mode\n"
-		" -q, --quiet             turn on quiet mode\n"
-		" -V, --version           output version information and exit\n"
-		" -h, --help              display this help and exit\n\n"), out);
-
+	fputs(_(" -p, --pid <path>        path to pid file\n"), out);
+	fputs(_(" -s, --socket <path>     path to socket\n"), out);
+	fputs(_(" -T, --timeout <sec>     specify inactivity timeout\n"), out);
+	fputs(_(" -k, --kill              kill running daemon\n"), out);
+	fputs(_(" -r, --random            test random-based generation\n"), out);
+	fputs(_(" -t, --time              test time-based generation\n"), out);
+	fputs(_(" -n, --uuids <num>       request number of uuids\n"), out);
+	fputs(_(" -P, --no-pid            do not create pid file\n"), out);
+	fputs(_(" -F, --no-fork           do not daemonize using double-fork\n"), out);
+	fputs(_(" -S, --socket-activation do not create listening socket\n"), out);
+	fputs(_(" -d, --debug             run in debugging mode\n"), out);
+	fputs(_(" -q, --quiet             turn on quiet mode\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("uuidd(8)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-- 
2.6.0

