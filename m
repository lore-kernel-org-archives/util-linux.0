Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:53248 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751304AbaG0S7W (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 27 Jul 2014 14:59:22 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/6] docs: sort the options in the man pages of hwclock and uuidd
Date: Sun, 27 Jul 2014 20:58:56 +0200
Message-Id: <1406487540-10491-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1406487540-10491-1-git-send-email-bensberg@justemail.net>
References: <1406487540-10491-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also improve the formatting a bit.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/uuidd.8.in  |   52 +++---
 sys-utils/hwclock.8.in |  409 ++++++++++++++++++++++++------------------------
 2 files changed, 228 insertions(+), 233 deletions(-)

diff --git a/misc-utils/uuidd.8.in b/misc-utils/uuidd.8.in
index c38d715..0e25fb1 100644
--- a/misc-utils/uuidd.8.in
+++ b/misc-utils/uuidd.8.in
@@ -2,12 +2,12 @@
 .\" Copyright 2007 by Theodore Ts'o.  All Rights Reserved.
 .\" This file may be copied under the terms of the GNU Public License.
 .\"
-.TH UUIDD 8 "June 2011" "util-linux" "System Administration"
+.TH UUIDD 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 uuidd \- UUID generation daemon
 .SH SYNOPSIS
 .B uuidd
-.RI [ options ]
+[options]
 .SH DESCRIPTION
 The
 .B uuidd
@@ -20,8 +20,8 @@ numbers of threads running on different CPUs trying to grab UUIDs.
 .BR \-d , " \-\-debug "
 Run uuidd in debugging mode.  This prevents uuidd from running as a daemon.
 .TP
-.BR \-h , " \-\-help "
-Display help screen and exit.
+.BR \-F , " \-\-no-fork "
+Do not daemonize using a double-fork.
 .TP
 .BR \-k , " \-\-kill "
 If currently a uuidd daemon is running, kill it.
@@ -32,22 +32,13 @@ of
 .I number
 UUIDs.
 .TP
+.BR \-P , " \-\-no-pid "
+Do not create a pid file.
+.TP
 .BR \-p , " \-\-pid " \fIpath\fR
 Specify the pathname where the pid file should be written.  By default,
 the pid file is written to @localstatedir@/uuidd/uuidd.pid.
 .TP
-.BR \-P , " \-\-no-pid "
-Do not create pid file.
-.TP
-.BR \-F , " \-\-no-fork "
-Do not daemonize using double-fork.
-.TP
-.BR \-S , " \-\-socket-activation "
-Do not create the socket and instead expect it to be provided by the calling
-process.  Implies --no-fork and --no-pid.  As of this writing, this option is
-supposed to be used only with systemd.  This option must be enabled with a configure
-option.
-.TP
 .BR \-q , " \-\-quiet "
 Suppress some failure messages.
 .TP
@@ -55,16 +46,20 @@ Suppress some failure messages.
 Test uuidd by trying to connect to a running uuidd daemon and
 request it to return a random-based UUID.
 .TP
+.BR \-S , " \-\-socket-activation "
+Do not create a socket but instead expect it to be provided by the calling
+process.  This implies \fB--no-fork\fR and \fB--no-pid\fR.  This option is
+intended to be used only with \fBsystemd\fR(1).  It needs to be enabled with
+a configure option.
+.TP
 .BR \-s , " \-\-socket " \fIpath\fR
-Specify the pathname used for the unix-domain socket used by uuidd.  By
-default, the pathname used is @localstatedir@/uuidd/request.  This is primarily
+Make uuidd use this pathname for the unix-domain socket.  By default, the
+pathname used is @localstatedir@/uuidd/request.  This option is primarily
 for debugging purposes, since the pathname is hard-coded in the libuuid
 library.
 .TP
