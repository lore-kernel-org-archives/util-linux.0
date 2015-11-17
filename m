Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37613 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbbKQMNn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Nov 2015 07:13:43 -0500
Received: by igcto18 with SMTP id to18so11725835igc.0
        for <util-linux@vger.kernel.org>; Tue, 17 Nov 2015 04:13:42 -0800 (PST)
Received: from localhost ([2001:cc0:201e:102:3e97:eff:fea9:6aa7])
        by smtp.gmail.com with ESMTPSA id qb2sm7965780igb.10.2015.11.17.04.13.40
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2015 04:13:41 -0800 (PST)
From: "Casper Ti. Vector" <caspervector@gmail.com>
Message-Id: <0549ea39f558cb6970596dc0cf56bc166c6c271e.1447762216.git.CasperVector@gmail.com>
In-Reply-To: <3122dea1b0bbfab174b9e1cc70aec72676568f52.1447762216.git.CasperVector@gmail.com>
References: <3122dea1b0bbfab174b9e1cc70aec72676568f52.1447762216.git.CasperVector@gmail.com>
Date: Tue, 17 Nov 2015 17:05:46 +0800
Subject: [PATCH 2/2] linux_reboot.h: remove code that is unused anyway.
To: util-linux@vger.kernel.org
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 include/linux_reboot.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/include/linux_reboot.h b/include/linux_reboot.h
index 7ba4bca..ce7fa68 100644
--- a/include/linux_reboot.h
+++ b/include/linux_reboot.h
@@ -34,10 +34,6 @@
 #include <unistd.h>
 #include "linux_reboot.h"
 
-#define USE_LIBC
-
-#ifdef USE_LIBC
-
 /* libc version */
 #if defined __GLIBC__ && __GLIBC__ < 2
 extern int reboot(int, int, int);
@@ -50,23 +46,5 @@ static inline int my_reboot(int cmd) {
 	return REBOOT(cmd);
 }
 
-#else /* no USE_LIBC */
-
-/* direct syscall version */
-#include <linux/unistd.h>
-
-#ifdef _syscall3
-_syscall3(int,  reboot,  int,  magic, int, magic_too, int, cmd);
-#else
-/* Let us hope we have a 3-argument reboot here */
-extern int reboot(int, int, int);
-#endif
-
-static inline int my_reboot(int cmd) {
-	return reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd);
-}
-
-#endif
-
 
 #endif /*  _LINUX_REBOOT_H  */
-- 
2.6.3

