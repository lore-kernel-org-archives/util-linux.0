Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35292 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbdFHTwd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id g15so8876679wmc.2
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/11] lib: simplify cpuset if clauses that return
Date: Thu,  8 Jun 2017 20:52:14 +0100
Message-Id: <20170608195215.1702-11-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
References: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no need for 'else' when 'if' will return.  In same go move call of
tolower() to last possible moment in char_to_val(), a lot of time hex values
should hit 0-9 range, and it can be omitted.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/cpuset.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/cpuset.c b/lib/cpuset.c
index 6d82522f5..011b6882b 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -29,23 +29,21 @@ static inline int val_to_char(int v)
 {
 	if (v >= 0 && v < 10)
 		return '0' + v;
-	else if (v >= 10 && v < 16)
+	if (v >= 10 && v < 16)
 		return ('a' - 10) + v;
-	else
-		return -1;
+	return -1;
 }
 
 static inline int char_to_val(int c)
 {
 	int cl;
 
-	cl = tolower(c);
 	if (c >= '0' && c <= '9')
 		return c - '0';
-	else if (cl >= 'a' && cl <= 'f')
+	cl = tolower(c);
+	if (cl >= 'a' && cl <= 'f')
 		return cl + (10 - 'a');
-	else
-		return -1;
+	return -1;
 }
 
 static const char *nexttoken(const char *q,  int sep)
-- 
2.13.1

