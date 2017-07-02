Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/5] hwclock: remove from usage() FILE *out = stdout
To: Karel Zak <kzak@redhat.com>
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <4f3045d8-b6bd-508e-b221-9bc011d5de3c@gmx.com>
Date: Sun, 2 Jul 2017 15:50:23 -0400
MIME-Version: 1.0
In-Reply-To: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 65 ++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index a0a48dd..8b1e2f3 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1202,48 +1202,47 @@ static void out_version(void)
 static void __attribute__((__noreturn__))
 usage(const struct hwclock_control *ctl)
 {
-	FILE *out = stdout;
-	fputs(USAGE_HEADER, out);
-	fputs(_(" hwclock [function] [option...]\n"), out);
-
-	fputs(USAGE_SEPARATOR, out);
-	fputs(_("Query or set the RTC (Real Time Clock / Hardware Clock)\n"), out);
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
+	puts(_("Query or set the RTC (Real Time Clock / Hardware Clock)"));
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
+	puts(_("     --predict        predict the drifted RTC time according to --date"));
+	fputs(USAGE_OPTIONS, stdout);
+	puts(_(" -u, --utc            inform hwclock the RTC timescale is UTC"));
+	puts(_(" -l, --localtime      inform hwclock the RTC timescale is Local"));
 #ifdef __linux__
 	printf(_(
-		" -f, --rtc <file>     use an alternate file to %1$s\n"), _PATH_RTC_DEV);
+	       " -f, --rtc <file>     use an alternate file to %1$s\n"), _PATH_RTC_DEV);
 #endif
 	printf(_(
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
+	puts(_("     --update-drift   update the RTC drift factor"));
+	printf(_(
+	       "     --noadjfile      do not use %1$s\n"
+	       "     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
+	puts(_("     --test           dry run; use -D to view what would have happened"));
+	puts(_(" -D, --debug          use debug mode"));
+	fputs(USAGE_SEPARATOR, stdout);
 	print_usage_help_options(22);
-	fprintf(out, USAGE_MAN_TAIL("hwclock(8)"));
+	printf(USAGE_MAN_TAIL("hwclock(8)"));
 	hwclock_exit(ctl, EXIT_SUCCESS);
 }
 
