Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:62173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933017AbdCaOuV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 31 Mar 2017 10:50:21 -0400
Subject: [PATCH 6/6] hwclock: remove unused 'silent' arg
To: Karel Zak <kzak@redhat.com>
References: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <73acf367-2f4f-5067-10ab-be0ec0479cfa@gmx.com>
Date: Fri, 31 Mar 2017 10:49:58 -0400
MIME-Version: 1.0
In-Reply-To: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The 'silent' argument for get_epoch_rtc() was used
to silence error messages when querying the rtc
driver for an alpha epoch while using cmos direct
access. Alpha cmos has since been removed so
'silent' is no longer used.

* sys-utils/hwclock.h: remove 'silent' argument
* sys-utils/hwclock.c: same
* sys-utils/hwclock-rtc.c: same

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c | 20 ++++++++------------
 sys-utils/hwclock.c     |  2 +-
 sys-utils/hwclock.h     |  2 +-
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 077db73..f272828 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -396,27 +396,23 @@ struct clock_ops *probe_for_rtc_clock(const struct hwclock_control *ctl)
 /*
  * Get the Hardware Clock epoch setting from the kernel.
  */
-int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch_p,
-		  int silent)
+int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch_p)
 {
 	int rtc_fd;
 
 	rtc_fd = open_rtc(ctl);
 	if (rtc_fd < 0) {
-		if (!silent) {
-			if (errno == ENOENT)
-				warnx(_
-				      ("To manipulate the epoch value in the kernel, we must "
-				       "access the Linux 'rtc' device driver via the device special "
-				       "file.  This file does not exist on this system."));
-			else
-				warn(_("cannot open rtc device"));
-		}
+		if (errno == ENOENT)
+			warnx(_
+			      ("To manipulate the epoch value in the kernel, we must "
+			       "access the Linux 'rtc' device driver via the device special "
+			       "file.  This file does not exist on this system."));
+		else
+			warn(_("cannot open rtc device"));
 		return 1;
 	}
 
 	if (ioctl(rtc_fd, RTC_EPOCH_READ, epoch_p) == -1) {
-		if (!silent)
 			warn(_("ioctl(RTC_EPOCH_READ) to %s failed"),
 				  rtc_dev_name);
 		return 1;
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 8914f94..3875bcc 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1190,7 +1190,7 @@ manipulate_epoch(const struct hwclock_control *ctl)
 	if (ctl->getepoch) {
 		unsigned long epoch;
 
-		if (get_epoch_rtc(ctl, &epoch, 0))
+		if (get_epoch_rtc(ctl, &epoch))
 			warnx(_
 			      ("Unable to get the epoch value from the kernel."));
 		else
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index f090ed7..37e8173 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -67,7 +67,7 @@ extern unsigned long epoch_option;
 extern double time_diff(struct timeval subtrahend, struct timeval subtractor);
 
 /* rtc.c */
-extern int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch, int silent);
+extern int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch);
 extern int set_epoch_rtc(const struct hwclock_control *ctl);
 
 extern void hwclock_exit(const struct hwclock_control *ctl, int status);
