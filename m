Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b32.telenor.se ([213.150.131.21]:59592 "EHLO
	smtprelay-b32.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbaGWRjR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 23 Jul 2014 13:39:17 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b32.telenor.se (Postfix) with ESMTP id 34A59840C5
	for <util-linux@vger.kernel.org>; Wed, 23 Jul 2014 19:39:14 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] Fix switch_root/pivot_root cut-n-paste error in configure.ac
Date: Wed, 23 Jul 2014 19:39:02 +0200
Message-Id: <1406137142-15441-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The "linux only" check for pivot_root seems to suffer from
a cut-n-paste problem from the earlier switch_root part.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index db53dff..aae2456 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1193,7 +1193,7 @@ AC_ARG_ENABLE([pivot_root],
   [], [UL_DEFAULT_ENABLE([pivot_root], [check])]
 )
 UL_BUILD_INIT([pivot_root])
-UL_REQUIRES_LINUX([switch_root])
+UL_REQUIRES_LINUX([pivot_root])
 UL_REQUIRES_SYSCALL_CHECK([pivot_root], [UL_CHECK_SYSCALL([pivot_root])])
 AM_CONDITIONAL([BUILD_PIVOT_ROOT], [test "x$build_pivot_root" = xyes])
 
-- 
2.0.1

