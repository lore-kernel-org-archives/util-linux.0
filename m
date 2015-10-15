Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:55569 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbbJONGG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 15 Oct 2015 09:06:06 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 945ADACA0
	for <util-linux@vger.kernel.org>; Thu, 15 Oct 2015 13:06:03 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] script: don't assume time_t is compatible with long
Date: Thu, 15 Oct 2015 15:06:04 +0200
Message-ID: <mvm37xcs2mb.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 term-utils/script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index eb4ddc3..ad252a3 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -141,7 +141,7 @@ static void script_init_debug(void)
 static inline time_t script_time(time_t *t)
 {
 	const char *str = getenv("SCRIPT_TEST_SECOND_SINCE_EPOCH");
-	time_t sec;
+	long sec;
 
 	if (str && sscanf(str, "%ld", &sec) == 1)
 		return sec;
-- 
2.6.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
