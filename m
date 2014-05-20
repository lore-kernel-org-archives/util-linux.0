Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:61732 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753497AbaETPnJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 11:43:09 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MUHbK-1WLjAM13xK-00Qwwo for
 <util-linux@vger.kernel.org>; Tue, 20 May 2014 17:43:08 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/5] lscpu: avoid compiler warnings
Date: Tue, 20 May 2014 15:42:31 +0000
Message-Id: <1400600551-7227-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/lscpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index ee3ad19..58f6609 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -598,6 +598,9 @@ static jmp_buf segv_handler_env;
 static void
 segv_handler(int sig, siginfo_t *info, void *ignored)
 {
+	(void)sig;
+	(void)info;
+	(void)ignored;
 	siglongjmp(segv_handler_env, 1);
 }
 
-- 
1.8.4.5

