Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751339AbdGaXjg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 31 Jul 2017 19:39:36 -0400
Subject: [PATCH 3/5] hwclock: fix unimplemented ioctl test
To: Karel Zak <kzak@redhat.com>
References: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <5e672d66-60ab-4250-408c-dedec3df234b@gmx.com>
Date: Mon, 31 Jul 2017 19:39:32 -0400
MIME-Version: 1.0
In-Reply-To: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The rtc driver has not returned EINVAL for unimplemented ioctls since
v2.5.8 in 2002. However, it does return it for other errors; making the
current test potentially problematic. Since 9f3d0fc util-linux assumes
kernel >= 2.6.0 so remove EINVAL as an ioctl test.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 36ce397..ea8357d 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -257,7 +257,7 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
 		 * they should.
 		 */
 		rc = -1;
-		errno = EINVAL;
+		errno = ENOTTY;
 #else
 		rc = ioctl(rtc_fd, RTC_UIE_ON, 0);
 #endif
@@ -293,7 +293,7 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
 			if (rc == -1)
 				warn(_("ioctl() to %s to turn off update interrupts failed"),
 				     rtc_dev_name);
-		} else if (errno == ENOTTY || errno == EINVAL) {
+		} else if (errno == ENOTTY) {
 			/*
 			 * This rtc device doesn't have interrupt functions.
 			 * This is typical on an Alpha, where the Hardware
