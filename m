Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:57226 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbbAUSC7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Jan 2015 13:02:59 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0LzKyn-1Xih7o0VtZ-014Py2 for
 <util-linux@vger.kernel.org>; Wed, 21 Jan 2015 19:02:57 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/5] build-sys: fix UL_SCANF_TYPE_MODIFIER for icc
Date: Wed, 21 Jan 2015 19:02:53 +0100
Message-Id: <1421863374-9953-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1421863374-9953-1-git-send-email-sweet_f_a@gmx.de>
References: <1421863374-9953-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

icc needs -Werror to let %m fail and to avoid this:
../libmount/src/tab_parse.c(61): warning #269: invalid format string conversion

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index de299d3..a0d5763 100644
--- a/configure.ac
+++ b/configure.ac
@@ -492,6 +492,8 @@ int main()
 	return 1;
 }])
 
+ul_save_CPPFLAGS="$CPPFLAGS"
+CPPFLAGS="-Werror ${CPPFLAGS}"
 AC_CACHE_VAL([scanf_cv_alloc_modifier],
   AC_RUN_IFELSE([AC_LANG_SOURCE([UL_SCANF_TYPE_MODIFIER(["%ms"])])],
     [scanf_cv_alloc_modifier=ms],
@@ -525,6 +527,7 @@ AC_CACHE_VAL([scanf_cv_alloc_modifier],
     [scanf_cv_alloc_modifier=no])]
   )
 )
+CPPFLAGS="$ul_save_CPPFLAGS"
 
 AC_MSG_CHECKING([scanf string alloc modifiers])
 AS_CASE([$scanf_cv_alloc_modifier],
-- 
1.8.4.5

