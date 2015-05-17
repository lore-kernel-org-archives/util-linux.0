Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33547 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbbEQR1u (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 May 2015 13:27:50 -0400
Received: by wicmx19 with SMTP id mx19so72988782wic.0
        for <util-linux@vger.kernel.org>; Sun, 17 May 2015 10:27:49 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] cal: fix January 1753 week number printout
Date: Sun, 17 May 2015 18:27:42 +0100
Message-Id: <1431883662-9121-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier output was clearly broken.

$ cal -w 1 1753
      January 1753
   Su Mo Tu We Th Fr Sa
51     1  2  3  4  5  6
52  7  8  9 10 11 12 13
52 14 15 16 17 18 19 20
52 21 22 23 24 25 26 27
52 28 29 30 31

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c           |  2 +-
 tests/expected/cal/jan1753 | 19 +++++++++++++++++++
 tests/ts/cal/jan1753       | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tests/expected/cal/jan1753
 create mode 100755 tests/ts/cal/jan1753

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index f1df759..548e567 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -609,7 +609,7 @@ static void cal_fill_month(struct cal_month *month, const struct cal_control *ct
 			else
 				month->weeks[i] = SPACE;
 			weeklines--;
-			if (52 < weeknum && i == 0)
+			if (i == 0 && (52 < weeknum || (month->year == 1753 && 51 < weeknum)))
 				weeknum = week_number(month->days[DAYS_IN_WEEK * (i + 1)], 1, month->year, ctl);
 			else if (52 < weeknum)
 				weeknum = week_number(31, 12, month->year, ctl);
diff --git a/tests/expected/cal/jan1753 b/tests/expected/cal/jan1753
new file mode 100644
index 0000000..d25ce9b
--- /dev/null
+++ b/tests/expected/cal/jan1753
@@ -0,0 +1,19 @@
+
+Monday-based 1753 week numbers
+     December 1752             January 1753            February 1753     
+   Mo Tu We Th Fr Sa Su     Mo Tu We Th Fr Sa Su     Mo Tu We Th Fr Sa Su
+47              1  2  3   1  1  2  3  4  5  6  7   5           1  2  3  4 
+48  4  5  6  7  8  9 10   2  8  9 10 11 12 13 14   6  5  6  7  8  9 10 11 
+49 11 12 13 14 15 16 17   3 15 16 17 18 19 20 21   7 12 13 14 15 16 17 18 
+50 18 19 20 21 22 23 24   4 22 23 24 25 26 27 28   8 19 20 21 22 23 24 25 
+51 25 26 27 28 29 30 31   5 29 30 31               9 26 27 28             
+                                                                          
+Sunday-based 1753 week numbers
+     December 1752             January 1753            February 1753     
+   Su Mo Tu We Th Fr Sa     Su Mo Tu We Th Fr Sa     Su Mo Tu We Th Fr Sa
+46                 1  2  51     1  2  3  4  5  6   4              1  2  3 
+47  3  4  5  6  7  8  9   1  7  8  9 10 11 12 13   5  4  5  6  7  8  9 10 
+48 10 11 12 13 14 15 16   2 14 15 16 17 18 19 20   6 11 12 13 14 15 16 17 
+49 17 18 19 20 21 22 23   3 21 22 23 24 25 26 27   7 18 19 20 21 22 23 24 
+50 24 25 26 27 28 29 30   4 28 29 30 31            8 25 26 27 28          
+51 31                                                                     
diff --git a/tests/ts/cal/jan1753 b/tests/ts/cal/jan1753
new file mode 100755
index 0000000..85dbf35
--- /dev/null
+++ b/tests/ts/cal/jan1753
@@ -0,0 +1,43 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="January 1753"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_CAL"
+
+export TERM=linux
+
+USETERM=$( ts_has_option "useterm" "$*" )
+MYMONTH="1 1753"
+
+[ "$USETERM" == "yes" ] && TS_VERBOSE="yes"
+ts_log ""
+
+ts_log "Monday-based 1753 week numbers"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -m3w $MYMONTH
+fi
+$TS_CMD_CAL -m3w $MYMONTH >> $TS_OUTPUT
+
+ts_log "Sunday-based 1753 week numbers"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -3w $MYMONTH
+fi
+$TS_CMD_CAL -3w $MYMONTH >> $TS_OUTPUT
+
+ts_finalize
-- 
2.4.1

