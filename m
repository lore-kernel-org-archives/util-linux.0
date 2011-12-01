Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36630 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393Ab1LAWK0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 1 Dec 2011 17:10:26 -0500
Received: by eeaq14 with SMTP id q14so859597eea.19
        for <util-linux@vger.kernel.org>; Thu, 01 Dec 2011 14:10:25 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/2] build-sys: add missing headers to dist
Date: Thu,  1 Dec 2011 23:10:20 +0100
Message-Id: <1322777421-11541-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/Makefile.am |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/Makefile.am b/include/Makefile.am
index 237840a..aa72a3e 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -18,10 +18,12 @@ dist_noinst_HEADERS = \
 	list.h \
 	loopdev.h \
 	mangle.h \
+	match.h \
 	mbsalign.h \
 	md5.h \
 	minix.h \
 	nls.h \
+	optutils.h \
 	pamfail.h \
 	path.h \
 	pathnames.h \
-- 
1.7.7.4

