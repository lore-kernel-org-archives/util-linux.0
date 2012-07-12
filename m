Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50447 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544Ab2GLJTf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Jul 2012 05:19:35 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 955F9A3BA5
	for <util-linux@vger.kernel.org>; Thu, 12 Jul 2012 11:19:34 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] utmpdump: kill unused variable in follow_by_inotify()
Date: Thu, 12 Jul 2012 11:18:46 +0200
Message-Id: <1342084726-32579-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 login-utils/utmpdump.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 8af333a..1fa274e 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -142,7 +142,6 @@ done:
 static int follow_by_inotify(FILE *fp, const char *filename)
 {
 	char buf[NEVENTS * sizeof(struct inotify_event)];
-	struct utmp ut;
 	int fd, wd, event;
 	ssize_t length;
 	off_t size;
-- 
1.7.7

