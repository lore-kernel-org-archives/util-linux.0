Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:46239 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbbBXRYe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 12:24:34 -0500
From: wfp5p@worldbroken.com
To: util-linux@vger.kernel.org
Subject: [PATCH 8/8] agetty.8: fix typo unnsupported -> unsupported
Date: Tue, 24 Feb 2015 12:15:23 -0500
Message-Id: <1424798123-11044-9-git-send-email-wfp5p@worldbroken.com>
In-Reply-To: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
References: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Bill Pemberton <wfp5p@worldbroken.com>

Signed-off-by: Bill Pemberton <wfp5p@worldbroken.com>
---
 term-utils/agetty.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 1652e0aef269..c4b7f13e2eb1 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -255,7 +255,7 @@ Run login with this priority.
 \-\-reload
 Ask all running agetty instances to reload and update their displayed prompts,
 if the user has not yet commenced logging in. After doing so the command will
-exit. This feature might be unnsupported on systems without Linux
+exit. This feature might be unsupported on systems without Linux
 .BR inotify (7).
 .TP
 \-\-version
-- 
2.1.0

