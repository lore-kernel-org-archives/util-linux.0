Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:41527 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758144Ab3AIWoS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jan 2013 17:44:18 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so1264043wgb.0
        for <util-linux@vger.kernel.org>; Wed, 09 Jan 2013 14:44:17 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/3] build-sys: add chkdupexe and uuidd socket activation to most-builds
Date: Wed,  9 Jan 2013 22:44:06 +0000
Message-Id: <1357771446-11966-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1357771446-11966-1-git-send-email-kerolasa@iki.fi>
References: <1357771446-11966-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 16255b1..e937736 100644
--- a/configure.ac
+++ b/configure.ac
@@ -673,15 +673,17 @@ AC_ARG_ENABLE([most-builds],
 )
 if test "x$enable_most_builds" = xyes; then
   enable_arch=check
+  enable_chfn_chsh=yes
+  enable_chkdupexe=yes
   enable_elvtune=check
-  enable_tunelp=yes
   enable_last=yes
   enable_line=yes
   enable_mesg=yes
+  enable_newgrp=yes
   enable_reset=yes
+  enable_socket_activation=yes
+  enable_tunelp=yes
   enable_vipw=yes
-  enable_chfn_chsh=yes
-  enable_newgrp=yes
   enable_write=yes
 fi
 
-- 
1.8.1

