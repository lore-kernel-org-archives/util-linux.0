Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:61468 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbaJXCxn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 23 Oct 2014 22:53:43 -0400
Message-ID: <5449BF2E.7040604@gmx.com>
Date: Thu, 23 Oct 2014 22:53:34 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 4/5] hwclock: Fix --date debug messages
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Fix --date debug messages with:
* Empty results for invalid arguments
* Empty lines(superfluous line breaks)
* Uncapitalized and missing words
* Inconsistent language
* Outdated message:
  --date is now used for --predict so
  'cannot set clock' makes no sense.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 3ad3791..6d05d46 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -765,15 +765,14 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
 	}

 	if (!fgets(date_resp, sizeof(date_resp), date_child_fp))
-		date_resp[0] = '\0';	/* in case fgets fails */
+		strcpy(date_resp, "NULL\n");	/* in case fgets fails */
 	if (debug)
-		printf(_("response from date command = %s"), date_resp);
+		printf(_("The response was: %s"), date_resp);
 	if (strncmp(date_resp, magic, sizeof(magic) - 1) != 0) {
 		warnx(_("The date command issued by %s returned "
-				  "unexpected results\n"
-				  "The command was:\n  %s\n"
-				  "The response was:\n  %s"),
-			program_invocation_short_name, date_command, date_resp);
+			"unexpected results\nThe response was: %s"
+			"The command was: %s"),
+		      program_invocation_short_name, date_resp, date_command);
 		retcode = 8;
 	} else {
 		long seconds_since_epoch;
@@ -783,16 +782,14 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
 			warnx(_("The date command issued by %s returned "
 				"something other\nthan an integer where the "
 				"converted time value was expected\n"
-				"The command was:\n  %s\n"
-				"The response was:\n %s\n"),
-			      program_invocation_short_name, date_command,
-			      date_resp);
+				"The response was: %sThe command was: %s"),
+			      program_invocation_short_name, date_resp, date_command);
 			retcode = 6;
 		} else {
 			retcode = 0;
 			*time_p = seconds_since_epoch;
 			if (debug)
-				printf(_("date string %s equates to "
+				printf(_("The date string '%s' equates to:\n"
 					 "%ld seconds since 1969\n"),
 				       date_opt, (long)*time_p);
 		}
@@ -1905,8 +1902,7 @@ int main(int argc, char **argv)
 		rc = interpret_date_string(date_opt, &set_time);
 		/* (time-consuming) */
 		if (rc != 0) {
-			warnx(_("No usable set-to time,  "
-				"cannot set clock"));
+			warnx(_("Invalid --date argument, see date(1)"));
 			hwclock_exit(EX_USAGE);
 		}
 	}