-.BR \-T , " \-\-timeout " \fItimeout\fR
-Specify a timeout for uuidd.  If specified, then uuidd will exit after
-.I timeout
-seconds of inactivity.
+.BR \-T , " \-\-timeout " \fInumber\fR
+Make uuidd exit after \fInumber\fR seconds of inactivity.
 .TP
 .BR \-t , " \-\-time "
 Test uuidd by trying to connect to a running uuidd daemon and
@@ -72,8 +67,11 @@ request it to return a time-based UUID.
 .TP
 .BR \-V , " \-\-version "
 Output version information and exit.
+.TP
+.BR \-h , " \-\-help "
+Display help screen and exit.
 .SH EXAMPLE
-Start up a daemon, print 42 random keys, and then stop the daemon.
+Start up a daemon, print 42 random keys, and then stop the daemon:
 .PP
 .RS
 .nf
@@ -86,9 +84,11 @@ uuidd -d -k -s /tmp/uuidd.socket
 The
 .B uuidd
 daemon was written by Theodore Ts'o <tytso@mit.edu>.
-.SH AVAILABILITY
-The uuidd daemon is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
 .SH "SEE ALSO"
 .BR uuid (3),
 .BR uuidgen (1)
+.SH AVAILABILITY
+The uuidd daemon is part of the util-linux package and is available from the
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 1e77269..b11b45c 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -1,4 +1,4 @@
-.TH HWCLOCK 8 "August 2011" "util-linux" "System Administration"
+.TH HWCLOCK 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 hwclock \- query or set the hardware clock (RTC)
 .SH SYNOPSIS
@@ -23,7 +23,35 @@ gains time at a certain rate when left to run).
 You need exactly one of the following options to tell
 .B hwclock
 what function to perform:
+.TP
+.B \-\-adjust
+Add or subtract time from the Hardware Clock to account for systematic
+drift since the last time the clock was set or adjusted.  See the
+discussion below, under \fBThe Adjust Function\fR.
+.TP
+.BR \-c , \ \-\-compare
+Periodically compare the Hardware Clock to the System Time and output
+the difference every 10 seconds.  This will also print the frequency
+offset and tick.
+.TP
+.B \-\-getepoch
+Print the kernel's Hardware Clock epoch value to standard output.
+This is the number of years into AD to which a zero year value in the
+Hardware Clock refers.  For example, if you are using the convention
+that the year counter in your Hardware Clock contains the number of
+full years since 1952, then the kernel's Hardware Clock epoch value
+must be 1952.
 .PP
+This epoch value is used whenever
+.B hwclock
+reads or sets the Hardware Clock.
+.TP
+.BI \-\-predict
+Predict what the RTC will read at the time given by the
+.B \-\-date
+option, based on the adjtime file.  This is useful for example if you
+need to set an RTC wakeup time to a distant future and want to account
+for the RTC drift.
 .TP
 .BR \-r , \ \-\-show
 Read the Hardware Clock and print the time on standard output.
@@ -32,16 +60,10 @@ in Coordinated Universal Time.  See the
 .B \-\-utc
 option.
 Showing the Hardware Clock time is the default when no function is specified.
-
-.TP
-.B \-\-set
-Set the Hardware Clock to the time given by the
-.B \-\-date
-option.
 .TP
 .BR \-s , \ \-\-hctosys
 Set the System Time from the Hardware Clock.
-
+.PP
 Also set the kernel's timezone value to the local timezone
 as indicated by the TZ environment variable and/or
 .IR /usr/share/zoneinfo ,
@@ -51,17 +73,26 @@ would interpret them.
 The obsolete tz_dsttime field of the kernel's timezone value is set
 to DST_NONE.  (For details on what this field used to mean, see
 .BR settimeofday (2).)
-
+.PP
 This is a good option to use in one of the system startup scripts.
 .TP
