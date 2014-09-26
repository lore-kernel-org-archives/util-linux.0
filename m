Return-Path: util-linux-owner@vger.kernel.org
Received: from mx-aarh-1.stofanet.dk ([212.10.10.11]:35596 "EHLO
	mx-aarh-1.stofanet.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbaIZQvf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 26 Sep 2014 12:51:35 -0400
Received: from 5634f347.rev.stofanet.dk ([86.52.243.71] helo=asrock)
	by mx-aarh-5.stofanet.dk (envelope-from
	<sgh@sgh.dk>)
	with esmtp id 1XXYUW-00046l-1m
	for util-linux@vger.kernel.org; Fri, 26 Sep 2014 18:35:32 +0200
From: =?UTF-8?q?S=C3=B8ren=20Holm?= <sgh@sgh.dk>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?S=C3=B8ren=20Holm?= <sgh@sgh.dk>
Subject: [PATCH] Don't return root if path contains // or ending /
Date: Fri, 26 Sep 2014 18:35:11 +0200
Message-Id: <1411749311-16666-1-git-send-email-sgh@sgh.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If the path fx. is /foo/bar/ the initial stripoff will replace the last slash
with \0 and return a pointer to that exact \0 character. The same thing will
happen if the path contains // somewhere.

Signed-off-by: Søren Holm <sgh@sgh.dk>
---
 libmount/src/tab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 011ba54..2b0a343 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -864,7 +864,7 @@ struct libmnt_fs *mnt_table_find_mountpoint(struct libmnt_table *tb,
 		}
 
 		p = stripoff_last_component(mnt);
-		if (!p || !*p)
+		if (!p)
 			break;
 	} while (mnt && *(mnt + 1) != '\0');
 
-- 
2.1.0

