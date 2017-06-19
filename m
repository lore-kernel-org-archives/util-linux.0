Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50434 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752643AbdFSAmB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 18 Jun 2017 20:42:01 -0400
Subject: [PATCH 04/12] hwclock: add usage() functions heading
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <68a54120-d8ad-59c2-89b6-4ccdd961300b@gmx.com>
Date: Sun, 18 Jun 2017 20:41:45 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Make a functions heading, similar to the existing options heading.

* include/c.h: define USAGE_FUNCTIONS
* Documentation/boilerplate.c: add USAGE_FUNCTIONS
* sys-utils/hwclock.c add functions header to usage()

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/boilerplate.c | 3 +++
 include/c.h                 | 3 ++-
 sys-utils/hwclock.c         | 3 +--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/boilerplate.c b/Documentation/boilerplate.c
index 7da9374..057893b 100644
--- a/Documentation/boilerplate.c
+++ b/Documentation/boilerplate.c
@@ -33,6 +33,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] file...\n"), program_invocation_short_name);
+	fputs(USAGE_FUNCTIONS, out);
+	fputs(_(" -s, --do-something      some specific task\n"), out);
+	fputs(_(" -o, --do-other          some different task\n"), out);
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -n, --no-argument       option does not use argument\n"), out);
 	fputs(_("     --optional[=<arg>]  option argument is optional\n"), out);
diff --git a/include/c.h b/include/c.h
index a5162b9..9c19965 100644
--- a/include/c.h
+++ b/include/c.h
@@ -317,10 +317,11 @@ static inline int xusleep(useconds_t usec)
  */
 #define USAGE_HEADER     _("\nUsage:\n")
 #define USAGE_OPTIONS    _("\nOptions:\n")
+#define USAGE_FUNCTIONS  _("\nFunctions:\n")
 #define USAGE_SEPARATOR    "\n"
 #define USAGE_HELP       _(" -h, --help     display this help and exit\n")
 #define USAGE_VERSION    _(" -V, --version  output version information and exit\n")
-#define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s.\n"), _man
+#define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s\n"), _man
 
 #define UTIL_LINUX_VERSION _("%s from %s\n"), program_invocation_short_name, PACKAGE_STRING
 
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 28655b0..9d6bb11 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1208,8 +1208,7 @@ usage(const struct hwclock_control *ctl, FILE *out)
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" Query or set the hardware clock\n"), out);
 
-	fputs(USAGE_SEPARATOR, out);
-	fputs(_("Functions:\n"), out);
+	fputs(USAGE_FUNCTIONS, out);
 	fputs(_(" -r, --show           read hardware clock and print result\n"
 		"     --get            read hardware clock and print drift corrected result\n"
 		"     --set            set the RTC to the time given with --date\n"), out);
