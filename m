Return-Path: util-linux-owner@vger.kernel.org
Received: from nymeria.archlinux.org ([89.238.67.251]:38521 "EHLO
	nymeria.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbaHUMxh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Aug 2014 08:53:37 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] mountpoint: drop S_ISDIR check
Date: Thu, 21 Aug 2014 08:48:12 -0400
Message-Id: <1408625292-2445-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Files can be mountpoints, too.
---
I can't find any reason for this check -- it seems to have existed since
mountpoint was added to the util-linux tree.

 sys-utils/mountpoint.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index cba5f01..3919ab7 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -192,12 +192,6 @@ int main(int argc, char **argv)
 	else {
 		dev_t src;
 
-		if (!S_ISDIR(st.st_mode)) {
-			if (!quiet)
-				errx(EXIT_FAILURE, _("%s: not a directory"), spec);
-			return EXIT_FAILURE;
-		}
-
 		if ( dir_to_device(spec, &src)) {
 			if (!quiet)
 				printf(_("%s is not a mountpoint\n"), spec);
-- 
2.1.0
