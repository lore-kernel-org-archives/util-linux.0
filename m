Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:48049 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934101AbaEKT1F (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:27:05 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so5915151wes.37
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:27:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/12] logger: check numeric priority and facility input values
Date: Sun, 11 May 2014 20:26:42 +0100
Message-Id: <1399836409-7769-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier use of unknown facility or priority number was accepted, and
resulted in unexpected result.  For example when looking journalctl
--priority=7.8 was converted to priotity 0 and facility 1.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index fccba38..b7f9064 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -99,9 +99,20 @@ static int decode(char *name, CODE *codetab)
 {
 	register CODE *c;
 
-	if (isdigit(*name))
-		return (atoi(name));
-
+	if (name == NULL || *name == '\0')
+		return -1;
+	if (isdigit(*name)) {
+		int num;
+		char *end = NULL;
+
+		num = strtol(name, &end, 10);
+		if (errno || name == end || (end && *end))
+			return -1;
+		for (c = codetab; c->c_name; c++)
+			if (num == c->c_val)
+				return num;
+		return -1;
+	}
 	for (c = codetab; c->c_name; c++)
 		if (!strcasecmp(name, c->c_name))
 			return (c->c_val);
-- 
1.9.2

