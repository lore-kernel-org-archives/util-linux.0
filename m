Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37577 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726595AbeIZMed (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Sep 2018 08:34:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CEFD321E1C
        for <util-linux@vger.kernel.org>; Wed, 26 Sep 2018 02:23:14 -0400 (EDT)
Received: from apu2 (x4db4907c.dyn.telefonica.de [77.180.144.124])
        by mail.messagingengine.com (Postfix) with ESMTPA id 421CEE461E
        for <util-linux@vger.kernel.org>; Wed, 26 Sep 2018 02:23:14 -0400 (EDT)
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] rename: avoid undefined function prototype for `fpurge`
Date: Wed, 26 Sep 2018 08:23:09 +0200
Message-Id: <9ecf9e8bb7fb7446624711e968fbb3d2f932a7dd.1537942755.git.ps@pks.im>
In-Reply-To: <cover.1537942755.git.ps@pks.im>
References: <cover.1537942755.git.ps@pks.im>
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In case where the non-standard `fpurge` function is available, we
redefine `__fpurge` to `fpurge`. We can do so because the only
difference between both functions is that one returns an error code
while the other does not. But as we do not check the error code either
way, we do not care about which one of them we use.

The above redefinition happens unconditionally if we know that `fpurge`
exists. Most notably, we also redefine it if we already do have an
`__fpurge` function available that could be used. This causes problems
on musl-based platforms, where we detect availability of `fpurge` in
libc, but where no function declaration for it exists in "stdio_ext.h".
The compiler thus prints a warning due to an unknown function, even
though it will link just fine.

Avoid this warning by only redefining `__fpurge` to `fpurge` when
HAVE___FPURGE is not defined.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 misc-utils/rename.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 0e3e1b9e1..1d9315793 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -17,9 +17,11 @@ for i in $@; do N=`echo "$i" | sed "s/$FROM/$TO/g"`; mv "$i" "$N"; done
 #ifdef HAVE_STDIO_EXT_H
 #	include <stdio_ext.h>
 #endif
-#ifdef HAVE_FPURGE
+#ifndef HAVE___FPURGE
+# ifdef HAVE_FPURGE
 #	define HAVE___FPURGE 1
 #	define __fpurge fpurge
+# endif
 #endif
 #include <string.h>
 #include <stdlib.h>
-- 
2.19.0
