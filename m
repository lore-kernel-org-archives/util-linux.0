Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:50012 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933106AbbA0W26 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Jan 2015 17:28:58 -0500
Received: by mail-we0-f175.google.com with SMTP id p10so17566795wes.6
        for <util-linux@vger.kernel.org>; Tue, 27 Jan 2015 14:28:57 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] more: fix repeat search crash
Date: Tue, 27 Jan 2015 22:28:57 +0000
Message-Id: <1422397737-9151-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Repeating a search for a pattern that did not found made more(1) to
crash.  To reproduce 'more /etc/services' and search for 'doom'; you will
find a service in port 666 - pressing '.' after that result used to cause
core dump.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/text-utils/more.c b/text-utils/more.c
index 74148a7..94b0455 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1605,6 +1605,8 @@ void search(char buf[], FILE *file, register int n)
 	context.line = saveln = Currline;
 	context.chrctr = startline;
 	lncount = 0;
+	if (!buf)
+		goto notfound;
 	if ((rc = regcomp(&re, buf, REG_NOSUB)) != 0) {
 		char s[REGERR_BUF];
 		regerror(rc, &re, s, sizeof s);
@@ -1661,6 +1663,7 @@ void search(char buf[], FILE *file, register int n)
 		}
 		free(previousre);
 		previousre = NULL;
+notfound:
 		more_error(_("Pattern not found"));
 	}
 }
-- 
2.2.2

