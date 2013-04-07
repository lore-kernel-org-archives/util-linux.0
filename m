Return-Path: util-linux-owner@vger.kernel.org
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:42760 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933048Ab3DGI4O (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Apr 2013 04:56:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri2.pp.htv.fi (Postfix) with ESMTP id 52F4819BD42
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:56:13 +0300 (EEST)
Received: from smtp6.welho.com ([213.243.153.40])
	by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
	with ESMTP id GmsR3TXGKxsb for <util-linux@vger.kernel.org>;
	Sun,  7 Apr 2013 11:56:12 +0300 (EEST)
Received: from viper.bobcat.mine.nu.bobcat.mine.nu (cs78200229.pp.htv.fi [62.78.200.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp6.welho.com (Postfix) with ESMTPS id C79875BC003
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:56:12 +0300 (EEST)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Subject: [PATCH] bash-completion: Symlink runuser symlink to su so it gets loaded on demand.
Date: Sun,  7 Apr 2013 11:56:12 +0300
Message-Id: <1365324972-4139-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 bash-completion/Makemodule.am | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 34bdc6c..4c41218 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -98,6 +98,9 @@ endif
 if BUILD_SU
 dist_bashcompletion_DATA += \
 	bash-completion/su
+install-data-hook-bashcomp-su::
+	ln -sf su $(DESTDIR)$(bashcompletiondir)/runuser
+INSTALL_DATA_HOOKS += install-data-hook-bashcomp-su
 endif
 if BUILD_UTMPDUMP
 dist_bashcompletion_DATA += \
-- 
1.7.11.7

