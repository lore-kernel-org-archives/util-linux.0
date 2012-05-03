Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53078 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758121Ab2ECTCE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:04 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E3877978B8
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:03 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 02/15] uuidd: remove useless initialization of cleanup_socket
Date: Thu,  3 May 2012 21:01:48 +0200
Message-Id: <1336071721-32492-3-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 80600f1..0d844fb 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -229,7 +229,6 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		exit(EXIT_FAILURE);
 	}
 	cleanup_pidfile = pidfile_path;
-	cleanup_socket = 0;
 	signal(SIGALRM, terminate_intr);
 	alarm(30);
 	fl.l_type = F_WRLCK;
-- 
1.7.7

