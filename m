Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:46641 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab3CUVrg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Mar 2013 17:47:36 -0400
Received: by mail-wg0-f48.google.com with SMTP id 16so864738wgi.3
        for <util-linux@vger.kernel.org>; Thu, 21 Mar 2013 14:47:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/2] docs: arch is gone, use delpart as usage() function example
Date: Thu, 21 Mar 2013 21:47:15 +0000
Message-Id: <1363902435-1487-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1363902435-1487-1-git-send-email-kerolasa@iki.fi>
References: <1363902435-1487-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The arch.c was removed in commit 27abd809.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/howto-usage-function.txt | 2 +-
 include/c.h                            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/howto-usage-function.txt b/Documentation/howto-usage-function.txt
index 371ff32..4daa736 100644
--- a/Documentation/howto-usage-function.txt
+++ b/Documentation/howto-usage-function.txt
@@ -153,5 +153,5 @@ are meant this.
 Example
 -------
 
-Command sys-utils/arch.c is a minimal example how to do write usage
+Command disk-utils/delpart.c is a minimal example how to do write usage
 function, setup option parsing, version printing and so on.
diff --git a/include/c.h b/include/c.h
index ec1020e..d2d68c3 100644
--- a/include/c.h
+++ b/include/c.h
@@ -262,7 +262,7 @@ static inline int usleep(useconds_t usec)
 
 /*
  * Constant strings for usage() functions. For more info see
- * Documentation/howto-usage-function.txt and sys-utils/arch.c
+ * Documentation/howto-usage-function.txt and disk-utils/delpart.c
  */
 #define USAGE_HEADER     _("\nUsage:\n")
 #define USAGE_OPTIONS    _("\nOptions:\n")
-- 
1.8.2

