Return-Path: elseifthen@gmx.com
Subject: [PATCH 02/12] hwclock: update usage() to util-linux style
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <a3863911-bf34-a0da-8f67-b5600ea46cfc@gmx.com>
Date: Sun, 18 Jun 2017 20:38:51 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Update usage() according to:
  Documentation/howto-usage-function.txt
  Documentation/boilerplate.c

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 4782318..d2f8ad1 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1206,11 +1206,11 @@ usage(const struct hwclock_control *ctl, FILE *usageto)
 	fputs(_(" hwclock [function] [option...]\n"), usageto);
 
 	fputs(USAGE_SEPARATOR, usageto);
-	fputs(_("Query or set the hardware clock.\n"), usageto);
+	fputs(_(" Query or set the hardware clock\n"), usageto);
 
-	fputs(_("\nFunctions:\n"), usageto);
-	fputs(_(" -h, --help           show this help text and exit\n"
-		" -r, --show           read hardware clock and print result\n"
+	fputs(USAGE_SEPARATOR, usageto);
+	fputs(_("Functions:\n"), usageto);
+	fputs(_(" -r, --show           read hardware clock and print result\n"
 		"     --get            read hardware clock and print drift corrected result\n"
 		"     --set            set the RTC to the time given with --date\n"), usageto);
 	fputs(_(" -s, --hctosys        set the system time from the hardware clock\n"
@@ -1223,8 +1223,7 @@ usage(const struct hwclock_control *ctl, FILE *usageto)
 		"     --setepoch       set the kernel's hardware clock epoch value to the \n"
 		"                        value given with --epoch\n"), usageto);
 #endif
-	fputs(_("     --predict        predict RTC reading at time given with --date\n"
-		" -V, --version        display version information and exit\n"), usageto);
+	fputs(_("     --predict        predict RTC reading at time given with --date\n"), usageto);
 
 	fputs(USAGE_OPTIONS, usageto);
 	fputs(_(" -u, --utc            the hardware clock is kept in UTC\n"
@@ -1246,8 +1245,11 @@ usage(const struct hwclock_control *ctl, FILE *usageto)
 		"     --adjfile <file> specifies the path to the adjust file;\n"
 		"                        the default is %1$s\n"), _PATH_ADJTIME);
 	fputs(_("     --test           do not update anything, just show what would happen\n"
-		" -D, --debug          debugging mode\n" "\n"), usageto);
-
+		" -D, --debug          debugging mode\n"), usageto);
+	fputs(USAGE_SEPARATOR, usageto);
+	fputs(USAGE_HELP, usageto);
+	fputs(USAGE_VERSION, usageto);
+	fprintf(usageto, USAGE_MAN_TAIL("hwclock(8)"));
 	hwclock_exit(ctl, EXIT_SUCCESS);
 }
 
