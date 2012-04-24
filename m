Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:39120 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755913Ab2DXIVE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Apr 2012 04:21:04 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8639C90983
	for <util-linux@vger.kernel.org>; Tue, 24 Apr 2012 10:21:02 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 3/9] build-sys: add ttyutils.h to dist
Date: Tue, 24 Apr 2012 10:20:55 +0200
Message-Id: <1335255661-10611-3-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
References: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 include/Makefile.am |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/Makefile.am b/include/Makefile.am
index 3f50970..f61cb04 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -36,6 +36,7 @@ dist_noinst_HEADERS = \
 	swapheader.h \
 	sysfs.h \
 	tt.h \
+	ttyutils.h \
 	usleep.h \
 	wholedisk.h \
 	widechar.h \
-- 
1.7.7

