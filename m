Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:65489 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299AbbAUSC6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Jan 2015 13:02:58 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0MNq4h-1Y6ZtT1ml1-007WvU for
 <util-linux@vger.kernel.org>; Wed, 21 Jan 2015 19:02:56 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/5] build-sys: avoid icc warnings "ignoring unknown option"
Date: Wed, 21 Jan 2015 19:02:51 +0100
Message-Id: <1421863374-9953-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1421863374-9953-1-git-send-email-sweet_f_a@gmx.de>
References: <1421863374-9953-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Our macro UL_WARN_ADD could not discover these ones:
icc: command line warning #10006: ignoring unknown option '-Wmissing-parameter-type'
icc: command line warning #10006: ignoring unknown option '-Wredundant-decls'
icc: command line warning #10006: ignoring unknown option '-Wunused-result'
icc: command line warning #10006: ignoring unknown option '-Wnested-externs'

We need to use AC_LANG_WERROR.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 m4/compiler.m4 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/m4/compiler.m4 b/m4/compiler.m4
index 062f936..058c73f 100644
--- a/m4/compiler.m4
+++ b/m4/compiler.m4
@@ -21,11 +21,18 @@ AC_DEFUN([UL_WARN_ADD], [
   m4_define([warnvarname], m4_default([$2],WARN_CFLAGS))
   AS_VAR_PUSHDEF([ul_Warn], [ul_cv_warn_$1])dnl
   AC_CACHE_CHECK([whether compiler handles $1], m4_defn([ul_Warn]), [
+    # store AC_LANG_WERROR status, then turn it on
+    save_ac_[]_AC_LANG_ABBREV[]_werror_flag="${ac_[]_AC_LANG_ABBREV[]_werror_flag}"
+    AC_LANG_WERROR
+
     ul_save_CPPFLAGS="$CPPFLAGS"
     CPPFLAGS="-Werror ${CPPFLAGS} $1"
     AC_PREPROC_IFELSE([AC_LANG_PROGRAM([])],
                       [AS_VAR_SET(ul_Warn, [yes])],
                       [AS_VAR_SET(ul_Warn, [no])])
+    # restore AC_LANG_WERROR
+    ac_[]_AC_LANG_ABBREV[]_werror_flag="${save_ac_[]_AC_LANG_ABBREV[]_werror_flag}"
+
     CPPFLAGS="$ul_save_CPPFLAGS"
   ])
   AS_VAR_IF(ul_Warn, [yes], [UL_AS_VAR_APPEND(warnvarname, [" $1"])])
-- 
1.8.4.5

