Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:62075 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab3HCXPd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Aug 2013 19:15:33 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so1460245wgg.0
        for <util-linux@vger.kernel.org>; Sat, 03 Aug 2013 16:15:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/3] cal: set statically defined data read-only
Date: Sun,  4 Aug 2013 00:15:21 +0100
Message-Id: <1375571721-30008-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1375571721-30008-1-git-send-email-kerolasa@iki.fi>
References: <1375571721-30008-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index c4ed1d1..d31b51d 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -197,14 +197,14 @@ struct fmt_st
 	char s[FMT_ST_LINES][FMT_ST_CHARS];
 };
 
-static int days_in_month[2][13] = {
+static const int days_in_month[2][13] = {
 	{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
 	{0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
 };
 
 /* September 1752 is special, and has static assignments for both date
  * and Julian representations.  */
-static int d_sep1752[MAXDAYS / 2] = {
+static const int d_sep1752[MAXDAYS / 2] = {
 	SPACE,	SPACE,	1,	2,	14,	15,	16,
 	17,	18,	19,	20,	21,	22,	23,
 	24,	25,	26,	27,	28,	29,	30
@@ -658,7 +658,7 @@ static void yearly(int day, long year, int julian)
 static void day_array(int day, int month, long year, int *days)
 {
 	int julday, daynum, dw, dm;
-	int *sep1752;
+	const int *sep1752;
 
 	memcpy(days, empty, MAXDAYS * sizeof(int));
 	if (year == REFORMATION_YEAR && month == REFORMATION_MONTH) {
-- 
1.8.3.4

