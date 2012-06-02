Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:60207 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab2FBRiG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 2 Jun 2012 13:38:06 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] include correct source file for chsh
Date: Sat,  2 Jun 2012 13:38:02 -0400
Message-Id: <1338658682-17318-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/Makefile.am b/login-utils/Makefile.am
index baa7949..f551191 100644
--- a/login-utils/Makefile.am
+++ b/login-utils/Makefile.am
@@ -70,7 +70,7 @@ chfn_CFLAGS = $(chfn_chsh_cflags)
 chfn_LDFLAGS = $(chfn_chsh_ldflags)
 chfn_LDADD = $(chfn_chsh_ldadd)
 
-chsh_SOURCES = chfn.c $(chfn_chsh_sources)
+chsh_SOURCES = chsh.c $(chfn_chsh_sources)
 chsh_CFLAGS = $(chfn_chsh_cflags)
 chsh_LDFLAGS = $(chfn_chsh_ldflags)
 chsh_LDADD = $(chfn_chsh_ldadd)
-- 
1.7.10.3

