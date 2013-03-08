Return-Path: util-linux-owner@vger.kernel.org
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39535 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab3CHTnY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 8 Mar 2013 14:43:24 -0500
Date: Fri, 8 Mar 2013 11:43:17 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: util-linux@vger.kernel.org
Cc: Anton Cherkashyn <mail@antonc.com>
Subject: [PATCH] namespace.h: Fix typo: s/CLONE_NEWSNS/CLONE_NEWNS/
Message-ID: <20130308194315.GA7638@jtriplet-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This typo causes namespace.h to always unconditionally define
CLONE_NEWNS rather than using the system definition.

Bug present since the initial version of unshare in commit
4205f1fda1ac32046125a2e0f3937b666186bfab.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Anton Cherkashyn <mail@antonc.com>
---
 include/namespace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/namespace.h b/include/namespace.h
index 3a219ce..9d58f13 100644
--- a/include/namespace.h
+++ b/include/namespace.h
@@ -4,7 +4,7 @@
 
 # include <sched.h>
 
-# ifndef CLONE_NEWSNS
+# ifndef CLONE_NEWNS
 #  define CLONE_NEWNS 0x00020000
 # endif
 # ifndef CLONE_NEWUTS
-- 
1.7.10.4

