Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:52648 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab3A1PVx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 28 Jan 2013 10:21:53 -0500
Message-ID: <5106978F.90202@bernhard-voelker.de>
Date: Mon, 28 Jan 2013 16:21:51 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] mount: fix bind mount success message
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From 94c87fbaf40a55e28bd99cbf236a28f1e494e02c Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Mon, 28 Jan 2013 16:20:24 +0100
Subject: [PATCH] mount: fix bind mount success message	

* sys-utils/mount.c (success_message): s/binded/bound/.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 sys-utils/mount.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index e98a688..0c74ed9 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -247,7 +247,7 @@ static void success_message(struct libmnt_context *cxt)
 	if (mflags & MS_MOVE)
 		printf(_("%s: %s moved to %s.\n"), pr, src, tgt);
 	else if (mflags & MS_BIND)
-		printf(_("%s: %s binded on %s.\n"), pr, src, tgt);
+		printf(_("%s: %s bound on %s.\n"), pr, src, tgt);
 	else if (mflags & MS_PROPAGATION) {
 		if (src && strcmp(src, "none") != 0 && tgt)
 			printf(_("%s: %s mounted on %s.\n"), pr, src, tgt);
-- 
1.7.7

