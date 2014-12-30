Return-Path: util-linux-owner@vger.kernel.org
Received: from mta02.eastlink.ca ([24.224.136.13]:35743 "EHLO
	mta02.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbaL3Fc1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 30 Dec 2014 00:32:27 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta02.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NHC008H2OQ5F2P0@mta02.eastlink.ca> for
 util-linux@vger.kernel.org; Tue, 30 Dec 2014 01:02:25 -0400 (AST)
Received: from tesla ([10.0.0.17])	by llama.cordes.ca with esmtp
 (Exim 3.36 #1 (Debian))	id 1Y5owr-0001t7-00	for <util-linux@vger.kernel.org>;
 Tue, 30 Dec 2014 01:02:25 -0400
From: Peter Cordes <peter@cordes.ca>
To: util-linux@vger.kernel.org
Subject: [PATCH] fallocate: create mode 0666, that's what umask is for
Date: Tue, 30 Dec 2014 01:02:17 -0400
Message-id: <1419915737-27310-1-git-send-email-peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

User's umask will typically mask the mode down to 0664 or 0644.
---
 sys-utils/fallocate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 0e06524b8c5837a63230dc047233c657c50c1d7c..9af3bb8ce1492defda57cc17764197790bb34c8e 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -365,7 +365,7 @@ int main(int argc, char **argv)
 
 	/* O_CREAT makes sense only for the default fallocate(2) behavior
 	 * when mode is no specified and new space is allocated */
-	fd = open(filename, O_RDWR | (!dig && !mode ? O_CREAT : 0), 0644);
+	fd = open(filename, O_RDWR | (!dig && !mode ? O_CREAT : 0), 0666);
 	if (fd < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), filename);
 
-- 
2.2.1

