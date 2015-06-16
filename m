Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:52319 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755057AbbFPO1C (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Jun 2015 10:27:02 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MO7ee-1ZAM0E3ilQ-005ZoC for
 <util-linux@vger.kernel.org>; Tue, 16 Jun 2015 16:26:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] procutils: reset errno before readdir
Date: Tue, 16 Jun 2015 16:26:56 +0200
Message-Id: <1434464817-8851-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1434464817-8851-1-git-send-email-sweet_f_a@gmx.de>
References: <1434464817-8851-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

readdir(3p): "When the end of the directory is encountered, a null
pointer shall be returned and errno is not changed"

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/procutils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/procutils.c b/lib/procutils.c
index ef96941..1823d16 100644
--- a/lib/procutils.c
+++ b/lib/procutils.c
@@ -143,6 +143,7 @@ int proc_next_pid(struct proc_processes *ps, pid_t *pid)
 	do {
 		char buf[BUFSIZ], *p;
 
+		errno = 0;
 		d = readdir(ps->dir);
 		if (!d)
 			return errno ? -1 : 1;		/* error or end-of-dir */
-- 
1.8.4.5

