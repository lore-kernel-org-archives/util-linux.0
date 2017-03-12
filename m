Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.135]:55016 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933837AbdCLQvC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 12 Mar 2017 12:51:02 -0400
Received: from localhost ([91.7.170.176]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPSA (Nemesis) id
 0MIj6a-1cpIZH1rDM-002EaE for <util-linux@vger.kernel.org>; Sun, 12 Mar 2017
 17:50:59 +0100
Date: Sun, 12 Mar 2017 17:51:00 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] last: Always terminate domain with '\0'
Message-ID: <20170312165059.GC28165@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Although in a practical sense, the stack will most likely be filled
with zeros when the function is called, the C language requires an
explicit '\0' termination which strncat() does not guarantee.

While at it, I replaced strncat with strncpy because that's what the
program logic wants to do here.
---
 login-utils/last.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 340705757..ddbdd84a3 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -507,8 +507,8 @@ static int list(const struct last_control *ctl, struct utmpx *p, time_t logout_t
 	if (r < 0) {
 		len = sizeof(p->ut_host);
 		if (len >= (int)sizeof(domain)) len = sizeof(domain) - 1;
-		domain[0] = 0;
-		strncat(domain, p->ut_host, len);
+		strncpy(domain, p->ut_host, len);
+		domain[len] = 0;
 	}
 
 
-- 
2.12.0

