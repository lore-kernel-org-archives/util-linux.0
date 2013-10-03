Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39556 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab3JCJjb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Oct 2013 05:39:31 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so2205233pdj.35
        for <util-linux@vger.kernel.org>; Thu, 03 Oct 2013 02:39:31 -0700 (PDT)
From: Michael Forney <mforney@mforney.org>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] Fix check for __GNU_LIBRARY__
Date: Thu,  3 Oct 2013 02:39:19 -0700
Message-Id: <1380793159-27602-4-git-send-email-mforney@mforney.org>
In-Reply-To: <1380792968-1176-1-git-send-email-mforney@mforney.org>
References: <1380792968-1176-1-git-send-email-mforney@mforney.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If we are not on glibc, __GNU_LIBRARY__ will not exist causing the check
to always fail and try to use syscalls directly.
---
 term-utils/setterm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index d41e335..f179ea8 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -124,7 +124,7 @@
 #include "nls.h"
 #include "closestream.h"
 
-#if __GNU_LIBRARY__ < 5
+#if defined(__GNU_LIBRARY__) && __GNU_LIBRARY__ < 5
 #ifndef __alpha__
 # include <linux/unistd.h>
 #define __NR_klogctl __NR_syslog
-- 
1.8.4

