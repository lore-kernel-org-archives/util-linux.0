Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49279 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab2JNUVX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:23 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1315606wib.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:22 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/19] c.h: remove unnecessary MAXHOSTNAMELEN fallback definition
Date: Sun, 14 Oct 2012 21:20:56 +0100
Message-Id: <1350246070-10544-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/c.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/c.h b/include/c.h
index 64c0138..125ec62 100644
--- a/include/c.h
+++ b/include/c.h
@@ -224,17 +224,6 @@ static inline int dirfd(DIR *d)
 #endif
 
 /*
- * Fallback for MAXHOSTNAMELEN
- */
-#ifndef MAXHOSTNAMELEN
-# ifdef HOST_NAME_MAX
-#  define MAXHOSTNAMELEN HOST_NAME_MAX
-# else
-#  define MAXHOSTNAMELEN 64
-# endif
-#endif
-
-/*
  * Constant strings for usage() functions. For more info see
  * Documentation/howto-usage-function.txt and sys-utils/arch.c
  */
-- 
1.7.12.2

