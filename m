Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50638 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759115Ab2C2Qpu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:50 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BC7728FB75
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:49 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 17/20] build-sys: run distcheck with verbose make rules
Date: Thu, 29 Mar 2012 18:45:25 +0200
Message-Id: <1333039528-24784-18-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
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

