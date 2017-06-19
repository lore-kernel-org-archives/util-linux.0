Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:61385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752891AbdFSAhg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 18 Jun 2017 20:37:36 -0400
Subject: [PATCH 01/12] hwclock: remove dead code in usage()
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9cfb5b20-1019-c550-fe92-9df337b1fa14@gmx.com>
Date: Sun, 18 Jun 2017 20:37:18 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Commit 677ec86 caused usage() to be called only by --help.

So remove the now dead code from usage().

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 55f54f5..4782318 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1199,24 +1199,9 @@ static void out_version(void)
 	printf(UTIL_LINUX_VERSION);
 }
 
-/*
- * usage - Output (error and) usage information
- *
- * This function is called both directly from main to show usage information
- * and as fatal function from shhopt if some argument is not understood. In
- * case of normal usage info FMT should be NULL. In that case the info is
- * printed to stdout. If FMT is given usage will act like fprintf( stderr,
- * fmt, ... ), show a usage information and terminate the program
- * afterwards.
- */
 static void __attribute__((__noreturn__))
-usage(const struct hwclock_control *ctl, const char *fmt, ...)
+usage(const struct hwclock_control *ctl, FILE *usageto)
 {
-	FILE *usageto;
-	va_list ap;
-
-	usageto = fmt ? stderr : stdout;
-
 	fputs(USAGE_HEADER, usageto);
 	fputs(_(" hwclock [function] [option...]\n"), usageto);
 
@@ -1263,14 +1248,7 @@ usage(const struct hwclock_control *ctl, const char *fmt, ...)
 	fputs(_("     --test           do not update anything, just show what would happen\n"
 		" -D, --debug          debugging mode\n" "\n"), usageto);
 
-	if (fmt) {
-		va_start(ap, fmt);
-		vfprintf(usageto, fmt, ap);
-		va_end(ap);
-	}
-
-	fflush(usageto);
-	hwclock_exit(ctl, fmt ? EX_USAGE : EX_OK);
+	hwclock_exit(ctl, EXIT_SUCCESS);
 }
 
 /*
@@ -1475,7 +1453,7 @@ int main(int argc, char **argv)
 			out_version();
 			return 0;
 		case 'h':			/* --help */
-			usage(&ctl, NULL);
+			usage(&ctl, stdout);
 		default:
 			errtryhelp(EXIT_FAILURE);
 		}
