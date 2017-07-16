Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:62732 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbdGPRvE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 16 Jul 2017 13:51:04 -0400
Subject: [PATCH 2/4] hwclock: remove dead ioctl check
To: Karel Zak <kzak@redhat.com>
References: <4a0f9283-7a08-a2c3-acc3-fb35ab51ec59@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <22fec1cf-4326-c567-183d-5fb106527c65@gmx.com>
Date: Sun, 16 Jul 2017 13:50:48 -0400
MIME-Version: 1.0
In-Reply-To: <4a0f9283-7a08-a2c3-acc3-fb35ab51ec59@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The epoch ioctls test hasn't been valid for 20 years (v2.1.88).
RTC has returned ENOTTY for unimplemented ioctls for 15 years.

The check is made for RTC_EPOCH_SET, but not for RTC_EPOCH_READ.
They were both implemented at the same time.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 9d3e5b9..5803561 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -458,13 +458,7 @@ int set_epoch_rtc(const struct hwclock_control *ctl)
 			 "with RTC_EPOCH_SET ioctl to %s.\n"), epoch,
 		       rtc_dev_name);
 	if (ioctl(rtc_fd, RTC_EPOCH_SET, epoch) == -1) {
-		if (errno == EINVAL)
-			warnx(_("The kernel device driver for %s "
-				"does not have the RTC_EPOCH_SET ioctl."),
-			      rtc_dev_name);
-		else
-			warn(_("ioctl(RTC_EPOCH_SET) to %s failed"),
-				  rtc_dev_name);
+		warn(_("ioctl(RTC_EPOCH_SET) to %s failed"), rtc_dev_name);
 		return 1;
 	}
 
