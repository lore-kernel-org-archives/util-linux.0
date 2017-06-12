Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:59555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbdFLIuB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Jun 2017 04:50:01 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFgxF-1d6KGo2KSj-00EhfD for
 <util-linux@vger.kernel.org>; Mon, 12 Jun 2017 10:49:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/6] hwclock: fix warning [-Winvalid-noreturn]
Date: Mon, 12 Jun 2017 10:49:55 +0200
Message-Id: <20170612084958.22054-4-sweet_f_a@gmx.de>
In-Reply-To: <20170612084958.22054-1-sweet_f_a@gmx.de>
References: <20170612084958.22054-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

clang warned:

 CC       sys-utils/hwclock.o
../sys-utils/hwclock.c:1274:1: warning: function declared 'noreturn' should not return [-Winvalid-noreturn]

We have to move the noreturn attribute from the function definition
to the declaration.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/hwclock.c | 2 +-
 sys-utils/hwclock.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 603146079..cfb6bcd6b 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1535,7 +1535,7 @@ int main(int argc, char **argv)
 	return rc;		/* Not reached */
 }
 
-void __attribute__((__noreturn__))
+void
 hwclock_exit(const struct hwclock_control *ctl
 #ifndef HAVE_LIBAUDIT
 	     __attribute__((__unused__))
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index f3f76a6da..d527fe310 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -73,6 +73,7 @@ extern int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch
 extern int set_epoch_rtc(const struct hwclock_control *ctl);
 #endif
 
-extern void hwclock_exit(const struct hwclock_control *ctl, int status);
+extern void __attribute__((__noreturn__))
+hwclock_exit(const struct hwclock_control *ctl, int status);
 
 #endif				/* HWCLOCK_CLOCK_H */
-- 
2.12.3

