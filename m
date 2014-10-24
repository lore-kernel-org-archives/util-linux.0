Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:45448 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756065AbaJXQ0O (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 12:26:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id E3BAF340366
	for <util-linux@vger.kernel.org>; Fri, 24 Oct 2014 16:26:13 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH v2] bash-completion: fix runuser install
Date: Fri, 24 Oct 2014 12:26:12 -0400
Message-Id: <1414167972-16829-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1414167178-29409-1-git-send-email-vapier@gentoo.org>
References: <1414167178-29409-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The runuser symlink used to depend on su being enabled, but a refactoring
broke that.  So if you build with runuser enabled but not su, you end up
with a broken symlink.  Rework the logic so it works in both cases.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
v2
	- use srcdir to fix out-of-tree building

 bash-completion/Makemodule.am | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 271a6db..d65cc8f 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -154,7 +154,11 @@ endif
 
 if BUILD_RUNUSER
 install-data-hook-bashcomp-runuser::
+if BUILD_SU
 	ln -sf su $(DESTDIR)$(bashcompletiondir)/runuser
+else
+	cp $(top_srcdir)/bash-completion/su $(DESTDIR)$(bashcompletiondir)/runuser
+endif
 INSTALL_DATA_HOOKS += install-data-hook-bashcomp-runuser
 endif
 
-- 
2.1.2

