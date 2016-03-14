Return-Path: util-linux-owner@vger.kernel.org
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:41370 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934381AbcCNOtF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Mar 2016 10:49:05 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <hegdevasant@linux.vnet.ibm.com>;
	Tue, 15 Mar 2016 00:49:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 426423578056
	for <util-linux@vger.kernel.org>; Tue, 15 Mar 2016 01:48:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2EEmohp11141602
	for <util-linux@vger.kernel.org>; Tue, 15 Mar 2016 01:48:59 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2EEmQeb031594
	for <util-linux@vger.kernel.org>; Tue, 15 Mar 2016 01:48:26 +1100
Subject: [PATCH] lscpu: Fix model and model name on Power Systems
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Date: Mon, 14 Mar 2016 20:18:07 +0530
Message-ID: <20160314144804.415.11481.stgit@hegdevasant>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Power System, lspcu presently displays system model number instead of
processor model name. 'model' tag in cpuinfo contains system model name,
not processor model. Instead it uses 'cpu' tag for processor model name.
Also it uses 'revision' tag for processor model.

Fix lspcu so that it displays processor model number. Also display processor
model name.

cpuinfo output on Power System:
  ...
  ...

  processor	: 127
  cpu		: POWER8E (raw), altivec supported
  clock		: 4322.000000MHz
  revision	: 2.1 (pvr 004b 0201)

  timebase	: 512000000
  platform	: PowerNV
  model		: 8286-42A
  machine	: PowerNV 8286-42A
  firmware	: OPAL


Output without this patch:
  Architecture:          ppc64le
  Byte Order:            Little Endian
  CPU(s):                128
  On-line CPU(s) list:   0-127
  Thread(s) per core:    8
  Core(s) per socket:    4
  Socket(s):             4
  NUMA node(s):          4
  Model:                 8286-42A
  ...
  ...

Output with this patch:
  Architecture:          ppc64le
  Byte Order:            Little Endian
  CPU(s):                128
  On-line CPU(s) list:   0-127
  Thread(s) per core:    8
  Core(s) per socket:    4
  Socket(s):             4
  NUMA node(s):          4
  Model:                 2.1 (pvr 004b 0201)
  Model name:            POWER8E (raw), altivec supported
  ...
  ...

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 sys-utils/lscpu.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index fc32762..423bc56 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -465,8 +465,13 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		else if (lookup(buf, "vendor_id", &desc->vendor)) ;
 		else if (lookup(buf, "family", &desc->family)) ;
 		else if (lookup(buf, "cpu family", &desc->family)) ;
+#if defined(__powerpc__) || defined(__powerpc64__)
+		else if (lookup(buf, "revision", &desc->model)) ;
+		else if (lookup(buf, "cpu", &desc->modelname)) ;
+#else
 		else if (lookup(buf, "model", &desc->model)) ;
 		else if (lookup(buf, "model name", &desc->modelname)) ;
+#endif
 		else if (lookup(buf, "stepping", &desc->stepping)) ;
 		else if (lookup(buf, "cpu MHz", &desc->mhz)) ;
 		else if (lookup(buf, "flags", &desc->flags)) ;		/* x86 */

