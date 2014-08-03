Return-Path: util-linux-owner@vger.kernel.org
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:32798 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbaHCSsW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 14:48:22 -0400
Received: from mfilter16-d.gandi.net (mfilter16-d.gandi.net [217.70.178.144])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 8D241172055
	for <util-linux@vger.kernel.org>; Sun,  3 Aug 2014 20:48:19 +0200 (CEST)
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter16-d.gandi.net (mfilter16-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id AKkZWV0408a4 for <util-linux@vger.kernel.org>;
	Sun,  3 Aug 2014 20:48:18 +0200 (CEST)
Received: from thin (static-50-43-15-134.bvtn.or.frontiernet.net [50.43.15.134])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id AA78D17207C
	for <util-linux@vger.kernel.org>; Sun,  3 Aug 2014 20:48:17 +0200 (CEST)
Date: Sun, 3 Aug 2014 11:48:15 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] Link mkswap to mkfs.swap so mkfs -t swap works
Message-ID: <20140803184813.GA20940@thin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes it easier to write generic code that deals with swap
along with other filesystems.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 disk-utils/Makemodule.am | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/disk-utils/Makemodule.am b/disk-utils/Makemodule.am
index 995e085..3f8f96b 100644
--- a/disk-utils/Makemodule.am
+++ b/disk-utils/Makemodule.am
@@ -59,6 +59,16 @@ endif
 if HAVE_SELINUX
 mkswap_LDADD += -lselinux
 endif
+
+install-exec-hook-mkswap:
+	ln -sf mkswap $(DESTDIR)$(sbindir)/mkfs.swap
+
+uninstall-hook-mkswap:
+	rm -f $(DESTDIR)$(sbindir)/mkfs.swap
+
+INSTALL_EXEC_HOOKS += install-exec-hook-mkswap
+UNINSTALL_HOOKS += uninstall-hook-mkswap
+
 endif # BUILD_MKSWAP
 
 
-- 
2.0.1

