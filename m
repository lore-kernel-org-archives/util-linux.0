Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32944 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeECV6F (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 3 May 2018 17:58:05 -0400
Received: by mail-wr0-f193.google.com with SMTP id o4-v6so19078973wrm.0
        for <util-linux@vger.kernel.org>; Thu, 03 May 2018 14:58:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] last: fix false positive compiler warning
Date: Thu,  3 May 2018 22:57:59 +0100
Message-Id: <20180503215759.3720-3-kerolasa@iki.fi>
In-Reply-To: <20180503215759.3720-1-kerolasa@iki.fi>
References: <20180503215759.3720-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

login-utils/last.c: In function ‘list’:
login-utils/last.c:398:36: warning: argument to ‘sizeof’ in ‘strncat’ call
is the same expression as the source; did you mean to use the size of the
destination?  [-Wsizeof-pointer-memaccess]
  strncat(utline, p->ut_line, sizeof(p->ut_line));

The sizeof(utline) is defined as sizeof(p->ut_line) + 1, so the compiler got
that wrong.  Lets truncate strncat() otherway around to keep gcc 8.1 happy.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 80d77d20b..59dfdb2f5 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -395,7 +395,7 @@ static int list(const struct last_control *ctl, struct utmpx *p, time_t logout_t
 	 *	uucp and ftp have special-type entries
 	 */
 	utline[0] = 0;
-	strncat(utline, p->ut_line, sizeof(p->ut_line));
+	strncat(utline, p->ut_line, sizeof(utline) - 1);
 	if (strncmp(utline, "ftp", 3) == 0 && isdigit(utline[3]))
 		utline[3] = 0;
 	if (strncmp(utline, "uucp", 4) == 0 && isdigit(utline[4]))
-- 
2.17.0

