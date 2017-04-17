Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932354AbdDQIbD (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Apr 2017 04:31:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v3H8T6t4070450
        for <util-linux@vger.kernel.org>; Mon, 17 Apr 2017 04:31:02 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
        by mx0a-001b2d01.pphosted.com with ESMTP id 29udufvx2k-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Mon, 17 Apr 2017 04:31:02 -0400
Received: from localhost
        by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Mon, 17 Apr 2017 14:00:55 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
        by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v3H8TU7w10944572
        for <util-linux@vger.kernel.org>; Mon, 17 Apr 2017 13:59:31 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
        by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v3H8UsIV025268
        for <util-linux@vger.kernel.org>; Mon, 17 Apr 2017 14:00:54 +0530
Received: from localhost.localdomain ([9.124.158.109])
        by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id v3H8UrlN025246
        for <util-linux@vger.kernel.org>; Mon, 17 Apr 2017 14:00:53 +0530
Subject: [PATCH]lscpu: Read available CPUs max and min frequencies 
From: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
To: util-linux@vger.kernel.org
Date: Mon, 17 Apr 2017 14:00:48 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149241772437.12614.9759492302686190446.stgit@localhost.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Problem: On power syatems "lscpu frequency-info" command was always 
reading CPU0 max and min frequencies. If CPU0 is guarded or offline 
then it used to display max and min frequencies as NULL.

Solution: This patch will check for the available/online CPUs
and read the max/min frequencies of that CPU

Test Results:

Before Patch:

#lscpu (CPU0 is guarded/offline)
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                120
On-line CPU(s) list:   8-127
Thread(s) per core:    8
Core(s) per socket:    3
Socket(s):             4
NUMA node(s):          4
Model:                 2.1 (pvr 004b 0201)
Model name:            POWER8E (raw), altivec supported
CPU max MHz:           (null)
CPU min MHz:           (null)
L1d cache:             64K
L1i cache:             32K
L2 cache:              512K
L3 cache:              8192K
NUMA node0 CPU(s):     8-31
NUMA node1 CPU(s):     32-63
NUMA node16 CPU(s):    64-95
NUMA node17 CPU(s):    96-127

With Patch:

# ./lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                120
On-line CPU(s) list:   8-127
Thread(s) per core:    8
Core(s) per socket:    3
Socket(s):             4
NUMA node(s):          4
Model:                 2.1 (pvr 004b 0201)
Model name:            POWER8E (raw), altivec supported
CPU max MHz:           4322.0000
CPU min MHz:           2061.0000
L1d cache:             64K
L1i cache:             32K
L2 cache:              512K
L3 cache:              8192K
NUMA node0 CPU(s):     8-31
NUMA node1 CPU(s):     32-63
NUMA node16 CPU(s):    64-95
NUMA node17 CPU(s):    96-127

Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
---
 sys-utils/lscpu.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 683fd66..7f92b20 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1775,7 +1775,7 @@ static void
 print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 {
 	char buf[512];
-	int i;
+	int i = 0;
 	size_t setsize = CPU_ALLOC_SIZE(maxcpus);
 
 	print_s(_("Architecture:"), desc->arch);
@@ -1898,9 +1898,21 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	if (desc->static_mhz)
 		print_s(_("CPU static MHz:"), desc->static_mhz);
 	if (desc->maxmhz)
-		print_s(_("CPU max MHz:"), desc->maxmhz[0]);
+		for (i = 0; i < desc->ncpuspos; i++) {
+			/*Check for the first online CPU */
+			if (desc->present &&
+				CPU_ISSET(real_cpu_num(desc, i), desc->present))
+				break;
+			}
+	print_s(_("CPU max MHz:"), desc->maxmhz[i]);
 	if (desc->minmhz)
-		print_s(_("CPU min MHz:"), desc->minmhz[0]);
+		for (i = 0; i < desc->ncpuspos; i++) {
+		/*Check for the first online CPU */
+			if (desc->present &&
+				CPU_ISSET(real_cpu_num(desc, i), desc->present))
+				break;
+		}
+	print_s(_("CPU min MHz:"), desc->minmhz[i]);
 	if (desc->bogomips)
 		print_s(_("BogoMIPS:"), desc->bogomips);
 	if (desc->virtflag) {

