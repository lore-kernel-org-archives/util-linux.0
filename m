Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34889 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759010Ab2LIVJs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Dec 2012 16:09:48 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so857405wib.1
        for <util-linux@vger.kernel.org>; Sun, 09 Dec 2012 13:09:47 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/3] docs: swapon.8 option name fix
Date: Sun,  9 Dec 2012 21:08:35 +0000
Message-Id: <1355087316-12422-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355087316-12422-1-git-send-email-kerolasa@iki.fi>
References: <1355087316-12422-1-git-send-email-kerolasa@iki.fi>
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
1.8.0.1

