Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33108 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab3KJSY5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:24:57 -0500
Received: by mail-wg0-f45.google.com with SMTP id x13so2730992wgg.12
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:24:56 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/13] cal: simplify ascii_weeknum() function
Date: Sun, 10 Nov 2013 18:23:32 +0000
Message-Id: <1384107820-498-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Either the week is or isn't highlighted, there is no need to over
complicate printing of that.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 748288d..c1bbdce 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -970,12 +970,9 @@ static char *ascii_day(char *p, int day, const struct cal_control *ctl)
 static char *ascii_weeknum(char *p, int weeknum, const struct cal_control *ctl)
 {
 	if ((ctl->weektype & WEEK_NUM_MASK) == weeknum)
-		p += sprintf(p,"%s",Senter);
-	p += sprintf(p,"%2d",weeknum);
-	if ((ctl->weektype & WEEK_NUM_MASK) == weeknum)
-		p += sprintf(p,"%s ",Sexit);
+		p += sprintf(p, "%s%2d%s ", Senter, weeknum, Sexit);
 	else
-		p += sprintf(p," ");
+		p += sprintf(p, "%2d ", weeknum);
 	return p;
 }
 
-- 
1.8.4.2

