Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:64193 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932759AbcCGXMH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:07 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MHnzh-1aa2a92Zy9-003bf9 for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:04 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/12] lib: include sys/stat.h for struct stat
Date: Tue,  8 Mar 2016 00:11:53 +0100
Message-Id: <1457392322-4974-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Compiler warning:
'struct stat' will not be visible outside of this function [-Wvisibility]

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 include/blkdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/blkdev.h b/include/blkdev.h
index 46fb2ce..62eda82 100644
--- a/include/blkdev.h
+++ b/include/blkdev.h
@@ -14,6 +14,7 @@
 #endif
 #include <fcntl.h>
 #include <unistd.h>
+#include <sys/stat.h>
 
 #ifdef HAVE_SYS_MKDEV_H
 # include <sys/mkdev.h>		/* major and minor on Solaris */
-- 
1.9.1

