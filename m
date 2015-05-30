Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vn0-f41.google.com ([209.85.216.41]:45215 "EHLO
	mail-vn0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbbE3Sv4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 30 May 2015 14:51:56 -0400
Received: by vnbg7 with SMTP id g7so11836156vnb.12
        for <util-linux@vger.kernel.org>; Sat, 30 May 2015 11:51:53 -0700 (PDT)
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH] sys-utils: lscpu segfaults when built with -fsanitize=address
Date: Sat, 30 May 2015 15:51:41 -0300
Message-Id: <1433011901-113397-1-git-send-email-crrodriguez@opensuse.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is expected and a false positive, exclude the vmware detection
trick when __SANITIZE_ADDRESS__ is defined.
---
 sys-utils/lscpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index b36d1da..f695a32 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -34,7 +34,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
-#if defined(__x86_64__) || defined(__i386__)
+#if (defined(__x86_64__) || defined(__i386__)) && !defined(__SANITIZE_ADDRESS__)
 # define INCLUDE_VMWARE_BDOOR
 #endif
 
-- 
2.4.1

