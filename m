Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34927 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbcCMKcC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2016 06:32:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id n205so9980172wmf.2
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 03:32:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/10] setsid: fix argument count bug
Date: Sun, 13 Mar 2016 10:31:44 +0000
Message-Id: <1457865109-2881-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
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
index adc34ec..bb089df 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -83,7 +83,7 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}
 
-	if (argc < 2)
+	if (argc - optind < 1)
 		usage(stderr);
 
 	if (getpgrp() == getpid()) {
-- 
2.7.2

