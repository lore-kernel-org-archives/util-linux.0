Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:63506 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755505AbcCUNEu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Mar 2016 09:04:50 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Werner Fink <werner@suse.de>
Subject: [PATCH 3/5] sulogin: ignore missing WEXITED, add warning
Date: Mon, 21 Mar 2016 14:04:43 +0100
Message-Id: <1458565485-27856-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
References: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <rudi@localhost>

This happens on Debian kFreeBSD and probably on Hurd too since
cde7699c. One should review this issue to fix it properly.

CC: Werner Fink <werner@suse.de>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/sulogin.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index b2c778a..c6d17b3 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -80,6 +80,11 @@ static volatile sig_atomic_t sigchild;
 # define IUCLC		0
 #endif
 
+#ifndef WEXITED
+# warning "WEXITED is missing, sulogin may not work as expected"
+# define WEXITED 0
+#endif
+
 static int locked_account_password(const char *passwd)
 {
 	if (passwd && (*passwd == '*' || *passwd == '!'))
-- 
1.8.4.5

