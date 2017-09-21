Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/2] hwclock: exit bug fix and single test mode message
To: Karel Zak <kzak@redhat.com>
References: <a996a4b2-89f5-eb63-a0cb-499830bce2e6@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <588cfc67-ec30-41b9-f778-f53b392a804c@gmx.com>
Date: Thu, 21 Sep 2017 16:09:58 -0400
MIME-Version: 1.0
In-Reply-To: <a996a4b2-89f5-eb63-a0cb-499830bce2e6@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Bug fix: hwclock returns success when saving /etc/adjtime fails.

Remove redundant test mode messages.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 61 ++++++++++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 9fa26bd0b..6a23bf2b0 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -385,9 +385,7 @@ set_hardware_clock(const struct hwclock_control *ctl, const time_t newtime)
 		       new_broken_time.tm_hour, new_broken_time.tm_min,
 		       new_broken_time.tm_sec, (long)newtime);
 
-	if (ctl->testing)
-		printf(_("Test mode: clock was not changed\n"));
-	else
+	if (!ctl->testing)
 		ur->set_hardware_clock(ctl, &new_broken_time);
 }
 
@@ -633,10 +631,7 @@ set_system_clock(const struct hwclock_control *ctl,
 		}
 	}
 
-	if (ctl->testing) {
-		printf(_
-		       ("Test mode: clock was not changed\n"));
-	} else {
+	if (!ctl->testing) {
 		const struct timezone tz = { minuteswest };
 
 		if (ctl->hctosys && !ctl->universal)	/* set PCIL */
@@ -787,15 +782,11 @@ calculate_adjustment(const struct hwclock_control *ctl,
  * But if the contents are clean (unchanged since read from disk), don't
  * bother.
  */
-static void save_adjtime(const struct hwclock_control *ctl,
+static int save_adjtime(const struct hwclock_control *ctl,
 			 const struct adjtime *adjtime)
 {
 	char *content;		/* Stuff to write to disk file */
 	FILE *fp;
-	int err = 0;
-
-	if (!adjtime->dirty)
-		return;
 
 	xasprintf(&content, "%f %ld %f\n%ld\n%s\n",
 		  adjtime->drift_factor,
@@ -804,28 +795,22 @@ static void save_adjtime(const struct hwclock_control *ctl,
 		  adjtime->last_calib_time,
 		  (adjtime->local_utc == LOCAL) ? "LOCAL" : "UTC");
 
-	if (ctl->testing) {
-		if (ctl->debug){
-			printf(_("Test mode: %s was not updated with:\n%s"),
-			       ctl->adj_file_name, content);
-		}
-		free(content);
-		return;
+	if (ctl->debug){
+		printf(_("New %s data:\n%s"),
+		       ctl->adj_file_name, content);
 	}
 
-	fp = fopen(ctl->adj_file_name, "w");
-	if (fp == NULL) {
-		warn(_("Could not open file with the clock adjustment parameters "
-		       "in it (%s) for writing"), ctl->adj_file_name);
-		err = 1;
-	} else if (fputs(content, fp) < 0 || close_stream(fp) != 0) {
-		warn(_("Could not update file with the clock adjustment "
-		       "parameters (%s) in it"), ctl->adj_file_name);
-		err = 1;
+	if (!ctl->testing) {
+		fp = fopen(ctl->adj_file_name, "w");
+		if (fp == NULL) {
+			warn(_("cannot open %s"), ctl->adj_file_name);
+			return EXIT_FAILURE;
+		} else if (fputs(content, fp) < 0 || close_stream(fp) != 0) {
+			warn(_("cannot update %s"), ctl->adj_file_name);
+			return EXIT_FAILURE;
+		}
 	}
-	free(content);
-	if (err)
-		warnx(_("Drift adjustment parameters not updated."));
+	return EXIT_SUCCESS;
 }
 
 /*
@@ -1023,8 +1008,8 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	} else if (ctl->hctosys) {
 		return set_system_clock(ctl, hclocktime);
 	}
-	if (!ctl->noadjfile)
-		save_adjtime(ctl, adjtime);
+	if (!ctl->noadjfile && adjtime->dirty)
+		return save_adjtime(ctl, adjtime);
 	return EXIT_SUCCESS;
 }
 
@@ -1046,11 +1031,9 @@ manipulate_epoch(const struct hwclock_control *ctl)
 	} else if (ctl->setepoch) {
 		if (!ctl->epoch_option)
 			warnx(_("--epoch is required for --setepoch."));
-		else if (ctl->testing)
-			printf(_("Test mode: epoch was not set to %s.\n"),
-			       ctl->epoch_option);
-		else if (set_epoch_rtc(ctl))
-			warnx(_("unable to set the RTC epoch."));
+		else if (!ctl->testing)
+			if (set_epoch_rtc(ctl))
+				warnx(_("unable to set the RTC epoch."));
 	}
 }
 #endif		/* __linux__ __alpha__ */
@@ -1363,6 +1346,8 @@ int main(int argc, char **argv)
 		adjtime.dirty = 0;
 	ctl.universal = hw_clock_is_utc(&ctl, adjtime);
 	rc = manipulate_clock(&ctl, set_time, startup_time, &adjtime);
+	if (ctl.testing)
+		puts(_("Test mode: nothing was changed."));
 	hwclock_exit(&ctl, rc);
 	return rc;		/* Not reached */
 }