-.BR \-w , \ \-\-systohc
-Set the Hardware Clock to the current System Time.
+.B \-\-set
+Set the Hardware Clock to the time given by the
+.B \-\-date
+option.
+.TP
+.B \-\-setepoch
+Set the kernel's Hardware Clock epoch value to the value specified by the
+.B \-\-epoch
+option.  See the
+.B \-\-getepoch
+option for details.
 .TP
 .B \-\-systz
 Set the kernel's timezone and reset the System Time based on the current timezone.
-
+.PP
 The system time is only reset on the first call after boot.
-
+.PP
 The local timezone is taken to be what is
 indicated by the TZ environment variable and/or
 .IR /usr/share/zoneinfo ,
@@ -71,166 +102,39 @@ would interpret them.
 The obsolete tz_dsttime field of the kernel's timezone value is set
 to DST_NONE.  (For details on what this field used to mean, see
 .BR settimeofday (2).)
-
+.PP
 This is an alternate option to
 .B \-\-hctosys
 that does not read the hardware clock, and may be used in system startup
 scripts for recent 2.6 kernels where you know the System Time contains
-the Hardware Clock time. If the Hardware Clock is already in UTC, it is
+the Hardware Clock time.  If the Hardware Clock is already in UTC, it is
 not reset.
 .TP
-.B \-\-adjust
-Add or subtract time from the Hardware Clock to account for systematic
-drift since the last time the clock was set or adjusted.  See discussion
-below.
-.TP
-.B \-\-getepoch
-Print the kernel's Hardware Clock epoch value to standard output.
-This is the number of years into AD to which a zero year value in the
-Hardware Clock refers.  For example, if you are using the convention
-that the year counter in your Hardware Clock contains the number of
-full years since 1952, then the kernel's Hardware Clock epoch value
-must be 1952.
-
-This epoch value is used whenever
-.B hwclock
-reads or sets the Hardware Clock.
-.TP
-.B \-\-setepoch
-Set the kernel's Hardware Clock epoch value to the value specified by the
-.B \-\-epoch
-option.  See the
-.B \-\-getepoch
-option for details.
-
-.TP
-.BI \-\-predict
-Predict what the RTC will read at time given by the
-.B \-\-date
-option based on the adjtime file. This is useful for example if you
-need to set an RTC wakeup time to distant future and want to account
-for the RTC drift.
+.BR \-w , \ \-\-systohc
+Set the Hardware Clock to the current System Time.
 .TP
-.BR \-c , \ \-\-compare
-Periodically compare the Hardware Clock to the System Time and output
-the difference every 10 seconds.  This will also print the frequency
-offset and tick.
+.BR \-V , \ \-\-version
+Display version information and exit.
 .TP
 .BR \-h , \ \-\-help
 Display help text and exit.
-.TP
-.BR \-V , \ \-\-version
-Display version information and exit.
 
 .SH OPTIONS
-.PP
-The first two options apply to just a few specific functions,
-the others apply to most functions.
-.TP
-.BI \-\-date= date_string
-You need this option if you specify the
-.B \-\-set
-or
-.B \-\-predict
-functions, otherwise it is ignored.
-It specifies the time to which to set the Hardware Clock, or the
-time for which to predict the Hardware Clock reading.
-The value of this option is an argument to the
-.BR date (1)
-program.
-For example:
-.sp
-.B "    hwclock" --set --date="2011-08-14 16:45:05"
-.sp
-The argument must be in local time, even if you keep your Hardware Clock in
-Coordinated Universal time.  See the
-.B \-\-utc
-option.
-
-.TP
-.BI \-\-epoch= year
-Specifies the year which is the beginning of the Hardware Clock's
-epoch, that is the number of years into AD to which a zero value in the
-Hardware Clock's year counter refers.  It is used together with
-the \fB\-\-setepoch\fR option to set the kernel's idea of the epoch of the
-Hardware Clock, or otherwise to specify the epoch for use with
-direct ISA access.
-
-For example, on a Digital Unix machine:
-.sp
-.B "    hwclock" --setepoch --epoch=1952
-
-.TP
-.BR \-u , \ \-\-utc
-.TP
-.B \-\-localtime
-Indicates that the Hardware Clock is kept in Coordinated Universal
-Time or local time, respectively.  It is your choice whether to keep
-your clock in UTC or local time, but nothing in the clock tells which
-you've chosen.  So this option is how you give that information to
-.BR hwclock .
-
-If you specify the wrong one of these options (or specify neither and
-take a wrong default), both setting and querying of the Hardware Clock
-will be messed up.
-
-If you specify neither
-.B \-\-utc
-nor
-.BR \-\-localtime ,
-the default is whichever was specified the last time
-.B hwclock
-was used to set the clock (i.e.
-.B hwclock
-was successfully run with the
-.BR \-\-set ,
-.BR \-\-systohc ,
-or
-.B \-\-adjust
-options), as recorded in the adjtime file.  If the adjtime file doesn't
-exist, the default is UTC time.
-
-.TP
-.B \-\-noadjfile
-Disables the facilities provided by
-.IR @ADJTIME_PATH@ .
-.B hwclock
-will not read nor write to that file with this option.  Either
-.B \-\-utc
-or
-.B \-\-localtime
-must be specified when using this option.
 
 .TP
 .BI \-\-adjfile= filename
