Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:52173 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab2IECbH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 4 Sep 2012 22:31:07 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] login-utils/Makemodule: install su.1 if building su
Date: Tue,  4 Sep 2012 22:31:03 -0400
Message-Id: <1346812263-9512-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
This also unfortunately means that su.1 isn't included in the dist tarball.

 login-utils/Makemodule.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index 755a361..e26d9a7 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -80,6 +80,7 @@ endif # BUILD_CHFN_CHSH
 
 if BUILD_SU
 bin_PROGRAMS += su
+dist_man_MANS += login-utils/su.1
 su_SOURCES = \
 	login-utils/su.c \
 	login-utils/su-common.c \
-- 
1.7.12

