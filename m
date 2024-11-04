Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819338F97
	for <util-linux@vger.kernel.org>; Mon,  4 Nov 2024 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701988; cv=none; b=LnmLjVpBjAycUQhV6AdhxqvDp6wH5xvjHX2W1xdJdKbBFCctveMZQJQNzVzEXWwLs/aFpkHPuLwAXSxCe6qM8xPKw4qNzRBe0vIe0oLfnAjMCC7RdwZ8tNR2xaYKgjVJH/7rYEx6Y12EZ0YZoxgNfrLr8hHlqWMWrfgCdyK86BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701988; c=relaxed/simple;
	bh=uz82i9J2RMGA6mFUf4lZtRGSIWzEW/J3MCMCaT8LTc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3tyNVKalr+fXtKmbcM/EEsSy+56umrygz47c+DowyR03mELH8oCrQuLQPEuBzaubCWOE7wS15cD+5iGrwsR4lUeaBxDtPz/hVHyFdi+GT3DJjW0tGk1py6DHSbBikPWKckW+N5tnzYJRqBLU24gD1vgC+fe4huv+V70ZAvV44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LCl5ox6R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LCl5ox6R"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A466M9V014200;
	Mon, 4 Nov 2024 06:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yR4ncOIoxNRa12uaUO5sAKoZYEPFQNq0gZdNNv37S
	Jk=; b=LCl5ox6RoPaswtC9czpkeg+e2LnQvqvNbbM64IgFsJcgCPXhCeeHdbmn3
	X3/Q+YcUoyAYk38u+cf1I6+63pDO3iqAcsg+8s6g6rF0WR05SSX0/VOsPKm89g+x
	QFJo/NLffz2FkohQIVXKbQXpGYzZCbiWMmg92mO/o47olrItCPTmlAM4CiC+Vjwd
	KjngmseA/TkmVKNDrXtCEj1/jwB85cp2usY3Jyd/H+Ed88J+k+Y5ByM+dswZb6HH
	sLhmPQn780P4BmtBSSdGS/NQiDbRV9Z6eCCNuQU8sglHj6wmPFlO1QQFgyqrrMXy
	Z/b4p3wjkoG9IwrvU/ejhI2csjoPg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pqejgab3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 06:33:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A465qnw024174;
	Mon, 4 Nov 2024 06:33:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsxtnjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 06:33:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A46WwUZ27525710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 06:32:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 431D020043;
	Mon,  4 Nov 2024 06:32:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AACBC20040;
	Mon,  4 Nov 2024 06:32:56 +0000 (GMT)
Received: from li-a929834c-276e-11b2-a85c-d3428da96d80.ibm.com.com (unknown [9.39.22.122])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 06:32:56 +0000 (GMT)
From: Anjali K <anjalik@linux.ibm.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com, anushree.mathur@linux.ibm.com, anjalik@linux.ibm.com
Subject: [PATCH v2] lscpu: fix incorrect number of sockets during hotplug
Date: Mon,  4 Nov 2024 12:02:26 +0530
Message-ID: <20241104063226.172077-1-anjalik@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XViri1cC0smXT4PgiM6vRv8oWiX3DMlb
X-Proofpoint-GUID: XViri1cC0smXT4PgiM6vRv8oWiX3DMlb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040053

lscpu sometimes shows incorrect 'Socket(s)' value if a hotplug operation
is running.
On a 32 CPU 2-socket system, the expected output is as shown below:
Architecture:           	      ppc64le
Byte Order:             	      Little Endian
CPU(s):                  	      32
On-line CPU(s) list:   		      0-31
Model name:               	      POWER10 (architected), altivec supported
Model:                  	      2.0 (pvr 0080 0200)
Thread(s) per core:     	      8
Core(s) per socket:     	      2
Socket(s):              	      2

