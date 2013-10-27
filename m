Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:49539 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523Ab3J0Umw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Oct 2013 16:42:52 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so5695844wgh.13
        for <util-linux@vger.kernel.org>; Sun, 27 Oct 2013 13:42:51 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/10] cal: simplify ascii_wnum() function
Date: Sun, 27 Oct 2013 20:42:30 +0000
Message-Id: <1382906556-16442-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Either the week is or isn't highlighted, there is no need to over
complicate printing of that.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index f8e3714..44c1af1 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -970,12 +970,9 @@ static char *ascii_day(char *p, int day, const struct cal_control *ctl)
 static char *ascii_wnum(char *p, int wnum, const struct cal_control *ctl)
 {
 	if ((ctl->wflag & WEEK_NUM_MASK) == wnum)
-		p += sprintf(p,"%s",Senter);
-	p += sprintf(p,"%2d",wnum);
-	if ((ctl->wflag & WEEK_NUM_MASK) == wnum)
-		p += sprintf(p,"%s ",Sexit);
+		p += sprintf(p, "%s%2d%s ", Senter, wnum, Sexit);
 	else
-		p += sprintf(p," ");
+		p += sprintf(p, "%2d ", wnum);
 	return p;
 }
 
-- 
1.8.4.1

