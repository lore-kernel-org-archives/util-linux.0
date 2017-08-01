Return-Path: elseifthen@gmx.com
Subject: [PATCH 8/8] hwclock: remove busywait tristate return status
To: Karel Zak <kzak@redhat.com>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <4b9e95a6-a4ab-85ed-5736-031f92098a2e@gmx.com>
Date: Tue, 1 Aug 2017 09:37:05 -0400
MIME-Version: 1.0
In-Reply-To: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


The select() synchronization branch only returns success or
fail. There is no reason for the busywait branch to do more.
If synchronization fails for any reason then it must exit,
otherwise all drift correction operation will be invalid.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c | 11 +++++------
 sys-utils/hwclock.h     |  6 ------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index a660e32..c50011a 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -216,9 +216,8 @@ static int busywait_for_rtc_clock_tick(const struct hwclock_control *ctl,
 		       rtc_dev_name);
 	}
 
-	rc = do_rtc_read_ioctl(rtc_fd, &start_time);
-	if (rc)
-		return RTC_BUSYWAIT_FAILED;
+	if (do_rtc_read_ioctl(rtc_fd, &start_time))
+		return 1;
 
 	/*
 	 * Wait for change.  Should be within a second, but in case
@@ -233,13 +232,13 @@ static int busywait_for_rtc_clock_tick(const struct hwclock_control *ctl,
 		gettimeofday(&now, NULL);
 		if (time_diff(now, begin) > 1.5) {
 			warnx(_("Timed out waiting for time change."));
-			return RTC_BUSYWAIT_TIMEOUT;
+			return 1;
 		}
 	} while (1);
 
 	if (rc)
-		return RTC_BUSYWAIT_FAILED;
-	return RTC_BUSYWAIT_OK;
+		return 1;
+	return 0;
 }
 
 /*
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 8843501..6943d8d 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -9,12 +9,6 @@
 
 #include "c.h"
 
-enum {
-	RTC_BUSYWAIT_OK = 0,
-	RTC_BUSYWAIT_FAILED,
-	RTC_BUSYWAIT_TIMEOUT
-};
-
 struct hwclock_control {
 	char *date_opt;
 	char *adj_file_name;
