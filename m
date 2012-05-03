Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53095 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758214Ab2ECTCL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:11 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B2C2F97BB4
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:10 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 11/15] libuuid: use EXIT_FAILURE
Date: Thu,  3 May 2012 21:01:57 +0200
Message-Id: <1336071721-32492-12-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libuuid/src/gen_uuid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index caa240e..8c102b1 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -416,7 +416,7 @@ static int get_uuid_via_daemon(int op, uuid_t out, int *num)
 				close_all_fds();
 				execl(uuidd_path, "uuidd", "-qT", "300",
 				      (char *) NULL);
-				exit(1);
+				exit(EXIT_FAILURE);
 			}
 			(void) waitpid(pid, 0, 0);
 			if (connect(s, (const struct sockaddr *) &srv_addr,
-- 
1.7.7

