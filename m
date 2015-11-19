Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38177 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbbKSDDl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 18 Nov 2015 22:03:41 -0500
Received: by igbxm8 with SMTP id xm8so54172879igb.1
        for <util-linux@vger.kernel.org>; Wed, 18 Nov 2015 19:03:40 -0800 (PST)
Received: from localhost ([2001:cc0:201e:102:3e97:eff:fea9:6aa7])
        by smtp.gmail.com with ESMTPSA id c21sm2557410ioc.24.2015.11.18.19.03.39
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 19:03:40 -0800 (PST)
From: "Casper Ti. Vector" <caspervector@gmail.com>
Message-Id: <b320213b725bc4b3e0f56b907dc963e28da74d13.1447902109.git.CasperVector@gmail.com>
In-Reply-To: <3122dea1b0bbfab174b9e1cc70aec72676568f52.1447762216.git.CasperVector@gmail.com>
References: <3122dea1b0bbfab174b9e1cc70aec72676568f52.1447762216.git.CasperVector@gmail.com>
Date: Thu, 19 Nov 2015 10:56:34 +0800
Subject: [PATCH v2 2/2] Remove now useless linux_reboot.h.
To: util-linux@vger.kernel.org
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 include/Makemodule.am  |  1 -
 include/linux_reboot.h | 72 --------------------------------------------------
 2 files changed, 73 deletions(-)
 delete mode 100644 include/linux_reboot.h

diff --git a/include/Makemodule.am b/include/Makemodule.am
index f0bb898..fcda908 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -19,7 +19,6 @@ dist_noinst_HEADERS += \
 	include/exitcodes.h \
 	include/fileutils.h \
 	include/ismounted.h \
-	include/linux_reboot.h \
 	include/linux_version.h \
 	include/list.h \
 	include/loopdev.h \
diff --git a/include/linux_reboot.h b/include/linux_reboot.h
deleted file mode 100644
index 9cebc67..0000000
--- a/include/linux_reboot.h
+++ /dev/null
@@ -1,72 +0,0 @@
-#ifndef _LINUX_REBOOT_H
-#define _LINUX_REBOOT_H
-
-/*
- * Magic values required to use _reboot() system call.
- */
-
-#define	LINUX_REBOOT_MAGIC1	0xfee1dead
-#define	LINUX_REBOOT_MAGIC2	672274793
-#define	LINUX_REBOOT_MAGIC2A	85072278
-#define	LINUX_REBOOT_MAGIC2B	369367448
-
-
-/*
- * Commands accepted by the _reboot() system call.
- *
- * RESTART     Restart system using default command and mode.
- * HALT        Stop OS and give system control to ROM monitor, if any.
- * CAD_ON      Ctrl-Alt-Del sequence causes RESTART command.
- * CAD_OFF     Ctrl-Alt-Del sequence sends SIGINT to init task.
- * POWER_OFF   Stop OS and remove all power from system, if possible.
- * RESTART2    Restart system using given command string.
- */
-
-#define	LINUX_REBOOT_CMD_RESTART	0x01234567
-#define	LINUX_REBOOT_CMD_HALT		0xCDEF0123
-#define	LINUX_REBOOT_CMD_CAD_ON		0x89ABCDEF
-#define	LINUX_REBOOT_CMD_CAD_OFF	0x00000000
-#define	LINUX_REBOOT_CMD_POWER_OFF	0x4321FEDC
-#define	LINUX_REBOOT_CMD_RESTART2	0xA1B2C3D4
-
-/* Including <unistd.h> makes sure that on a glibc system
-   <features.h> is included, which again defines __GLIBC__ */
-#include <unistd.h>
-#include "linux_reboot.h"
-
-#define USE_LIBC
-
-#ifdef USE_LIBC
-
-/* libc version */
-#if defined __GLIBC__ && __GLIBC__ >= 2
-#  include <sys/reboot.h>
-#  define REBOOT(cmd) reboot(cmd)
-#else
-extern int reboot(int, int, int);
-#  define REBOOT(cmd) reboot(LINUX_REBOOT_MAGIC1,LINUX_REBOOT_MAGIC2,(cmd))
-#endif
-static inline int my_reboot(int cmd) {
-	return REBOOT(cmd);
-}
-
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
-
-#endif /*  _LINUX_REBOOT_H  */
-- 
2.6.3

