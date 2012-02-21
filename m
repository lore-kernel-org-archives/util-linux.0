Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:43309 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931Ab2BUPD1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Feb 2012 10:03:27 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 4FA978FA97
	for <util-linux@vger.kernel.org>; Tue, 21 Feb 2012 16:03:26 +0100 (CET)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] build-sys: fix building of wall
Date: Tue, 21 Feb 2012 16:03:25 +0100
Message-Id: <1329836605-11638-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index ac760c1..7e88aa1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1037,7 +1037,7 @@ AC_ARG_ENABLE([wall],
   AS_HELP_STRING([--disable-wall], [do not build wall]),
   [], enable_wall=yes
 )
-UL_BUILD_INIT([wasll])
+UL_BUILD_INIT([wall])
 AM_CONDITIONAL(BUILD_WALL, test "x$build_wall" = xyes)
 
 
-- 
1.7.7

