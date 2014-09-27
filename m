Return-Path: elseifthen@gmx.com
Message-ID: <5426D808.5050502@gmx.com>
Date: Sat, 27 Sep 2014 11:30:16 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 7/7] hwclock: Add --update option MAN
References: <5426D4C2.4060403@gmx.com>
In-Reply-To: <5426D4C2.4060403@gmx.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>


Update hwclock man page for the
hwclock: Add --update option patch.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index d04a429..1948251 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -342,7 +342,18 @@ with SRM console.
 Do everything except actually updating the Hardware Clock or anything
 else.  This is useful, especially in conjunction with
 .BR \-\-debug ,
-in learning about
+in learning about the internal operations of hwclock.
+
+.TP
+.B \-\-update
+Update the Hardware Clock's drift factor in
+.IR @ADJTIME_PATH@ .
+It is used with
+.BR --set\  or \ --systohc ,
+otherwise it is ignored.
+See the discussion below, under
+.B The Adjust
+.BR Function.
 
 .TP
 .BR \-u , \ \-\-utc
@@ -532,8 +543,8 @@ command to set the Hardware Clock to the true current time.
 .B hwclock
 creates the adjtime file and records in it the current time as the
 last time the clock was calibrated.
-5 days later, the clock has gained 10 seconds, so you issue another
-.I hwclock \-\-set
+5 days later, the clock has gained 10 seconds, so you issue the
+.I hwclock \-\-set \-\-update
 command to set it back 10 seconds.
 .B hwclock
 updates the adjtime file to show the current time as the last time the
@@ -552,15 +563,16 @@ Another 24 hours goes by and you issue another
 does the same thing: subtracts 2 seconds and updates the adjtime file
 with the current time as the last time the clock was adjusted.
 .PP
-Every time you calibrate (set) the clock (using
-.I \-\-set
-or
-.IR \-\-systohc ),
-.B hwclock
-recalculates the systematic drift rate based on how long it has been
+When you use the
+.I \-\-update
+option with
+.IR \-\-set\  or \ \-\-systohc ,
+the systematic drift rate is (re)calculated based on how long it has been
 since the last calibration, how long it has been since the last
 adjustment, what drift rate was assumed in any intervening
-adjustments, and the amount by which the clock is presently off.
+adjustments, and the amount by which the clock is presently off.  This updated
+drift factor is then saved in
+.IR @ADJTIME_PATH@ .
 .PP
 A small amount of error creeps in when
 the Hardware Clock is set, so
