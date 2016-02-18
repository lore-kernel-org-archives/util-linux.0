Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:59001 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946042AbcBRNWU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:22:20 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Lurin-1Znwvj32C9-0108LZ for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:22:18 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/15] include: remove unused mntent.h
Date: Thu, 18 Feb 2016 14:22:17 +0100
Message-Id: <1455801737-10715-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.minix.c | 1 -
 disk-utils/mkfs.minix.c | 1 -
 disk-utils/mkswap.c     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 3d73d49..2058a97 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -87,7 +87,6 @@
 #include <ctype.h>
 #include <stdlib.h>
 #include <termios.h>
-#include <mntent.h>
 #include <sys/stat.h>
 #include <signal.h>
 #include <getopt.h>
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 4712772..b472242 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -64,7 +64,6 @@
 #include <stdlib.h>
 #include <termios.h>
 #include <sys/stat.h>
-#include <mntent.h>
 #include <getopt.h>
 #include <err.h>
 
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 22999da..ae02de5 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -14,7 +14,6 @@
 #include <fcntl.h>
 #include <stdlib.h>
 #include <limits.h>
-#include <mntent.h>
 #include <sys/utsname.h>
 #include <sys/stat.h>
 #include <errno.h>
-- 
1.8.4.5

