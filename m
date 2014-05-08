Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50680 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569AbaEHKKS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 May 2014 06:10:18 -0400
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Werner Fink <werner@suse.de>, Ruediger Meier <sweet_f_a@gmx.de>
Subject: [PATCH 2/4] Enable sulogin to find a suitable console device even if the first line in /proc/consoles does not have any major and minor number.
Date: Thu,  8 May 2014 12:09:23 +0200
Message-Id: <1399543765-31106-2-git-send-email-werner@suse.de>
In-Reply-To: <1399543765-31106-1-git-send-email-werner@suse.de>
References: <1399543765-31106-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Enable sulogin to find a suitable console device even if the first line
in /proc/consoles does not have any major and minor number.

Signed-off-by: Werner Fink <werner@suse.de>
---
 login-utils/sulogin-consoles.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git login-utils/sulogin-consoles.c login-utils/sulogin-consoles.c
index 6ceea6b..817a882 100644
--- login-utils/sulogin-consoles.c
+++ login-utils/sulogin-consoles.c
@@ -324,7 +324,7 @@ static int detect_consoles_from_proc(struct list_head *consoles)
 	char fbuf[16 + 1];
 	DIR *dir = NULL;
 	FILE *fc = NULL;
-	int maj, min, rc = 1;
+	int maj, min, rc = 1, matches;
 
 	DBG(dbgprint("trying /proc"));
 
@@ -337,10 +337,12 @@ static int detect_consoles_from_proc(struct list_head *consoles)
 	if (!dir)
 		goto done;
 
-	while (fscanf(fc, "%*s %*s (%16[^)]) %d:%d", fbuf, &maj, &min) == 3) {
+	while ((matches = fscanf(fc, "%*s %*s (%16[^)]) %d:%d", fbuf, &maj, &min)) >= 1) {
 		char *name;
 		dev_t comparedev;
 
+		if (matches != 3)
+			continue;
 		if (!strchr(fbuf, 'E'))
 			continue;
 		comparedev = makedev(maj, min);
-- 
1.7.9.2

