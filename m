Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:55530 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218AbbBNSMe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 14 Feb 2015 13:12:34 -0500
Received: from tenfore.ga-group.nl ([77.12.225.240]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0MBWTO-1YTt141Gas-00AVkH for
 <util-linux@vger.kernel.org>; Sat, 14 Feb 2015 19:12:32 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] fsck: fix warning, gcc 5.0
Date: Sat, 14 Feb 2015 19:12:30 +0100
Message-Id: <1423937550-2035-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1423937550-2035-1-git-send-email-sweet_f_a@gmx.de>
References: <1423937550-2035-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

disk-utils/fsck.c:1474:37: warning: logical not is only applied to
the left hand side of comparison [-Wlogical-not-parentheses]
         !strncmp(argv[i+1], "-", 1) == 0) {
                                     ^

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 78ad43e..8825f0e 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -1471,7 +1471,7 @@ static void parse_argv(int argc, char *argv[])
 					else
 						goto next_arg;
 				} else if ((i+1) < argc &&
-					   !strncmp(argv[i+1], "-", 1) == 0) {
+					   strncmp(argv[i+1], "-", 1) != 0) {
 					progress_fd = string_to_int(argv[i]);
 					if (progress_fd < 0)
 						progress_fd = 0;
-- 
1.8.4.5

