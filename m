Return-Path: elseifthen@gmx.com
Message-ID: <550339DA.1060408@gmx.com>
Date: Fri, 13 Mar 2015 15:26:18 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 5/5] hwclock: man-page errata
References: <5503364E.6010302@gmx.com>
In-Reply-To: <5503364E.6010302@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

The information I wrote regarding clock crystals was not
only incomplete, it was wrong. The characteristics of
quartz crystals is beyond the scope of this man-page. It
was misguided to attempt to include it. This commit
removes said information.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 8cf86a3..79c7907 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -938,28 +938,6 @@ Clock is corrected properly at startup.  To check this, first make sure
 that the System Time is correct before shutdown and then use
 .BR \%sntp ", or " \%date\ \-Ins
 and a precision timepiece, immediately after startup.
-.PP
-Both clocks typically use a quartz crystal oscillator.  Crystals are
-used for reference oscillators in electronics because by most measures
-they produce a very clean and stable sine wave.  Their greatest
-shortcoming is that they have a Positive Temperature Coefficient;
-meaning that their frequency increases as the temperature increases and
-vise versa. Therefore, both the Hardware and System Clock's drift rate
-changes with intrinsic and extrinsic machine temperatures.  These
-characteristics will vary by machine depending upon its design.
-.PP
-Drift correction strategies are many, but as a general guide the goal
-would be to find a longterm average.  A year long average to take into
-account seasonal ambient temperature shifts may be a good target period.
-So perhaps the date-time advances a bit in the summer and declines a bit
-in the winter, but at the end of a year it balances to zero.
-.PP
-If this is beginning to sound futile, it is not.  Left on its own a
-machine can lose 3 seconds per day or more.  Accumulated drift over a
-year may easily exceed half an hour.  Using carefully crafted drift
-corrections can make a significant improvement in a machine's ability to
-keep reasonably good date-time.
-.
 .SS LOCAL vs UTC
 Keeping the Hardware Clock in a local timescale causes inconsistent
 daylight saving time results:
