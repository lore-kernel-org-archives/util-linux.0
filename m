Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f180.google.com ([209.85.223.180]:35568 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbbKQMNj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Nov 2015 07:13:39 -0500
Received: by ioc74 with SMTP id 74so16096702ioc.2
        for <util-linux@vger.kernel.org>; Tue, 17 Nov 2015 04:13:38 -0800 (PST)
Received: from localhost ([2001:cc0:201e:102:3e97:eff:fea9:6aa7])
        by smtp.gmail.com with ESMTPSA id b81sm13572372ioj.30.2015.11.17.04.13.36
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2015 04:13:37 -0800 (PST)
From: "Casper Ti. Vector" <caspervector@gmail.com>
Message-Id: <3122dea1b0bbfab174b9e1cc70aec72676568f52.1447762216.git.CasperVector@gmail.com>
Date: Tue, 17 Nov 2015 16:54:15 +0800
Subject: [PATCH 1/2] linux_reboot.h: support 1-argument reboot() from
 alternative libc.
To: util-linux@vger.kernel.org
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Original code assumes 1-argument reboot() is only provided by glibc 2.x
and later; but as far as the patch author knows, at least the following
alternative C libraries for linux also provide the 1-argument variant:

* uclibc: all public releases.
* dietlibc: 0.7.2 and all later releases; reboot() was not provided in
            0.7.1 and earlier versions.
* musl: all public releases.
* klibc: all public releases.
* bionic: all public releases.

... which should already cover most use cases.
---
 include/linux_reboot.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux_reboot.h b/include/linux_reboot.h
index 9cebc67..7ba4bca 100644
--- a/include/linux_reboot.h
+++ b/include/linux_reboot.h
@@ -39,12 +39,12 @@
 #ifdef USE_LIBC
 
 /* libc version */
-#if defined __GLIBC__ && __GLIBC__ >= 2
-#  include <sys/reboot.h>
-#  define REBOOT(cmd) reboot(cmd)
-#else
+#if defined __GLIBC__ && __GLIBC__ < 2
 extern int reboot(int, int, int);
 #  define REBOOT(cmd) reboot(LINUX_REBOOT_MAGIC1,LINUX_REBOOT_MAGIC2,(cmd))
+#else
+#  include <sys/reboot.h>
+#  define REBOOT(cmd) reboot(cmd)
 #endif
 static inline int my_reboot(int cmd) {
 	return REBOOT(cmd);
-- 
2.6.3

