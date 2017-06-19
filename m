Return-Path: elseifthen@gmx.com
Subject: [PATCH 06/12] hwclock: use RTC in help output
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <5e0d3131-5637-d9dd-71e7-57cffbde19e3@gmx.com>
Date: Sun, 18 Jun 2017 20:44:06 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Switching between 'hardware clock' and 'RTC' is ambiguous.
RTC is used due to space constraints, so use it consistently.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 9d6bb11..25b159d 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1206,35 +1206,35 @@ usage(const struct hwclock_control *ctl, FILE *out)
 	fputs(_(" hwclock [function] [option...]\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
-	fputs(_(" Query or set the hardware clock\n"), out);
+	fputs(_(" Query or set the RTC (Real Time Clock / Hardware Clock)\n"), out);
 
 	fputs(USAGE_FUNCTIONS, out);
-	fputs(_(" -r, --show           read hardware clock and print result\n"
-		"     --get            read hardware clock and print drift corrected result\n"
+	fputs(_(" -r, --show           read the RTC and print result\n"
+		"     --get            read the RTC and print drift corrected result\n"
 		"     --set            set the RTC to the time given with --date\n"), out);
-	fputs(_(" -s, --hctosys        set the system time from the hardware clock\n"
-		" -w, --systohc        set the hardware clock from the current system time\n"
+	fputs(_(" -s, --hctosys        set the system time from the RTC\n"
+		" -w, --systohc        set the RTC from the current system time\n"
 		"     --systz          set the system time based on the current timezone\n"
 		"     --adjust         adjust the RTC to account for systematic drift since\n"
 		"                        the clock was last set or adjusted\n"), out);
 #if defined(__linux__) && defined(__alpha__)
-	fputs(_("     --getepoch       print out the kernel's hardware clock epoch value\n"
-		"     --setepoch       set the kernel's hardware clock epoch value to the \n"
+	fputs(_("     --getepoch       print out the kernel's RTC epoch value\n"
+		"     --setepoch       set the kernel's RTC epoch value to the \n"
 		"                        value given with --epoch\n"), out);
 #endif
-	fputs(_("     --predict        predict RTC reading at time given with --date\n"), out);
+	fputs(_("     --predict        predict the RTC reading at time given with --date\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -u, --utc            the hardware clock is kept in UTC\n"
-		" -l, --localtime      the hardware clock is kept in local time\n"), out);
+	fputs(_(" -u, --utc            the RTC is kept in UTC\n"
+		" -l, --localtime      the RTC is kept in local time\n"), out);
 #ifdef __linux__
 	fputs(_(" -f, --rtc <file>     special /dev/... file to use instead of default\n"), out);
 #endif
 	fprintf(out, _(
 		"     --directisa      access the ISA bus directly instead of %s\n"
-		"     --date <time>    specifies the time to which to set the hardware clock\n"), _PATH_RTC_DEV);
+		"     --date <time>    specifies the time to which to set the RTC\n"), _PATH_RTC_DEV);
 #if defined(__linux__) && defined(__alpha__)
-	fputs(_("     --epoch <year>   specifies the hardware clock's epoch value\n"), out);
+	fputs(_("     --epoch <year>   specifies the RTC's epoch value\n"), out);
 #endif
 	fprintf(out, _(
 		"     --update-drift   update drift factor in %1$s (requires\n"