On the same system, if hotplug is running along with lscpu, it shows
"Socket(s):" as 3 and 4 incorrectly sometimes.
Architecture:                         ppc64le
Byte Order:                           Little Endian
CPU(s):                               32
On-line CPU(s) list:                  0-11,16-31
Off-line CPU(s) list:                 12-15
Model name:                           POWER10 (architected), altivec supported
Model:                                2.0 (pvr 0080 0200)
Thread(s) per core:                   8
Core(s) per socket:                   1
Socket(s):                            3

The number of sockets is considered as the number of unique core_siblings
CPU groups. The issues causing the number of sockets to sometimes be
higher during hotplug is:
1. The core_siblings of CPUs on the same socket are different because a CPU
on the socket has been onlined/offlined in between. In the below example,
nr sockets was wrongly incremented for CPU 5 though CPU 4 and 5 are on the
same socket because their core_siblings was different as CPU 12 was onlined
in between.
CPU: 4
core_siblings: ff f0 0 0 0 0 0 0
CPU: 5
core_siblings: ff f8 0 0 0 0 0 0

2. The core_siblings file of a CPU is created when a CPU is onlined. It may
have an invalid value for some time until the online operation is fully
complete. In the below example, nr sockets is wrongly incremented because
the core_siblings of CPU 14 was 0 as it had just been onlined.
CPU: 14
core_siblings: 0 0 0 0 0 0 0 0

To fix this, make the below changes:
1. Instead of considering CPUs to be on different sockets if their
core_siblings masks are unequal, consider them to be on different sockets
only if their core_siblings masks don't have even one common CPU. Then CPUs
on the same socket will be correctly identified even if offline/online
operations happen while they are read if at least one CPU in the socket is
online during both reads.
2. Check if a CPU's hotplug operation has been completed before using its
core_siblings file

Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Signed-off-by: Anjali K <anjalik@linux.ibm.com>
---
 sys-utils/lscpu-topology.c | 71 ++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/sys-utils/lscpu-topology.c b/sys-utils/lscpu-topology.c
index e3742e319..7fb4a1af9 100644
--- a/sys-utils/lscpu-topology.c
+++ b/sys-utils/lscpu-topology.c
@@ -17,19 +17,25 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdio.h>
+#include <ctype.h>
 
 #include "lscpu.h"
 
 /* add @set to the @ary, unnecessary set is deallocated. */
