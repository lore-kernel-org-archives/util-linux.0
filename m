Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:55079 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbaINTq6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Sep 2014 15:46:58 -0400
Message-ID: <5415F0AA.5090603@gmx.com>
Date: Sun, 14 Sep 2014 15:46:50 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 2/2] hwclock: hctosys drift compensation man page
References: <5415EC97.4060305@gmx.com>
In-Reply-To: <5415EC97.4060305@gmx.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Update hwclock man page for the
hwclock: hctosys drift compensation patch.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index b11b45c..b42a201 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -62,7 +62,9 @@ option.
 Showing the Hardware Clock time is the default when no function is specified.
 .TP
 .BR \-s , \ \-\-hctosys
-Set the System Time from the Hardware Clock.
+Set the System Time from the Hardware Clock.  The time read from the Hardware
+Clock is compensated to account for systematic drift before using it to set the
+System Clock.  See the discussion below, under \fBThe Adjust Function\fR.
 .PP
 Also set the kernel's timezone value to the local timezone
 as indicated by the TZ environment variable and/or
@@ -484,8 +486,9 @@ The Hardware Clock is usually not very accurate.  However, much of its
 inaccuracy is completely predictable - it gains or loses the same amount
 of time every day.  This is called systematic drift.
 .BR hwclock 's
-"adjust" function lets you make systematic corrections to correct the
-systematic drift.
+.I \-\-adjust
+function lets you apply systematic drift corrections to the
+Hardware Clock.
 .PP
 It works like this:
 .B hwclock
@@ -529,20 +532,22 @@ since the last calibration, how long it has been since the last
 adjustment, what drift rate was assumed in any intervening
 adjustments, and the amount by which the clock is presently off.
 .PP
-A small amount of error creeps in any time
-.B hwclock
-sets the clock, so it refrains from making an adjustment that would be
-less than 1 second.  Later on, when you request an adjustment again,
-the accumulated drift will be more than a second and
-.B hwclock
-will do the adjustment then.
-.PP
-It is good to do a
-.I hwclock \-\-adjust
-just before the
-.I hwclock \-\-hctosys
-at system startup time, and maybe periodically while the system is
-running via cron.
+A small amount of error creeps in when
+the Hardware Clock is set, so
+.I \-\-adjust
+refrains from making any adjustment that is less
+than 1 second.  Later on, when you request an adjustment again, the accumulated
+drift will be more than 1 second and
+.I \-\-adjust
+will make the adjustment including any fractional amount.
+.PP
+.IR "hwclock \-\-hctosys"
+also uses the adjtime file data to compensate the value read from the Hardware
+Clock before using it to set the System Time.  It does not share the 1 second
+limitation of --adjust, and will correct sub-second drift values immediately.
+It does not change the Hardware Clock time or the adjtime file.  This may
+eliminate the need to use --adjust, unless something else on the system needs
+the Hardware Clock to be compensated.
 .PP
 The adjtime file, while named for its historical purpose of controlling
 adjustments only, actually contains other information for use by hwclock


