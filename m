Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:64002 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbdHSASH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 18 Aug 2017 20:18:07 -0400
Subject: [PATCH 1/6] hwclock: move systz into hctosys
To: Karel Zak <kzak@redhat.com>
References: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <42ac6811-69d7-2bbf-56a7-ead6d1a0d489@gmx.com>
Date: Fri, 18 Aug 2017 20:18:04 -0400
MIME-Version: 1.0
In-Reply-To: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The set_system_clock_timezone() function is nearly identical to
set_system_clock(). Three additional statements are required
to include systz in hctosys.

This patch is intentionally incomplete to make reviewing the
actual required changes easier. Other patches in this set will:

 * remove set_system_clock_timezone()
 * fix messages and debugging
 * fix comments
 * and finally refactor set_system_clock()

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 910e39f..e49f1a1 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -594,6 +594,7 @@ set_system_clock(const struct hwclock_control *ctl,
 	struct tm *broken;
 	int minuteswest;
 	int rc = 0;
+	const struct timezone tz_utc = { 0 };
 
 	broken = localtime(&newtime.tv_sec);
 #ifdef HAVE_TM_GMTOFF
@@ -621,10 +622,15 @@ set_system_clock(const struct hwclock_control *ctl,
 		 * mode does not clobber the Hardware Clock with UTC. This
 		 * is only available on first call of settimeofday after boot.
 		 */
-		if (!ctl->universal)
+		if (ctl->hctosys && !ctl->universal)	/* set PCIL */
 			rc = settimeofday(tv_null, &tz);
-		if (!rc)
+		if (ctl->systz && ctl->universal)	/* lock warp_clock */
+			rc = settimeofday(tv_null, &tz_utc);
+		if (!rc && ctl->hctosys)
 			rc = settimeofday(&newtime, &tz);
+		else if (!rc)
+			rc = settimeofday(NULL, &tz);
+
 		if (rc) {
 			warn(_("settimeofday() failed"));
 			retcode = 1;
@@ -1024,7 +1030,7 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	}
 
 	if (ctl->systz)
-		return set_system_clock_timezone(ctl);
+		return set_system_clock(ctl, startup_time);
 
 	if (ur->get_permissions())
 		return EX_NOPERM;