-Overrides the default @ADJTIME_PATH@.
-
-.TP
-.BR \-f , \ \-\-rtc=\fIfilename\fB
-Overrides the default /dev file name, which is
-.IR /dev/rtc
-on many platforms but may be
-.IR /dev/rtc0 ,
-.IR /dev/rtc1 ,
-and so on.
+Override the default @ADJTIME_PATH@.
 
 .TP
-.B \-\-directisa
-This option is meaningful only on an ISA machine or an Alpha (which implements
-enough of ISA to be, roughly speaking, an ISA machine for
-.BR hwclock 's
-purposes).  For other machines, it has no effect.  This option tells
-.B hwclock
-to use explicit I/O instructions to access the Hardware Clock.
-Without this option,
-.B hwclock
-will try to use the /dev/rtc device (which it assumes to be driven by the
-RTC device driver).  If it is unable to open the device (for reading), it will
-use the explicit I/O instructions anyway.
+.B \-\-arc
+This option is equivalent to
+.B \-\-epoch=1980
+and is used to specify the most common epoch on Alphas
+with ARC console (but Ruffians have epoch 1900).
 
 .TP
 .B \-\-badyear
-Indicates that the Hardware Clock is incapable of storing years outside
+Indicate that the Hardware Clock is incapable of storing years outside
 the range 1994-1999.  There is a problem in some BIOSes (almost all
 Award BIOSes made between 4/26/94 and 5/31/95) wherein they are unable
 to deal with years after 1999.  If one attempts to set the year-of-century
@@ -239,7 +143,7 @@ actually gets set is 94 (or 95).  Thus, if you have one of these machines,
 .B hwclock
 cannot set the year after 1999 and cannot use the value of the clock as
 the true time in the normal way.
-
+.PP
 To compensate for this (without your getting a BIOS update, which would
 definitely be preferable), always use
 .B \-\-badyear
@@ -253,7 +157,7 @@ within the past year.  For this to work, you had better do a
 or
 .B hwclock \-\-systohc
 at least once a year!
-
+.PP
 Though
 .B hwclock
 ignores the year value when it reads the Hardware Clock, it sets the
@@ -263,28 +167,80 @@ the true year.  That way, the Hardware Clock inserts leap days where
 they belong.  Again, if you let the Hardware Clock run for more than a
 year without setting it, this scheme could be defeated and you could
 end up losing a day.
-
+.PP
 .B hwclock
 warns you that you probably need
 .B \-\-badyear
 whenever it finds your Hardware Clock set to 1994 or 1995.
 
 .TP
