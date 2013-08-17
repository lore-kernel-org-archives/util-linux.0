Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:64806 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSQs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:16:48 -0400
Received: by mail-we0-f169.google.com with SMTP id n5so2661890wev.28
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:16:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/16] last: use as narrow variable scoping as possible
Date: Sat, 17 Aug 2013 19:15:17 +0100
Message-Id: <1376763321-22782-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 63055a7..e94f1f0 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -259,7 +259,7 @@ static int list(struct utmp *p, time_t t, int what)
 	char		final[512];
 	char		utline[UT_LINESIZE+1];
 	char		domain[256];
-	char		*s, **walk;
+	char		*s;
 	int		mins, hours, days;
 	int		r, len;
 
@@ -277,6 +277,7 @@ static int list(struct utmp *p, time_t t, int what)
 	 *	Is this something we wanna show?
 	 */
 	if (show) {
+		char **walk;
 		for (walk = show; *walk; walk++) {
 			if (strncmp(p->ut_name, *walk, UT_NAMESIZE) == 0 ||
 			    strcmp(utline, *walk) == 0 ||
-- 
1.8.3.4

