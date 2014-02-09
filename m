Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:52962 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaBIRVE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Feb 2014 12:21:04 -0500
Received: by mail-wg0-f50.google.com with SMTP id l18so3499246wgh.17
        for <util-linux@vger.kernel.org>; Sun, 09 Feb 2014 09:21:02 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] cal: remove unnecessary static variables
Date: Sun,  9 Feb 2014 17:20:29 +0000
Message-Id: <1391966429-28219-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Not in use since commit 95f4adde867492563167b11ba94dba67f93809aa.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 0f40111..747694d 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -200,25 +200,6 @@ static const int days_in_month[2][13] = {
 	{0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
 };
 
-/* September 1752 is special, and has static assignments for both date
- * and Julian representations.  */
-static const int d_sep1752[MAXDAYS / 2] = {
-	SPACE,	SPACE,	1,	2,	14,	15,	16,
-	17,	18,	19,	20,	21,	22,	23,
-	24,	25,	26,	27,	28,	29,	30
-}, j_sep1752[MAXDAYS / 2] = {
-	SPACE,	SPACE,	245,	246,	258,	259,	260,
-	261,	262,	263,	264,	265,	266,	267,
-	268,	269,	270,	271,	272,	273,	274
-}, empty[MAXDAYS] = {
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE
-};
-
 enum {
 	WEEK_NUM_DISABLED = 0,
 	WEEK_NUM_MASK=0xff,
-- 
1.8.5.4

