Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:48572 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbaLHWVA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Dec 2014 17:21:00 -0500
Received: by mail-wg0-f42.google.com with SMTP id z12so7425254wgg.29
        for <util-linux@vger.kernel.org>; Mon, 08 Dec 2014 14:20:59 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] lslogins: fix assertion failure for none existing logins
Date: Mon,  8 Dec 2014 22:20:55 +0000
Message-Id: <1418077256-24258-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This cange makes the following to retun none-zero value instead of a core
dump.

$ lslogins qwertyuiopasdfghjklzxcvbnm1234567
lslogins: libsmartcols/src/line.c:362: scols_line_get_cell: Assertion `ln' failed.
Aborted (core dumped)

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 7867404..38d3cf6 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -842,7 +842,7 @@ static int get_user(struct lslogins_control *ctl, struct lslogins_user **user,
 		    const char *username)
 {
 	*user = get_user_info(ctl, username);
-	if (!*user && errno)
+	if (!*user)
 		if (IS_REAL_ERRNO(errno))
 			return -1;
 	return 0;
-- 
2.1.3

