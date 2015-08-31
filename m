Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.windriver.com ([147.11.1.11]:55755 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbbHaIcy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 31 Aug 2015 04:32:54 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id t7V8Wrhk012988
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <util-linux@vger.kernel.org>; Mon, 31 Aug 2015 01:32:53 -0700 (PDT)
From: Chen Qi <Qi.Chen@windriver.com>
To: <util-linux@vger.kernel.org>
Subject: [PATCH] sys-utils/Makemodule.am: fix parallel build issue
Date: Mon, 31 Aug 2015 16:23:44 +0800
Message-ID: <1441009426-13799-1-git-send-email-Qi.Chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Robert Yang <liezhi.yang@windriver.com>

The rule SETARCH_MAN_LINKS is used for the files under the sys-utils
dir, for example:

echo ".so man8/setarch.8" > sys-utils/linux32.8

but it depends on nothing so that the sys-utils dir may not exist, we
can create the sys-utils dir to fix problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 sys-utils/Makemodule.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 6265282..62ead37 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -124,6 +124,7 @@ man_MANS += $(SETARCH_MAN_LINKS)
 CLEANFILES += $(SETARCH_MAN_LINKS)
 
 $(SETARCH_MAN_LINKS):
+	$(MKDIR_P) sys-utils
 	$(AM_V_GEN)echo ".so man8/setarch.8" > $@
 
 install-exec-hook-setarch:
-- 
1.8.2.1

