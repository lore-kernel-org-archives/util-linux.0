Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:60636 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdHSAWS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 18 Aug 2017 20:22:18 -0400
Subject: [PATCH 4/6] hwclock: update set_system_clock comments
To: Karel Zak <kzak@redhat.com>
References: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <5178659f-8dce-4086-8772-3f3ac5aa7c41@gmx.com>
Date: Fri, 18 Aug 2017 20:22:05 -0400
MIME-Version: 1.0
In-Reply-To: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 0be9c2a..c398d60 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -569,20 +569,36 @@ display_time(struct timeval hwctime)
 }
 
 /*
- * Set the System Clock to time 'newtime'.
+ * Adjusts System time, sets the kernel's timezone and RTC timescale.
  *
- * Also set the kernel time zone value to the value indicated by the TZ
- * environment variable and/or /usr/lib/zoneinfo/, interpreted as tzset()
- * would interpret them.
+ * The kernel warp_clock function adjusts the System time according to the
+ * tz.tz_minuteswest argument and sets PCIL (see below). At boot settimeofday(2)
+ * has one-shot access to this function as shown in the table below.
  *
- * If this is the first call of settimeofday since boot, then this also sets
- * the kernel variable persistent_clock_is_local so that NTP 11 minute mode
- * will update the Hardware Clock with the proper timescale. If the Hardware
- * Clock's timescale configuration is changed then a reboot is required for
- * persistent_clock_is_local to be updated.
+ * +-------------------------------------------------------------------+
+ * |                       settimeofday(tv, tz)                        |
+ * |-------------------------------------------------------------------|
+ * |     Arguments     |  System Time  | PCIL |           | warp_clock |
+ * |   tv    |   tz    | set  | warped | set  | firsttime |   locked   |
+ * |---------|---------|---------------|------|-----------|------------|
+ * | pointer | NULL    |  yes |   no   |  no  |     1     |    no      |
+ * | pointer | pointer |  yes |   no   |  no  |     0     |    yes     |
+ * | NULL    | ptr2utc |  no  |   no   |  no  |     0     |    yes     |
+ * | NULL    | pointer |  no  |   yes  |  yes |     0     |    yes     |
+ * +-------------------------------------------------------------------+
+ * ptr2utc: tz.tz_minuteswest is zero (UTC).
+ * PCIL: persistent_clock_is_local, sets the "11 minute mode" timescale.
+ * firsttime: locks the warp_clock function (initialized to 1 at boot).
  *
- * If 'testing' is true, don't actually update anything -- just say we would
- * have.
+ * +---------------------------------------------------------------------------+
+ * |  op     | RTC scale | settimeofday calls                                  |
+ * |---------|-----------|-----------------------------------------------------|
+ * | systz   |   Local   | 1) warps system time*, sets PCIL* and kernel tz     |
+ * | systz   |   UTC     | 1st) locks warp_clock* 2nd) sets kernel tz          |
+ * | hctosys |   Local   | 1st) sets PCIL* 2nd) sets system time and kernel tz |
+ * | hctosys |   UTC     | 1) sets system time and kernel tz                   |
+ * +---------------------------------------------------------------------------+
+ *                         * only on first call after boot
  */
 static int
 set_system_clock(const struct hwclock_control *ctl,
@@ -631,10 +647,6 @@ set_system_clock(const struct hwclock_control *ctl,
 	} else {
 		const struct timezone tz = { minuteswest, 0 };
 
-		/* Set kernel persistent_clock_is_local so that 11 minute
-		 * mode does not clobber the Hardware Clock with UTC. This
-		 * is only available on first call of settimeofday after boot.
-		 */
 		if (ctl->hctosys && !ctl->universal)	/* set PCIL */
 			rc = settimeofday(tv_null, &tz);
 		if (ctl->systz && ctl->universal)	/* lock warp_clock */
