Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37449 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab1FHWxt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 8 Jun 2011 18:53:49 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so837342iyb.19
        for <util-linux@vger.kernel.org>; Wed, 08 Jun 2011 15:53:48 -0700 (PDT)
From: Josiah Worcester <josiahw@gmail.com>
To: util-linux@vger.kernel.org
Cc: Josiah Worcester <josiahw@gmail.com>
Subject: [PATCH 6/6] hwclock: Don't use asm/io.h if sys/io.h can't be found
Date: Wed,  8 Jun 2011 16:52:48 -0600
Message-Id: <1307573568-23643-7-git-send-email-josiahw@gmail.com>
In-Reply-To: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
References: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Josiah Worcester <josiahw@gmail.com>
---
 hwclock/cmos.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/hwclock/cmos.c b/hwclock/cmos.c
index 947b21b..b5169a1 100644
--- a/hwclock/cmos.c
+++ b/hwclock/cmos.c
@@ -53,7 +53,12 @@
 #ifdef HAVE_SYS_IO_H
 #include <sys/io.h>
 #else
-#include <asm/io.h>		/* for inb, outb */
+/* Disable cmos access; we can no longer use asm/io.h, since
+ * the kernel does not export that header.
+ */
+#undef __i386__
+void outb(int a, int b){}
+int inb(int c){ return 0; }
 #endif
 #elif defined(__alpha__)
 /* <asm/io.h> fails to compile, probably because of u8 etc */
-- 
1.7.5.3

