Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:63930 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932865AbcCGXMH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:07 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M08eS-1ZjAoS3GNI-00uKsE for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:04 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/12] fdisk: sun, undef HAVE_QSORT_R for non-Linux
Date: Tue,  8 Mar 2016 00:11:54 +0100
Message-Id: <1457392322-4974-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Linux/glibc's qsort_r(3) has differently ordered arguments than BSD
implementations. For now we undef that quick and dirty.

The real fix would be to make configure check for qsort_r more
carefully (AC_CHECK_FUNCS with AC_LANG_WERROR). Moreover one could
add a wrapper to swap arguments, see
https://github.com/noporpoise/sort_r/blob/master/sort_r.h

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libfdisk/src/sun.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libfdisk/src/sun.c b/libfdisk/src/sun.c
index d5c76ae..a50076a 100644
--- a/libfdisk/src/sun.c
+++ b/libfdisk/src/sun.c
@@ -378,6 +378,11 @@ static void fetch_sun(struct fdisk_context *cxt,
 	}
 }
 
+/* non-Linux qsort_r(3) has usually differently ordered arguments */
+#if !defined (__linux__) || !defined (__GLIBC__)
+# undef HAVE_QSORT_R
+#endif
+
 #ifdef HAVE_QSORT_R
 static int verify_sun_cmp(int *a, int *b, void *data)
 {
-- 
1.9.1

