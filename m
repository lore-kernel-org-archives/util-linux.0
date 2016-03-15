Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:51440 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755547AbcCOPbY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Mar 2016 11:31:24 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0M1Ee8-1Zn3MP3Th2-00tCyi for
 <util-linux@vger.kernel.org>; Tue, 15 Mar 2016 16:31:21 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] Revert "lscpu: keep lscpu usable on snapshots"
Date: Tue, 15 Mar 2016 16:31:19 +0100
Message-Id: <1458055880-18766-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This reverts commit 641350fe822e7f1ac10873dad9a364bdeaba8083.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/lscpu.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 8e62c64..423bc56 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -453,36 +453,25 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	char buf[BUFSIZ];
 	struct utsname utsbuf;
 	size_t setsize;
-	int overwrite_model = 0;
 
 	/* architecture */
 	if (uname(&utsbuf) == -1)
 		err(EXIT_FAILURE, _("error: uname failed"));
 	desc->arch = xstrdup(utsbuf.machine);
 
-	/* Use another records from cpuinfo for PPC, on snapshot follow
-	 * standard behavior.
-	 *
-	 * TODO: use runtime detection to make model overwrite possible on
-	 *       snapshots too.
-	 */
-#if defined(__powerpc__) || defined(__powerpc64__)
-	if (mod->system == SYSTEM_LIVE)
-		overwrite_model = 1;
-#endif
 	/* details */
 	while (fgets(buf, sizeof(buf), fp) != NULL) {
 		if (lookup(buf, "vendor", &desc->vendor)) ;
 		else if (lookup(buf, "vendor_id", &desc->vendor)) ;
 		else if (lookup(buf, "family", &desc->family)) ;
 		else if (lookup(buf, "cpu family", &desc->family)) ;
-
-		else if (overwrite_model && lookup(buf, "revision", &desc->model)) ;
-		else if (overwrite_model && lookup(buf, "cpu", &desc->modelname)) ;
-
-		else if (!overwrite_model && lookup(buf, "model", &desc->model)) ;
-		else if (!overwrite_model && lookup(buf, "model name", &desc->modelname)) ;
-
+#if defined(__powerpc__) || defined(__powerpc64__)
+		else if (lookup(buf, "revision", &desc->model)) ;
+		else if (lookup(buf, "cpu", &desc->modelname)) ;
+#else
+		else if (lookup(buf, "model", &desc->model)) ;
+		else if (lookup(buf, "model name", &desc->modelname)) ;
+#endif
 		else if (lookup(buf, "stepping", &desc->stepping)) ;
 		else if (lookup(buf, "cpu MHz", &desc->mhz)) ;
 		else if (lookup(buf, "flags", &desc->flags)) ;		/* x86 */
-- 
1.8.4.5

