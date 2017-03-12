Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.130]:57287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933837AbdCLQts (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 12 Mar 2017 12:49:48 -0400
Received: from localhost ([91.7.170.176]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPSA (Nemesis) id
 0LaYX5-1cOB3X3un9-00mLqD for <util-linux@vger.kernel.org>; Sun, 12 Mar 2017
 17:49:45 +0100
Date: Sun, 12 Mar 2017 17:49:45 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] login: prevent OOB read on illegal /etc/hushlogins
Message-ID: <20170312164945.GB28165@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If the file /etc/hushlogins exists and a line starts with '\0', the
login tools are prone to an off-by-one read.

I see no reliability issue with this, as it would clearly need a
hostile action from a system administrator. But for the sake of
correctness, I've sent this patch nonetheless.
---
 login-utils/logindefs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/login-utils/logindefs.c b/login-utils/logindefs.c
index f02c4752d..213ff8d25 100644
--- a/login-utils/logindefs.c
+++ b/login-utils/logindefs.c
@@ -344,7 +344,8 @@ int get_hushlogin_status(struct passwd *pwd, int force_check)
 				continue;	/* ignore errors... */
 
 			while (ok == 0 && fgets(buf, sizeof(buf), f)) {
-				buf[strlen(buf) - 1] = '\0';
+				if (buf[0] != '\0')
+					buf[strlen(buf) - 1] = '\0';
 				ok = !strcmp(buf, *buf == '/' ? pwd->pw_shell :
 								pwd->pw_name);
 			}
-- 
2.12.0