-.B \-\-srm
-This option is equivalent to
-.B \-\-epoch=1900
-and is used to specify the most common epoch on Alphas
-with SRM console.
+.BI \-\-date= date_string
+You need this option if you specify the
+.B \-\-set
+or
+.B \-\-predict
+functions, otherwise it is ignored.
+It specifies the time to which to set the Hardware Clock, or the
+time for which to predict the Hardware Clock reading.
+The value of this option is an argument to the
+.BR date (1)
+program.
+For example:
+.PP
+.B "    hwclock" --set --date="2011-08-14 16:45:05"
+.PP
+The argument must be in local time, even if you keep your Hardware Clock in
+Coordinated Universal time.  See the
+.B \-\-utc
+option.
+
 .TP
-.B \-\-arc
-This option is equivalent to
-.B \-\-epoch=1980
-and is used to specify the most common epoch on Alphas
-with ARC console (but Ruffians have epoch 1900).
+.B \-\-debug
+Display a lot of information about what
+.B hwclock
+is doing internally.  Some of its function is complex and this output
+can help you understand how the program works.
+
 .TP
-.B \-\-jensen
+.B \-\-directisa
+This option is meaningful only on an ISA machine or an Alpha (which implements
+enough of ISA to be, roughly speaking, an ISA machine for
+.BR hwclock 's
+purposes).  For other machines, it has no effect.  This option tells
+.B hwclock
+to use explicit I/O instructions to access the Hardware Clock.
+Without this option,
+.B hwclock
+will try to use the /dev/rtc device (which it assumes to be driven by the
+RTC device driver).  If it is unable to open the device (for reading), it will
+use the explicit I/O instructions anyway.
+
+.TP
+.BI \-\-epoch= year
+Specifies the year which is the beginning of the Hardware Clock's
+epoch, that is the number of years into AD to which a zero value in the
+Hardware Clock's year counter refers.  It is used together with
+the \fB\-\-setepoch\fR option to set the kernel's idea of the epoch of the
+Hardware Clock, or otherwise to specify the epoch for use with
+direct ISA access.
+.PP
+For example, on a Digital Unix machine:
+.PP
+.B "    hwclock" --setepoch --epoch=1952
+
+.TP
+.BR \-f , \ \-\-rtc=\fIfilename\fB
+Overrides the default /dev file name, which is
+.IR /dev/rtc
+on many platforms but may be
+.IR /dev/rtc0 ,
+.IR /dev/rtc1 ,
+and so on.
+
 .TP
 .B \-\-funky\-toy
+.TP
+.B \-\-jensen
 These two options specify what kind of Alpha machine you have.  They
 are invalid if you don't have an Alpha and are usually unnecessary
 if you do, because
@@ -298,7 +254,7 @@ is mounted.
 work, contact the maintainer to see if the program can be improved
 to detect your system automatically.  Output of `hwclock --debug'
 and `cat /proc/cpuinfo' may be of interest.)
-
+.PP
 Option
 .B \-\-jensen
 means you are running on a Jensen model.  And
@@ -307,6 +263,52 @@ means that on your machine one has to use the UF bit instead
 of the UIP bit in the Hardware Clock to detect a time transition.  "Toy"
 in the option name refers to the Time Of Year facility of the machine.
 
+.TP
+.B \-\-localtime
+Indicate that the Hardware Clock is kept in local time.
+.PP
+It is your choice whether to keep
+your clock in UTC or in local time, but nothing in the clock itself
+says which alternative
+you've chosen.  So with \fB\-\-localtime\fR or \fB\-\-utc\fR
+you give this information to
+.BR hwclock .
+If you specify the wrong one (or specify neither and take a wrong default),
+both setting and querying the Hardware Clock will be messed up.
+.PP
+If you specify neither
+.B \-\-utc
+nor
+.BR \-\-localtime ,
+the default is whichever was specified the last time
+.B hwclock
+was used to set the clock (i.e.
+.B hwclock
+was successfully run with the
+.BR \-\-set ,
+.BR \-\-systohc ,
+or
+.B \-\-adjust
+options), as recorded in the adjtime file.  If the adjtime file doesn't
+exist, the default is UTC time.
+
+.TP
+.B \-\-noadjfile
+Disable the facilities provided by
+.IR @ADJTIME_PATH@ .
+.B hwclock
+will not read nor write to that file with this option.  Either
+.B \-\-utc
+or
+.B \-\-localtime
+must be specified when using this option.
+
+.TP
+.B \-\-srm
+This option is equivalent to
+.B \-\-epoch=1900
+and is used to specify the most common epoch on Alphas
+with SRM console.
 
 .TP
 .B \-\-test
