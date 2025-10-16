Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABC32861E
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609877; cv=none; b=LXy60EINLXFWwdb55g+UDv3BERoyWvcf4iUXBPZQw53aJ4zAKL2SBUXipwymdFWI2rV2Qb9GSNX+RsG95R1YezTAAk4DRW8jZtqzeEsfWCjqODE9ZLWMFBuGkTecczc8hYU9jRpao26x2UqnVXar+GYGcIYy22699qSFc1+BrIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609877; c=relaxed/simple;
	bh=FIpvWNkDsdk8t23MbsFVpHRbWFLZFVumH8cufzmz4JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lh0kVaBK1/z+dErZe8Mx4yJdCMKR/BNnh5ySUM+r7YIFAHjxVgr7FCOf1qUZV8TS6rfHv/7xccAbQtKMUNBzjMooP4arKVbapFOzA1lxs0cpHAN8ZqnwyN5W3aPs2og6pRfhOvAPEYZx+c9tgTOPVwVl0s9tG+t4cm9ZGrGpS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lfheghE3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lfheghE3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GA3RC7012367;
	Thu, 16 Oct 2025 10:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fJ5f8/
	Q1Ji1n1AdcFfmo2jNRuMbGCS/z9IWP0Y9Ih+o=; b=lfheghE3E18hPEwHjQIA/3
	t5Wd4ComhIyy8FYcCuYYJcllmErn9cotlWLRluRuwFzylsAEJbphcXkMSMxhnZhr
	47QPKUEviMZJ3phiF4o44GR/S3+FZf4GB0rB4Nt2p4FaQu1HTo4cb6f7MZjRpY4s
	WDvhjRD6ddi3QmFYIIxeDHoiXnbN3yY/ZBvdC5cGz6luxEBUUTWtAu8T+Wjo+ER/
	wutyRmofNy1qK6bZtfX3854aIWN311zQ2c+vAmzIb1qUsQzKFfQ4IHHgvu2okQEN
	ERzQutZfRztmVOaSbuQRw9qgiLyCO5hSCoWXBboTUTH9uPYV0BICTftb0D4iDS/A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrh5b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GA9nF2018862;
	Thu, 16 Oct 2025 10:17:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jmw6na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GAHmNc30802378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 10:17:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5951920063;
	Thu, 16 Oct 2025 10:17:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27DB220080;
	Thu, 16 Oct 2025 10:17:48 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 10:17:48 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 3/6] chmem: add support for dynamic (de)configuration of hotplug memory
Date: Thu, 16 Oct 2025 12:16:50 +0200
Message-ID: <20251016101701.552597-4-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016101701.552597-1-sumanthk@linux.ibm.com>
References: <20251016101701.552597-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68f0c651 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=eqOK5gE0MLgnCjM6HjkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FMIDTv91fEyFnHlcca7DgspvvbsHuxct
X-Proofpoint-ORIG-GUID: FMIDTv91fEyFnHlcca7DgspvvbsHuxct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfXxBTv08rWNS+Z
 xlNxU16ClZBADK8kXfR7spBSBpPhaPxHQLD+7cYFnhh9eayi5CAbjI5ZKEjKOONZBWKQy3t/D9P
 /Z4zWpwugyTz4SuOyLVanJe1wF9hDN2FhUzu6RCASdB8NujaH48G7d4HKY0x6EIUpYe9UvZX0UM
 bP6GEWXe2Vo35CX77dNT6dDqN6vm5vDH7pcMZgYbMhT9ZugYD1Se8CMn1wj86e3EmTEP/XNHuER
 cToZzUs/J9qGRIgauzr05hjdJKR8ABrF4GYgncSgmE3AO+r8DSZqMB9D8ZWwJq8gNFjkwF55XJ+
 xR3fpjX0Va4WRLx/qAogEd7nYq6/54C2yHPdajZEfUakSQ9jbzPre2MrVAyz3T2jUkvqO4xt9AD
 F7AVaxrF7ye02LDEN6ywU7W6/de4/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140

Extend chmem to use the new s390 kernel interface for configuring and
deconfiguring hotpluggable memory blocks, with memmap-on-memory support.

