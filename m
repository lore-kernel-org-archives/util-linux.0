Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:52059 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751304AbaG0S7T (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 27 Jul 2014 14:59:19 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/6] docs: bring the rtcwake man page closer to standard formatting
Date: Sun, 27 Jul 2014 20:58:55 +0200
Message-Id: <1406487540-10491-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also sort the options alphabetically, and use the standard comma
instead of the vertical bar to separate short from long option.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/rtcwake.8.in |  152 ++++++++++++++++++++++++------------------------
 1 files changed, 77 insertions(+), 75 deletions(-)

diff --git a/sys-utils/rtcwake.8.in b/sys-utils/rtcwake.8.in
index 643b59d..5ec9c6c 100644
--- a/sys-utils/rtcwake.8.in
+++ b/sys-utils/rtcwake.8.in
@@ -16,19 +16,20 @@
 .\" Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 .\" 02110-1301, USA.
 .\"
-.TH RTCWAKE 8 "July 2007" "util-linux" "System Administration"
+.TH RTCWAKE 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
-rtcwake - enter a system sleep state until specified wakeup time
+rtcwake \- enter a system sleep state until specified wakeup time
 .SH SYNOPSIS
 .B rtcwake
-.RB [ options ]
+[options]
 .RB [ \-d
 .IR device ]
 .RB [ \-m
 .IR standby_mode ]
-.RB { "\-t \fItime_t\fP" | "\-s \fIseconds\fP" }
+.RB { "\-s \fIseconds\fP" | "\-t \fItime_t\fP" }
 .SH DESCRIPTION
-This program is used to enter a system sleep state until specified wakeup time.
+This program is used to enter a system sleep state and to automatically
+wake from it at a specified time.
 .PP
 This uses cross-platform Linux interfaces to enter a system sleep state, and
 leave it no later than a specified time.  It uses any RTC framework driver that
@@ -37,121 +38,122 @@ supports standard driver model wakeup flags.
 This is normally used like the old \fBapmsleep\fP utility, to wake from a suspend
 state like ACPI S1 (standby) or S3 (suspend-to-RAM).  Most platforms can
 implement those without analogues of BIOS, APM, or ACPI.
-.P
+.PP
 On some systems, this can also be used like \fBnvram-wakeup\fP, waking from states
 like ACPI S4 (suspend to disk).  Not all systems have persistent media that are
 appropriate for such suspend modes.
-.SS Options
-.TP
-\fB-v\fP | \fB--verbose\fP
-Be verbose.
+.SH OPTIONS
 .TP
-\fB-h\fP | \fB--help\fP
-Display help text and exit.
-.TP
-\fB-V\fP | \fB--version\fP
-Display version information and exit.
+.BR \-A , " \-\-adjfile " \fIfile
+Specify an alternative path to the adjust file.
 .TP
-\fB-n\fP | \fB--dry-run\fP
-This option does everything apart from actually setting up the alarm,
-suspending the system, or waiting for the alarm.
-.TP
-\fB-A\fP | \fB--adjfile\fP \fIfile\fP
-Specifies an alternative path to the adjust file.
-.TP
-\fB-a\fP | \fB--auto\fP
-Reads the clock mode (whether the hardware clock is set to UTC or local time)
-from \fIadjtime\fP file. That's the location where the
+.BR \-a , " \-\-auto"
+Read the clock mode (whether the hardware clock is set to UTC or local time)
+from the \fIadjtime\fP file, where
 .BR hwclock (8)
-stores that information. This is the default.
-.TP
-\fB-l\fP | \fB--local\fP
-Assumes that the hardware clock is set to local time, regardless of the
-contents of \fIadjtime\fP file.
+stores that information.  This is the default.
 .TP
-\fB-u\fP | \fB--utc\fP
-Assumes that the hardware clock is set to UTC (Universal Time Coordinated),
-regardless of the contents of \fIadjtime\fP file.
+.BR \-d , " \-\-device " \fIdevice
+Use the specified \fIdevice\fP instead of \fBrtc0\fP as realtime clock.
+This option is only relevant if your system has more than one RTC.
+You may specify \fBrtc1\fP, \fBrtc2\fP, ... here.
 .TP
-\fB-d\fP \fIdevice\fP | \fB--device\fP \fIdevice\fP
-Uses \fIdevice\fP instead of \fIrtc0\fP as realtime clock. This option
-is only relevant if your system has more than one RTC. You may specify
-\fIrtc1\fP, \fIrtc2\fP, ... here.
+.BR \-l , " \-\-local"
+Assume that the hardware clock is set to local time, regardless of the
+contents of the \fIadjtime\fP file.
 .TP
-\fB-s\fP \fIseconds\fP | \fB--seconds\fP \fIseconds\fP
-Sets the wakeup time to \fIseconds\fP in future from now.
-.TP
-\fB-t\fP \fItime_t\fP | \fB--time\fP \fItime_t\fP
-Sets the wakeup time to the absolute time \fItime_t\fP. \fItime_t\fP
-is the time in seconds since 1970-01-01, 00:00 UTC. Use the
-.BR date (1)
-tool to convert between human-readable time and \fItime_t\fP.
-.TP
-\fB-m\fP \fImode\fP | \fB--mode\fP \fImode\fP
-Use standby state \fImode\fP. Valid values are:
+.BR \-m , " \-\-mode " \fImode
+Go into the given standby state.  Valid values for \fImode\fP are:
 .RS
 .TP
 .B standby
