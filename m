Return-Path: util-linux-owner@vger.kernel.org
Received: from www.linutronix.de ([62.245.132.108]:58295 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab2BXRPG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 24 Feb 2012 12:15:06 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] conifigure: add a crosscompile path for scanf_cv_alloc_modifier
Date: Fri, 24 Feb 2012 18:16:07 +0100
Message-Id: <1330103768-32139-1-git-send-email-bigeasy@linutronix.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This allows to building the package cross again. Since the return value
is not used I guess there is little loss.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 configure.ac |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index d3b298c..c27e890 100644
--- a/configure.ac
+++ b/configure.ac
@@ -387,6 +387,8 @@ AC_CACHE_VAL([scanf_cv_alloc_modifier],
       [scanf_cv_alloc_modifier=as],
       [scanf_cv_alloc_modifier=no]
     )
+    ,
+    [scanf_cv_alloc_modifier=no]
   )
 )
 
-- 
1.7.9

