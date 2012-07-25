Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:63323 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab2GYTPz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:55 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so794233wey.19
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/19] lslocks: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:26 +0200
Message-Id: <1343243745-1172-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

misc-utils/lslocks.c:157:49: warning: declaration of 'pid' shadows a global declaration [-Wshadow]
misc-utils/lslocks.c:80:14: warning: shadowed declaration is here [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/lslocks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index 094224d..56855f4 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -104,12 +104,12 @@ static void disable_columns_truncate(void)
 /*
  * Return a PID's command name
  */
-static char *get_cmdname(pid_t pid)
+static char *get_cmdname(pid_t qpid)
 {
 	FILE *fp;
 	char path[PATH_MAX], *ret = NULL;
 
-	sprintf(path, "/proc/%d/comm", pid);
+	sprintf(path, "/proc/%d/comm", qpid);
 	if (!(fp = fopen(path, "r")))
 		return NULL;
 
-- 
1.7.11.3

