Return-Path: util-linux-owner@vger.kernel.org
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:33347 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab1F3A1C (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 Jun 2011 20:27:02 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 89AC1388CD
	for <util-linux@vger.kernel.org>; Thu, 30 Jun 2011 02:27:00 +0200 (CEST)
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id ABB4D17207E
	for <util-linux@vger.kernel.org>; Thu, 30 Jun 2011 02:26:57 +0200 (CEST)
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id pgL2IxdWWWfC for <util-linux@vger.kernel.org>;
	Thu, 30 Jun 2011 02:26:56 +0200 (CEST)
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com [209.85.210.51])
	(Authenticated sender: sendmail@perennou.com)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 868C7172084
	for <util-linux@vger.kernel.org>; Thu, 30 Jun 2011 02:26:53 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1562265pzk.10
        for <util-linux@vger.kernel.org>; Wed, 29 Jun 2011 17:26:52 -0700 (PDT)
MIME-Version: 1.0
From: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
Date: Thu, 30 Jun 2011 02:26:32 +0200
Message-ID: <BANLkTikpHa-0aVp7G7cpRw_ePOQQiuXSEYnrV-AgssjhFEf2zg@mail.gmail.com>
Subject: [PATCH] Don't try to chgrp write or wall if they are not built
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix regression from commit 4aa9d65bfa76afd0d886ca410ae83428a490d4ea

Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
---
 term-utils/Makefile.am |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/term-utils/Makefile.am b/term-utils/Makefile.am
index 5e03560..d5ba479 100644
--- a/term-utils/Makefile.am
+++ b/term-utils/Makefile.am
@@ -67,8 +67,14 @@ endif
 if USE_TTY_GROUP
 if MAKEINSTALL_DO_CHOWN
 install-exec-hook::
-       chgrp tty $(DESTDIR)$(usrbin_execdir)/wall
$(DESTDIR)$(usrbin_execdir)/write
-       chmod g+s $(DESTDIR)$(usrbin_execdir)/wall
$(DESTDIR)$(usrbin_execdir)/write
+if BUILD_WALL
+       chgrp tty $(DESTDIR)$(usrbin_execdir)/wall
+       chmod g+s $(DESTDIR)$(usrbin_execdir)/wall
+endif
+if BUILD_WRITE
+       chgrp tty $(DESTDIR)$(usrbin_execdir)/write
+       chmod g+s $(DESTDIR)$(usrbin_execdir)/write
+endif

 endif
 endif
-- 
1.7.6
