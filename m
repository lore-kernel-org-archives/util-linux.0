Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50624 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759115Ab2C2Qpq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:46 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id CBB9390B1D
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:45 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 14/20] libuuid: use EXIT_FAILURE
Date: Thu, 29 Mar 2012 18:45:22 +0200
Message-Id: <1333039528-24784-15-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libuuid/src/gen_uuid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 492bb75..29211b9 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -517,7 +517,7 @@ static int get_uuid_via_daemon(int op, uuid_t out, int *num)
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

