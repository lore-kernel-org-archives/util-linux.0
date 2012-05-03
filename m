Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53081 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755646Ab2ECTCG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:06 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 0EBE79664A
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:06 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 05/15] uuidd: use ignore_result helper
Date: Thu,  3 May 2012 21:01:51 +0200
Message-Id: <1336071721-32492-6-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index be3e3cf..50ae61f 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -34,6 +34,7 @@ extern int optind;
 #include "uuid.h"
 #include "uuidd.h"
 #include "writeall.h"
+#include "c.h"
 
 #include "closestream.h"
 #include "nls.h"
@@ -327,9 +328,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 
 	if (pidfile_path) {
 		sprintf(reply_buf, "%8d\n", getpid());
-		if (ftruncate(fd_pidfile, 0)) {
-			/* Silence warn_unused_result */
-		}
+		ignore_result( ftruncate(fd_pidfile, 0) );
 		write_all(fd_pidfile, reply_buf, strlen(reply_buf));
 		if (fd_pidfile > 1)
 			close(fd_pidfile); /* Unlock the pid file */
-- 
1.7.7

