Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:32945 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbbEDDvX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 3 May 2015 23:51:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 41953340AE2
	for <util-linux@vger.kernel.org>; Mon,  4 May 2015 03:51:17 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] build-sys: fix parallel builds w/setarch links
Date: Sun,  3 May 2015 23:51:04 -0400
Message-Id: <1430711464-4943-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Mike Frysinger <vapier@chromium.org>

The symlink generation tries to write to the sys-utils/ subdir but does
not make sure that dir exists.  This can sometimes lead to parallel build
failures when building out-of-tree like:
...
echo ".so man8/setarch.8" > sys-utils/linux64.8
/bin/bash: sys-utils/linux64.8: No such file or directory
Makefile:11503: recipe for target 'sys-utils/linux64.8' failed
make: *** [sys-utils/linux64.8] Error 1

References: https://bugs.gentoo.org/511812
Signed-off-by: Mike Frysinger <vapier@chromium.org>
---
 sys-utils/Makemodule.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index a1dc042..08bb6ce 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -152,6 +152,7 @@ man_MANS += $(SETARCH_MAN_LINKS)
 CLEANFILES += $(SETARCH_MAN_LINKS)
 
 $(SETARCH_MAN_LINKS):
+	$(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)
 	$(AM_V_GEN)echo ".so man8/setarch.8" > $@
 
 install-exec-hook-setarch:
-- 
2.4.0

