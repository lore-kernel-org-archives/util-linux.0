Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:57645 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab2G0KJG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Jul 2012 06:09:06 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 01395912E4
	for <util-linux@vger.kernel.org>; Fri, 27 Jul 2012 12:09:05 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] build-sys: fix description of utmpdump configure option
Date: Fri, 27 Jul 2012 12:09:01 +0200
Message-Id: <1343383741-29096-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index e32a1c1..99f1df0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1020,7 +1020,7 @@ AM_CONDITIONAL(BUILD_LAST, test "x$build_last" = xyes)
 
 
 AC_ARG_ENABLE([utmpdump],
-  AS_HELP_STRING([--disable-utmpdump], [build utmpdump]),
+  AS_HELP_STRING([--disable-utmpdump], [do not build utmpdump]),
   [], enable_utmpdump=yes
 )
 UL_BUILD_INIT([utmpdump])
-- 
1.7.7

