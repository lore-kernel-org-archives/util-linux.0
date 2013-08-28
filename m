Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f180.google.com ([209.85.215.180]:62381 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab3H1Szl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 28 Aug 2013 14:55:41 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so3138729eaj.39
        for <util-linux@vger.kernel.org>; Wed, 28 Aug 2013 11:55:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 18/21] last: never restrict session time
Date: Wed, 28 Aug 2013 19:55:21 +0100
Message-Id: <1377716124-12491-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When a session time will reach whopping 10000 days the last round bracket
is unnecessarily removed from output.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 4733c64..23cc8aa 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -462,7 +462,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 	if (ctl->showhost) {
 		if (!ctl->altlist) {
 			len = snprintf(final, sizeof(final),
-				"%-8.*s %-12.12s %-16.*s %-*.*s %-*.*s %-12.12s\n",
+				"%-8.*s %-12.12s %-16.*s %-*.*s %-*.*s %s\n",
 				ctl->name_len, p->ut_name, utline,
 				ctl->domain_len, domain,
 				tftl[ctl->time_fmt].in, tftl[ctl->time_fmt].in, logintime,
@@ -478,7 +478,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 		}
 	} else
 		len = snprintf(final, sizeof(final),
-			"%-8.*s %-12.12s %-*.*s %-*.*s %-12.12s\n",
+			"%-8.*s %-12.12s %-*.*s %-*.*s %s\n",
 			ctl->name_len, p->ut_name, utline,
 			tftl[ctl->time_fmt].in, tftl[ctl->time_fmt].in, logintime,
 			tftl[ctl->time_fmt].out, tftl[ctl->time_fmt].out, logouttime,
-- 
1.8.4

