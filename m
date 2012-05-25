Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:51960 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757818Ab2EYSQ0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:16:26 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=EU1-MAIL.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1SXz3p-0007mj-V0 from Thomas_Schwinge@mentor.com
	for util-linux@vger.kernel.org; Fri, 25 May 2012 11:16:26 -0700
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH 1/7] kill, raw, rename: Don't explicitly enable for --enable-most-builds.
Date: Fri, 25 May 2012 20:16:12 +0200
Message-Id: <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
References: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

They're already dealt with in the default configuration.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 configure.ac |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index eb67ada..76f73a1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -631,12 +631,9 @@ if test "x$enable_most_builds" = xyes; then
   enable_arch=yes
   enable_ddate=yes
   enable_elvtune=yes
-  enable_kill=yes
   enable_last=yes
   enable_line=yes
   enable_mesg=yes
-  enable_raw=yes
-  enable_rename=yes
   enable_reset=yes
   enable_login_utils=yes
   enable_write=yes
-- 
1.7.9

