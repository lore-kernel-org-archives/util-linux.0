Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:51068 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752346AbaJ0VSZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Oct 2014 17:18:25 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] docs: improve wording and formattin of man page of hwclock
Date: Mon, 27 Oct 2014 22:18:13 +0100
Message-Id: <1414444693-16407-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/hwclock.8.in |   73 +++++++++++++++++++++++-------------------------
 1 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 30f191b..9219218 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -1,4 +1,4 @@
-.TH HWCLOCK 8 "July 2014" "util-linux" "System Administration"
+.TH HWCLOCK 8 "October 2014" "util-linux" "System Administration"
 .SH NAME
 hwclock \- query or set the hardware clock (RTC)
 .SH SYNOPSIS
@@ -22,15 +22,16 @@ gains time at a certain rate when left to run).
 Since v2.26
 .B hwclock
 does not update the Hardware Clock's drift factor in @ADJTIME_PATH@ by default.
-It is necessary to use \fB\-\-update-drift\fR, with \fB\-\-set\fR or
+It is necessary to use the option \fB\-\-update-drift\fR, with \fB\-\-set\fR or
 \fB\-\-systohc\fR, to force drift factor updates.
 
 Since v2.26
 .B hwclock \-\-hctosys
-automatically compensates time read from the Hardware Clock to account for
-systematic drift before using it to set the System Clock.  Therefore,
-\fB\-\-adjust\fR is no longer necessary during boot. This functionality makes
-hwclock usable early in the boot process when the root filesystem is read-only.
+automatically takes a systematic drift of the Hardware Clock into account,
+setting the System Clock to the drift-compensated time.  Therefore the option
+\fB\-\-adjust\fR is no longer necessary during boot.  This feature makes
+.B hwclock
+usable early on in the boot process when the root filesystem is read-only.
 
 .SH FUNCTIONS
 You need exactly one of the following options to tell
@@ -101,9 +102,8 @@ When used in a startup script, making it the first caller of
 .BR settimeofday (2)
 from boot, it will set the NTP 11 minute mode time scale via the
 .I persistent_clock_is_local
-kernel variable. See the discussion below, under
-.B Automatic Hardware Clock Synchronization by the
-.BR Kernel.
+kernel variable.  See the discussion below, under
+.BR "Automatic Hardware Clock Synchronization by the Kernel" .
 .sp
 This is a good option to use in one of the system startup scripts.
 .sp
@@ -358,15 +358,13 @@ else.  This is useful, especially in conjunction with
 in learning about the internal operations of hwclock.
 
 .TP
-.B \-\-update\-drift
+.B \-\-update-drift
 Update the Hardware Clock's drift factor in
 .IR @ADJTIME_PATH@ .
 It is used with
 .BR --set\  or \ --systohc ,
 otherwise it is ignored.
-See the discussion below, under
-.B The Adjust
-.BR Function.
+See the discussion below, under \fBThe Adjust Function\fR.
 
 .TP
 .BR \-u , \ \-\-utc
@@ -442,8 +440,7 @@ If the kernel's timezone value and/or the
 .I persistent_clock_is_local
 variable are wrong, then the Hardware Clock will be set incorrectly by 11 minute
 mode.  See the discussion below, under
-.B Automatic Hardware Clock Synchronization by the
-.BR Kernel.
+.BR "Automatic Hardware Clock Synchronization by the Kernel" .
 .PP
 .B hwclock
 sets the kernel timezone to the value indicated by TZ and/or
@@ -551,35 +548,35 @@ keeps a file,
 that keeps some historical information.  This is called the adjtime file.
 .PP
 Suppose you start with no adjtime file.  You issue a
-.I hwclock \-\-set
+.B hwclock \-\-set
 command to set the Hardware Clock to the true current time.
 .B hwclock
 creates the adjtime file and records in it the current time as the
 last time the clock was calibrated.
-5 days later, the clock has gained 10 seconds, so you issue the
-.I hwclock \-\-set \-\-update\-drift
+Five days later, the clock has gained 10 seconds, so you issue a
+.B hwclock \-\-set \-\-update-drift
 command to set it back 10 seconds.
 .B hwclock
 updates the adjtime file to show the current time as the last time the
 clock was calibrated, and records 2 seconds per day as the systematic
 drift rate.  24 hours go by, and then you issue a
-.I hwclock \-\-adjust
+.B hwclock \-\-adjust
 command.
 .B hwclock
 consults the adjtime file and sees that the clock gains 2 seconds per
 day when left alone and that it has been left alone for exactly one
 day.  So it subtracts 2 seconds from the Hardware Clock.  It then
 records the current time as the last time the clock was adjusted.
