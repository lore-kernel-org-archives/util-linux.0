Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:44630 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbaJXQNF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 12:13:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 067E1340471
	for <util-linux@vger.kernel.org>; Fri, 24 Oct 2014 16:12:58 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] bash-completion: fix runuser install
Date: Fri, 24 Oct 2014 12:12:58 -0400
Message-Id: <1414167178-29409-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The runuser symlink used to depend on su being enabled, but a refactoring
broke that.  So if you build with runuser enabled but not su, you end up
with a broken symlink.  Rework the logic so it works in both cases.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 bash-completion/Makemodule.am | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 271a6db..045c2d5 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -154,7 +154,11 @@ endif
 
 if BUILD_RUNUSER
 install-data-hook-bashcomp-runuser::
+if BUILD_SU
 	ln -sf su $(DESTDIR)$(bashcompletiondir)/runuser
+else
+	cp bash-completion/su $(DESTDIR)$(bashcompletiondir)/runuser
+endif
 INSTALL_DATA_HOOKS += install-data-hook-bashcomp-runuser
 endif
 
-- 
2.1.2

