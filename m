Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:56484 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbdBJVIg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 10 Feb 2017 16:08:36 -0500
Subject: [PATCH 3/3] hwclock: use gnulib's parse_datetime2 function
To: Karel Zak <kzak@redhat.com>
References: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <621b8782-5b62-d07c-c81f-3cfcfbeef8ae@gmx.com>
Date: Fri, 10 Feb 2017 16:08:20 -0500
MIME-Version: 1.0
In-Reply-To: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* hwclock.c: replace interpret_date_string() with parse_datetime2().
   Eliminates shell injection vulnerability from popen() date(1).
   Removes system dependency on date(1).
   Significant cleanup of hwclock.c code.

* Bug fix for "hwclock --predict --date 'bad_date'" printing:
    hwclock: No usable set-to time.  Cannot set clock.

  The message now matches date(1) for an invalid --date argument.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 105 +++-------------------------------------------------
 1 file changed, 6 insertions(+), 99 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 059ee40..0697533 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -83,6 +83,7 @@
 #include "timeutils.h"
 #include "env.h"
 #include "xalloc.h"
+#include "parse-datetime.h"
 
 #ifdef HAVE_LIBAUDIT
 #include <libaudit.h>
@@ -639,100 +640,6 @@ display_time(const bool hclock_valid, struct timeval hwctime)
 }
 
 /*
- * Interpret the value of the --date option, which is something like
- * "13:05:01". In fact, it can be any of the myriad ASCII strings that
- * specify a time which the "date" program can understand. The date option
- * value in question is our "dateopt" argument.
- *
- * The specified time is in the local time zone.
- *
- * Our output, "*time_p", is a seconds-into-epoch time.
- *
- * We use the "date" program to interpret the date string. "date" must be
- * runnable by issuing the command "date" to the /bin/sh shell. That means
- * in must be in the current PATH.
- *
- * If anything goes wrong (and many things can), we return return code 10
- * and arbitrary *time_p. Otherwise, return code is 0 and *time_p is valid.
- */
-static int interpret_date_string(const struct hwclock_control *ctl,
-				 time_t *const time_p)
-{
-	FILE *date_child_fp = NULL;
-	char *date_command = NULL;
-	char *date_resp = NULL;
-	size_t len = 0;
-	const char magic[] = "seconds-into-epoch=";
-	int retcode = 1;
-	long seconds_since_epoch;
-
-	if (!ctl->date_opt) {
-		warnx(_("No --date option specified."));
-		return retcode;
-	}
-
-	/* Quotes in date_opt would ruin the date command we construct. */
-	if (strchr(ctl->date_opt, '"') != NULL ||
-	    strchr(ctl->date_opt, '`') != NULL ||
-	    strchr(ctl->date_opt, '$') != NULL) {
-		warnx(_
-		      ("The value of the --date option is not a valid date.\n"
-		       "In particular, it contains illegal character(s)."));
-		return retcode;
-	}
-
-	xasprintf(&date_command, "date --date=\"%s\" +%s%%s",
-		ctl->date_opt, magic);
-	if (ctl->debug)
-		printf(_("Issuing date command: %s\n"), date_command);
-
-	date_child_fp = popen(date_command, "r");
-	if (date_child_fp == NULL) {
-		warn(_("Unable to run 'date' program in /bin/sh shell. "
-			    "popen() failed"));
-		goto out;
-	}
-
-	if (getline(&date_resp, &len, date_child_fp) < 0) {
-		warn(_("getline() failed"));
-		goto out;
-	}
-	if (ctl->debug)
-		printf(_("response from date command = %s\n"), date_resp);
-	if (strncmp(date_resp, magic, sizeof(magic) - 1) != 0) {
-		warnx(_("The date command issued by %s returned "
-				  "unexpected results.\n"
-				  "The command was:\n  %s\n"
-				  "The response was:\n  %s"),
-			program_invocation_short_name, date_command, date_resp);
-		goto out;
-	}
-
-	if (sscanf(date_resp + sizeof(magic) - 1, "%ld", &seconds_since_epoch) < 1) {
-		warnx(_("The date command issued by %s returned "
-			"something other than an integer where the "
-			"converted time value was expected.\n"
-			"The command was:\n  %s\n"
-			"The response was:\n %s\n"),
-		      program_invocation_short_name, date_command, date_resp);
-	} else {
-		retcode = 0;
-		*time_p = seconds_since_epoch;
-		if (ctl->debug)
-			printf(_("date string %s equates to "
-				 "%ld seconds since 1969.\n"),
-			       ctl->date_opt, *time_p);
-	}
- out:
-	free(date_command);
-	free(date_resp);
-	if (date_child_fp)
-		pclose(date_child_fp);
-
-	return retcode;
-}
-
-/*
  * Set the System Clock to time 'newtime'.
  *
  * Also set the kernel time zone value to the value indicated by the TZ
@@ -1460,6 +1367,7 @@ int main(int argc, char **argv)
 	struct hwclock_control ctl = { 0 };
 	struct timeval startup_time;
 	struct adjtime adjtime = { 0 };
+	struct timespec when = { 0 };
 	/*
 	 * The time we started up, in seconds into the epoch, including
 	 * fractions.
@@ -1699,11 +1607,10 @@ int main(int argc, char **argv)
 #endif
 
 	if (ctl.set || ctl.predict) {
-		rc = interpret_date_string(&ctl, &set_time);
-		/* (time-consuming) */
-		if (rc != 0) {
-			warnx(_("No usable set-to time.  "
-				"Cannot set clock."));
+		if (parse_datetime2 (&when, ctl.date_opt, NULL, ctl.debug))
+			set_time = when.tv_sec;
+		else {
+			warnx(_("invalid date '%s'"), ctl.date_opt);
 			hwclock_exit(&ctl, EX_USAGE);
 		}
 	}
