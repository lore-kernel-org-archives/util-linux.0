Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:57657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbdHANVO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 09:21:14 -0400
Subject: [PATCH 6/8] hwclock: update man page
To: Karel Zak <kzak@redhat.com>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c32e76a0-04d0-f92e-bfc3-ca9720e49b5c@gmx.com>
Date: Tue, 1 Aug 2017 09:20:59 -0400
MIME-Version: 1.0
In-Reply-To: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Add information about setting the Hardware Clock if it has been
corrupted.

Add information about --update-drift and reduced system shutdown
times for --systohc.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index e0862c9..107e3f1 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -4,7 +4,7 @@
 .\"   Authored new section: DATE-TIME CONFIGURATION.
 .\"   Subsections: Keeping Time..., LOCAL vs UTC, POSIX vs 'RIGHT'.
 .\"
-.TH HWCLOCK 8 "April 2015" "util-linux" "System Administration"
+.TH HWCLOCK 8 "July 2017" "util-linux" "System Administration"
 .SH NAME
 hwclock \- time clocks utility
 .SH SYNOPSIS
@@ -197,8 +197,9 @@ Set the Hardware Clock to the time given by the
 option, and update the timestamps in
 .IR @ADJTIME_PATH@ .
 With the
-.B --update-drift
-option (re)calculate the drift factor.
+.B \%\-\-update-drift
+option also (re)calculate the drift factor.  Try it without the option if
+.BR \%\-\-set " fails.  See " \%\-\-update-drift " below."
 .
 .TP
 .B \-\-systz
@@ -234,9 +235,10 @@ changed then a reboot would be required to inform the kernel.
 .BR \-w , \ \-\-systohc
 Set the Hardware Clock from the System Clock, and update the timestamps in
 .IR @ADJTIME_PATH@ .
-When the
-.B --update-drift
-option is given, then also (re)calculate the drift factor.
+With the
+.B \%\-\-update-drift
+option also (re)calculate the drift factor.  Try it without the option if
+.BR \%\-\-systohc " fails.  See " \%\-\-update-drift " below."
 .
 .TP
 .BR \-V , \ \-\-version
@@ -404,6 +406,11 @@ on the drift factor.
 (Re)calculating drift factor on every shutdown delivers suboptimal
 results.  For example, if ephemeral conditions cause the machine to be
 abnormally hot the drift factor calculation would be out of range.
+.IP \(bu 2
+Significantly increased system shutdown times (as of v2.31 when not
+using
+.B \%\-\-update\-drift
+the RTC is not read).
 .PP
 .RB "Having " \%hwclock
 calculate the drift factor is a good starting point, but for optimal
@@ -414,6 +421,13 @@ crafted it should not need to be changed.  Therefore, the old behavior to
 automatically (re)calculate drift was changed and now requires this
 option to be used.  See the discussion below, under
 .BR "The Adjust Function" .
+.PP
+This option requires reading the Hardware Clock before setting it.  If
+it cannot be read, then this option will cause the set functions to fail.
+This can happen, for example, if the Hardware Clock is corrupted by a
+power failure.  In that case, the clock must first be set without this
+option.  Despite it not working, the resulting drift correction factor
+would be invalid anyway.
 .RE
 .
 .SH NOTES
