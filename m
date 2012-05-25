Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:51961 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757950Ab2EYSQ2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:16:28 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=EU1-MAIL.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1SXz3r-0007ms-P4 from Thomas_Schwinge@mentor.com
	for util-linux@vger.kernel.org; Fri, 25 May 2012 11:16:27 -0700
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH 2/7] arch, eject, elvtune: Gracefully disable on non-Linux platforms.
Date: Fri, 25 May 2012 20:16:13 +0200
Message-Id: <1337969778-3154-2-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
References: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
 <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 configure.ac |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 76f73a1..cd8fa4e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -628,9 +628,9 @@ AC_ARG_ENABLE([most-builds],
   [], enable_most_builds=no
 )
 if test "x$enable_most_builds" = xyes; then
-  enable_arch=yes
+  enable_arch=check
   enable_ddate=yes
-  enable_elvtune=yes
+  enable_elvtune=check
   enable_last=yes
   enable_line=yes
   enable_mesg=yes
@@ -862,7 +862,7 @@ AC_SUBST([ruman1dir])
 
 AC_ARG_ENABLE([eject],
   AS_HELP_STRING([--disable-eject], [do not build eject]),
-  [], enable_eject=yes
+  [], enable_eject=check
 )
 UL_BUILD_INIT([eject])
 UL_REQUIRES_LINUX([eject])
-- 
1.7.9

