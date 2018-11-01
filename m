Return-Path: <SRS0=5PSr=NM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1BEC0044C
	for <util-linux@archiver.kernel.org>; Thu,  1 Nov 2018 18:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF94205F4
	for <util-linux@archiver.kernel.org>; Thu,  1 Nov 2018 18:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iBviRTTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF94205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeKBDO6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:14:58 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:53802 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbeKBDO6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 1 Nov 2018 23:14:58 -0400
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id DBBFB30C07D;
        Thu,  1 Nov 2018 11:10:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com DBBFB30C07D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1541095853;
        bh=ePb22TyTeumnfvP/sYf1jrDd3RJzfa5GH6JjvhJ9GJc=;
        h=From:To:Cc:Subject:Date:From;
        b=iBviRTTKhx3SERcQcV3LCOOIJuv+sw27gXYLjbBMq1TL46RoQssHXJR238wYs1IL9
         sjuL2Vf8e1So56J6nCKazYVaItb7bkdUGSk/5LnsG96ksCFEXXaqKdvt6tUuhzIBrB
         hdIoNEC+u+BZRvsjC/7ecrkMazM61/FX/tl2UtCg=
Received: from stbirv-lnx-2.igp.broadcom.net (stbirv-lnx-2.igp.broadcom.net [10.67.48.34])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 58D9CAC073F;
        Thu,  1 Nov 2018 11:10:54 -0700 (PDT)
Received: by stbirv-lnx-2.igp.broadcom.net (Postfix, from userid 47169)
        id 43FC927FA8B; Thu,  1 Nov 2018 11:10:53 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     util-linux@vger.kernel.org
Cc:     f.fainelli@gmail.com, Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH] rtcwake: use poweroff if shutdown is not found
Date:   Thu,  1 Nov 2018 11:10:38 -0700
Message-Id: <1541095838-3816-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Some systems do not have the shutdown command. Use poweroff as an
alternative.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 include/pathnames.h |  1 +
 sys-utils/rtcwake.c | 39 +++++++++++++++++++++++++++------------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index 3d5052e..ed8ea33 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -53,6 +53,7 @@
 # define _PATH_LOGIN		"/bin/login"
 #endif
 #define _PATH_SHUTDOWN		"/sbin/shutdown"
+#define _PATH_POWEROFF		"/sbin/poweroff"
 
 #define _PATH_TERMCOLORS_DIRNAME "terminal-colors.d"
 #define _PATH_TERMCOLORS_DIR	"/etc/" _PATH_TERMCOLORS_DIRNAME
diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index b63c646..029f00f 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -28,6 +28,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/types.h>
 #include <termios.h>
@@ -582,18 +583,32 @@ int main(int argc, char **argv)
 		char *arg[5];
 		int i = 0;
 
-		if (ctl.verbose)
-			printf(_("suspend mode: off; executing %s\n"),
-						_PATH_SHUTDOWN);
-		arg[i++] = _PATH_SHUTDOWN;
-		arg[i++] = "-h";
-		arg[i++] = "-P";
-		arg[i++] = "now";
-		arg[i]   = NULL;
-		if (!ctl.dryrun) {
-			execv(arg[0], arg);
-			warn(_("failed to execute %s"), _PATH_SHUTDOWN);
-			rc = EXIT_FAILURE;
+		if (!access(_PATH_SHUTDOWN, X_OK)) {
+			arg[i++] = _PATH_SHUTDOWN;
+			arg[i++] = "-h";
+			arg[i++] = "-P";
+			arg[i++] = "now";
+			arg[i]   = NULL;
+		} else if (!access(_PATH_POWEROFF, X_OK)) {
+			arg[i++] = _PATH_POWEROFF;
+			arg[i]   = NULL;
+		} else {
+			arg[i] 	 = NULL;
+		}
+
+		if (arg[0]) {
+			if (ctl.verbose)
+				printf(_("suspend mode: off; executing %s\n"),
+						arg[0]);
+			if (!ctl.dryrun) {
+				execv(arg[0], arg);
+				warn(_("failed to execute %s"), arg[0]);
+				rc = EX_EXEC_ENOENT;
+			}
+		} else {
+			/* Failed to find shutdown command */
+			warn(_("failed to find shutdown command"));
+			rc = EX_EXEC_ENOENT;
 		}
 		break;
 	}
-- 
2.7.4

