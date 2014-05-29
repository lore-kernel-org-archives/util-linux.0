Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:63468 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754167AbaE2AxV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 28 May 2014 20:53:21 -0400
Received: from tenfore.ga-group.nl ([77.12.144.175]) by mail.gmx.com
 (mrgmx001) with ESMTPSA (Nemesis) id 0LjaEi-1WIghL31ZY-00bZAh for
 <util-linux@vger.kernel.org>; Thu, 29 May 2014 02:53:19 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] setarch, add generic support for setarch $(uname -m) ...
Date: Thu, 29 May 2014 02:53:18 +0200
Message-Id: <1401324798-15059-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1401324798-15059-1-git-send-email-sweet_f_a@gmx.de>
References: <201405270134.29753.sweet_f_a@gmx.de>
 <1401324798-15059-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/setarch.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 8e2b6e5..f335f83 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -202,9 +202,25 @@ set_arch(const char *pers, unsigned long options, int list)
     {PER_LINUX, "alphaev6", "alpha"},
     {PER_LINUX, "alphaev67", "alpha"},
 #endif
+    {-1, NULL, NULL}, /* place holder, eventually filled up at runtime */
     {-1, NULL, NULL}
   };
 
+  /* Add the trivial transition {PER_LINUX, machine, machine} if no such
+     target_arch is hardcoded yet. */
+  uname(&un);
+  for (i = 0; transitions[i].perval >= 0; i++)
+  	if(!strcmp(un.machine, transitions[i].target_arch))
+  		break;
+  if (transitions[i].perval < 0) {
+  	unsigned long wrdsz = CHAR_BIT * sizeof(void*);
+  	if (wrdsz == 32 || wrdsz == 64) {
+  		transitions[i].perval = wrdsz == 32 ? PER_LINUX32 : PER_LINUX;
+  		transitions[i].target_arch = un.machine;
+  		transitions[i].result_arch = un.machine;
+  	}
+  }
+
   if (list) {
     for(i = 0; transitions[i].target_arch != NULL; i++)
       printf("%s\n", transitions[i].target_arch);
-- 
1.8.4.5

