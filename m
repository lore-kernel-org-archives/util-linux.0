Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:57195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751700AbdD0DhE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Apr 2017 23:37:04 -0400
Subject: [PATCH 2/4] hwclock: make clock test mode message consistent
To: Karel Zak <kzak@redhat.com>
References: <50c7367a-c086-2c18-af81-9f86f1c2560a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <0977f8d1-e7db-b4ba-6918-8e3f0e4ae6f8@gmx.com>
Date: Wed, 26 Apr 2017 23:36:54 -0400
MIME-Version: 1.0
In-Reply-To: <50c7367a-c086-2c18-af81-9f86f1c2560a@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 31ee8fe..4a187c5 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -391,7 +391,7 @@ set_hardware_clock(const struct hwclock_control *ctl, const time_t newtime)
 		       new_broken_time.tm_sec, (long)newtime);
 
 	if (ctl->testing)
-		printf(_("Clock not changed - testing only.\n"));
+		printf(_("Test mode: clock was not changed\n"));
 	else {
 		ur->set_hardware_clock(ctl, &new_broken_time);
 	}
@@ -636,7 +636,7 @@ set_system_clock(const struct hwclock_control *ctl, const bool hclock_valid,
 		}
 		if (ctl->testing) {
 			printf(_
-			       ("Not setting system clock because running in test mode.\n"));
+			       ("Test mode: clock was not changed\n"));
 			retcode = 0;
 		} else {
 			const struct timezone tz = { minuteswest, 0 };
@@ -724,7 +724,7 @@ static int set_system_clock_timezone(const struct hwclock_control *ctl)
 	}
 	if (ctl->testing) {
 		printf(_
-		       ("Not setting system clock because running in test mode.\n"));
+		       ("Test mode: clock was not changed\n"));
 		retcode = 0;
 	} else {
 		const struct timezone tz_utc = { 0, 0 };
