Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50647 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759612Ab2C2Qpx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:53 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 070128FE2D
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:53 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 20/20] build-sys: fix installation of uuidd units with make distcheck
Date: Thu, 29 Mar 2012 18:45:28 +0200
Message-Id: <1333039528-24784-21-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 6fec32d..12e1103 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -89,7 +89,8 @@ checkxalloc:
 
 ENABLE_ALL = --enable-static-programs --enable-most-builds
 DISTCHECK_CONFIGURE_FLAGS = --enable-gtk-doc --disable-use-tty-group \
-			    --disable-silent-rules $(ENABLE_ALL)
+			    --disable-silent-rules $(ENABLE_ALL) \
+			    --with-systemdsystemunitdir=$$dc_install_base/$(systemdsystemunitdir)
 
 
 BUILT_SOURCES = .version
-- 
1.7.7

