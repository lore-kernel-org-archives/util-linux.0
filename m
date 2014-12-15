Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41686 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbaLOLvl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 15 Dec 2014 06:51:41 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so11536256pdi.31
        for <util-linux@vger.kernel.org>; Mon, 15 Dec 2014 03:51:41 -0800 (PST)
From: Will Johansson <will.johansson@gmail.com>
To: util-linux@vger.kernel.org
Cc: Will Johansson <will.johansson@gmail.com>
Subject: [PATCH] login-utils: Fix unused variables in login.c if _HAVE_UT_TV isn't defined
Date: Mon, 15 Dec 2014 03:51:29 -0800
Message-Id: <1418644289-46965-1-git-send-email-will.johansson@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Wrap around the variable declaration for `tv' with ifdef so the compilers
don't warn about unused variables if we're compiling without UT_TV. This
happens with the musl libc, since it doesn't define _HAVE_UT_TV, even
though it _does_ have the ut_tv field in the utmp struct.

Signed-off-by: Will Johansson <will.johansson@gmail.com>
---
 login-utils/login.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/login-utils/login.c b/login-utils/login.c
index 540554e..f07358f 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -429,7 +429,9 @@ static void init_tty(struct login_context *cxt)
 static void log_btmp(struct login_context *cxt)
 {
 	struct utmp ut;
+#if defined(_HAVE_UT_TV)        /* in <utmpbits.h> included by <utmp.h> */
 	struct timeval tv;
+#endif
 
 	memset(&ut, 0, sizeof(ut));
 
-- 
1.8.3.1

