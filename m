Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:34259 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab3ATSFM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Jan 2013 13:05:12 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so3197313wgb.1
        for <util-linux@vger.kernel.org>; Sun, 20 Jan 2013 10:05:11 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/6] nsenter: fix compiler warning
Date: Sun, 20 Jan 2013 18:04:54 +0000
Message-Id: <1358705096-21092-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
References: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

nsenter.c:53:2: warning: ISO C forbids empty initializer braces [-pedantic]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/nsenter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index ec8600a..b83f457 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -50,7 +50,7 @@ static struct namespace_file{
 	{ .nstype = CLONE_NEWNET,  .name = "ns/net",  .fd = -1 },
 	{ .nstype = CLONE_NEWPID,  .name = "ns/pid",  .fd = -1 },
 	{ .nstype = CLONE_NEWNS,   .name = "ns/mnt",  .fd = -1 },
-	{}
+	{ .nstype = 0, .name = NULL, .fd = 0 }
 };
 
 static void usage(int status)
-- 
1.8.1.1

