Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:60686 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbeAVMB3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Jan 2018 07:01:29 -0500
Subject: [PATCH 1/2] cal: fix week calculations for 1752
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <a6d50a7c-6938-6f29-a983-039c5a422a7f@gmx.com>
Date: Mon, 22 Jan 2018 07:01:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Before:
cal --week=39 1752
     September 1752
   Su Mo Tu We Th Fr Sa
36        1  2 14 15 16
37 17 18 19 20 21 22 23
38 24 25 26 27 28 29 30

Patched:
cal --week=39 1752
      October 1752
   Su Mo Tu We Th Fr Sa
39  1  2  3  4  5  6  7
40  8  9 10 11 12 13 14
41 15 16 17 18 19 20 21
42 22 23 24 25 26 27 28
43 29 30 31

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index a854eaf9d..1b03857f6 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -997,6 +997,9 @@ static int week_to_day(const struct cal_control *ctl)
 	wday = day_in_week(ctl, 1, JANUARY, ctl->req.year);
 	yday = ctl->req.week * DAYS_IN_WEEK - wday;
 
+	if (ctl->req.year == ctl->reform_year && yday >= YDAY_AFTER_MISSING)
+		yday += NUMBER_MISSING_DAYS;
+
 	if (ctl->weektype & WEEK_NUM_ISO)
 		yday -= (wday >= FRIDAY ? -2 : 5);
 	else
