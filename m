Return-Path: util-linux-owner@vger.kernel.org
Received: from mx.datacom.ind.br ([177.66.5.10]:44209 "EHLO
        mail.datacom.ind.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751060AbdBHQY2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 8 Feb 2017 11:24:28 -0500
Received: from mail.datacom.ind.br (localhost [127.0.0.1])
        by mail.datacom.ind.br (Postfix) with ESMTPS id 98D2019C0AFB
        for <util-linux@vger.kernel.org>; Wed,  8 Feb 2017 13:23:34 -0200 (BRST)
Received: from localhost (localhost [127.0.0.1])
        by mail.datacom.ind.br (Postfix) with ESMTP id 89D2119C06AC
        for <util-linux@vger.kernel.org>; Wed,  8 Feb 2017 13:23:34 -0200 (BRST)
Received: from mail.datacom.ind.br ([127.0.0.1])
        by localhost (mail.datacom.ind.br [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GYd8-oxsIFMz for <util-linux@vger.kernel.org>;
        Wed,  8 Feb 2017 13:23:34 -0200 (BRST)
Received: from pedeld202344.datacom.net (pedeld202344.datacom.net [10.0.120.87])
        by mail.datacom.ind.br (Postfix) with ESMTPSA id 6A82319C02DD
        for <util-linux@vger.kernel.org>; Wed,  8 Feb 2017 13:23:34 -0200 (BRST)
From: Carlos Santos <casantos@datacom.ind.br>
To: util-linux@vger.kernel.org
Subject: [PATCH] build-sys: improve detection of the "isnan" function in uClibc
Date: Wed,  8 Feb 2017 13:27:36 -0200
Message-Id: <1486567656-22277-1-git-send-email-casantos@datacom.ind.br>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Since commit beceb14b450ded6560ed743634a5e80604a8edf3, MATH_LIBS is set
to "-lm" when the isnan function is detected. In uClibc, however, isnan
is a macro that calls __isnan, __isnanf, or __isnanl, depending on the
size of the argument (double, float or long double).

Fixes:
  http://autobuild.buildroot.net/results/2c2/2c29a78ed81ca844a87dcd076ab3e14ea080296d/
  http://autobuild.buildroot.net/results/404/404b10f359b2ae8a7216729fa1bab37fed2d3d4c/

Signed-off-by: Carlos Santos <casantos@datacom.ind.br>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 3759921..3bb3ba8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -435,6 +435,7 @@ AM_CONDITIONAL([HAVE_OPENAT], [test "x$have_openat" = xyes])
 
 AC_CHECK_FUNCS([isnan], [],
 	[AC_CHECK_LIB([m], [isnan], [MATH_LIBS="-lm"])]
+	[AC_CHECK_LIB([m], [__isnan], [MATH_LIBS="-lm"])]
 )
 AC_SUBST([MATH_LIBS])
 
-- 
2.7.4