-Another 24 hours goes by and you issue another
-.IR "hwclock \-\-adjust" .
+Another 24 hours go by and you issue another
+.BR "hwclock \-\-adjust" .
 .B hwclock
 does the same thing: subtracts 2 seconds and updates the adjtime file
 with the current time as the last time the clock was adjusted.
 .PP
 When you use the
-.I \-\-update\-drift
+.B \-\-update-drift
 option with
-.IR \-\-set\  or \ \-\-systohc ,
+.BR \-\-set\  or \ \-\-systohc ,
 the systematic drift rate is (re)calculated based on how long it has been
 since the last calibration, how long it has been since the last
 adjustment, what drift rate was assumed in any intervening
@@ -589,19 +586,19 @@ drift factor is then saved in
 .PP
 A small amount of error creeps in when
 the Hardware Clock is set, so
-.I \-\-adjust
+.B \-\-adjust
 refrains from making any adjustment that is less
 than 1 second.  Later on, when you request an adjustment again, the accumulated
 drift will be more than 1 second and
-.I \-\-adjust
+.B \-\-adjust
 will make the adjustment including any fractional amount.
 .PP
-.IR "hwclock \-\-hctosys"
+.B hwclock \-\-hctosys
 also uses the adjtime file data to compensate the value read from the Hardware
 Clock before using it to set the System Time.  It does not share the 1 second
-limitation of --adjust, and will correct sub-second drift values immediately.
+limitation of \fB--adjust\fR, and will correct sub-second drift values immediately.
 It does not change the Hardware Clock time or the adjtime file.  This may
-eliminate the need to use --adjust, unless something else on the system needs
+eliminate the need to use \fB--adjust\fR, unless something else on the system needs
 the Hardware Clock to be compensated. The drift compensation can be inhibited
 by using the
 .B --noadjfile
@@ -613,14 +610,14 @@ in remembering information from one invocation to the next.
 .PP
 The format of the adjtime file is, in ASCII:
 .PP
-Line 1: 3 numbers, separated by blanks: 1) systematic drift rate in
-seconds per day, floating point decimal; 2) Resulting number of
+Line 1: Three numbers, separated by blanks: 1) the systematic drift rate
+in seconds per day, floating point decimal; 2) the resulting number of
 seconds since 1969 UTC of most recent adjustment or calibration,
 decimal integer; 3) zero (for compatibility with
 .BR clock (8))
 as a decimal integer.
 .PP
-Line 2: 1 number: Resulting number of seconds since 1969 UTC of most
+Line 2: One number: the resulting number of seconds since 1969 UTC of most
 recent calibration.  Zero if there has been no calibration yet or it
 is known that any previous calibration is moot (for example, because
 the Hardware Clock has been found, since that calibration, not to
@@ -650,28 +647,28 @@ network or to a radio clock hooked up to your system.  See RFC 1305.)
 This mode (we'll call it "11 minute mode") is off until something
 turns it on.  The ntp daemon ntpd is one thing that turns it on.  You
 can turn it off by running anything, including
-.IR "hwclock \-\-hctosys" ,
+.BR "hwclock \-\-hctosys" ,
 that sets the System Time the old fashioned way.  However, if the ntp daemon is
 still running, it will turn 11 minute mode back on again the next time it
 synchronizes the System Clock.
 .PP
 If your system runs with 11 minute mode on, it may need
-.I hwclock \-\-hctosys
+.B hwclock \-\-hctosys
 in a startup script, especially if the Hardware Clock is configured to to use
 the local timescale.
 
 The first user space command to set the System Clock informs the
-kernel what timescale the Hardware Clock is using. This happens via the
+kernel what timescale the Hardware Clock is using.  This happens via the
 .I persistent_clock_is_local
-kernel variable. If
-.I hwclock \-\-hctosys
+kernel variable.  If
+.B hwclock \-\-hctosys
 is the first, it will set this variable according to the adjtime file or the
-appropriate command line argument. Note that when using this capability and the
+appropriate command-line argument.  Note that when using this capability and the
 Hardware Clock timescale configuration is changed, then a reboot is required to
 notify the kernel.
 
 Don't use
-.I hwclock \-\-adjust
+.B hwclock \-\-adjust
 with 11 minute mode.  You'll just make a mess.
 
 .SS ISA Hardware Clock Century value
-- 
1.7.0.4

