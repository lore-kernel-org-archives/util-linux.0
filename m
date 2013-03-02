Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:56458 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab3CBSAE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 2 Mar 2013 13:00:04 -0500
From: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux@vger.kernel.org
Cc: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH] build-sys: add exec_shell.h to distribution
Date: Sat,  2 Mar 2013 18:59:02 +0100
Message-Id: <1362247142-28358-1-git-send-email-mail@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 include/Makemodule.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/Makemodule.am b/include/Makemodule.am
index c8af1ec..358a351 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -12,6 +12,7 @@ dist_noinst_HEADERS += \
 	include/cpuset.h \
 	include/crc32.h \
 	include/env.h \
+	include/exec_shell.h \
 	include/exitcodes.h \
 	include/fileutils.h \
 	include/ismounted.h \
-- 
1.8.1.3.619.g7b6e784

