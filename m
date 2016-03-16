Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:51996 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965443AbcCPMS1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 08:18:27 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH 2/3] lscpu: use cpu and revision tag if available
Date: Wed, 16 Mar 2016 13:18:18 +0100
Message-Id: <1458130699-25464-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458130699-25464-1-git-send-email-sweet_f_a@gmx.de>
References: <1458130699-25464-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Avoid ifdef which does not work with --sysroot. Our existing test
dumps produce even better output now for ppc and sparc.

The logic moved to the printing section.

CC: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/lscpu.c                             | 17 ++++++++---------
 tests/expected/lscpu/lscpu-ppc-qemu           |  3 ++-
 tests/expected/lscpu/lscpu-ppc64-POWER7       |  3 ++-
 tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu |  3 ++-
 tests/expected/lscpu/lscpu-sparc64            |  1 +
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 423bc56..3b338aa 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -191,6 +191,8 @@ struct lscpu_desc {
 	char	*family;
 	char	*model;
 	char	*modelname;
+	char	*revision;  /* alternative for model (ppc) */
+	char	*cpu;       /* alternative for modelname (ppc, sparc) */
 	char	*virtflag;	/* virtualization flag (vmx, svm) */
 	char	*hypervisor;	/* hypervisor software */
 	int	hyper;		/* hypervisor vendor ID */
@@ -465,13 +467,8 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		else if (lookup(buf, "vendor_id", &desc->vendor)) ;
 		else if (lookup(buf, "family", &desc->family)) ;
 		else if (lookup(buf, "cpu family", &desc->family)) ;
-#if defined(__powerpc__) || defined(__powerpc64__)
-		else if (lookup(buf, "revision", &desc->model)) ;
-		else if (lookup(buf, "cpu", &desc->modelname)) ;
-#else
 		else if (lookup(buf, "model", &desc->model)) ;
 		else if (lookup(buf, "model name", &desc->modelname)) ;
-#endif
 		else if (lookup(buf, "stepping", &desc->stepping)) ;
 		else if (lookup(buf, "cpu MHz", &desc->mhz)) ;
 		else if (lookup(buf, "flags", &desc->flags)) ;		/* x86 */
@@ -479,6 +476,8 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		else if (lookup(buf, "type", &desc->flags)) ;		/* sparc64 */
 		else if (lookup(buf, "bogomips", &desc->bogomips)) ;
 		else if (lookup(buf, "bogomips per cpu", &desc->bogomips)) ; /* s390 */
+		else if (lookup(buf, "cpu", &desc->cpu)) ;
+		else if (lookup(buf, "revision", &desc->revision)) ;
 		else
 			continue;
 	}
@@ -1649,10 +1648,10 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		print_s(_("Vendor ID:"), desc->vendor);
 	if (desc->family)
 		print_s(_("CPU family:"), desc->family);
-	if (desc->model)
-		print_s(_("Model:"), desc->model);
-	if (desc->modelname)
-		print_s(_("Model name:"), desc->modelname);
+	if (desc->model || desc->revision)
+		print_s(_("Model:"), desc->revision ? desc->revision : desc->model);
+	if (desc->modelname || desc->cpu)
+		print_s(_("Model name:"), desc->cpu ? desc->cpu : desc->modelname);
 	if (desc->stepping)
 		print_s(_("Stepping:"), desc->stepping);
 	if (desc->mhz)
diff --git a/tests/expected/lscpu/lscpu-ppc-qemu b/tests/expected/lscpu/lscpu-ppc-qemu
index b3ea4a7..78b0b29 100644
--- a/tests/expected/lscpu/lscpu-ppc-qemu
+++ b/tests/expected/lscpu/lscpu-ppc-qemu
@@ -3,7 +3,8 @@ On-line CPU(s) list:   0
 Thread(s) per core:    1
 Core(s) per socket:    1
 Socket(s):             1
-Model:                 Power Macintosh
+Model:                 3.1 (pvr 0008 0301)
+Model name:            740/750
 BogoMIPS:              33.25
 L1d cache:             unknown size
 L1i cache:             unknown size
diff --git a/tests/expected/lscpu/lscpu-ppc64-POWER7 b/tests/expected/lscpu/lscpu-ppc64-POWER7
index 0d6c5ba..9a3c0c9 100644
--- a/tests/expected/lscpu/lscpu-ppc64-POWER7
+++ b/tests/expected/lscpu/lscpu-ppc64-POWER7
@@ -4,7 +4,8 @@ Thread(s) per core:    4
 Core(s) per socket:    1
 Socket(s):             4
 NUMA node(s):          1
-Model:                 IBM,8233-E8B
+Model:                 2.1 (pvr 003f 0201)
+Model name:            POWER7 (architected), altivec supported
 L1d cache:             32K
 L1i cache:             32K
 NUMA node0 CPU(s):     0-15
diff --git a/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu b/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu
index e48735e..0aed12a 100644
--- a/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu
+++ b/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu
@@ -4,7 +4,8 @@ Thread(s) per core:    4
 Core(s) per socket:    1
 Socket(s):             16
 NUMA node(s):          2
-Model:                 IBM,8231-E2B
+Model:                 2.1 (pvr 003f 0201)
+Model name:            POWER7 (architected), altivec supported
 Hypervisor vendor:     pHyp
 Virtualization type:   para
 L1d cache:             32K
diff --git a/tests/expected/lscpu/lscpu-sparc64 b/tests/expected/lscpu/lscpu-sparc64
index 629b399..aacaf11 100644
--- a/tests/expected/lscpu/lscpu-sparc64
+++ b/tests/expected/lscpu/lscpu-sparc64
@@ -4,6 +4,7 @@ On-line CPU(s) list:   6,7,10,11,14,15
 Thread(s) per core:    1
 Core(s) per socket:    1
 Socket(s):             6
+Model name:            TI UltraSparc II  (BlackBird)
 Flags:                 sun4u
 
 # The following is the parsable format, which can be fed to other
-- 
1.8.4.5

