Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:49216 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757091AbcLAIwV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:52:21 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Ondrej Oprala <ooprala@redhat.com>
Subject: [PATCH 03/11] lslogins: remove useless strlen()
Date: Thu,  1 Dec 2016 09:52:06 +0100
Message-Id: <1480582332-17407-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

strlen() is not smarter than strncpy(). Bytes that follow a null byte
are not compared anyway.

BTW avoid using the defined sizes.

CC: Ondrej Oprala <ooprala@redhat.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/lslogins.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 78d4ed4..4109876 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -413,16 +413,14 @@ again:
 static struct utmp *get_last_wtmp(struct lslogins_control *ctl, const char *username)
 {
 	size_t n = 0;
-	size_t len;
 
 	if (!username)
 		return NULL;
 
-	len = strlen(username);
 	n = ctl->wtmp_size - 1;
 	do {
 		if (!strncmp(username, ctl->wtmp[n].ut_user,
-		    len < UT_NAMESIZE ? len : UT_NAMESIZE))
+		             sizeof(ctl->wtmp[0].ut_user)))
 			return ctl->wtmp + n;
 	} while (n--);
 	return NULL;
@@ -450,16 +448,14 @@ static int require_btmp(void)
 static struct utmp *get_last_btmp(struct lslogins_control *ctl, const char *username)
 {
 	size_t n = 0;
-	size_t len;
 
 	if (!username)
 		return NULL;
 
-	len = strlen(username);
 	n = ctl->btmp_size - 1;
 	do {
 		if (!strncmp(username, ctl->btmp[n].ut_user,
-		    len < UT_NAMESIZE ? len : UT_NAMESIZE))
+		             sizeof(ctl->wtmp[0].ut_user)))
 			return ctl->btmp + n;
 	}while (n--);
 	return NULL;
-- 
1.8.5.6

