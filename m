Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48511 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755765Ab1GEROL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 Jul 2011 13:14:11 -0400
Received: by gwaa18 with SMTP id a18so2398723gwa.19
        for <util-linux@vger.kernel.org>; Tue, 05 Jul 2011 10:14:11 -0700 (PDT)
MIME-Version: 1.0
From: Kirill Elagin <kirelagin@gmail.com>
Date: Tue, 5 Jul 2011 21:13:51 +0400
Message-ID: <CABVT_geJbR477C0OBrT1_Mn+iz0sUEE7mLuG56JytoF15uMHTg@mail.gmail.com>
Subject: [PATCH] Fix install-exec-hook to check whether wall and write were built
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Kirill Elagin <kirelagin@gmail.com>
---
 term-utils/Makefile.am |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/term-utils/Makefile.am b/term-utils/Makefile.am
index 5e03560..8ab9d0b 100644
--- a/term-utils/Makefile.am
+++ b/term-utils/Makefile.am
@@ -66,9 +66,15 @@ endif

 if USE_TTY_GROUP
 if MAKEINSTALL_DO_CHOWN
+if BUILD_WALL
 install-exec-hook::
-   chgrp tty $(DESTDIR)$(usrbin_execdir)/wall $(DESTDIR)$(usrbin_execdir)/write
-   chmod g+s $(DESTDIR)$(usrbin_execdir)/wall $(DESTDIR)$(usrbin_execdir)/write
-
+   chgrp tty $(DESTDIR)$(usrbin_execdir)/wall
+   chmod g+s $(DESTDIR)$(usrbin_execdir)/wall
+endif
+if BUILD_WRITE
+install-exec-hook::
+   chgrp tty $(DESTDIR)$(usrbin_execdir)/write
+   chmod g+s $(DESTDIR)$(usrbin_execdir)/write
+endif
 endif
 endif
--
1.7.3.4
