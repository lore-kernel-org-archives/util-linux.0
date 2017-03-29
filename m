Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33131 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932827AbdC2VfM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 29 Mar 2017 17:35:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id u18so6738933wrc.0
        for <util-linux@vger.kernel.org>; Wed, 29 Mar 2017 14:35:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] utmpdump: remove unnecessary variable
Date: Wed, 29 Mar 2017 22:35:05 +0100
Message-Id: <20170329213505.4857-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/utmpdump.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 02e13ea88..fb07e19d0 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -268,7 +268,6 @@ static void undump(FILE *in, FILE *out)
 {
 	struct utmpx ut;
 	char s_addr[INET6_ADDRSTRLEN + 1], s_time[29], *linestart, *line;
-	int count = 0;
 
 	linestart = xmalloc(1024 * sizeof(*linestart));
 	s_time[28] = 0;
@@ -293,8 +292,6 @@ static void undump(FILE *in, FILE *out)
 		ut.ut_tv.tv_usec = strtousec(s_time);
 
 		ignore_result( fwrite(&ut, sizeof(ut), 1, out) );
-
-		++count;
 	}
 
 	free(linestart);
-- 
2.12.2

