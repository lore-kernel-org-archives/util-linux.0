Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:65367 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755837AbbBPMzj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Feb 2015 07:55:39 -0500
Message-ID: <54E1E8C3.30704@gmx.com>
Date: Mon, 16 Feb 2015 07:55:31 -0500
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH] hwclock: improve man-page language
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 7ddd2b1..b13be31 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -993,12 +993,13 @@ A discussion on date-time configuration would be incomplete without
 addressing timezones, this is mostly well covered by
 .BR tzset (3).
 One area that seems to have no documentation is the 'right'
-directory of the Time Zone Database, aka tz, aka zoneinfo.
+directory of the Time Zone Database, sometimes called tz or zoneinfo.
 .PP
 There are two separate databases in the zoneinfo system, posix
 and 'right'. 'Right' (now named zoneinfo\-leaps) includes leap seconds and posix
-does not. To use the 'right' database the System Clock must be kept in
-\%UTC\ +\ leap_seconds, i.e., \%TAI\ \-\ 10. This allows calculating the
+does not. To use the 'right' database the System Clock must be set to
+\%(UTC\ +\ leap seconds), which is equivalent to \%(TAI\ \-\ 10). This
+allows calculating the
 exact number of seconds between two dates that cross a leap second
 epoch. The System Clock is then converted to the correct civil time,
 including UTC, by using the 'right' timezone files which subtract the
