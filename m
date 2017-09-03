Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:59094 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751509AbdICUCC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 3 Sep 2017 16:02:02 -0400
Subject: [v2 PATCH 2/3] hwclock: don't always use hwclock_exit
To: Karel Zak <kzak@redhat.com>
References: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
 <484f55d0-ecaf-437c-cb70-e6a871f06878@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ed4db76b-e015-6066-7992-8d6efc8002ea@gmx.com>
Date: Sun, 3 Sep 2017 16:01:49 -0400
MIME-Version: 1.0
In-Reply-To: <484f55d0-ecaf-437c-cb70-e6a871f06878@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Special exit handling is not wanted for usage() or bad
command syntax. For example we do not want to audit:
hwclock --set --date foo

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 82f919048..e471fe1ae 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1061,7 +1061,7 @@ static void out_version(void)
 }
 
 static void __attribute__((__noreturn__))
-usage(const struct hwclock_control *ctl)
+usage(void)
 {
 	fputs(USAGE_HEADER, stdout);
 	printf(_(" %s [function] [option...]\n"), program_invocation_short_name);
@@ -1105,7 +1105,7 @@ usage(const struct hwclock_control *ctl)
 	fputs(USAGE_SEPARATOR, stdout);
 	printf(USAGE_HELP_OPTIONS(22));
 	printf(USAGE_MAN_TAIL("hwclock(8)"));
-	hwclock_exit(ctl, EXIT_SUCCESS);
+	exit(EXIT_SUCCESS);
 }
 
 int main(int argc, char **argv)
@@ -1301,7 +1301,7 @@ int main(int argc, char **argv)
 			out_version();
 			return 0;
 		case 'h':			/* --help */
-			usage(&ctl);
+			usage();
 		default:
 			errtryhelp(EXIT_FAILURE);
 		}
@@ -1317,25 +1317,25 @@ int main(int argc, char **argv)
 
 	if (ctl.update && !ctl.set && !ctl.systohc) {
 		warnx(_("--update-drift requires --set or --systohc"));
-		hwclock_exit(&ctl, EXIT_FAILURE);
+		exit(EXIT_FAILURE);
 	}
 
 	if (ctl.noadjfile && !ctl.utc && !ctl.local_opt) {
 		warnx(_("With --noadjfile, you must specify "
 			"either --utc or --localtime"));
-		hwclock_exit(&ctl, EXIT_FAILURE);
+		exit(EXIT_FAILURE);
 	}
 
 	if (ctl.set || ctl.predict) {
 		if (!ctl.date_opt) {
 		warnx(_("--date is required for --set or --predict"));
-		hwclock_exit(&ctl, EXIT_FAILURE);
+		exit(EXIT_FAILURE);
 		}
 		if (parse_date(&when, ctl.date_opt, NULL))
 			set_time = when.tv_sec;
 		else {
 			warnx(_("invalid date '%s'"), ctl.date_opt);
-			hwclock_exit(&ctl, EXIT_FAILURE);
+			exit(EXIT_FAILURE);
 		}
 	}
 
