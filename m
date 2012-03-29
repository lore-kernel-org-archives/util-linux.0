Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50641 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758958Ab2C2Qpv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:51 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id AF3A390B1D
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:50 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 18/20] build-sys: add ttyutils.h to dist
Date: Thu, 29 Mar 2012 18:45:26 +0200
Message-Id: <1333039528-24784-19-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 include/Makefile.am |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/Makefile.am b/include/Makefile.am
index b939f89..cc355ed 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -34,6 +34,7 @@ dist_noinst_HEADERS = \
 	swapheader.h \
 	sysfs.h \
 	tt.h \
+	ttyutils.h \
 	usleep.h \
 	wholedisk.h \
 	widechar.h \
-- 
1.7.7

