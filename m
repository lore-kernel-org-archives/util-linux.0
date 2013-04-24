Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:33430 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757052Ab3DXDXR (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 23 Apr 2013 23:23:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id D9DD133DC57
	for <util-linux-ng@vger.kernel.org>; Wed, 24 Apr 2013 03:23:16 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH] rtcwake: pass -h to shutdown
Date: Tue, 23 Apr 2013 23:23:21 -0400
Message-Id: <1366773801-8246-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The sysvinit shutdown requires you use -h when using -H or -P.
Other inits just don't seem to care.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/rtcwake.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index f2efc87..eedf78d 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -569,13 +569,14 @@ int main(int argc, char **argv)
 		dryrun = 1;	/* to skip disabling alarm at the end */
 
 	} else if (strcmp(suspend, "off") == 0) {
-		char *arg[4];
+		char *arg[5];
 		int i = 0;
 
 		if (verbose)
 			printf(_("suspend mode: off; executing %s\n"),
 						_PATH_SHUTDOWN);
 		arg[i++] = _PATH_SHUTDOWN;
+		arg[i++] = "-h";
 		arg[i++] = "-P";
 		arg[i++] = "now";
 		arg[i]   = NULL;
-- 
1.8.2.1

