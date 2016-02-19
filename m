Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37386 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161731AbcBSVvG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Feb 2016 16:51:06 -0500
Received: by mail-wm0-f54.google.com with SMTP id g62so89159854wme.0
        for <util-linux@vger.kernel.org>; Fri, 19 Feb 2016 13:50:55 -0800 (PST)
From: Romain Naour <romain.naour@gmail.com>
To: util-linux@vger.kernel.org
Cc: Romain Naour <romain.naour@gmail.com>
Subject: [PATCH 2/2] vipw: Remove pre-ANSI compiler support
Date: Fri, 19 Feb 2016 22:50:48 +0100
Message-Id: <1455918648-11430-2-git-send-email-romain.naour@gmail.com>
In-Reply-To: <1455918648-11430-1-git-send-email-romain.naour@gmail.com>
References: <1455918648-11430-1-git-send-email-romain.naour@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

__P() is used for compatibility with old K&R C compilers. With
ANSI C this macro has no effect.

This fixes a compilation error with musl libc because of undeclared
__P.

Ref:
https://lists.samba.org/archive/samba-technical/2015-June/108042.html

Signed-off-by: Romain Naour <romain.naour@gmail.com>
---
 login-utils/vipw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index a3c932f..bb4a8ba 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -85,7 +85,7 @@ int program;
 char orig_file[FILENAMELEN];	/* original file /etc/passwd or /etc/group */
 char *tmp_file;			/* tmp file */
 
-void pw_error __P((char *, int, int));
+void pw_error (char *, int, int);
 
 static void copyfile(int from, int to)
 {
-- 
2.5.0