@@ -314,26 +316,23 @@ Do everything except actually updating the Hardware Clock or anything
 else.  This is useful, especially in conjunction with
 .BR \-\-debug ,
 in learning about
-.BR hwclock .
+
 .TP
-.B \-\-debug
-Display a lot of information about what
-.B hwclock
-is doing internally.  Some of its function is complex and this output
-can help you understand how the program works.
+.BR \-u , \ \-\-utc
+Indicate that the Hardware Clock is kept in Coordinated Universal Time.
+See the discussion under \fB\-\-localtime\fR.
 
 
 .SH NOTES
 
-
-.SH Clocks in a Linux System
+.SS Clocks in a Linux System
 .PP
 There are two main clocks in a Linux system:
 .PP
 .B The Hardware Clock:
 This is a clock that runs independently of any control program running
 in the CPU and even when the machine is powered off.
-
+.PP
 On an ISA system, this clock is specified as part of the ISA standard.
 The control program can read or set this clock to a whole second, but
 the control program can also detect the edges of the 1 second clock
@@ -355,7 +354,7 @@ integrated real-time clock which is used for most other purposes.
 .B The System Time:
 This is the time kept by a clock inside the Linux kernel and driven by
 a timer interrupt.  (On an ISA machine, the timer interrupt is part of
-the ISA standard).  It has meaning only while Linux is running on the
+the ISA standard.)  It has meaning only while Linux is running on the
 machine.  The System Time is the number of seconds since 00:00:00
 January 1, 1970 UTC (or more succinctly, the number of seconds since
 1969).  The System Time is not an integer, though.  It has virtually
@@ -406,21 +405,21 @@ This second field is not used under Linux and is always zero.
 (See also
 .BR settimeofday (2).)
 
-.SH Users access and setuid
+.SS User access and setuid
 .PP
 Sometimes, you need to install
 .B hwclock
-setuid root. If you want users other than the superuser to be able to
+setuid root.  If you want users other than the superuser to be able to
 display the clock value using the direct ISA I/O method, install it setuid
-root. If you have the /dev/rtc interface on your system or are on a non-ISA
+root.  If you have the /dev/rtc interface on your system or are on a non-ISA
 system, there's probably no need for users to use the direct ISA I/O method,
 so don't bother.
-
+.PP
 In any case, hwclock will not allow you to set anything unless you have the
-superuser real uid. (This is restriction is not necessary if you haven't
-installed setuid root, but it's there for now).
+superuser real uid.  (This restriction is not necessary if you haven't
+installed setuid root, but it's there for now.)
 
-.SH How hwclock Accesses the Hardware Clock
+.SS How hwclock accesses the Hardware Clock
 .PP
 .B hwclock
 uses many different ways to get and set Hardware Clock values.
@@ -452,14 +451,13 @@ Alpha, there is no way for
 .B hwclock
 to execute those I/O instructions, and so it uses instead the
 /dev/port device special file, which provides almost as low-level an
-interface to the I/O subsystem).
-
+interface to the I/O subsystem.)
+.PP
 This is a really poor method of accessing the clock, for all the
-reasons that user space programs are generally not supposed to do
-direct I/O and disable interrupts.  Hwclock provides it because it is
+reasons that userspace programs are generally not supposed to do
+direct I/O and disable interrupts.  \fBhwclock\fR provides it because it is
 the only method available on ISA and Alpha systems which don't have
 working rtc device drivers available.
