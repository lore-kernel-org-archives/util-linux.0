Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752891AbdFSAk0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 18 Jun 2017 20:40:26 -0400
Subject: [PATCH 03/12] hwclock: update usage() FILE name
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <b97a3054-33f0-d666-ab4f-558e30f98eb8@gmx.com>
Date: Sun, 18 Jun 2017 20:40:11 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Use the util-linux standard file name instead of 'usageto'.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index d2f8ad1..28655b0 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1200,44 +1200,44 @@ static void out_version(void)
 }
 
 static void __attribute__((__noreturn__))
-usage(const struct hwclock_control *ctl, FILE *usageto)
+usage(const struct hwclock_control *ctl, FILE *out)
 {
-	fputs(USAGE_HEADER, usageto);
-	fputs(_(" hwclock [function] [option...]\n"), usageto);
+	fputs(USAGE_HEADER, out);
+	fputs(_(" hwclock [function] [option...]\n"), out);
 
-	fputs(USAGE_SEPARATOR, usageto);
-	fputs(_(" Query or set the hardware clock\n"), usageto);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_(" Query or set the hardware clock\n"), out);
 
-	fputs(USAGE_SEPARATOR, usageto);
-	fputs(_("Functions:\n"), usageto);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Functions:\n"), out);
 	fputs(_(" -r, --show           read hardware clock and print result\n"
 		"     --get            read hardware clock and print drift corrected result\n"
-		"     --set            set the RTC to the time given with --date\n"), usageto);
+		"     --set            set the RTC to the time given with --date\n"), out);
 	fputs(_(" -s, --hctosys        set the system time from the hardware clock\n"
 		" -w, --systohc        set the hardware clock from the current system time\n"
 		"     --systz          set the system time based on the current timezone\n"
 		"     --adjust         adjust the RTC to account for systematic drift since\n"
-		"                        the clock was last set or adjusted\n"), usageto);
+		"                        the clock was last set or adjusted\n"), out);
 #if defined(__linux__) && defined(__alpha__)
 	fputs(_("     --getepoch       print out the kernel's hardware clock epoch value\n"
 		"     --setepoch       set the kernel's hardware clock epoch value to the \n"
-		"                        value given with --epoch\n"), usageto);
+		"                        value given with --epoch\n"), out);
 #endif
-	fputs(_("     --predict        predict RTC reading at time given with --date\n"), usageto);
+	fputs(_("     --predict        predict RTC reading at time given with --date\n"), out);
 
-	fputs(USAGE_OPTIONS, usageto);
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -u, --utc            the hardware clock is kept in UTC\n"
-		" -l, --localtime      the hardware clock is kept in local time\n"), usageto);
+		" -l, --localtime      the hardware clock is kept in local time\n"), out);
 #ifdef __linux__
-	fputs(_(" -f, --rtc <file>     special /dev/... file to use instead of default\n"), usageto);
+	fputs(_(" -f, --rtc <file>     special /dev/... file to use instead of default\n"), out);
 #endif
-	fprintf(usageto, _(
+	fprintf(out, _(
 		"     --directisa      access the ISA bus directly instead of %s\n"
 		"     --date <time>    specifies the time to which to set the hardware clock\n"), _PATH_RTC_DEV);
 #if defined(__linux__) && defined(__alpha__)
-	fputs(_("     --epoch <year>   specifies the hardware clock's epoch value\n"), usageto);
+	fputs(_("     --epoch <year>   specifies the hardware clock's epoch value\n"), out);
 #endif
-	fprintf(usageto, _(
+	fprintf(out, _(
 		"     --update-drift   update drift factor in %1$s (requires\n"
 		"                        --set or --systohc)\n"
 		"     --noadjfile      do not access %1$s; this requires the use of\n"
@@ -1245,11 +1245,11 @@ usage(const struct hwclock_control *ctl, FILE *usageto)
 		"     --adjfile <file> specifies the path to the adjust file;\n"
 		"                        the default is %1$s\n"), _PATH_ADJTIME);
 	fputs(_("     --test           do not update anything, just show what would happen\n"
-		" -D, --debug          debugging mode\n"), usageto);
-	fputs(USAGE_SEPARATOR, usageto);
-	fputs(USAGE_HELP, usageto);
-	fputs(USAGE_VERSION, usageto);
-	fprintf(usageto, USAGE_MAN_TAIL("hwclock(8)"));
+		" -D, --debug          debugging mode\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("hwclock(8)"));
 	hwclock_exit(ctl, EXIT_SUCCESS);
 }
 
