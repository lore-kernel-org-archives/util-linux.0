Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:39118 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755697Ab2DXIVE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Apr 2012 04:21:04 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id C2A5B8FFEB
	for <util-linux@vger.kernel.org>; Tue, 24 Apr 2012 10:21:01 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 1/9] build-sys: run distcheck with verbose make rules
Date: Tue, 24 Apr 2012 10:20:53 +0200
Message-Id: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 9ac1ffc..6fec32d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -88,7 +88,8 @@ checkxalloc:
 	@ $(top_srcdir)/tools/checkxalloc.sh
 
 ENABLE_ALL = --enable-static-programs --enable-most-builds
-DISTCHECK_CONFIGURE_FLAGS = --enable-gtk-doc --disable-use-tty-group $(ENABLE_ALL)
+DISTCHECK_CONFIGURE_FLAGS = --enable-gtk-doc --disable-use-tty-group \
+			    --disable-silent-rules $(ENABLE_ALL)
 
 
 BUILT_SOURCES = .version
-- 
1.7.7

