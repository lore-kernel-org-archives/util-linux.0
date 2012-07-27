Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:33558 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709Ab2G0LP6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Jul 2012 07:15:58 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5AA61A2FD6
	for <util-linux@vger.kernel.org>; Fri, 27 Jul 2012 13:15:57 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] build-sys: include tools/git-version-gen in the tarball
Date: Fri, 27 Jul 2012 13:15:54 +0200
Message-Id: <1343387754-19285-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

tools/git-version-gen is called from AC_INIT. Include it
in the tarball to make it easier to autoreconf-igure the package.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 112a4fb..1aeca79 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -61,7 +61,8 @@ EXTRA_DIST += \
 	autogen.sh \
 	Documentation \
 	po/update-potfiles \
-	README.licensing
+	README.licensing \
+	tools/git-version-gen
 
 
 include include/Makemodule.am
-- 
1.7.7

