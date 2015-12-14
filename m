Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34736 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbbLNVzJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Dec 2015 16:55:09 -0500
Received: by mail-wm0-f51.google.com with SMTP id p66so83324870wmp.1
        for <util-linux@vger.kernel.org>; Mon, 14 Dec 2015 13:55:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/8] setsid: fix argument count bug
Date: Mon, 14 Dec 2015 21:54:50 +0000
Message-Id: <1450130093-12108-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
References: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The below demonstrates what happen before this change.

$ setsid --wait
setsid: child 3252 did not exit normally: Success

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setsid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index 71d552f..1abf95b 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -89,7 +89,7 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}
 
-	if (argc < 2)
+	if (argc - optind < 1)
 		usage(stderr);
 
 	if (getpgrp() == getpid()) {
-- 
2.6.4

