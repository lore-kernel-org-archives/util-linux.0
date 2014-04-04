Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f47.google.com ([209.85.160.47]:41082 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbaDDNBk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 4 Apr 2014 09:01:40 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so3400513pbc.6
        for <util-linux@vger.kernel.org>; Fri, 04 Apr 2014 06:01:39 -0700 (PDT)
From: Jonathan Liu <net147@gmail.com>
To: util-linux@vger.kernel.org
Cc: Jonathan Liu <net147@gmail.com>
Subject: [PATCH] umount: fix typo in usage
Date: Sat,  5 Apr 2014 00:08:01 +1100
Message-Id: <1396616881-30759-1-git-send-email-net147@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 sys-utils/umount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index fe120db..f3bac0f 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -80,7 +80,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all               unmount all filesystems\n"), out);
-	fputs(_(" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+	fputs(_(" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 	        "                           current namespace\n"), out);
 	fputs(_(" -c, --no-canonicalize   don't canonicalize paths\n"), out);
 	fputs(_(" -d, --detach-loop       if mounted loop device, also free this loop device\n"), out);
-- 
1.9.0

