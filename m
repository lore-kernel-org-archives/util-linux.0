Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbdGXXyf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 24 Jul 2017 19:54:35 -0400
Subject: [PATCH] hwclock: remove m68k and alpha cmos from manual
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <668555d6-aff5-8423-889a-a2c543b54192@gmx.com>
Date: Mon, 24 Jul 2017 19:54:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


  m68k removed in commit 846c7d3
  alpha cmos removed in commit c47a618

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index b616e3f..e0862c9 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -533,11 +533,6 @@ direct I/O and disable interrupts.
 provides it for testing, troubleshooting, and  because it may be the
 only method available on ISA systems which do not have a working rtc
 device driver.
-.PP
-On an m68k system,
-.B \%hwclock
-can access the clock with the console driver, via the device special file
-.IR \%/dev/tty1 .
 .SS The Adjust Function
 .PP
 The Hardware Clock is usually not very accurate.  However, much of its
@@ -941,10 +936,6 @@ may try for Hardware Clock access:
 .I /dev/efirtc
 .br
 .I /dev/misc/efirtc
-.br
-.I /dev/port
-.br
-.I /dev/tty1
 .SH "SEE ALSO"
 .BR date (1),
 .BR adjtimex (8),
