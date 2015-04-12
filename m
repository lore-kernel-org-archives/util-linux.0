Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:48508 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbbDLJG7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 12 Apr 2015 05:06:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id D50B33409AE
	for <util-linux@vger.kernel.org>; Sun, 12 Apr 2015 09:06:58 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] swapon: search for mkswap via PATH
Date: Sun, 12 Apr 2015 05:06:52 -0400
Message-Id: <1428829613-30423-2-git-send-email-vapier@gentoo.org>
In-Reply-To: <1428829613-30423-1-git-send-email-vapier@gentoo.org>
References: <1428829613-30423-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Rather than hardcode /sbin/mkswap all the time, use a normal PATH search.
This matches the normal behavior of other tools, and makes local testing
easier.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/swapon.8 | 2 +-
 sys-utils/swapon.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index e571a5f..299da22 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -108,7 +108,7 @@ may also be used to skip non-existing device.
 
 .TP
 .BR \-f , " \-\-fixpgsz"
-Reinitialize (exec /sbin/mkswap) the swap space if its page size does not
+Reinitialize (exec mkswap) the swap space if its page size does not
 match that of the current running kernel.
 .BR mkswap (2)
 initializes the whole device and does not check for bad blocks.
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 645a01d..561b1a9 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -28,8 +28,6 @@
 #include "swapprober.h"
 #include "swapon-common.h"
 
-#define PATH_MKSWAP	"/sbin/mkswap"
-
 #ifdef HAVE_SYS_SWAP_H
 # include <sys/swap.h>
 #endif
@@ -303,7 +301,7 @@ static int swap_reinitialize(const char *device,
 		return -1;
 
 	case 0:	/* child */
-		cmd[idx++] = PATH_MKSWAP;
+		cmd[idx++] = "mkswap";
 		if (label && *label) {
 			cmd[idx++] = "-L";
 			cmd[idx++] = (char *) label;
@@ -314,7 +312,7 @@ static int swap_reinitialize(const char *device,
 		}
 		cmd[idx++] = (char *) device;
 		cmd[idx++] = NULL;
-		execv(cmd[0], cmd);
+		execvp(cmd[0], cmd);
 		err(EXIT_FAILURE, _("failed to execute %s"), cmd[0]);
 
 	default: /* parent */
-- 
2.3.5

