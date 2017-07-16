Return-Path: elseifthen@gmx.com
Subject: [PATCH 3/4] hwclock: improve RTC epoch messages
To: Karel Zak <kzak@redhat.com>
References: <4a0f9283-7a08-a2c3-acc3-fb35ab51ec59@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9dd6fce1-357c-7be8-9c4e-bf4ef59b4008@gmx.com>
Date: Sun, 16 Jul 2017 13:51:48 -0400
MIME-Version: 1.0
In-Reply-To: <4a0f9283-7a08-a2c3-acc3-fb35ab51ec59@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Make consistent and improve messages in get_epoch_rtc()
and set_epoch_rtc().

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 5803561..2af2666 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -403,24 +403,21 @@ int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch_p)
 	rtc_fd = open_rtc(ctl);
 	if (rtc_fd < 0) {
 		if (errno == ENOENT)
-			warnx(_
-			      ("To manipulate the epoch value in the kernel, we must "
-			       "access the Linux 'rtc' device driver via the device special "
-			       "file.  This file does not exist on this system."));
+			warnx(_("%s does not exist."), rtc_dev_name);
 		else
-			warn(_("cannot open rtc device"));
+			warn(_("cannot open %s"), rtc_dev_name);
 		return 1;
 	}
 
 	if (ioctl(rtc_fd, RTC_EPOCH_READ, epoch_p) == -1) {
-		warn(_("ioctl(RTC_EPOCH_READ) to %s failed"), rtc_dev_name);
+		warn(_("ioctl(%d, RTC_EPOCH_READ, epoch_p) to %s failed"),
+		     rtc_fd, rtc_dev_name);
 		return 1;
 	}
 
 	if (ctl->debug)
-		printf(_("we have read epoch %lu from %s "
-			 "with RTC_EPOCH_READ ioctl.\n"), *epoch_p,
-		       rtc_dev_name);
+		printf(_("ioctl(%d, RTC_EPOCH_READ, epoch_p) to %s succeeded.\n"),
+		       rtc_fd, rtc_dev_name);
 
 	return 0;
 }
@@ -444,24 +441,22 @@ int set_epoch_rtc(const struct hwclock_control *ctl)
 	rtc_fd = open_rtc(ctl);
 	if (rtc_fd < 0) {
 		if (errno == ENOENT)
-			warnx(_
-			      ("To manipulate the epoch value in the kernel, we must "
-			       "access the Linux 'rtc' device driver via the device special "
-			       "file.  This file does not exist on this system."));
+			warnx(_("%s does not exist."), rtc_dev_name);
 		else
-			warn(_("cannot open rtc device"));
+			warn(_("cannot open %s"), rtc_dev_name);
 		return 1;
 	}
 
-	if (ctl->debug)
-		printf(_("setting epoch to %lu "
-			 "with RTC_EPOCH_SET ioctl to %s.\n"), epoch,
-		       rtc_dev_name);
 	if (ioctl(rtc_fd, RTC_EPOCH_SET, epoch) == -1) {
-		warn(_("ioctl(RTC_EPOCH_SET) to %s failed"), rtc_dev_name);
+		warn(_("ioctl(%d, RTC_EPOCH_SET, %lu) to %s failed"),
+		     rtc_fd, epoch, rtc_dev_name);
 		return 1;
 	}
 
+	if (ctl->debug)
+		printf(_("ioctl(%d, RTC_EPOCH_SET, %lu) to %s succeeded.\n"),
+		       rtc_fd, epoch, rtc_dev_name);
+
 	return 0;
 }
 #endif	/* __alpha__ */
