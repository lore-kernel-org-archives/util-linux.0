Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:39121 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755954Ab2DXIVE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Apr 2012 04:21:04 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E5BC190B49
	for <util-linux@vger.kernel.org>; Tue, 24 Apr 2012 10:21:02 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 4/9] build-sys: add swapon-common.h to swapon sources (fix distcheck)
Date: Tue, 24 Apr 2012 10:20:56 +0200
Message-Id: <1335255661-10611-4-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
References: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 sys-utils/Makefile.am |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index 9849429..86c525c 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -138,6 +138,7 @@ dist_man_MANS += swapoff.8 swapon.8
 swapon_SOURCES = \
 	swapon.c \
 	swapon-common.c \
+	swapon-common.h \
 	$(top_srcdir)/lib/blkdev.c \
 	$(top_srcdir)/lib/linux_version.c
 
-- 
1.7.7

