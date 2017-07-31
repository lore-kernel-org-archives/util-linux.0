Return-Path: elseifthen@gmx.com
Subject: [PATCH 4/5] hwclock: remove custom errno string
To: Karel Zak <kzak@redhat.com>
References: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <92a45f1d-ddfb-ac43-89d9-a47d328c64c9@gmx.com>
Date: Mon, 31 Jul 2017 19:51:55 -0400
MIME-Version: 1.0
In-Reply-To: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Custom errno messages are unnecessary and problematic for translators.

The current messages are also too long, > 90 columns:
/dev/rtc0 does not have interrupt functions. Waiting in loop for time from \
/dev/rtc0 to change

Fixed:
ioctl(3, RTC_UIE_ON, 0): Inappropriate ioctl for device
Waiting in loop for time from /dev/rtc0 to change

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index ea8357d..c738076 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -194,8 +194,11 @@ static int do_rtc_read_ioctl(int rtc_fd, struct tm *tm)
 }
 
 /*
- * Wait for the top of a clock tick by reading /dev/rtc in a busy loop until
- * we see it.
+ * Wait for the top of a clock tick by reading /dev/rtc in a busy loop
+ * until we see it. This function is used for rtc drivers without ioctl
+ * interrupts. This is typical on an Alpha, where the Hardware Clock
+ * interrupts are used by the kernel for the system clock, so aren't at
+ * the user's disposal.
  */
 static int busywait_for_rtc_clock_tick(const struct hwclock_control *ctl,
 				       const int rtc_fd)
@@ -206,9 +209,12 @@ static int busywait_for_rtc_clock_tick(const struct hwclock_control *ctl,
 	int rc;
 	struct timeval begin, now;
 
-	if (ctl->debug)
+	if (ctl->debug) {
+		printf("ioctl(%d, RTC_UIE_ON, 0): %s\n",
+		       rtc_fd, strerror(errno));
 		printf(_("Waiting in loop for time from %s to change\n"),
 		       rtc_dev_name);
+	}
 
 	rc = do_rtc_read_ioctl(rtc_fd, &start_time);
 	if (rc)
@@ -294,19 +300,11 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
 				warn(_("ioctl() to %s to turn off update interrupts failed"),
 				     rtc_dev_name);
 		} else if (errno == ENOTTY) {
-			/*
-			 * This rtc device doesn't have interrupt functions.
-			 * This is typical on an Alpha, where the Hardware
-			 * Clock interrupts are used by the kernel for the
-			 * system clock, so aren't at the user's disposal.
-			 */
-			if (ctl->debug)
-				printf(_("%s does not have interrupt functions. "),
-				       rtc_dev_name);
+			/* rtc ioctl interrupts are unimplemented */
 			ret = busywait_for_rtc_clock_tick(ctl, rtc_fd);
 		} else
-			warn(_("ioctl() to %s to turn on update interrupts "
-			      "failed unexpectedly"), rtc_dev_name);
+			warn(_("ioctl(%d, RTC_UIE_ON, 0) to %s failed"),
+			     rtc_fd, rtc_dev_name);
 	}
 	return ret;
 }
