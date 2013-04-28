Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34266 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab3D1RL2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 13:11:28 -0400
Received: by mail-wi0-f180.google.com with SMTP id h11so2069603wiv.7
        for <util-linux@vger.kernel.org>; Sun, 28 Apr 2013 10:11:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/11] cal: remove unnecessary initializations
Date: Sun, 28 Apr 2013 18:11:02 +0100
Message-Id: <1367169067-23705-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 8afa322..3d87f40 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -438,9 +438,6 @@ void headers_init(void)
 	int i, wd;
 	char *cur_dh = day_headings, *cur_j_dh = j_day_headings;
 
-	strcpy(day_headings, "");
-	strcpy(j_day_headings, "");
-
 	for (i = 0; i < DAYS_IN_WEEK; i++) {
 		ssize_t space_left;
 		wd = (i + weekstart) % DAYS_IN_WEEK;
@@ -585,8 +582,6 @@ j_yearly(int day, int year) {
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
 		day_array(day, i + 1, year, days[i]);
-	memset(lineout, ' ', sizeof(lineout) - 1);
-	lineout[sizeof(lineout) - 1] = '\0';
 	for (month = 0; month < MONTHS_IN_YEAR; month += 2) {
 		center(full_month[month], J_WEEK_LEN-1, J_HEAD_SEP+1);
 		center(full_month[month + 1], J_WEEK_LEN-1, 0);
@@ -623,8 +618,6 @@ yearly(int day, int year) {
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
 		day_array(day, i + 1, year, days[i]);
-	memset(lineout, ' ', sizeof(lineout) - 1);
-	lineout[sizeof(lineout) - 1] = '\0';
 	for (month = 0; month < MONTHS_IN_YEAR; month += 3) {
 		center(full_month[month], WEEK_LEN-1, HEAD_SEP+1);
 		center(full_month[month + 1], WEEK_LEN-1, HEAD_SEP+1);
-- 
1.8.2.2

