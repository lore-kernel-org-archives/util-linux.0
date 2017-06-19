Return-Path: elseifthen@gmx.com
Subject: [PATCH 07/12] hwclock: update --help content and grammar
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <bf8f26c6-c0d8-2190-38ed-456dfe0fe58a@gmx.com>
Date: Sun, 18 Jun 2017 20:45:09 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 include/c.h         |  4 ++--
 sys-utils/hwclock.c | 48 +++++++++++++++++++++---------------------------
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/include/c.h b/include/c.h
index 9c19965..bd073fc 100644
--- a/include/c.h
+++ b/include/c.h
@@ -319,8 +319,8 @@ static inline int xusleep(useconds_t usec)
 #define USAGE_OPTIONS    _("\nOptions:\n")
 #define USAGE_FUNCTIONS  _("\nFunctions:\n")
 #define USAGE_SEPARATOR    "\n"
-#define USAGE_HELP       _(" -h, --help     display this help and exit\n")
-#define USAGE_VERSION    _(" -V, --version  output version information and exit\n")
+#define USAGE_HELP       _(" -h, --help     display this information and exit\n")
+#define USAGE_VERSION    _(" -V, --version  display version information and exit\n")
 #define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s\n"), _man
 
 #define UTIL_LINUX_VERSION _("%s from %s\n"), program_invocation_short_name, PACKAGE_STRING
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 25b159d..33d1bd2 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1209,42 +1209,36 @@ usage(const struct hwclock_control *ctl, FILE *out)
 	fputs(_(" Query or set the RTC (Real Time Clock / Hardware Clock)\n"), out);
 
 	fputs(USAGE_FUNCTIONS, out);
-	fputs(_(" -r, --show           read the RTC and print result\n"
-		"     --get            read the RTC and print drift corrected result\n"
-		"     --set            set the RTC to the time given with --date\n"), out);
+	fputs(_(" -r, --show           display the RTC time\n"
+		"     --get            display drift corrected RTC time\n"
+		"     --set            set the RTC according to --date\n"), out);
 	fputs(_(" -s, --hctosys        set the system time from the RTC\n"
-		" -w, --systohc        set the RTC from the current system time\n"
-		"     --systz          set the system time based on the current timezone\n"
-		"     --adjust         adjust the RTC to account for systematic drift since\n"
-		"                        the clock was last set or adjusted\n"), out);
+		" -w, --systohc        set the RTC from the system time\n"
+		"     --systz          send timescale configurations to the kernel\n"
+		"     --adjust         adjust the RTC to account for systematic drift\n"), out);
 #if defined(__linux__) && defined(__alpha__)
-	fputs(_("     --getepoch       print out the kernel's RTC epoch value\n"
-		"     --setepoch       set the kernel's RTC epoch value to the \n"
-		"                        value given with --epoch\n"), out);
+	fputs(_("     --getepoch       display the RTC epoch\n"
+		"     --setepoch       set the RTC epoch according to --epoch\n"), out);
 #endif
-	fputs(_("     --predict        predict the RTC reading at time given with --date\n"), out);
-
+	fputs(_("     --predict        predict the drifted RTC time according to --date\n"), out);
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -u, --utc            the RTC is kept in UTC\n"
-		" -l, --localtime      the RTC is kept in local time\n"), out);
+	fputs(_(" -u, --utc            inform hwclock the RTC timescale is UTC\n"
+		" -l, --localtime      inform hwclock the RTC timescale is Local\n"), out);
+	fprintf(out, _(
 #ifdef __linux__
-	fputs(_(" -f, --rtc <file>     special /dev/... file to use instead of default\n"), out);
+		" -f, --rtc <file>     use an alternate file to %1$s\n"
 #endif
-	fprintf(out, _(
-		"     --directisa      access the ISA bus directly instead of %s\n"
-		"     --date <time>    specifies the time to which to set the RTC\n"), _PATH_RTC_DEV);
+		"     --directisa      use the ISA bus instead of %1$s access\n"
+		"     --date <time>    date/time input for --set and --predict\n"), _PATH_RTC_DEV);
 #if defined(__linux__) && defined(__alpha__)
-	fputs(_("     --epoch <year>   specifies the RTC's epoch value\n"), out);
+	fputs(_("     --epoch <year>   epoch input for --setepoch\n"), out);
 #endif
 	fprintf(out, _(
-		"     --update-drift   update drift factor in %1$s (requires\n"
-		"                        --set or --systohc)\n"
-		"     --noadjfile      do not access %1$s; this requires the use of\n"
-		"                        either --utc or --localtime\n"
-		"     --adjfile <file> specifies the path to the adjust file;\n"
-		"                        the default is %1$s\n"), _PATH_ADJTIME);
-	fputs(_("     --test           do not update anything, just show what would happen\n"
-		" -D, --debug          debugging mode\n"), out);
+		"     --update-drift   update drift factor (requires --set or --systohc)\n"
+		"     --noadjfile      do not use %1$s\n"
+		"     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
+	fputs(_("     --test           dry run; use -D to view what would have happened\n"
+		" -D, --debug          use debug mode\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