-
 .PP
 On an m68k system,
 .B hwclock
@@ -480,8 +478,7 @@ by specifying the
 .B \-\-directisa
 option.
 
-
-.SH The Adjust Function
+.SS The Adjust Function
 .PP
 The Hardware Clock is usually not very accurate.  However, much of its
 inaccuracy is completely predictable - it gains or loses the same amount
@@ -499,26 +496,26 @@ that keeps some historical information.  This is called the adjtime file.
 Suppose you start with no adjtime file.  You issue a
 .I hwclock \-\-set
 command to set the Hardware Clock to the true current time.
-.B Hwclock
+.B hwclock
 creates the adjtime file and records in it the current time as the
 last time the clock was calibrated.
 5 days later, the clock has gained 10 seconds, so you issue another
 .I hwclock \-\-set
 command to set it back 10 seconds.
-.B Hwclock
+.B hwclock
 updates the adjtime file to show the current time as the last time the
 clock was calibrated, and records 2 seconds per day as the systematic
 drift rate.  24 hours go by, and then you issue a
 .I hwclock \-\-adjust
 command.
-.B Hwclock
+.B hwclock
 consults the adjtime file and sees that the clock gains 2 seconds per
 day when left alone and that it has been left alone for exactly one
 day.  So it subtracts 2 seconds from the Hardware Clock.  It then
 records the current time as the last time the clock was adjusted.
 Another 24 hours goes by and you issue another
 .IR "hwclock \-\-adjust" .
-.B Hwclock
+.B hwclock
 does the same thing: subtracts 2 seconds and updates the adjtime file
 with the current time as the last time the clock was adjusted.
 .PP
@@ -577,23 +574,22 @@ You can use an adjtime file that was previously used with the
 program with
 .BR hwclock .
 
-
-.SH "Automatic Hardware Clock Synchronization By the Kernel"
-
+.SS Automatic Hardware Clock Synchronization by the Kernel
+.PP
 You should be aware of another way that the Hardware Clock is kept
 synchronized in some systems.  The Linux kernel has a mode wherein it
 copies the System Time to the Hardware Clock every 11 minutes.
 This is a good mode to use when you are using something sophisticated
 like ntp to keep your System Time synchronized. (ntp is a way to keep
 your System Time synchronized either to a time server somewhere on the
-network or to a radio clock hooked up to your system.  See RFC 1305).
-
+network or to a radio clock hooked up to your system.  See RFC 1305.)
+.PP
 This mode (we'll call it "11 minute mode") is off until something
 turns it on.  The ntp daemon xntpd is one thing that turns it on.  You
 can turn it off by running anything, including
 .IR "hwclock \-\-hctosys" ,
 that sets the System Time the old fashioned way.
-
+.PP
 If your system runs with 11 minute mode on, don't use
 .I hwclock \-\-adjust
 or
@@ -604,9 +600,8 @@ at startup time to get a reasonable System Time until your system is
 able to set the System Time from the external source and start 11
 minute mode.
 
-
-.SH ISA Hardware Clock Century value
-
+.SS ISA Hardware Clock Century value
+.PP
 There is some sort of standard that defines CMOS memory Byte 50 on an ISA
 machine as an indicator of what century it is.
 .B hwclock
@@ -614,11 +609,11 @@ does not use or set that byte because there are some machines that
 don't define the byte that way, and it really isn't necessary anyway,
 since the year-of-century does a good job of implying which century it
 is.
-
+.PP
 If you have a bona fide use for a CMOS century byte, contact the
 .B hwclock
 maintainer; an option may be appropriate.
-
+.PP
 Note that this section is only relevant when you are using the "direct
 ISA" method of accessing the Hardware Clock.
 ACPI provides a standard way to access century values, when they
-- 
1.7.0.4

