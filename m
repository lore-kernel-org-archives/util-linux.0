Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:37082 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbaGMUZJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:09 -0400
Received: by mail-wg0-f47.google.com with SMTP id b13so1144446wgh.30
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/14] cal: remove unnused structure and definition
Date: Sun, 13 Jul 2014 21:24:41 +0100
Message-Id: <1405283093-28182-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 1004266..a11136a 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -187,12 +187,7 @@ enum {
 
 #define TODAY_FLAG		0x400		/* flag day for highlighting */
 
-#define FMT_ST_LINES 9
 #define FMT_ST_CHARS 300	/* 90 suffices in most locales */
-struct fmt_st
-{
-	char s[FMT_ST_LINES][FMT_ST_CHARS];
-};
 
 static const int days_in_month[2][13] = {
 	{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
-- 
2.0.1

