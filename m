Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC0328617
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609876; cv=none; b=KjpfLVaXO8Gkv9FUajlWHkI6VHBbjDeEl//ewUH5TZxZd3Y4IBOw3UkB5MGVhr4OLrGfyrLvpxc/zXt34ZwZ9UBwQnfzGGRSXPE6UvXI+HtU+jZIoUVuZEMCsLqIMQXcMnJvzoS7d5ON3F0k8/8Le/1ztALjoEivL8k8cCecSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609876; c=relaxed/simple;
	bh=2ZkXV1F1ez7Cbqff/ND2c/y79Sv/w4rrL3o4vB9vkck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJmkR65wqjTYQ5umVgHH/B23xmoqeMt1St6Ic+0rn/tindiH0c8xYiuah/omiDbZxvqkAcWCWGITaKhTfYG1D6bZuoZ4K9kzr1hvSBBzmQs54HYszKbIwbqagY0XpgEgW9MCrOViyBhvKMVfXciF+fmn82pNvpi2uRNYygDpsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kNzoBRr9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kNzoBRr9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FNWfHc013442;
	Thu, 16 Oct 2025 10:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LRL9sN2rADEj9kfi1
	qXtXNfzZY4iP/B/qwAg5HZOF7E=; b=kNzoBRr9xynCI4TUyA/ERVT9nQpHyLfd1
	AiysdMVQW1YnWVge6umXV1+kgnofnJoROUG5ES/3LjkoFNm5q7Jx0H5hNmNmNaz7
	jMBZlj3xCqDgAI+HG9Cu/ISsFVgJmIMi0snwVSVIruwV2TadTOFEofJhZ6ABtdcw
	QVW2Bzh+Wih6enu255j+T/b0kj0TcIx087+BFUi+wS2fOQTtTGAOFB4rK5FEnLle
	2f6/Ph/H8+DSwUWN2Ok8VhttieOpE+M6RLG/C6Lgdxu7RcLDWmYPlxwhS82Dw/dd
	iLDw4pmm3CzE7E3Zna3H9oQvdNhPAB9KHuOdGYiZzuYhI6ci5OWZw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrh5aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G73itV015010;
	Thu, 16 Oct 2025 10:17:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjmwny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GAHmWc12779910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 10:17:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9D5320063;
	Thu, 16 Oct 2025 10:17:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C96202007F;
	Thu, 16 Oct 2025 10:17:47 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 10:17:47 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 1/6] lsmem: display global memmap on memory parameter
Date: Thu, 16 Oct 2025 12:16:48 +0200
Message-ID: <20251016101701.552597-2-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016101701.552597-1-sumanthk@linux.ibm.com>
References: <20251016101701.552597-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68f0c650 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=w9e5aAkKI-zt_GHOaJgA:9
X-Proofpoint-GUID: My9on3_YqCum1djx9Ycy2Epr6ibcqTRT
X-Proofpoint-ORIG-GUID: My9on3_YqCum1djx9Ycy2Epr6ibcqTRT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfXykk9ck4jXblw
 omZ1aa2HUenQoPCb7ExqD0ZbH4RO98inZsmjq3U86Qe1m3WuSx/IW8248M3YTNiiM8oQqyrUQTa
 eQKInCAs01VNk3e1G5IZVTyVCStqY5Jkz39cCB2XpuClGuKEkkB9MMTpSXAeSIrMYIt8PEbHzUm
 0bH6jScsJUIjWyORtLuvuvK9Q+GF3NiPwlVFhIDQXbr1n5cinRk/EbTSU/pyl6riRegRl7904eO
 XkeSt4LDas2MSEJeIi4Eonl16F18YHk3rRFFcr2Zy5xhaOxqEDQdR+oj6UI3ljtW/SWv3/YDO3i
 eVnNwBs95DfMWh0tN2Tjwdts1+Vkp7K8Y/LmUZ5IaQoTj/GcM3la0eE2GvjOGwlH+LFEqsPOP2E
 hDslGNhLJ8WxcNm/AJknA+lruFIWzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140

Display the output of global memmap-on-memory parameter for memory
hotplug. Retrieve the details via
/sys/module/memory_hotplug/parameters/memmap_on_memory.

lsmem
RANGE                                 SIZE  STATE REMOVABLE BLOCK
0x0000000000000000-0x00000001ffffffff   8G online       yes  0-63

Memory block size:                128M
Total online memory:                8G
Total offline memory:               0B
Memmap on memory parameter:        yes

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 sys-utils/lsmem.1.adoc |  2 ++
 sys-utils/lsmem.c      | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/sys-utils/lsmem.1.adoc b/sys-utils/lsmem.1.adoc
index d588051a8..9c9397631 100644
--- a/sys-utils/lsmem.1.adoc
+++ b/sys-utils/lsmem.1.adoc
@@ -28,6 +28,8 @@ Not all columns are supported on all systems. If an unsupported column is specif
 
 Use the *--help* option to see the columns description.
 
+Memmap on memory parameter output displays the globally enabled memmap-on-memory setting for memory_hotplug. This is typically set on the kernel command line via memory_hotplug.memmap_on_memory.
+
 == OPTIONS
 
 *-a*, *--all*::
diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index 39967bfc9..ea818d6dc 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -306,8 +306,25 @@ static void fill_scols_table(struct lsmem *lsmem)
 		add_scols_line(lsmem, &lsmem->blocks[i]);
 }
 
+static int get_memmap_mode(char *res, char *src, int len)
+{
+	if (!strncmp(src, "Y", 1))
+		strncpy(res, "yes", len);
+	else if (!strncmp(src, "N", 1))
+		strncpy(res, "no", len);
+	else if (!strncmp(src, "force", 5))
+		strncpy(res, "force", len);
+	else
+		return -1;
+	return 0;
+}
+
 static void print_summary(struct lsmem *lsmem)
 {
+	const char *path = "/sys/module/memory_hotplug/parameters/memmap_on_memory";
+	char buf[8], res[8];
+	FILE *memmap;
+
 	if (lsmem->bytes) {
 		printf("%-32s %15"PRId64"\n",_("Memory block size:"), lsmem->block_size);
 		printf("%-32s %15"PRId64"\n",_("Total online memory:"), lsmem->mem_online);
@@ -327,6 +344,18 @@ static void print_summary(struct lsmem *lsmem)
 			printf("%-32s %5s\n",_("Total offline memory:"), p);
 		free(p);
 	}
+	memmap = fopen(path, "r");
+	if (!memmap)
+		return;
+	if (fgets(buf, sizeof(buf), memmap)) {
+		if (!get_memmap_mode(res, buf, sizeof(res))) {
+			if (lsmem->bytes)
+				printf("%-32s %15s\n", _("Memmap on memory parameter:"), res);
+			else
+				printf("%-32s %5s\n", _("Memmap on memory parameter:"), res);
+		}
+	}
+	fclose(memmap);
 }
 
 static int memory_block_get_node(struct lsmem *lsmem, char *name)
-- 
2.48.1

