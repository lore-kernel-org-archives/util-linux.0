Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:60316 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753236AbdFSAqf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 18 Jun 2017 20:46:35 -0400
Subject: [PATCH 08/12] hwclock: slice up the usage text
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <dfcb2bd8-4372-4588-7f47-783404c30732@gmx.com>
Date: Sun, 18 Jun 2017 20:46:19 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 33d1bd2..5868ad6 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1209,36 +1209,36 @@ usage(const struct hwclock_control *ctl, FILE *out)
 	fputs(_(" Query or set the RTC (Real Time Clock / Hardware Clock)\n"), out);
 
 	fputs(USAGE_FUNCTIONS, out);
-	fputs(_(" -r, --show           display the RTC time\n"
-		"     --get            display drift corrected RTC time\n"
-		"     --set            set the RTC according to --date\n"), out);
-	fputs(_(" -s, --hctosys        set the system time from the RTC\n"
-		" -w, --systohc        set the RTC from the system time\n"
-		"     --systz          send timescale configurations to the kernel\n"
-		"     --adjust         adjust the RTC to account for systematic drift\n"), out);
+	fputs(_(" -r, --show           display the RTC time\n"), out);
+	fputs(_("     --get            display drift corrected RTC time\n"), out);
+	fputs(_("     --set            set the RTC according to --date\n"), out);
+	fputs(_(" -s, --hctosys        set the system time from the RTC\n"), out);
+	fputs(_(" -w, --systohc        set the RTC from the system time\n"), out);
+	fputs(_("     --systz          send timescale configurations to the kernel\n"), out);
+	fputs(_("     --adjust         adjust the RTC to account for systematic drift\n"), out);
 #if defined(__linux__) && defined(__alpha__)
-	fputs(_("     --getepoch       display the RTC epoch\n"
-		"     --setepoch       set the RTC epoch according to --epoch\n"), out);
+	fputs(_("     --getepoch       display the RTC epoch\n"), out);
+	fputs(_("     --setepoch       set the RTC epoch according to --epoch\n"), out);
 #endif
 	fputs(_("     --predict        predict the drifted RTC time according to --date\n"), out);
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -u, --utc            inform hwclock the RTC timescale is UTC\n"
-		" -l, --localtime      inform hwclock the RTC timescale is Local\n"), out);
+	fputs(_(" -u, --utc            inform hwclock the RTC timescale is UTC\n"), out);
+	fputs(_(" -l, --localtime      inform hwclock the RTC timescale is Local\n"), out);
 	fprintf(out, _(
 #ifdef __linux__
 		" -f, --rtc <file>     use an alternate file to %1$s\n"
 #endif
-		"     --directisa      use the ISA bus instead of %1$s access\n"
-		"     --date <time>    date/time input for --set and --predict\n"), _PATH_RTC_DEV);
+		"     --directisa      use the ISA bus instead of %1$s access\n"), _PATH_RTC_DEV);
+	fputs(_("     --date <time>    date/time input for --set and --predict\n"), out);
 #if defined(__linux__) && defined(__alpha__)
 	fputs(_("     --epoch <year>   epoch input for --setepoch\n"), out);
 #endif
+	fputs(_("     --update-drift   update drift factor (requires --set or --systohc)\n"), out);
 	fprintf(out, _(
-		"     --update-drift   update drift factor (requires --set or --systohc)\n"
 		"     --noadjfile      do not use %1$s\n"
 		"     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
-	fputs(_("     --test           dry run; use -D to view what would have happened\n"
-		" -D, --debug          use debug mode\n"), out);
+	fputs(_("     --test           dry run; use -D to view what would have happened\n"), out);
+	fputs(_(" -D, --debug          use debug mode\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
