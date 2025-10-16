Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3734BA5A
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629126; cv=none; b=Xe3HREq7P/XLiJZ+xsvpezPfgMjdHFM8jQDiCLdGu6VmmbH+NKjZu8vqecSid2VCMD2l0pqDTcfbA3ej/lyMDNGyV1jNp6zYnf0cWn3zZF0kSB/fK4zokzYi92XnTYpRmWzhDLu2OiMf+1Y/yyF4Etc0GezZ/0s7y9NCVz+X+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629126; c=relaxed/simple;
	bh=3b/JO90yT6h0mCGNuutHjblIdhDOD4D2nYwUrt0iwcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXorbLIJp2GX9PSeHEUWnL1q8dilwNsJhBKaXvaXeYuZQobbSMtkFoguUSdmyrRCuSNevsWPbD2FBRe9bcZ81goozFUyuAdAL8AZtIaAA2pp4O2bq1yHoPVVP2kAG+AguS2F9S+0gsZE9svtzhFHjEOL/PFLEkK1jV4hnoll11o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aFRxQqW1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aFRxQqW1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GBAHk7021634;
	Thu, 16 Oct 2025 15:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LuN5Zx6TxTc2h7hea
	wDpcho+HCIvtIbE9HkoxyADO0g=; b=aFRxQqW1Q6jgOsiz2KNL9W/u3sApghRQD
	o+k1UKOo871y8iTlj7LnVJVHJmCzlLNWqa/M/Bi65KDmtEFrgAVOCv2+7aQwVySv
	bJa3TteLkADvWzQnCG6JAdLCrknsFew7bXTI4M37ChMwdJBb3vt8+CnjXQUdk/PY
	6uqckdmC9ci4VS0DdVs4Gg+coqTs76b62zXEvXqJbFhnj1Aiw4ydbXwvCeDoQ8yN
	cLAebbG04tOMvSc96ZcMhQqKq/0HybToMmiwernL6KkcNinBoUMBzp1Z88E7ILwa
	0V5+wW25lRFnuzocBCUKnksnHQZ9H1DuLodPNpu7GwBuOuQpoaTwA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey93p63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:38:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GCW1is015204;
	Thu, 16 Oct 2025 15:38:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jserkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:38:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GFcblG61276554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 15:38:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D260200DC;
	Thu, 16 Oct 2025 15:38:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CD19200DF;
	Thu, 16 Oct 2025 15:38:37 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 15:38:37 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v2 1/6] lsmem: display global memmap on memory parameter
Date: Thu, 16 Oct 2025 17:38:01 +0200
Message-ID: <20251016153808.3565873-2-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016153808.3565873-1-sumanthk@linux.ibm.com>
References: <20251016153808.3565873-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: by3KVHQteJjP_lHgyCgRAbk6gRszECIr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfXy3HZErryt43c
 6P2z/njr8CDbJ+LjwkfSoKqpVk3pzQGJ0cu6Ts/EVCom569L7Bk+hTa7DC1rK7ew7VjBIh1dwko
 0SuT6po9kqvJKABKVmB0T3E2xVF5EryMNgX7euL0D06DwlauO5nWMZcED9yfjOwyxPPG8lJ+L7O
 k4ILPtW03C0URUPtDTcrlCivBh4h4Ums4k6azeuBb2lf3Y6OQMYeXyR1Nu2AdYrdam0sVETHM4j
 YYE7DKIwxZpjaxpvejCOG923wP2AaBRugleKh6yAp1WnGSEBaPchN8L8sedoHkXE1jrYeRl75ZJ
 YFgoJca0uAP5wey/zA9c7fHY61Jb5apAXAoo3Suf65gExWr1tSDZmMaCC9Cxho9uatq2DSzSvKx
 1hsm4zYUIUYyC2LPVv18SO02X8xEfQ==
X-Proofpoint-GUID: by3KVHQteJjP_lHgyCgRAbk6gRszECIr
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f11181 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=w9e5aAkKI-zt_GHOaJgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

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
index 39967bfc9..6151e269f 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -32,6 +32,7 @@
 #include "optutils.h"
 
 #define _PATH_SYS_MEMORY		"/sys/devices/system/memory"
+#define _PATH_SYS_MEMMAP_PARM		"/sys/module/memory_hotplug/parameters/memmap_on_memory"
 
 #define MEMORY_STATE_ONLINE		0
 #define MEMORY_STATE_OFFLINE		1
@@ -306,8 +307,24 @@ static void fill_scols_table(struct lsmem *lsmem)
 		add_scols_line(lsmem, &lsmem->blocks[i]);
 }
 
+static int get_memmap_mode(char *res, char *src, int len)
+{
+	if (!strncmp(src, "Y", 1))
+		strncpy(res, N_("yes"), len);
+	else if (!strncmp(src, "N", 1))
+		strncpy(res, N_("no"), len);
+	else if (!strncmp(src, "force", 5))
+		strncpy(res, N_("force"), len);
+	else
+		return -1;
+	return 0;
+}
+
 static void print_summary(struct lsmem *lsmem)
 {
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
+	memmap = fopen(_PATH_SYS_MEMMAP_PARM, "r");
+	if (!memmap)
+		return;
+	if (fgets(buf, sizeof(buf), memmap)) {
+		if (!get_memmap_mode(res, buf, sizeof(res))) {
+			if (lsmem->bytes)
+				printf("%-32s %15s\n", _("Memmap on memory parameter:"), _(res));
+			else
+				printf("%-32s %5s\n", _("Memmap on memory parameter:"), _(res));
+		}
+	}
+	fclose(memmap);
 }
 
 static int memory_block_get_node(struct lsmem *lsmem, char *name)
-- 
2.41.0

