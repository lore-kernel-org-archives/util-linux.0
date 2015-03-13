Return-Path: elseifthen@gmx.com
Message-ID: <550337F0.3050100@gmx.com>
Date: Fri, 13 Mar 2015 15:18:08 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 3/5] hwclock: remove depreciated ntpdate
References: <5503364E.6010302@gmx.com>
In-Reply-To: <5503364E.6010302@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

Replace references to the depreciated ntpdate with sntp.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 51367a4..0c294af 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -888,7 +888,7 @@ would be
 .BR \%adjtimex 's " \-\-log " options.
 .PP
 It may be more effective to simply track the System Clock drift with
-.BR \%ntpdate\ \-q " , or " \%date\ \-Ins
+.BR \%sntp ", or " \%date\ \-Ins
 and a precision timepiece, and then calculate the correction manually.
 .PP
 After setting the tick and frequency values, continue to test and refine the
@@ -931,7 +931,7 @@ results it will likely need to be adjusted by directly editing the
 file.  Continue to test and refine the drift factor until the Hardware
 Clock is corrected properly at startup.  To check this, first make sure
 that the System Time is correct before shutdown and then use
-.BR \%ntpdate\ \-q ", or " \%date\ \-Ins
+.BR \%sntp ", or " \%date\ \-Ins
 and a precision timepiece, immediately after startup.
 .PP
 Both clocks typically use a quartz crystal oscillator.  Crystals are
