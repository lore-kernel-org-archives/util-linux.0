Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:59891 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754192AbbCMTW3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Mar 2015 15:22:29 -0400
Message-ID: <550338F2.2000908@gmx.com>
Date: Fri, 13 Mar 2015 15:22:26 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 4/5] hwclock: add '11 minute mode' information
References: <5503364E.6010302@gmx.com>
In-Reply-To: <5503364E.6010302@gmx.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add that '11 minute mode' is a kernel compile time
option. Add details regarding its activation and
how to check its status.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 0c294af..8cf86a3 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -758,25 +758,30 @@ You can use an adjtime file that was previously used with the
 .PP
 You should be aware of another way that the Hardware Clock is kept
 synchronized in some systems.  The Linux kernel has a mode wherein it
-copies the System Time to the Hardware Clock every 11 minutes.
+copies the System Time to the Hardware Clock every 11 minutes. This mode
+is a compile time option, so not all kernels will have this capability.
 This is a good mode to use when you are using something sophisticated
 like NTP to keep your System Clock synchronized. (NTP is a way to keep
 your System Time synchronized either to a time server somewhere on the
 network or to a radio clock hooked up to your system.  See RFC 1305.)
 .PP
-This mode (we'll call it \%'11\ minute\ mode') is off until something
-turns it on.  The NTP daemon ntpd is one thing that turns it on.  You
-can turn it off by running anything, including
+If the kernel is compiled with the \%'11\ minute\ mode' option it will
+be active when the kernel's clock discipline is in a synchronized state.
+When in this state the binary 64's bit of the kernel's
+.I \%time_status
+variable is unset (10111111). This value is output as the 'status' line of the
+.BR \%adjtimex\ --print " or " \%ntptime " commands."
+.PP
+It takes an outside influence, like the NTP daemon
+.BR ntpd (1),
+to put the kernel's clock discipline into a synchronized state, and
+therefore turn on \%'11\ minute\ mode'.
+It can be turned off by running anything, including
 .BR \%hwclock\ \-\-hctosys ,
 that sets the System Clock the old fashioned way.  However, if the NTP daemon is
-still running, it will turn 11 minute mode back on again the next time it
+still running, it will turn \%'11\ minute\ mode' back on again the next time it
 synchronizes the System Clock.
 .PP
-When \%'11\ minute\ mode' is active the 64 bit of the kernel's
-.I time_status
-variable is unset. The status variable can be checked with the
-.BR \%adjtimex\ --print " or " \%ntptime " commands."
-.PP
 If your system runs with \%'11\ minute\ mode' on, it may need to use either
 .BR \%\-\-hctosys " or " \%\-\-systz
 in a startup script, especially if the Hardware Clock is configured to use
