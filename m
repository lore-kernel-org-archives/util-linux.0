Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57305 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759789AbbBIPLN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Feb 2015 10:11:13 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] cal: use int64_t instead of long
Date: Mon,  9 Feb 2015 16:11:01 +0100
Message-Id: <1423494662-2658-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1423494662-2658-1-git-send-email-sweet_f_a@gmx.de>
References: <1423494662-2658-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Followup 26f3a386, bigyear test was broken on ppc.

CC: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/cal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 593ab28..2311d01 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -59,6 +59,7 @@
 
 #include <ctype.h>
 #include <getopt.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -808,7 +809,7 @@ static int day_in_week(int day, int month, int32_t year)
 	if (REFORMATION_YEAR < year
 	    || (year == REFORMATION_YEAR && 9 < month)
 	    || (year == REFORMATION_YEAR && month == 9 && 13 < day)) {
-		long long_year = year;
+		int64_t long_year = year;
 		return (long_year + (year / 4) - (year / 100) + (year / 400) + reform[month - 1] +
 			day) % 7;
 	}
-- 
1.8.4.5

