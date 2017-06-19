Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52600 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752851AbdFSAuH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 18 Jun 2017 20:50:07 -0400
Subject: [PATCH 11/12] hwclock: remove unused usage() FILE argument
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ce8ce9d6-d266-12da-8e7e-c41e6a185714@gmx.com>
Date: Sun, 18 Jun 2017 20:49:49 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 74 ++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 7d69b7a..636d36a 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1200,49 +1200,49 @@ static void out_version(void)
 }
 
 static void __attribute__((__noreturn__))
-usage(const struct hwclock_control *ctl, FILE *out)
+usage(const struct hwclock_control *ctl)
 {
-	fputs(USAGE_HEADER, out);
-	fputs(_(" hwclock [function] [option...]\n"), out);
-
-	fputs(USAGE_SEPARATOR, out);
-	fputs(_(" Query or set the RTC (Real Time Clock / Hardware Clock)\n"), out);
-
-	fputs(USAGE_FUNCTIONS, out);
-	fputs(_(" -r, --show           display the RTC time\n"), out);
-	fputs(_("     --get            display drift corrected RTC time\n"), out);
-	fputs(_("     --set            set the RTC according to --date\n"), out);
-	fputs(_(" -s, --hctosys        set the system time from the RTC\n"), out);
-	fputs(_(" -w, --systohc        set the RTC from the system time\n"), out);
-	fputs(_("     --systz          send timescale configurations to the kernel\n"), out);
-	fputs(_("     --adjust         adjust the RTC to account for systematic drift\n"), out);
+	fputs(USAGE_HEADER, stdout);
+	puts(_(" hwclock [function] [option...]"));
+
+	fputs(USAGE_SEPARATOR, stdout);
+	puts(_(" Query or set the RTC (Real Time Clock / Hardware Clock)"));
+
+	fputs(USAGE_FUNCTIONS, stdout);
+	puts(_(" -r, --show           display the RTC time"));
+	puts(_("     --get            display drift corrected RTC time"));
+	puts(_("     --set            set the RTC according to --date"));
+	puts(_(" -s, --hctosys        set the system time from the RTC"));
+	puts(_(" -w, --systohc        set the RTC from the system time"));
+	puts(_("     --systz          send timescale configurations to the kernel"));
+	puts(_("     --adjust         adjust the RTC to account for systematic drift"));
 #if defined(__linux__) && defined(__alpha__)
-	fputs(_("     --getepoch       display the RTC epoch\n"), out);
-	fputs(_("     --setepoch       set the RTC epoch according to --epoch\n"), out);
+	puts(_("     --getepoch       display the RTC epoch"));
+	puts(_("     --setepoch       set the RTC epoch according to --epoch"));
 #endif
-	fputs(_("     --predict        predict the drifted RTC time according to --date\n"), out);
-	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -u, --utc            inform hwclock the RTC timescale is UTC\n"), out);
-	fputs(_(" -l, --localtime      inform hwclock the RTC timescale is Local\n"), out);
-	fprintf(out, _(
+	puts(_("     --predict        predict the drifted RTC time according to --date"));
+	fputs(USAGE_OPTIONS, stdout);
+	puts(_(" -u, --utc            inform hwclock the RTC timescale is UTC"));
+	puts(_(" -l, --localtime      inform hwclock the RTC timescale is Local"));
+	printf(_(
 #ifdef __linux__
-		" -f, --rtc <file>     use an alternate file to %1$s\n"
+	       " -f, --rtc <file>     use an alternate file to %1$s\n"
 #endif
-		"     --directisa      use the ISA bus instead of %1$s access\n"), _PATH_RTC_DEV);
-	fputs(_("     --date <time>    date/time input for --set and --predict\n"), out);
+	       "     --directisa      use the ISA bus instead of %1$s access\n"), _PATH_RTC_DEV);
+	puts(_("     --date <time>    date/time input for --set and --predict"));
 #if defined(__linux__) && defined(__alpha__)
-	fputs(_("     --epoch <year>   epoch input for --setepoch\n"), out);
+	puts(_("     --epoch <year>   epoch input for --setepoch"));
 #endif
-	fputs(_("     --update-drift   update the RTC drift factor\n"), out);
-	fprintf(out, _(
-		"     --noadjfile      do not use %1$s\n"
-		"     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
-	fputs(_("     --test           dry run; use -D to view what would have happened\n"), out);
-	fputs(_(" -D, --debug          use debug mode\n"), out);
-	fputs(USAGE_SEPARATOR, out);
-	fputs(USAGE_HELP, out);
-	fputs(USAGE_VERSION, out);
-	fprintf(out, USAGE_MAN_TAIL("hwclock(8)"));
+	puts(_("     --update-drift   update the RTC drift factor"));
+	printf(_(
+	       "     --noadjfile      do not use %1$s\n"
+	       "     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
+	puts(_("     --test           dry run; use -D to view what would have happened"));
+	puts(_(" -D, --debug          use debug mode"));
+	fputs(USAGE_SEPARATOR, stdout);
+	fputs(USAGE_HELP, stdout);
+	fputs(USAGE_VERSION, stdout);
+	fprintf(stdout, USAGE_MAN_TAIL("hwclock(8)"));
 	hwclock_exit(ctl, EXIT_SUCCESS);
 }
 
@@ -1448,7 +1448,7 @@ int main(int argc, char **argv)
 			out_version();
 			return 0;
 		case 'h':			/* --help */
-			usage(&ctl, stdout);
+			usage(&ctl);
 		default:
 			errtryhelp(EXIT_FAILURE);
 		}
