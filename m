Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f176.google.com ([74.125.82.176]:57230 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaIGMnw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:52 -0400
Received: by mail-we0-f176.google.com with SMTP id q58so1083509wes.35
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/17] setarch: use personality() system call when it is available
Date: Sun,  7 Sep 2014 13:43:04 +0100
Message-Id: <1410093785-17537-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setarch.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 468e492..ed2a6a6 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -24,8 +24,7 @@
  * sparc32 util by Jakub Jelinek (1998, 1999)
  */
 
-#include <syscall.h>
-#include <linux/personality.h>
+#include <sys/personality.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <string.h>
@@ -37,7 +36,10 @@
 #include "c.h"
 #include "closestream.h"
 
-#define set_pers(pers) ((long)syscall(SYS_personality, pers))
+#ifndef HAVE_PERSONALITY
+# include <syscall.h>
+# define personality(pers) ((long)syscall(SYS_personality, pers))
+#endif
 
 /* Options without equivalent short options */
 enum {
@@ -229,7 +231,7 @@ static int set_arch(const char *pers, unsigned long options, int list)
 	if (transitions[i].perval < 0)
 		errx(EXIT_FAILURE, _("%s: Unrecognized architecture"), pers);
 	pers_value = transitions[i].perval | options;
-	if (set_pers(pers_value) == -EINVAL)
+	if (personality(pers_value) == -EINVAL)
 		return 1;
 	uname(&un);
 	if (transitions[i].result_arch && strcmp(un.machine, transitions[i].result_arch)) {
-- 
2.1.0

