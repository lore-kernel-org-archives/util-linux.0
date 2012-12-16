Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:57639 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab2LPKoK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:10 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so2061699wgb.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:09 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/14] docs: swapon.8 option name fix
Date: Sun, 16 Dec 2012 10:43:49 +0000
Message-Id: <1355654642-22106-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The commit 7ae8b469adda598fda28e4ea647d47905b43e172 added option --bytes,
not the initial proposal which was changed after maillist discussion.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index 2fbf855..be1f34a 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -182,7 +182,7 @@ Display
 .B \-\-show
 output without aligning table columns.
 .TP
-.B \-\-inhuman
+.B \-\-bytes
 Display swap size in bytes in
 .B \-\-show
 output instead of user friendly size and unit.
-- 
1.8.0.2

