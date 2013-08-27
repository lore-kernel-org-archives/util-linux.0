Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f177.google.com ([209.85.215.177]:51764 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab3H0SHV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:07:21 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so2389444eak.8
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:07:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/17] last: fix --present option logic error
Date: Tue, 27 Aug 2013 19:06:16 +0100
Message-Id: <1377626779-26030-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Printing of sessions 'still logged in' was skipped because an error in
logic.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index c23469e..7ab27c9 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -293,7 +293,7 @@ static int list(struct utmp *p, time_t t, int what, time_t present)
 	 */
 	tmp = (time_t)p->ut_time;
 
-	if (present && (present < tmp || 0 == t || t < present))
+	if (present && (present < tmp || (0 < t && t < present)))
 		return 0;
 
 	strcpy(logintime, ctime(&tmp));
-- 
1.8.4

