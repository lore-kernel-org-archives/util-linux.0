Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:38506 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab3BTVbS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 20 Feb 2013 16:31:18 -0500
Received: by mail-we0-f182.google.com with SMTP id t57so7169823wey.13
        for <util-linux@vger.kernel.org>; Wed, 20 Feb 2013 13:31:15 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] login: remove file descriptor leak [cppcheck]
Date: Wed, 20 Feb 2013 21:31:09 +0000
Message-Id: <1361395869-2959-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[login-utils/login.c:510]: (error) Resource leak: fd

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/login.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index a17083b..4250534 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -506,8 +506,10 @@ static void log_lastlog(struct login_context *cxt)
 	if (fd < 0)
 		return;
 
-	if (lseek(fd, (off_t) cxt->pwd->pw_uid * sizeof(ll), SEEK_SET) == -1)
+	if (lseek(fd, (off_t) cxt->pwd->pw_uid * sizeof(ll), SEEK_SET) == -1) {
+		close(fd);
 		return;
+	}
 
 	/*
 	 * Print last log message
-- 
1.8.1.4

