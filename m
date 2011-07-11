Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-fx0-f52.google.com ([209.85.161.52]:33259 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab1GKMqi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Jul 2011 08:46:38 -0400
Received: by fxd18 with SMTP id 18so3961122fxd.11
        for <util-linux@vger.kernel.org>; Mon, 11 Jul 2011 05:46:37 -0700 (PDT)
Subject: [PATCH] build-sys: fix spaces versus tabs conflict
From: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Mon, 11 Jul 2011 14:46:27 +0200
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310388392.30860.1.camel@Lou.local>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For some reason, tabs were replaced by spaces in commit
73ae0d5be6e070afe83d1a2324ac79941629201e

Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
---
 term-utils/Makefile.am |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/term-utils/Makefile.am b/term-utils/Makefile.am
index 5013898..7b545c3 100644
--- a/term-utils/Makefile.am
+++ b/term-utils/Makefile.am
@@ -68,12 +68,12 @@ if USE_TTY_GROUP
 if MAKEINSTALL_DO_CHOWN
 install-exec-hook::
 if BUILD_WALL
-       chgrp tty $(DESTDIR)$(usrbin_execdir)/wall
-       chmod g+s $(DESTDIR)$(usrbin_execdir)/wall
+	chgrp tty $(DESTDIR)$(usrbin_execdir)/wall
+	chmod g+s $(DESTDIR)$(usrbin_execdir)/wall
 endif
 if BUILD_WRITE
-       chgrp tty $(DESTDIR)$(usrbin_execdir)/write
-       chmod g+s $(DESTDIR)$(usrbin_execdir)/write
+	chgrp tty $(DESTDIR)$(usrbin_execdir)/write
+	chmod g+s $(DESTDIR)$(usrbin_execdir)/write
 endif
 endif
 endif
-- 
1.7.6.134.gcf13f6.dirty