Background:
On s390, memmap-on-memory was introduced to ensure that the struct page
array (metadata) for hotpluggable standby memory is allocated from the
memory block itself. This allowed hot-add operations even under memory
pressure, particularly in cases with a strong imbalance between
boot-time online memory and standby memory.

The original design, however, had few limitations:
* All hotpluggable standby memory was added at boot.
* The use of memmap-on-memory was global and static, decided at boot
  time. Either all standby blocks used it, or none of them did.
* memmap-on-memory choice could not be changed at runtime, limiting
  flexibility. For example, when continuous physical memory was required
  later across memory blocks.

The s390 kernel ff18dcb19aab ("s390/sclp: Add support for dynamic
(de)configuration of memory") no longer pre-adds all standby memory at
boot. Instead, users must explicitly configure a block before it can be
used for online/offline actions.  At configuration time, users can
dynamically decide whether to use optional memmap-on-memory for each
memory block, where value of 1 allocates metadata (such as struct pages
array) from the hotplug memory itself, enabling hot-add operations even
under memory pressure. A value of 0 stores metadata in regular system
memory and enables continuous physical memory across memory blocks.

s390 kernel sysfs interface to configure/deconfigure memory with
memmap-on-memory support looks as shown below:

1. Configure memory
echo 1 > /sys/firmware/memory/memoryX/config  

2. Deconfigure memory
echo 0 > /sys/firmware/memory/memoryX/config

3. Enable memmap-on-memory
echo 1 > /sys/firmware/memory/memoryX/memmap_on_memory

4. Disable memmap-on-memory
echo 0 > /sys/firmware/memory/memoryX/memmap_on_memory

* Initial memory layout:
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP-ON-MEMORY
RANGE                   SIZE   STATE   BLOCK CONFIGURED MEMMAP-ON-MEMORY
0x00000000-0x7fffffff   2G     online  0-15  yes        no
0x80000000-0xffffffff   2G     offline 16-31 no         yes

Memory block size:                128M
Total online memory:                2G
Total offline memory:               2G
Memmap on memory parameter:        yes

* Configure memory with memmap-on-memory.
chmem -c 128M -m 1
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP-ON-MEMORY
RANGE                   SIZE   STATE    BLOCK CONFIGURED MEMMAP-ON-MEMORY
0x00000000-0x7fffffff   2G     online   0-15  yes        no
0x80000000-0x87ffffff   128M   offline  16    yes        yes
0x88000000-0xffffffff   1.9G   offline  17-31 no         yes

Memory block size:                128M
Total online memory:                2G
Total offline memory:               2G
Memmap on memory parameter:        yes

* Deconfigure memory
chmem -g 128M
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP-ON-MEMORY
RANGE                   SIZE   STATE    BLOCK CONFIGURED MEMMAP-ON-MEMORY
0x00000000-0x7fffffff   2G     online   0-15  yes        no
0x80000000-0xffffffff   2G     offline  16-31 no         yes

Memory block size:                128M
Total online memory:                2G
Total offline memory:               2G
Memmap on memory parameter:        yes

* Online memory.
If the memory is in deconfigured state, configure and online it.

chmem -e 128M -v
Memory Block 16 (0x0000000080000000-0x0000000087ffffff) configured
Memory Block 16 (0x0000000080000000-0x0000000087ffffff) enabled

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP-ON-MEMORY
RANGE                   SIZE   STATE    BLOCK CONFIGURED MEMMAP-ON-MEMORY
0x00000000-0x7fffffff    2G    online   0-15  yes        no
0x80000000-0x87ffffff    128M  online   16    yes        yes
0x88000000-0xffffffff    1.9G  offline  17-31 no         yes

Memory block size:                128M
Total online memory:              2.1G
Total offline memory:             1.9G
Memmap on memory parameter:        yes

* Offline memory
If the memory is in online state, then offline it and deconfigure it.

chmem -d 128M -v
Memory Block 16 (0x0000000080000000-0x0000000087ffffff) disabled
Memory Block 16 (0x0000000080000000-0x0000000087ffffff) deconfigured

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP-ON-MEMORY
RANGE                   SIZE   STATE    BLOCK CONFIGURED MEMMAP-ON-MEMORY
0x00000000-0x7fffffff   2G     online   0-15  yes        no
0x80000000-0xffffffff   2G     offline  16-31 no         yes

Memory block size:                128M
Total online memory:                2G
Total offline memory:               2G
Memmap on memory parameter:        yes

Just like online and offline actions, memory configuration and
deconfiguration can be controlled through similar options. Also,
memmap-on-memory setting can be changed, only when the memory block is
in deconfigured state. This means, it is usable only via --configure
option.

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 sys-utils/chmem.c | 372 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 343 insertions(+), 29 deletions(-)

diff --git a/sys-utils/chmem.c b/sys-utils/chmem.c
index bee2a90f8..9331925ff 100644
--- a/sys-utils/chmem.c
+++ b/sys-utils/chmem.c
@@ -37,11 +37,16 @@
 #define CHMEM_EXIT_SOMEOK		64
 
 #define _PATH_SYS_MEMORY		"/sys/devices/system/memory"
+#define _PATH_SYS_MEMCONFIG		"/sys/firmware/memory"
 
 struct chmem_desc {
 	struct path_cxt	*sysmem;	/* _PATH_SYS_MEMORY handler */
+	struct path_cxt *sysmemconfig;	/* _PATH_SYS_MEMCONFIG directory handler */
 	struct dirent	**dirs;
+	struct dirent   **memconfig_dirs;
 	int		ndirs;
+	int		memconfig_ndirs;
+	int		memmap_on_memory;
 	uint64_t	block_size;
 	uint64_t	start;
 	uint64_t	end;
@@ -50,11 +55,14 @@ struct chmem_desc {
 	unsigned int	is_size	   : 1;
 	unsigned int	verbose	   : 1;
 	unsigned int	have_zones : 1;
+	unsigned int	have_memconfig : 1;
 };
 
 enum {
 	CMD_MEMORY_ENABLE = 0,
 	CMD_MEMORY_DISABLE,
+	CMD_MEMORY_CONFIGURE,
+	CMD_MEMORY_DECONFIGURE,
 	CMD_NONE
 };
 
@@ -101,16 +109,130 @@ static void idxtostr(struct chmem_desc *desc, uint64_t idx, char *buf, size_t bu
 		 idx, start, end);
 }
 
-static int chmem_size(struct chmem_desc *desc, int enable, int zone_id)
+static bool chmem_memmap_on_memory_option_enabled(struct chmem_desc *desc)
+{
+	if (desc->memmap_on_memory == 0 || desc->memmap_on_memory == 1)
+		return true;
+	else
+		return false;
+}
+
+static int chmem_set_memmap_on_memory(struct chmem_desc *desc, char *name)
+{
+	char str[BUFSIZ];
+	int rc, index;
+
+	index = strtou64_or_err(name + 6, _("Failed to parse index"));
+	idxtostr(desc, index, str, sizeof(str));
+	rc = ul_path_writef_u64(desc->sysmemconfig, desc->memmap_on_memory,
+				"%s/memmap_on_memory", name);
+	if (rc)
+		warn(_("%s memmap-on-memory failed"), str);
+	return rc;
+}
+
+static int chmem_config(struct chmem_desc *desc, char *name, int configure)
+{
+	int mblock_configured, memmap, rc, index;
+	char str[BUFSIZ], state[BUFSIZ];
+
+	index = strtou64_or_err(name + 6, _("Failed to parse index"));
+	idxtostr(desc, index, str, sizeof(str));
+	rc = ul_path_readf_s32(desc->sysmemconfig, &mblock_configured, "%s/config", name);
+	if (rc)
+		goto out;
+	rc = ul_path_readf_s32(desc->sysmemconfig, &memmap, "%s/memmap_on_memory", name);
+	if (rc)
+		goto out;
+	if (mblock_configured) {
+		if (configure) {
+			if (chmem_memmap_on_memory_option_enabled(desc) &&
+					memmap != desc->memmap_on_memory) {
+				if (!desc->is_size || desc->verbose)
+					fprintf(stdout,
+						_("%s must be deconfigured before using -m option\n"), str);
+				rc = -1;
+			} else if (desc->is_size) {
+				/*
+				 * Allow chmem_onoff_size() to proceed with
+				 * configuring different memory blocks when the
+				 * current block is already configured.
+				 */
+				rc = -1;
+			} else if (desc->verbose) {
+				fprintf(stdout, _("%s already configured\n"), str);
+			}
+			goto out;
+		} else if (ul_path_readf_buffer(desc->sysmem, state,
+						sizeof(state), "%s/state", name) > 0 &&
+			   strncmp("online", state, 6) == 0) {
+			if (!desc->is_size || desc->verbose)
+				fprintf(stdout, "%s must be offline before deconfiguration\n", str);
+			rc = -1;
+			goto out;
+		}
+	} else {
+		/*
+		 * If memory block is currently in deconfigured state, set
+		 * memmap-on-memory if -m option is enabled.
+		 */
+		if (chmem_memmap_on_memory_option_enabled(desc)) {
+			rc = chmem_set_memmap_on_memory(desc, name);
+			if (rc)
+				goto out;
+		} else if (!configure) {
+			/*
+			 * Allow chmem_onoff_size() to proceed with
+			 * deconfiguring different memory blocks when the
+			 * current block is already deconfigured.
+			 */
+			if (desc->is_size)
+				rc = -1;
+			else if (desc->verbose)
+				fprintf(stdout, _("%s already deconfigured\n"), str);
+			goto out;
+		}
+	}
+	rc = ul_path_writef_u64(desc->sysmemconfig, configure ? 1 : 0, "%s/config", name);
+	if (rc) {
+		if (!desc->is_size) {
+			if (configure)
+				warn(_("%s configure failed\n"), str);
+			else
+				warn(_("%s deconfigure failed\n"), str);
+		} else if (desc->verbose) {
+			if (configure)
+				fprintf(stdout, _("%s configure failed\n"), str);
+			else
+				fprintf(stdout, _("%s deconfigure failed\n"), str);
+		}
+	} else if (desc->verbose) {
+		if (configure)
+			fprintf(stdout, _("%s configured\n"), str);
+		else
+			fprintf(stdout, _("%s deconfigured\n"), str);
+	}
+out:
+	return rc;
+}
+
+static int chmem_configured(struct chmem_desc *desc, char *name)
+{
+	int mblock_configured = 0;
+
+	ul_path_readf_s32(desc->sysmemconfig, &mblock_configured, "%s/config", name);
+	return mblock_configured;
+}
+
+static int chmem_onoff_size(struct chmem_desc *desc, int enable, int zone_id)
 {
 	char *name, *onoff, line[BUFSIZ], str[BUFSIZ];
 	uint64_t size, index;
+	int i, rc = 0, ndirs;
 	const char *zn;
-	int i, rc;
 
 	size = desc->size;
 	onoff = enable ? "online" : "offline";
-	i = enable ? 0 : desc->ndirs - 1;
 
 	if (enable && zone_id >= 0) {
 		if (zone_id == ZONE_MOVABLE)
@@ -118,15 +240,30 @@ static int chmem_size(struct chmem_desc *desc, int enable, int zone_id)
 		else
 			onoff = "online_kernel";
 	}
-
-	for (; i >= 0 && i < desc->ndirs && size; i += enable ? 1 : -1) {
-		name = desc->dirs[i]->d_name;
+	ndirs = desc->have_memconfig ? desc->memconfig_ndirs : desc->ndirs;
+	i = enable ? 0 : ndirs - 1;
+	for (; i >= 0 && i < ndirs && size; i += enable ? 1 : -1) {
+		if (desc->have_memconfig)
+			name = desc->memconfig_dirs[i]->d_name;
+		else
+			name = desc->dirs[i]->d_name;
 		index = strtou64_or_err(name + 6, _("Failed to parse index"));
-
-		if (ul_path_readf_buffer(desc->sysmem, line, sizeof(line), "%s/state", name) > 0
-		    && strncmp(onoff, line, 6) == 0)
+		if (enable && desc->have_memconfig && !chmem_configured(desc, name)) {
+			/* Configure memory block */
+			rc = chmem_config(desc, name, enable);
+			if (rc)
+				continue;
+		} else if (ul_path_readf_buffer(desc->sysmem, line, sizeof(line), "%s/state", name) > 0) {
+			if (strncmp(onoff, line, 6) == 0)
+				continue;
+		} else if (!enable) {
+			/*
+			 * If /sys/devices/system/memory/memoryX is
+			 * unavailable, memory block is offline and
+			 * deconfigured.
+			 */
 			continue;
-
+		}
 		if (desc->have_zones) {
 			ul_path_readf_buffer(desc->sysmem, line, sizeof(line), "%s/valid_zones", name);
 			if (zone_id >= 0) {
@@ -143,7 +280,6 @@ static int chmem_size(struct chmem_desc *desc, int enable, int zone_id)
 					onoff = "online";
 			}
 		}
-
 		idxtostr(desc, index, str, sizeof(str));
 		rc = ul_path_writef_string(desc->sysmem, onoff, "%s/state", name);
 		if (rc != 0 && desc->verbose) {
@@ -157,6 +293,12 @@ static int chmem_size(struct chmem_desc *desc, int enable, int zone_id)
 			else
 				fprintf(stdout, _("%s disabled\n"), str);
 		}
+		if (!rc && !enable && desc->have_memconfig) {
+			/* Deconfigure memory block */
+			rc = chmem_config(desc, name, enable);
+			if (rc)
+				continue;
+		}
 		if (rc == 0)
 			size--;
 	}
@@ -175,12 +317,80 @@ static int chmem_size(struct chmem_desc *desc, int enable, int zone_id)
 	return size == 0 ? 0 : size == desc->size ? -1 : 1;
 }
 
-static int chmem_range(struct chmem_desc *desc, int enable, int zone_id)
+static int chmem_config_size(struct chmem_desc *desc, int configure)
+{
+	uint64_t size;
+	char *name;
+	int i, rc;
+
+	if (!desc->have_memconfig) {
+		if (configure)
+			fprintf(stdout,
+				_("Skip configuration — use chmem -e instead\n"));
+		else
+			fprintf(stdout,
+				_("Skip deconfiguration - use chmem -d instead\n"));
+		return -1;
+	}
+	size = desc->size;
+	i = configure ? 0 : desc->memconfig_ndirs - 1;
+	for (; i >= 0 && i < desc->memconfig_ndirs && size; i += configure ? 1 : -1) {
+		name = desc->memconfig_dirs[i]->d_name;
+		rc = chmem_config(desc, name, configure);
+		if (rc == 0)
+			size--;
+	}
+	if (size) {
+		uint64_t bytes;
+		char *sizestr;
+
+		bytes = (desc->size - size) * desc->block_size;
+		sizestr = size_to_human_string(SIZE_SUFFIX_1LETTER, bytes);
+		if (configure)
+			fprintf(stdout, _("Could only configure %s of memory\n"), sizestr);
+		else
+			fprintf(stdout, _("Could only deconfigure %s of memory\n"), sizestr);
+		free(sizestr);
+	}
+	return size == 0 ? 0 : size == desc->size ? -1 : 1;
+}
+
+static int chmem_config_range(struct chmem_desc *desc, int configure)
+{
+	uint64_t index, todo;
+	char *name;
+	int rc, i;
+
+	if (!desc->have_memconfig) {
+		if (configure)
+			fprintf(stdout,
+				_("Skip configuration — use chmem -e instead\n"));
+		else
+			fprintf(stdout,
+				_("Skip deconfiguration - use chmem -d instead\n"));
+		return -1;
+	}
+	todo = desc->end - desc->start + 1;
+	for (i = 0; i < desc->memconfig_ndirs; i++) {
+		name = desc->memconfig_dirs[i]->d_name;
+		index = strtou64_or_err(name + 6, _("Failed to parse index"));
+		if (index < desc->start)
+			continue;
+		if (index > desc->end)
+			break;
+		rc = chmem_config(desc, name, configure);
+		if (rc == 0)
+			todo--;
+	}
+	return todo == 0 ? 0 : todo == desc->end - desc->start + 1 ? -1 : 1;
+}
+
+static int chmem_onoff_range(struct chmem_desc *desc, int enable, int zone_id)
 {
 	char *name, *onoff, line[BUFSIZ], str[BUFSIZ];
 	uint64_t index, todo;
+	int i, rc, ndirs;
 	const char *zn;
-	int i, rc;
 
 	todo = desc->end - desc->start + 1;
 	onoff = enable ? "online" : "offline";
@@ -192,22 +402,43 @@ static int chmem_range(struct chmem_desc *desc, int enable, int zone_id)
 			onoff = "online_kernel";
 	}
 
-	for (i = 0; i < desc->ndirs; i++) {
-		name = desc->dirs[i]->d_name;
+	ndirs = desc->have_memconfig ? desc->memconfig_ndirs : desc->ndirs;
+	for (i = 0; i < ndirs; i++) {
+		name = desc->have_memconfig ? desc->memconfig_dirs[i]->d_name :
+					      desc->dirs[i]->d_name;
 		index = strtou64_or_err(name + 6, _("Failed to parse index"));
 		if (index < desc->start)
 			continue;
 		if (index > desc->end)
 			break;
+		if (enable && desc->have_memconfig && !chmem_configured(desc, name)) {
+			/* Configure memory block */
+			rc = chmem_config(desc, name, enable);
+			if (rc)
+				continue;
+		}
 		idxtostr(desc, index, str, sizeof(str));
-		if (ul_path_readf_buffer(desc->sysmem, line, sizeof(line), "%s/state", name) > 0
-		    && strncmp(onoff, line, 6) == 0) {
-			if (desc->verbose && enable)
-				fprintf(stdout, _("%s already enabled\n"), str);
-			else if (desc->verbose && !enable)
-				fprintf(stdout, _("%s already disabled\n"), str);
-			todo--;
-			continue;
+		if (ul_path_readf_buffer(desc->sysmem, line, sizeof(line), "%s/state", name) > 0) {
+			if (strncmp(onoff, line, 6) == 0) {
+				if (desc->verbose && enable)
+					fprintf(stdout, _("%s already enabled\n"), str);
+				else if (desc->verbose && !enable)
+					fprintf(stdout, _("%s already disabled\n"), str);
+				todo--;
+				continue;
+			}
+		} else {
+			/*
+			 * If /sys/devices/system/memory/memoryX is
+			 * unavailable, memory block is offline and
+			 * deconfigured.
+			 */
+			if (!enable) {
+				if (desc->verbose)
+					fprintf(stdout, _("%s already disabled\n"), str);
+				todo--;
+				continue;
+			}
 		}
 
 		if (desc->have_zones) {
@@ -243,6 +474,12 @@ static int chmem_range(struct chmem_desc *desc, int enable, int zone_id)
 			else
 				fprintf(stdout, _("%s disabled\n"), str);
 		}
+		if (!rc && !enable && desc->have_memconfig) {
+			/* Deconfigure memory block */
+			rc = chmem_config(desc, name, enable);
+			if (rc)
+				continue;
+		}
 		if (rc == 0)
 			todo--;
 	}
@@ -256,6 +493,16 @@ static int filter(const struct dirent *de)
 	return isdigit_string(de->d_name + 6);
 }
 
+static void read_conf(struct chmem_desc *desc)
+{
+	if (!desc->have_memconfig)
+		return;
+	desc->memconfig_ndirs = scandir(_PATH_SYS_MEMCONFIG, &desc->memconfig_dirs,
+					filter, versionsort);
+	if (desc->memconfig_ndirs <= 0)
+		err(EXIT_FAILURE, _("Failed to read %s"), _PATH_SYS_MEMCONFIG);
+}
+
 static void read_info(struct chmem_desc *desc)
 {
 	char line[128];
@@ -269,6 +516,7 @@ static void read_info(struct chmem_desc *desc)
 	desc->block_size = strtoumax(line, NULL, 16);
 	if (errno)
 		goto fail;
+	read_conf(desc);
 	return;
 fail:
 	err(EXIT_FAILURE, _("Failed to read %s"), _PATH_SYS_MEMORY);
@@ -347,6 +595,9 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -d, --disable      disable memory\n"), out);
 	fputs(_(" -b, --blocks       use memory blocks\n"), out);
 	fputs(_(" -z, --zone <name>  select memory zone (see below)\n"), out);
+	fputs(_(" -c, --configure    configure range\n"), out);
+	fputs(_(" -g, --deconfigure  deconfigure range\n"), out);
+	fputs(_(" -m, --memmap-on-memory select memmap-on-memory\n"), out);
 	fputs(_(" -v, --verbose      verbose output\n"), out);
 	fprintf(out, USAGE_HELP_OPTIONS(20));
 
@@ -359,6 +610,52 @@ static void __attribute__((__noreturn__)) usage(void)
 	exit(EXIT_SUCCESS);
 }
 
+static int chmem_range(struct chmem_desc *desc, int cmd, int zone_id)
+{
+	int rc = -1;
+
+	switch (cmd) {
+	case CMD_MEMORY_ENABLE:
+		rc = chmem_onoff_range(desc, 1, zone_id);
+		break;
+	case CMD_MEMORY_DISABLE:
+		rc = chmem_onoff_range(desc, 0, zone_id);
+		break;
+	case CMD_MEMORY_CONFIGURE:
+		rc = chmem_config_range(desc, 1);
+		break;
+	case CMD_MEMORY_DECONFIGURE:
+		rc = chmem_config_range(desc, 0);
+		break;
+	default:
+		break;
+	}
+	return rc;
+}
+
+static int chmem_size(struct chmem_desc *desc, int cmd, int zone_id)
+{
+	int rc = -1;
+
+	switch (cmd) {
+	case CMD_MEMORY_ENABLE:
+		rc = chmem_onoff_size(desc, 1, zone_id);
+		break;
+	case CMD_MEMORY_DISABLE:
+		rc = chmem_onoff_size(desc, 0, zone_id);
+		break;
+	case CMD_MEMORY_CONFIGURE:
+		rc = chmem_config_size(desc, 1);
+		break;
+	case CMD_MEMORY_DECONFIGURE:
+		rc = chmem_config_size(desc, 0);
+		break;
+	default:
+		break;
+	}
+	return rc;
+}
+
 int main(int argc, char **argv)
 {
 	struct chmem_desc _desc = { 0 }, *desc = &_desc;
@@ -374,11 +671,15 @@ int main(int argc, char **argv)
 		{"verbose",	no_argument,		NULL, 'v'},
 		{"version",	no_argument,		NULL, 'V'},
 		{"zone",	required_argument,	NULL, 'z'},
+		{"configure",	no_argument,		NULL, 'c'},
+		{"deconfigure", no_argument,		NULL, 'g'},
+		{"memmap-on-memory", required_argument,	NULL, 'm'},
 		{NULL,		0,			NULL, 0}
 	};
 
 	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
-		{ 'd','e' },
+		{ 'd', 'e', 'g', 'm' },
+		{ 'c', 'd', 'e', 'g' },
 		{ 0 }
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
@@ -389,13 +690,18 @@ int main(int argc, char **argv)
 	close_stdout_atexit();
 
 	ul_path_init_debug();
+	desc->memmap_on_memory = -1;
 	desc->sysmem = ul_new_path(_PATH_SYS_MEMORY);
 	if (!desc->sysmem)
 		err(EXIT_FAILURE, _("failed to initialize %s handler"), _PATH_SYS_MEMORY);
-
+	desc->sysmemconfig = ul_new_path(_PATH_SYS_MEMCONFIG);
+	if (!desc->sysmemconfig)
+		err(EXIT_FAILURE, _("failed to initialize %s handler"), _PATH_SYS_MEMCONFIG);
+	if (ul_path_access(desc->sysmemconfig, F_OK, "memory0") == 0)
+		desc->have_memconfig = 1;
 	read_info(desc);
 
-	while ((c = getopt_long(argc, argv, "bdehvVz:", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "bcdeghm:vVz:", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -415,7 +721,15 @@ int main(int argc, char **argv)
 		case 'z':
 			zone = xstrdup(optarg);
 			break;
-
+		case 'c':
+			cmd = CMD_MEMORY_CONFIGURE;
+			break;
+		case 'g':
+			cmd = CMD_MEMORY_DECONFIGURE;
+			break;
+		case 'm':
+			desc->memmap_on_memory = atoi(optarg);
+			break;
 		case 'h':
 			usage();
 		case 'V':
@@ -448,9 +762,9 @@ int main(int argc, char **argv)
 	}
 
 	if (desc->is_size)
-		rc = chmem_size(desc, cmd == CMD_MEMORY_ENABLE ? 1 : 0, zone_id);
+		rc = chmem_size(desc, cmd, zone_id);
 	else
-		rc = chmem_range(desc, cmd == CMD_MEMORY_ENABLE ? 1 : 0, zone_id);
+		rc = chmem_range(desc, cmd, zone_id);
 
 	ul_unref_path(desc->sysmem);
 
-- 
2.48.1

