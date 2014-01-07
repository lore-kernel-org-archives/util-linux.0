Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:46342 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbaAGWFG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Jan 2014 17:05:06 -0500
Received: by mail-wi0-f176.google.com with SMTP id hq4so4772046wib.3
        for <util-linux@vger.kernel.org>; Tue, 07 Jan 2014 14:05:04 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] fallocate: avoid preprocessor token redefinitions
Date: Tue,  7 Jan 2014 22:04:59 +0000
Message-Id: <1389132299-12109-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The FALLOC_FL_KEEP_SIZE and FALLOC_FL_PUNCH_HOLE are part of
bits/fcntl-linux.h, and one should prefer use of libc rather than
kernel header linux/falloc.h when possible.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/fallocate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 6a87673..9fa1e58 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -36,8 +36,10 @@
 # include <sys/syscall.h>
 #endif
 
-#ifdef HAVE_LINUX_FALLOC_H
-# include <linux/falloc.h>	/* for FALLOC_FL_* flags */
+#ifndef HAVE_LINUX_FALLOC_H
+# ifndef FALLOC_FL_KEEP_SIZE	/* FALLOC_FL_* should be part of */
+#  include <linux/falloc.h>	/* bits/fcntl-linux.h that is */
+# endif				/* included by fcntl.h */
 #endif
 
 #ifndef FALLOC_FL_KEEP_SIZE
-- 
1.8.5.2

