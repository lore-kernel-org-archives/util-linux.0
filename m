Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:59680 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932650AbcCGXMH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:07 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LzLJR-1ZrClw163d-014VsF for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:05 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/12] libmount: don't include libio.h
Date: Tue,  8 Mar 2016 00:11:57 +0100
Message-Id: <1457392322-4974-8-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This include was added just one month ago in 5a971329 but I don't see
what it was good for. It's missing in musl libc.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libmount/src/btrfs.c | 2 +-
 login-utils/last.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libmount/src/btrfs.c b/libmount/src/btrfs.c
index edcabf3..9f48bf4 100644
--- a/libmount/src/btrfs.c
+++ b/libmount/src/btrfs.c
@@ -9,7 +9,7 @@
  */
 #include <dirent.h>
 #include <sys/ioctl.h>
-#include <libio.h>
+#include <stdlib.h>
 #include <stdint.h>
 #include <linux/btrfs.h>
 
diff --git a/login-utils/last.c b/login-utils/last.c
index 38b92ef..b8c4b83 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -26,7 +26,7 @@
  */
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/fcntl.h>
+#include <fcntl.h>
 #include <time.h>
 #include <stdio.h>
 #include <ctype.h>
-- 
1.9.1

