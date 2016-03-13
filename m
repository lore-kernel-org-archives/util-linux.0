Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54503 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754299AbcCMWb0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:26 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MdXSC-1aT4wC0r2C-00PNcv for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:24 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/12] build-sys: fix again UL_SCANF_TYPE_MODIFIER
Date: Sun, 13 Mar 2016 23:31:15 +0100
Message-Id: <1457908280-15588-8-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This reverts commit c8494d88:
  "build-sys: fix UL_SCANF_TYPE_MODIFIER for icc"

plus fix the check prog, because it found "%as" to be valid on
systems where "%a" is used for float conversion.

icc warns about "%ms" but it works anyways. Our AC_RUN_IFELSE prog
should do it right now regardless of compiler warnings.

Note "%ms" is POSIX.1-2008 standard but still not available on
many systems. Maybe it's time to remove "%as" fallback for old
glibc which is even less portable.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8d808b7..0bfe28c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -539,16 +539,15 @@ AC_DEFUN([UL_SCANF_TYPE_MODIFIER], [dnl
 int main()
 {
 	int i;
+	int rc = 1;
 	char *s;
 	i = sscanf("x", $1, &s);
+	if (i == 1  && *s == 'x')
+		rc = 0;
 	free(s);
-	if (i == 1)
-		return 0;
-	return 1;
+	return rc;
 }])
 
-ul_save_CPPFLAGS="$CPPFLAGS"
-CPPFLAGS="-Werror ${CPPFLAGS}"
 AC_CACHE_VAL([scanf_cv_alloc_modifier],
   AC_RUN_IFELSE([AC_LANG_SOURCE([UL_SCANF_TYPE_MODIFIER(["%ms"])])],
     [scanf_cv_alloc_modifier=ms],
@@ -582,7 +581,6 @@ AC_CACHE_VAL([scanf_cv_alloc_modifier],
     [scanf_cv_alloc_modifier=no])]
   )
 )
-CPPFLAGS="$ul_save_CPPFLAGS"
 
 AC_MSG_CHECKING([scanf string alloc modifiers])
 AS_CASE([$scanf_cv_alloc_modifier],
-- 
1.8.4.5

