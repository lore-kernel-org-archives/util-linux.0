Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36605 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbcLRScp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 18 Dec 2016 13:32:45 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so14824888wma.3
        for <util-linux@vger.kernel.org>; Sun, 18 Dec 2016 10:32:45 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] fsfreeze: remove unnecessary functions
Date: Sun, 18 Dec 2016 18:32:40 +0000
Message-Id: <20161218183241.1826-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/fsfreeze.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sys-utils/fsfreeze.c b/sys-utils/fsfreeze.c
index d4d5bd3df..a9b32aa66 100644
--- a/sys-utils/fsfreeze.c
+++ b/sys-utils/fsfreeze.c
@@ -33,16 +33,6 @@ enum fs_operation {
 	UNFREEZE
 };
 
-static int freeze_f(int fd)
-{
-	return ioctl(fd, FIFREEZE, 0);
-}
-
-static int unfreeze_f(int fd)
-{
-	return ioctl(fd, FITHAW, 0);
-}
-
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fprintf(out, USAGE_HEADER);
@@ -139,13 +129,13 @@ int main(int argc, char **argv)
 
 	switch (action) {
 	case FREEZE:
-		if (freeze_f(fd)) {
+		if (ioctl(fd, FIFREEZE, 0)) {
 			warn(_("%s: freeze failed"), path);
 			goto done;
 		}
 		break;
 	case UNFREEZE:
-		if (unfreeze_f(fd)) {
+		if (ioctl(fd, FITHAW, 0)) {
 			warn(_("%s: unfreeze failed"), path);
 			goto done;
 		}
-- 
2.11.0

