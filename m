Return-Path: elseifthen@gmx.com
Subject: [PATCH 5/6] hwclock: rename/refactor set_system_clock()
To: Karel Zak <kzak@redhat.com>
References: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ab175fb6-72c2-c3a4-5f72-fa0600c2b13d@gmx.com>
Date: Fri, 18 Aug 2017 20:23:01 -0400
MIME-Version: 1.0
In-Reply-To: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index c398d60..4279931 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -601,12 +601,8 @@ display_time(struct timeval hwctime)
  *                         * only on first call after boot
  */
 static int
-set_system_clock(const struct hwclock_control *ctl,
-		 const struct timeval newtime)
+kernel_time_ctl(const struct hwclock_control *ctl, const struct timeval newtime)
 {
-	int retcode;
-
-	const struct timeval *tv_null = NULL;
 	struct tm *broken;
 	int minuteswest;
 	int rc = 0;
@@ -643,14 +639,13 @@ set_system_clock(const struct hwclock_control *ctl,
 	if (ctl->testing) {
 		printf(_
 		       ("Test mode: clock was not changed\n"));
-		retcode = 0;
 	} else {
-		const struct timezone tz = { minuteswest, 0 };
+		const struct timezone tz = { minuteswest };
 
 		if (ctl->hctosys && !ctl->universal)	/* set PCIL */
-			rc = settimeofday(tv_null, &tz);
+			rc = settimeofday(NULL, &tz);
 		if (ctl->systz && ctl->universal)	/* lock warp_clock */
-			rc = settimeofday(tv_null, &tz_utc);
+			rc = settimeofday(NULL, &tz_utc);
 		if (!rc && ctl->hctosys)
 			rc = settimeofday(&newtime, &tz);
 		else if (!rc)
@@ -658,11 +653,10 @@ set_system_clock(const struct hwclock_control *ctl,
 
 		if (rc) {
 			warn(_("settimeofday() failed"));
-			retcode = 1;
-		} else
-			retcode = 0;
+			return  1;
+		}
 	}
-	return retcode;
+	return 0;
 }
 
 /*
@@ -966,7 +960,7 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	}
 
 	if (ctl->systz)
-		return set_system_clock(ctl, startup_time);
+		return kernel_time_ctl(ctl, startup_time);
 
 	if (ur->get_permissions())
 		return EX_NOPERM;
@@ -1036,7 +1030,7 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 			adjust_drift_factor(ctl, adjtime, nowtime,
 					    hclocktime);
 	} else if (ctl->hctosys) {
-		return set_system_clock(ctl, hclocktime);
+		return kernel_time_ctl(ctl, hclocktime);
 	}
 	if (!ctl->noadjfile)
 		save_adjtime(ctl, adjtime);
