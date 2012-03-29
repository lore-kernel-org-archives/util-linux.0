Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50589 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759008Ab2C2Qpa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:30 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 3DEE08FB75
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:29 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/20] uuidd: remove useless initialization of cleanup_socket
Date: Thu, 29 Mar 2012 18:45:10 +0200
Message-Id: <1333039528-24784-3-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index ffb7319..28648ad 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -228,7 +228,6 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		exit(EXIT_FAILURE);
 	}
 	cleanup_pidfile = pidfile_path;
-	cleanup_socket = 0;
 	signal(SIGALRM, terminate_intr);
 	alarm(30);
 	fl.l_type = F_WRLCK;
-- 
1.7.7

