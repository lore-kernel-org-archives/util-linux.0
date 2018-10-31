Return-Path: <SRS0=wC18=NL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7BBC0044C
	for <util-linux@archiver.kernel.org>; Wed, 31 Oct 2018 19:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D772080A
	for <util-linux@archiver.kernel.org>; Wed, 31 Oct 2018 19:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="r0CiuoD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D772080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeKAEZd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:25:33 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:49418 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbeKAEZd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 1 Nov 2018 00:25:33 -0400
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 7A4AE30C042;
        Wed, 31 Oct 2018 12:26:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 7A4AE30C042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1541013966;
        bh=pc+dF2sUQqKjTbg8Gs2f6PYY3fGYybhEdsga1c2DqwM=;
        h=From:To:Cc:Subject:Date:From;
        b=r0CiuoD3y44VJFHo8TMDoimrTogXMnoa6sZCLmuurpAZy8CatrEYpbETdXgYh++nE
         bbEjn1Fg7iRmUPmWW8Tg89iwJ+sZ3GtLx7psENuzJmSi54fXd498oEe9FPYK+COdbH
         +1lKzU2x5zr97LD/JBs7B3+ZCda+WuiG0NgptyJg=
Received: from stbirv-lnx-2.igp.broadcom.net (stbirv-lnx-2.igp.broadcom.net [10.67.48.34])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id F1441AC0796;
        Wed, 31 Oct 2018 12:26:06 -0700 (PDT)
Received: by stbirv-lnx-2.igp.broadcom.net (Postfix, from userid 47169)
        id D124127FA8B; Wed, 31 Oct 2018 12:26:06 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     util-linux@vger.kernel.org
Cc:     f.fainelli@gmail.com, Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH] rtcwake: use poweroff if shutdown is not found
Date:   Wed, 31 Oct 2018 12:25:48 -0700
Message-Id: <1541013948-15403-1-git-send-email-justinpopo6@gmail.com>
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
 sys-utils/rtcwake.c | 38 +++++++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 11 deletions(-)

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
index b63c646..b79adbe 100644
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
@@ -579,20 +580,35 @@ int main(int argc, char **argv)
 		break;
 	case OFF_MODE:
 	{
+		struct stat buf;
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
+		if (!stat(_PATH_SHUTDOWN, &buf)) {
+			arg[i++] = _PATH_SHUTDOWN;
+			arg[i++] = "-h";
+			arg[i++] = "-P";
+			arg[i++] = "now";
+			arg[i]   = NULL;
+		} else if (!stat(_PATH_POWEROFF, &buf)) {
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
+				rc = EXIT_FAILURE;
+			}
+		} else {
+			/* Failed to find shutdown command */
+			warn(_("failed to find shutdown command"));
 			rc = EXIT_FAILURE;
 		}
 		break;
-- 
2.7.4