-ACPI state S1. This state offers minimal, though real, power savings, while
-providing a very low-latency transition back to a working system. This is the
+ACPI state S1.  This state offers minimal, though real, power savings, while
+providing a very low-latency transition back to a working system.  This is the
 default mode.
 .TP
+.B freeze
+The processes are frozen, all the devices are suspended and all the processors
+idled.  This state is a general state that does not need any platform-specific
+support, but it saves less power than Suspend-to-RAM, because the system is
+still in a running state.  (Available since Linux 3.9.)
+.TP
 .B mem
-ACPI state S3 (Suspend-to-RAM). This state offers significant power savings as
+ACPI state S3 (Suspend-to-RAM).  This state offers significant power savings as
 everything in the system is put into a low-power state, except for memory,
 which is placed in self-refresh mode to retain its contents.
 .TP
-.B freeze
-The processes are frozen, all the devices are suspended and all the processors
-idles. This state is a general state that does not need any platform specific
-support, but it saves less power than susepnd to RAM, because the system is
-still in a running state. (since Linux 3.9)
-.TP
 .B disk
-ACPI state S4 (Suspend-to-disk). This state offers the greatest power savings,
+ACPI state S4 (Suspend-to-disk).  This state offers the greatest power savings,
 and can be used even in the absence of low-level platform support for power
-management. This state operates similarly to Suspend-to-RAM, but includes a
+management.  This state operates similarly to Suspend-to-RAM, but includes a
 final step of writing memory contents to disk.
 .TP
 .B off
-ACPI state S5 (Poweroff). This is done by calling '/sbin/shutdown'.
-Not officially supported by ACPI, but usually working.
+ACPI state S5 (Poweroff).  This is done by calling '/sbin/shutdown'.
+Not officially supported by ACPI, but it usually works.
 .TP
 .B no
-Don't suspend. The rtcwake command sets RTC wakeup time only.
+Don't suspend, only set the RTC wakeup time.
 .TP
 .B on
-Don't suspend, but read RTC device until alarm time appears. This mode is
-useful for debugging.
+Don't suspend, but read the RTC device until an alarm time appears.
+This mode is useful for debugging.
 .TP
 .B disable
-Disable previously set alarm.
+Disable a previously set alarm.
 .TP
 .B show
 Print alarm information in format: "alarm: off|on  <time>".
 The time is in ctime() output format, e.g. "alarm: on  Tue Nov 16 04:48:45 2010".
 .RE
-.PP
-.SH FILES
-.I @ADJTIME_PATH@
+.TP
+.BR \-n , " \-\-dry-run"
+This option does everything apart from actually setting up the alarm,
+suspending the system, or waiting for the alarm.
+.TP
+.BR \-s , " \-\-seconds " \fIseconds
+Set the wakeup time to \fIseconds\fP in the future from now.
+.TP
+.BR \-t , " \-\-time " \fItime_t
+Set the wakeup time to the absolute time \fItime_t\fP.  \fItime_t\fP
+is the time in seconds since 1970-01-01, 00:00 UTC.  Use the
+.BR date (1)
+tool to convert between human-readable time and \fItime_t\fP.
+.TP
+.BR \-u , " \-\-utc"
+Assume that the hardware clock is set to UTC (Universal Time Coordinated),
+regardless of the contents of the \fIadjtime\fP file.
+.TP
+.BR \-v , " \-\-verbose"
+Be verbose.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH NOTES
-Some PC systems can't currently exit sleep states such as \fImem\fP
+Some PC systems can't currently exit sleep states such as \fBmem\fP
 using only the kernel code accessed by this driver.
 They need help from userspace code to make the framebuffer work again.
+.SH FILES
+.I @ADJTIME_PATH@
 .SH HISTORY
 The program was posted several times on LKML and other lists
 before appearing in kernel commit message for Linux 2.6 in the GIT
 commit 87ac84f42a7a580d0dd72ae31d6a5eb4bfe04c6d.
-.SH AVAILABILITY
-The rtcwake command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-.SH AUTHOR
+.SH AUTHORS
 The program was written by David Brownell <dbrownell@users.sourceforge.net>
 and improved by Bernhard Walle <bwalle@suse.de>.
 .SH COPYRIGHT
-This is free software.  You may redistribute copies of it  under  the  terms
-of  the  GNU General  Public  License <http://www.gnu.org/licenses/gpl.html>.
+This is free software.  You may redistribute copies of it under the terms
+of the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
 There is NO WARRANTY, to the extent permitted by law.
 .SH "SEE ALSO"
 .BR hwclock (8),
 .BR date (1)
+.SH AVAILABILITY
+The rtcwake command is part of the util-linux package and is available from the
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
\ No newline at end of file
-- 
1.7.0.4

