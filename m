Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40559 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab2AWObc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 23 Jan 2012 09:31:32 -0500
Received: by qadc10 with SMTP id c10so1814920qad.19
        for <util-linux@vger.kernel.org>; Mon, 23 Jan 2012 06:31:32 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] mount: define fallback selinux_warning macro with 2 params
Date: Mon, 23 Jan 2012 09:31:24 -0500
Message-Id: <1327329084-4273-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 sys-utils/mount.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 280bab0..7c11811 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -286,7 +286,7 @@ static void selinux_warning(struct libmnt_context *cxt, const char *tgt)
 	}
 }
 #else
-# define selinux_warning(_x)
+# define selinux_warning(_x, _y)
 #endif
 
 
-- 
1.7.8.4

