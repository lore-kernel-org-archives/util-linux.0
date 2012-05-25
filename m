Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:51352 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab2EYSLd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:11:33 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=EU1-MAIL.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1SXyz5-0007Nv-Nu from Thomas_Schwinge@mentor.com
	for util-linux@vger.kernel.org; Fri, 25 May 2012 11:11:31 -0700
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH] kill: Check the correct variable when configuring.
Date: Fri, 25 May 2012 20:11:22 +0200
Message-Id: <1337969482-3000-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index a1b1e9b..eb67ada 100644
--- a/configure.ac
+++ b/configure.ac
@@ -976,7 +976,7 @@ AC_ARG_ENABLE([kill],
 )
 UL_BUILD_INIT([kill])
 UL_REQUIRES_LINUX([kill])
-AM_CONDITIONAL(BUILD_KILL, test "x$enable_kill" = xyes)
+AM_CONDITIONAL(BUILD_KILL, test "x$build_kill" = xyes)
 
 
 AC_ARG_ENABLE([last],
-- 
1.7.9

