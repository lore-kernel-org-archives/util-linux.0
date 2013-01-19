Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:39773 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742Ab3ASAJ5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:57 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so3442158wib.7
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:56 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 17/22] docs: mkswap.8: recommend fallocate(1)
Date: Sat, 19 Jan 2013 00:09:06 +0000
Message-Id: <1358554151-25985-18-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no reason why fallocate(1) should not be preferred instead of
'dd if=/dev/zero of=swapfile' with it's cumbersome size spec.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/mkswap.8 b/disk-utils/mkswap.8
index 219c49f..ab8a44a 100644
--- a/disk-utils/mkswap.8
+++ b/disk-utils/mkswap.8
@@ -130,7 +130,7 @@ e.g. using a command like
 
 .nf
 .RS
-# dd if=/dev/zero of=swapfile bs=1024 count=65536
+# fallocate -l 8GB swapfile
 .RE
 .fi
 
-- 
1.8.1.1

