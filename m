Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:43910 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbBVOmf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:35 -0500
Received: by wesu56 with SMTP id u56so13580550wes.10
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:33 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/13] rtcwake: add human readable --date timestamp format
Date: Sun, 22 Feb 2015 14:42:12 +0000
Message-Id: <1424616139-638-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/rtcwake |  7 ++++++-
 sys-utils/rtcwake.8.in  | 19 ++++++++++++++++++-
 sys-utils/rtcwake.c     | 24 +++++++++++++++++++-----
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/bash-completion/rtcwake b/bash-completion/rtcwake
index d7d1427..51566a2 100644
--- a/bash-completion/rtcwake
+++ b/bash-completion/rtcwake
@@ -23,11 +23,16 @@ _rtcwake_module()
 			COMPREPLY=( $(compgen -W "time_t" -- $cur) )
 			return 0
 			;;
+		'--date')
+			COMPREPLY=( $(compgen -W "YYYYMMDDhhmmss" -- $cur) )
+			return 0
+			;;
 		'-h'|'--help'|'-V'|'--version')
 			return 0
 			;;
 	esac
-	OPTS="--device
+	OPTS="	--date
+		--device
 		--dry-run
 		--local
 		--mode
diff --git a/sys-utils/rtcwake.8.in b/sys-utils/rtcwake.8.in
index 5ec9c6c..d81f9e1 100644
--- a/sys-utils/rtcwake.8.in
+++ b/sys-utils/rtcwake.8.in
@@ -120,6 +120,23 @@ is the time in seconds since 1970-01-01, 00:00 UTC.  Use the
 .BR date (1)
 tool to convert between human-readable time and \fItime_t\fP.
 .TP
+.BR \-\-date " \fItimestamp"
+Set the wakeup time to the value of the timestamp.  Format of the
+timestmap can be any of the following:
+.TS
+tab(|);
+left l2 l.
+YYYYMMDDhhmmss
+YYYY-MM-DD hh:mm:ss
+YYYY-MM-DD hh:mm|(seconds will be set to 00)
+YYYY-MM-DD|(time will be set to 00:00:00)
+hh:mm:ss|(date will be set to today)
+hh:mm|(date will be set to today, seconds to 00)
+today|(time is set to 00:00:00)
+tomorrow|(time is set to 00:00:00)
++5min
+.TE
+.TP
 .BR \-u , " \-\-utc"
 Assume that the hardware clock is set to UTC (Universal Time Coordinated),
 regardless of the contents of the \fIadjtime\fP file.
@@ -156,4 +173,4 @@ There is NO WARRANTY, to the extent permitted by law.
 The rtcwake command is part of the util-linux package and is available from the
 .UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
 Linux Kernel Archive
-.UE .
\ No newline at end of file
+.UE .
diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 790863f..4aa4fd3 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -41,6 +41,7 @@
 #include "strutils.h"
 #include "c.h"
 #include "closestream.h"
+#include "timeutils.h"
 
 /* constants from legacy PC/AT hardware */
 #define	RTC_PF	0x40
@@ -118,6 +119,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -m, --mode <mode>        standby|mem|... sleep mode\n"), out);
 	fputs(_(" -s, --seconds <seconds>  seconds to sleep\n"), out);
 	fputs(_(" -t, --time <time_t>      time to wake\n"), out);
+	fputs(_("     --date <timestamp>   date time of timestamp to wake\n"), out);
 	fputs(_(" -u, --utc                RTC uses UTC\n"), out);
 	fputs(_(" -v, --verbose            verbose messages\n"), out);
 
@@ -417,6 +419,10 @@ int main(int argc, char **argv)
 	int		fd;
 	time_t		alarm = 0;
 
+	enum {
+		OPT_DATE = CHAR_MAX + 1
+	};
+
 	static const struct option long_options[] = {
 		{"adjfile",     required_argument,      0, 'A'},
 		{"auto",	no_argument,		0, 'a'},
@@ -430,6 +436,7 @@ int main(int argc, char **argv)
 		{"device",	required_argument,	0, 'd'},
 		{"seconds",	required_argument,	0, 's'},
 		{"time",	required_argument,	0, 't'},
+		{"date",	required_argument,	0, OPT_DATE},
 		{0,		0,			0, 0  }
 	};
 
@@ -467,18 +474,25 @@ int main(int argc, char **argv)
 			ctl.dryrun = 1;
 			break;
 
-			/* alarm time, seconds-to-sleep (relative) */
 		case 's':
+			/* alarm time, seconds-to-sleep (relative) */
 			seconds = strtou32_or_err(optarg, _("invalid seconds argument"));
 			break;
 
-			/* alarm time, time_t (absolute, seconds since
-			 * 1/1 1970 UTC)
-			 */
 		case 't':
+			/* alarm time, time_t (absolute, seconds since epoc) */
 			alarm = strtou32_or_err(optarg, _("invalid time argument"));
 			break;
 
+		case OPT_DATE:
+		{
+			/* alarm time, see timestamp format from manual */
+			usec_t p;
+			if (parse_timestamp(optarg, &p) < 0)
+				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
+			alarm = (time_t) (p / 1000000);
+			break;
+		}
 		case 'u':
 			ctl.clock_mode = CM_UTC;
 			break;
@@ -510,7 +524,7 @@ int main(int argc, char **argv)
 				_("Using local time.\n"));
 
 	if (!alarm && !seconds && suspend < DISABLE_MODE) {
-		warnx(_("must provide wake time (see -t and -s options)"));
+		warnx(_("must provide wake time (see --seconds, --time, and --date options)"));
 		usage(stderr);
 	}
 
-- 
2.3.0

