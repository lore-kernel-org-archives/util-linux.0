Return-Path: elseifthen@gmx.com
Message-ID: <5426D7EE.5010605@gmx.com>
Date: Sat, 27 Sep 2014 11:29:50 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 5/7] hwclock: persistent_clock_is_local MAN
References: <5426D4C2.4060403@gmx.com>
In-Reply-To: <5426D4C2.4060403@gmx.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>


Update hwclock man page for the
hwclock: persistent_clock_is_local patch.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 63 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 913da37..d04a429 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -84,7 +84,24 @@ The obsolete tz_dsttime field of the kernel's timezone value is set
 to DST_NONE.  (For details on what this field used to mean, see
 .BR settimeofday (2).)
 .PP
+When used in a startup script, making it the first caller of
+.BR settimeofday (2)
+from boot, it will set the NTP 11 minute mode time scale via the
+.I persistent_clock_is_local
+kernel variable. See the discussion below, under
+.B Automatic Hardware Clock Synchronization by the
+.BR Kernel.
+.PP
 This is a good option to use in one of the system startup scripts.
+.PP
+This option should never be used on a running system. Jumping system time
+will cause problems, such as, corrupted file system timestamps.
+Also, if NTP 11 minute mode is active then
+.B --hctosys
+will set the time incorrectly by
+including drift compensation. Drift compensation can be inhibited by using the
+.B --noadjfile
+option.
 .TP
 .B \-\-set
 Set the Hardware Clock to the time given by the
@@ -393,11 +410,16 @@ use the TZ environment variable and/or the
 .I /usr/share/zoneinfo
 directory, as explained in the man page for
 .BR tzset (3).
-However, some
-programs and fringe parts of the Linux kernel such as filesystems use
-the kernel timezone value.  An example is the vfat filesystem.  If the
-kernel timezone value is wrong, the vfat filesystem will report and
-set the wrong timestamps on files.
+However, some programs and fringe parts of the Linux kernel such as filesystems
+use the kernel timezone value.  An example is the vfat filesystem.  If the
+kernel timezone value is wrong, the vfat filesystem will report and set the
+wrong timestamps on files. Another example is the kernel's NTP 11 minute mode.
+If the kernel's timezone value and/or the
+.I persistent_clock_is_local
+variable are wrong, then the Hardware Clock will be set incorrectly by 11 minute
+mode.  See the discussion below, under
+.B Automatic Hardware Clock Synchronization by the
+.BR Kernel.
 .PP
 .B hwclock
 sets the kernel timezone to the value indicated by TZ and/or
@@ -601,20 +623,31 @@ your System Time synchronized either to a time server somewhere on the
 network or to a radio clock hooked up to your system.  See RFC 1305.)
 .PP
 This mode (we'll call it "11 minute mode") is off until something
-turns it on.  The ntp daemon xntpd is one thing that turns it on.  You
+turns it on.  The ntp daemon ntpd is one thing that turns it on.  You
 can turn it off by running anything, including
 .IR "hwclock \-\-hctosys" ,
-that sets the System Time the old fashioned way.
+that sets the System Time the old fashioned way.  However, if the ntp daemon is
+still running, it will turn 11 minute mode back on again the next time it
+synchronizes the System Clock.
 .PP
-If your system runs with 11 minute mode on, don't use
-.I hwclock \-\-adjust
-or
-.IR "hwclock \-\-hctosys" .
-You'll just make a mess.  It is acceptable to use a
+If your system runs with 11 minute mode on, it may need
+.I hwclock \-\-hctosys
+in a startup script, especially if the Hardware Clock is configured to to use
+the local timescale.
+
+The first user space command to set the System Clock informs the
+kernel what timescale the Hardware Clock is using. This happens via the
+.I persistent_clock_is_local
+kernel variable. If
 .I hwclock \-\-hctosys
-at startup time to get a reasonable System Time until your system is
-able to set the System Time from the external source and start 11
-minute mode.
+is the first, it will set this variable according to the adjtime file or the
+appropriate command line argument. Note that when using this capability and the
+Hardware Clock timescale configuration is changed, then a reboot is required to
+notify the kernel.
+
+Don't use
+.I hwclock \-\-adjust
+with 11 minute mode.  You'll just make a mess.
 
 .SS ISA Hardware Clock Century value
 .PP
