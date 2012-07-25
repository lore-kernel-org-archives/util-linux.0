Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34399 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab2GYTQG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:06 -0400
Received: by mail-wi0-f170.google.com with SMTP id hq12so4797543wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/19] libmount: add noreturn function attribute
Date: Wed, 25 Jul 2012 21:15:37 +0200
Message-Id: <1343243745-1172-20-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/lock.c b/libmount/src/lock.c
index 80ccdee..9f04725 100644
--- a/libmount/src/lock.c
+++ b/libmount/src/lock.c
@@ -589,7 +589,7 @@ void clean_lock(void)
 	mnt_free_lock(lock);
 }
 
-void sig_handler(int sig)
+void __attribute__((__noreturn__)) sig_handler(int sig)
 {
 	errx(EXIT_FAILURE, "\n%d: catch signal: %s\n", getpid(), strsignal(sig));
 }
-- 
1.7.11.3

