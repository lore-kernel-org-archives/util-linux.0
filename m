Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932575AbdD0KYA (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 27 Apr 2017 06:24:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v3RANc4P004693
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 06:23:59 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2a3ah43gc4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 06:23:59 -0400
Received: from localhost
        by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Thu, 27 Apr 2017 20:23:56 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v3RANkFG1311222
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 20:23:54 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v3RANKmj015438
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 20:23:20 +1000
Received: from localhost.localdomain ([9.124.158.109])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id v3RANJax015039
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 20:23:20 +1000
Subject: [PATCH V2]lscpu: Read available CPUs max and min frequencies
From: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
To: util-linux@vger.kernel.org
Date: Thu, 27 Apr 2017 15:52:59 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149328816596.3522.18183659350666784285.stgit@localhost.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Problem:"lscpu frequency-info" command was always reading CPU0
max and min frequencies. If CPU0 is guarded or offline then it used to
display max and min frequencies as NULL.

This patch will read overall CPU max and min frequencies.

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
 sys-utils/lscpu.c |   45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 7da441e..86aa875 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1255,6 +1255,35 @@ read_configured(struct lscpu_desc *desc, int idx)
 	desc->configured[idx] = path_read_s32(_PATH_SYS_CPU "/cpu%d/configure", num);
 }
 
+/* Read overall maximum frequency of cpu */
+static void
+cpu_max_mhz(struct lscpu_desc *desc, char *max_freq)
+{
+	int i;
+	float cpu_freq = atof(desc->maxmhz[0]);
+	for (i = 1; i < desc->ncpuspos; i++) {
+		if (desc->present && CPU_ISSET(real_cpu_num(desc, i), desc->present))
+			if(atof(desc->maxmhz[i]) > cpu_freq)
+				cpu_freq = atof(desc->maxmhz[i]);
+	}
+	sprintf(max_freq, "%.4f", cpu_freq);
+}
+
+/* Read overall minimum frequency of cpu */
+static void
+cpu_min_mhz(struct lscpu_desc *desc, char *min_freq)
+{
+        int i;
+        float cpu_freq = atof(desc->minmhz[0]);
+        for (i = 1; i < desc->ncpuspos; i++) {
+                if (desc->present && CPU_ISSET(real_cpu_num(desc, i), desc->present))
+                        if(atof(desc->minmhz[i]) > cpu_freq)
+                                cpu_freq = atof(desc->minmhz[i]);
+        }
+        sprintf(min_freq, "%.4f", cpu_freq);
+}
+
+
 static void
 read_max_mhz(struct lscpu_desc *desc, int idx)
 {
@@ -1809,7 +1838,9 @@ static void
 print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 {
 	char buf[512];
-	int i;
+	int i = 0;
+	char max_freq[32];
+	char min_freq[32];
 	size_t setsize = CPU_ALLOC_SIZE(maxcpus);
 	struct libscols_table *tb;
 
@@ -1947,10 +1978,14 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		add_summary_s(tb, _("CPU dynamic MHz:"), desc->dynamic_mhz);
 	if (desc->static_mhz)
 		add_summary_s(tb, _("CPU static MHz:"), desc->static_mhz);
-	if (desc->maxmhz)
-		add_summary_s(tb, _("CPU max MHz:"), desc->maxmhz[0]);
-	if (desc->minmhz)
-		add_summary_s(tb, _("CPU min MHz:"), desc->minmhz[0]);
+	if (desc->maxmhz){
+		cpu_max_mhz(desc, max_freq);
+		add_summary_s(tb, _("CPU max MHz:"), max_freq);
+	}
+	if (desc->minmhz){
+		cpu_min_mhz(desc, min_freq);
+		add_summary_s(tb, _("CPU min MHz:"), min_freq);
+	}
 	if (desc->bogomips)
 		add_summary_s(tb, _("BogoMIPS:"), desc->bogomips);
 	if (desc->virtflag) {