-static int add_cpuset_to_array(cpu_set_t **ary, size_t *items, cpu_set_t *set, size_t setsize)
+static int add_cpuset_to_array(cpu_set_t **ary, size_t *items, cpu_set_t *set, size_t setsize, cpu_set_t *common_cpus_set)
 {
 	size_t i;
 
 	if (!ary)
 		return -EINVAL;
 
+	/*
+	 * Check if @set has no cpu in common with the cpusets
+	 * saved in @ary and if so append @set to @ary.
+	 */
 	for (i = 0; i < *items; i++) {
-		if (CPU_EQUAL_S(setsize, set, ary[i]))
+		CPU_AND_S(setsize, common_cpus_set, set, ary[i]);
+		if (CPU_COUNT_S(setsize, common_cpus_set))
 			break;
 	}
 	if (i == *items) {
@@ -98,14 +104,49 @@ void lscpu_sort_caches(struct lscpu_cache *caches, size_t n)
 		qsort(caches, n, sizeof(struct lscpu_cache), cmp_cache);
 }
 
+/*
+ * Get the hotplug state number representing a completely online
+ * cpu from /sys/devices/system/cpu/hotplug/state
+ */
+static int get_online_state(struct path_cxt *sys)
+{
+	int hp_online_state_val, page_size, rc;
+	char *buf, *strp;
+
+	hp_online_state_val = -1;
+
+	/* sysfs text files have size = page size */
+	page_size = getpagesize();
+
+	buf = (char *)malloc(page_size);
+	if (!buf)
+		goto done;
+	rc = ul_path_readf_buffer(sys, buf, page_size, "hotplug/states");
+	if (rc <= 0)
+		goto done;
+
+	strp = strstr(buf, ": online");
+	if (!strp)
+		goto done;
+
+	strp--; /* get digits before ': online' */
+	while (strp >= buf && isdigit(*strp))
+		strp--;
+	hp_online_state_val = atoi(strp + 1);
+
+done:
+	free(buf);
+	return hp_online_state_val;
+}
 
 /* Read topology for specified type */
 static int cputype_read_topology(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 {
 	size_t i, npos;
 	struct path_cxt *sys;
-	int nthreads = 0, sw_topo = 0;
+	int nthreads = 0, sw_topo = 0, rc, hp_state, hp_online_state;
 	FILE *fd;
+	cpu_set_t *temp_set;
 
 	sys = cxt->syscpu;				/* /sys/devices/system/cpu/ */
 	npos = cxt->npossibles;				/* possible CPUs */
@@ -113,6 +154,12 @@ static int cputype_read_topology(struct lscpu_cxt *cxt, struct lscpu_cputype *ct
 	DBG(TYPE, ul_debugobj(ct, "reading %s/%s/%s topology",
 				ct->vendor ?: "", ct->model ?: "", ct->modelname ?:""));
 
+	hp_online_state = get_online_state(sys);
+
+	temp_set = CPU_ALLOC(cxt->maxcpus);
+	if (!temp_set)
+		return -EINVAL;
+
 	for (i = 0; i < cxt->npossibles; i++) {
 		struct lscpu_cpu *cpu = cxt->cpus[i];
 		cpu_set_t *thread_siblings = NULL, *core_siblings = NULL;
@@ -127,6 +174,15 @@ static int cputype_read_topology(struct lscpu_cxt *cxt, struct lscpu_cputype *ct
 					"cpu%d/topology/thread_siblings", num) != 0)
 			continue;
 
+		/*
+		 * Ignore cpus which are not fully online.
+		 * If hp_online_state is negative/zero or rc is negative,
+		 * online state could not be read correctly, skip this check.
+		 */
+		rc = ul_path_readf_s32(sys, &hp_state, "cpu%d/hotplug/state", num);
+		if (hp_online_state > 0 && rc >= 0 && hp_state != hp_online_state)
+			continue;
+
 		/* read topology maps */
 		ul_path_readf_cpuset(sys, &thread_siblings, cxt->maxcpus,
 					"cpu%d/topology/thread_siblings", num);
@@ -163,15 +219,16 @@ static int cputype_read_topology(struct lscpu_cxt *cxt, struct lscpu_cputype *ct
 
 		/* add to topology maps */
 		if (thread_siblings)
-			add_cpuset_to_array(ct->coremaps, &ct->ncores, thread_siblings, cxt->setsize);
+			add_cpuset_to_array(ct->coremaps, &ct->ncores, thread_siblings, cxt->setsize, temp_set);
 		if (core_siblings)
-			add_cpuset_to_array(ct->socketmaps, &ct->nsockets, core_siblings, cxt->setsize);
+			add_cpuset_to_array(ct->socketmaps, &ct->nsockets, core_siblings, cxt->setsize, temp_set);
 		if (book_siblings)
-			add_cpuset_to_array(ct->bookmaps, &ct->nbooks, book_siblings, cxt->setsize);
+			add_cpuset_to_array(ct->bookmaps, &ct->nbooks, book_siblings, cxt->setsize, temp_set);
 		if (drawer_siblings)
-			add_cpuset_to_array(ct->drawermaps, &ct->ndrawers, drawer_siblings, cxt->setsize);
+			add_cpuset_to_array(ct->drawermaps, &ct->ndrawers, drawer_siblings, cxt->setsize, temp_set);
 
 	}
+	CPU_FREE(temp_set);
 
 	/* s390 detects its cpu topology via /proc/sysinfo, if present.
 	 * Using simply the cpu topology masks in sysfs will not give

base-commit: 9e2aafe5a493284615a17572c4ead4737bcc66a3
-- 
2.46.0

