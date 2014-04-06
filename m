Return-Path: util-linux-owner@vger.kernel.org
Received: from ozlabs.org ([203.10.76.45]:41063 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464AbaDFXSO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 6 Apr 2014 19:18:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.org (Postfix) with ESMTPSA id 6A4901400B2
	for <util-linux@vger.kernel.org>; Mon,  7 Apr 2014 09:18:13 +1000 (EST)
Date: Mon, 7 Apr 2014 09:18:13 +1000
From: Anton Blanchard <anton@samba.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] setarch: Fix ppc64le architectures
Message-ID: <20140407091813.74f6695d@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


setarch currently fails on ppc64le because it tries to
use big endian architecture names. Fix it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 99724c6..957bb2b 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -149,11 +149,17 @@ set_arch(const char *pers, unsigned long options, int list)
     {PER_LINUX32, "linux32", NULL},
     {PER_LINUX, "linux64", NULL},
 #if defined(__powerpc__) || defined(__powerpc64__)
+#ifdef __BIG_ENDIAN__
     {PER_LINUX32, "ppc32", "ppc"},
     {PER_LINUX32, "ppc", "ppc"},
     {PER_LINUX, "ppc64", "ppc64"},
     {PER_LINUX, "ppc64pseries", "ppc64"},
     {PER_LINUX, "ppc64iseries", "ppc64"},
+#else
+    {PER_LINUX32, "ppc32le", "ppcle"},
+    {PER_LINUX32, "ppcle", "ppcle"},
+    {PER_LINUX, "ppc64le", "ppc64le"},
+#endif
 #endif
 #if defined(__x86_64__) || defined(__i386__) || defined(__ia64__)
     {PER_LINUX32, "i386", "i386"},
