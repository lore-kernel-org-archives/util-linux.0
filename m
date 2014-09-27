Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53662 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990AbaI0P3j (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 27 Sep 2014 11:29:39 -0400
Message-ID: <5426D7DD.6070501@gmx.com>
Date: Sat, 27 Sep 2014 11:29:33 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 4/7] hwclock: persistent_clock_is_local
References: <5426D4C2.4060403@gmx.com>
In-Reply-To: <5426D4C2.4060403@gmx.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


When hctosys is used at boot time, making it the
first caller of settimeofday, the responsibility
of setting persistent_clock_is_local is thrust
upon it.  Currently hctosys always leaves this
variable uninitialized.  This causes a Hardware
Clock configured to use the local timescale to be
clobbered with the UTC timescale by the kernel's
NTP eleven minute mode.

This patch fixes this hctosys bug, by having it
properly set persistent_clock_is_local according
to the time scale configured for the Hardware
Clock.

It does this via the kernel warp_clock function
but this in inconsequential, because we set the
system time immediately afterward.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 08e79e8..42f54c2 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -808,6 +808,12 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
  * environment variable and/or /usr/lib/zoneinfo/, interpreted as tzset()
  * would interpret them.
  *
+ * If this is the first call of settimeofday since boot, then this also sets
+ * the kernel variable persistent_clock_is_local so that NTP 11 minute mode
+ * will update the Hardware Clock with the proper timescale. If the Hardware
+ * Clock's timescale configuration is changed then a reboot is required for
+ * persistent_clock_is_local to be updated.
+ *
  * EXCEPT: if hclock_valid is false, just issue an error message saying
  * there is no valid time in the Hardware Clock to which to set the system
  * time.
@@ -817,7 +823,7 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
  */
 static int
 set_system_clock(const bool hclock_valid, const struct timeval newtime,
-		 const bool testing)
+		 const bool testing, const bool universal)
 {
 	int retcode;
 
@@ -827,9 +833,10 @@ set_system_clock(const bool hclock_valid, const struct timeval newtime,
 		       "we cannot set the System Time from it."));
 		retcode = 1;
 	} else {
+		const struct timeval *tv_null = NULL;
 		struct tm *broken;
 		int minuteswest;
-		int rc;
+		int rc = 0;
 
 		broken = localtime(&newtime.tv_sec);
 #ifdef HAVE_TM_GMTOFF
@@ -853,7 +860,14 @@ set_system_clock(const bool hclock_valid, const struct timeval newtime,
 		} else {
 			const struct timezone tz = { minuteswest, 0 };
 
-			rc = settimeofday(&newtime, &tz);
+			/* Set kernel persistent_clock_is_local so that 11 minute
+			 * mode does not clobber the Hardware Clock with UTC. This
+			 * is only available on first call of settimeofday after boot.
+			 */
+			if (!universal)
+				rc = settimeofday(tv_null, &tz);
+			if (!rc)
+				rc = settimeofday(&newtime, &tz);
 			if (rc) {
 				if (errno == EPERM) {
 					warnx(_
@@ -1378,7 +1392,8 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 			adjust_drift_factor(&adjtime, nowtime,
 					    hclock_valid, hclocktime);
 	} else if (hctosys) {
-		rc = set_system_clock(hclock_valid, hclocktime, testing);
+		rc = set_system_clock(hclock_valid, hclocktime,
+				      testing, universal);
 		if (rc) {
 			printf(_("Unable to set system clock.\n"));
 			return rc;
