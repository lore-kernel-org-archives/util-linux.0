Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0966328610
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609877; cv=none; b=m7S00nkNu7Q5RzBHJP3UbVg4bWutienoM0dsyTjpTsnRDISc9JR8GYQy+ZeDHgFrxaJta+LxIYMZVzbPzrMJphg0Jp1bOtzvuxcDL4WJtzjM7LB5m6YP3fZDMot9GHOPveYhdLTrSQAKX3V5hXxbdy7PthRD/Euv0e3A4b4HTeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609877; c=relaxed/simple;
	bh=LGpcmsIZy/J8qC0WvZKV7Wa21pDCeuWvfsqeRn6BIKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y26HlWnZaoDVwdf0ND6kITSwAi7oPr7+FEYQdY90zaTpor0gfAfwV8U4XWODJLkQvGasyQB5V8Xr17VU+yQaVKl3wQYzWdBmg50v6WhAzqGepzrxnwigagg0vv+CvdWCKs0kUfhNMm8YFTqoKIjjHitVp1kwrECH8KvfcCX3Ux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gj8+zCBn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gj8+zCBn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G0lI7q021634;
	Thu, 16 Oct 2025 10:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lkH96t1rF7LhGRFgn
	8Sr+gf8fB7XiNXyHIBHbfmbjAs=; b=Gj8+zCBn9IHQKPv1VMwHKk9qgdQHzLjXc
	XJ8lf6K/PaMdknyir7YSlsC3NKD7rZvvsIx0HknQymbRmtgedu6uBX7q2OPZkGTh
	2Z+DhCA6ROzx5pUeGHU/gMk8yuUR/x54zy3fMT9LWNjXO49D9LmusvVUn3AjBmvt
	IY9JsEKldj/vDfpWs2/sZ+QytE5zjGu/PcZVTx+nO9DHhz565wQ3/zaeEDb7D1GN
	/gFZt4j69B6R1jDpIBjAYCsKI0xfRz2yp6pp8qTEkxfT/ANveVc9Yuj4g22puRgx
	E8xBnp+zKH+9mCTXh4HfRDtWwEe0/0OTPpKvHPTt+zTIiOiRS2G6A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey920ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7fBM8014981;
	Thu, 16 Oct 2025 10:17:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjmwp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GAHmgv30146876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 10:17:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2299A2007F;
	Thu, 16 Oct 2025 10:17:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEA482007D;
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
Subject: [PATCH 2/6] lsmem: add support to display dynamic (de)configuration of memory
Date: Thu, 16 Oct 2025 12:16:49 +0200
Message-ID: <20251016101701.552597-3-sumanthk@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: IeElD70q7pZve0cKgdt1tIDVvqiF5skd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX5vOjd4TxAn4Z
 kKJOygF1MnswvreRhJ+8TSWLiOu/yHHGH/JDxVQ22T+apzwndqnTibqw/SQ2zGU/HdHoBT3C2+K
 aO3kJXC4yWJWDYtjoajlHw1Ye96TQzSxouoRt0LtfkFzOxVUkCFytKVoY9q98f6ZXdrVbFrOVNg
 0/bqAgBQ/lPNcaPemF1K2zpEf11BMu5MMd2YDWzqUSbv6Bt0jp5eD2LgMt8A+d0R9in7VvArlUN
 rwC2iRQ3VdzVmCQz2ruws+gSPcW7qTZcbanOlP6u8q1nGbyH8jus4mfqXDH/j1SGVn8Ym6MxA1H
 aIJ62lEX8AcgWIXGKHogktdUiVuaRBjygpZUQuzw5q2+kUyQ4kdqsCaQsBiEpHeu8xWJ/Bv1RjA
 DZ1UihDS1kbHKeWJ6PPTtZq0/pTzUg==
X-Proofpoint-GUID: IeElD70q7pZve0cKgdt1tIDVvqiF5skd
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f0c651 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=6rvU8sXd-WCdn4QYFxEA:9 a=-uN0bxNmadYA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

Extend lsmem to display (de)configured blocks and memmap_on_memory
state. With the new s390 kernel interface (linux-next) ff18dcb19aab
("s390/sclp: Add support for dynamic (de)configuration of memory"),
standby memory blocks are no longer pre-added at boot, but must be
explicitly configured before being eligible for online/offline
operations. At configuration time, users can also decide whether to use
memmap-on-memory per block.

Add CONFIGURED column : indicate if a memory block has been explicitly
configured.

Add MEMMAP-ON-MEMORY column : indicate if a memory block uses
memmap-on-memory.

memmap-on-memory reference:
https://docs.kernel.org/admin-guide/mm/memory-hotplug.html

Users can now inspect memory configuration state and retrieve
memmap-on-memory state per block.

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP-ON-MEMORY
RANGE                   SIZE   STATE   BLOCK CONFIGURED MEMMAP-ON-MEMORY
0x00000000-0x7fffffff   2G     online  0-15  yes        no
0x80000000-0xffffffff   2G     offline 16-31 no         yes

Memory block size:                128M
Total online memory:                2G
Total offline memory:               2G
Memmap on memory parameter:        yes

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 sys-utils/lsmem.c | 115 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 12 deletions(-)

diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index ea818d6dc..7b456492e 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -32,6 +32,7 @@
 #include "optutils.h"
 
 #define _PATH_SYS_MEMORY		"/sys/devices/system/memory"
+#define _PATH_SYS_MEMCONFIG			"/sys/firmware/memory"
 
 #define MEMORY_STATE_ONLINE		0
 #define MEMORY_STATE_OFFLINE		1
@@ -58,12 +59,17 @@ struct memory_block {
 	int		nr_zones;
 	int		zones[MAX_NR_ZONES];
 	bool		removable;
+	bool		config;
+	bool		memmap_on_memory;
 };
 
 struct lsmem {
 	struct path_cxt		*sysmem;		/* _PATH_SYS_MEMORY directory handler */
+	struct path_cxt		*sysmemconfig;		/* _PATH_SYS_MEMCONFIG directory handler */
 	struct dirent		**dirs;
+	struct dirent		**memconfig_dirs;
 	int			ndirs;
+	int			memconfig_ndirs;
 	struct memory_block	*blocks;
 	int			nblocks;
 	uint64_t		block_size;
@@ -85,7 +91,10 @@ struct lsmem {
 				split_by_state : 1,
 				split_by_removable : 1,
 				split_by_zones : 1,
-				have_zones : 1;
+				split_by_memmap_on_memory : 1,
+				split_by_config : 1,
+				have_zones : 1,
+				have_memconfig : 1;
 };
 
 
@@ -97,6 +106,8 @@ enum {
 	COL_BLOCK,
 	COL_NODE,
 	COL_ZONES,
+	COL_CONFIG,
+	COL_MEMMAP,
 };
 
 static const char *const zone_names[] = {
@@ -127,6 +138,10 @@ static struct coldesc coldescs[] = {
 	[COL_BLOCK]	= { "BLOCK", 0, SCOLS_FL_RIGHT, N_("memory block number or blocks range")},
 	[COL_NODE]	= { "NODE", 0, SCOLS_FL_RIGHT, N_("numa node of memory")},
 	[COL_ZONES]	= { "ZONES", 0, SCOLS_FL_RIGHT, N_("valid zones for the memory range")},
+	[COL_CONFIG]	= { "CONFIGURED", 0, SCOLS_FL_RIGHT,
+			    N_("configuration status of the memory range")},
+	[COL_MEMMAP]	= { "MEMMAP-ON-MEMORY", 0, SCOLS_FL_RIGHT,
+			    N_("memmap-on-memory status of the memory range")},
 };
 
 /* columns[] array specifies all currently wanted output column. The columns
@@ -196,6 +211,8 @@ static inline void reset_split_policy(struct lsmem *l, int enable)
 	l->split_by_node = enable;
 	l->split_by_removable = enable;
 	l->split_by_zones = enable;
+	l->split_by_memmap_on_memory = enable;
+	l->split_by_config = enable;
 }
 
 static void set_split_policy(struct lsmem *l, int cols[], size_t ncols)
@@ -218,12 +235,32 @@ static void set_split_policy(struct lsmem *l, int cols[], size_t ncols)
 		case COL_ZONES:
 			l->split_by_zones = 1;
 			break;
+		case COL_MEMMAP:
+			l->split_by_memmap_on_memory = 1;
+			break;
+		case COL_CONFIG:
+			l->split_by_config = 1;
+			break;
 		default:
 			break;
 		}
 	}
 }
 
+static bool skip_memconfig_column(struct lsmem *lsmem, int i)
+{
+	struct coldesc *ci = get_column_desc(i);
+
+	if (!strcmp(ci->name, "MEMMAP-ON-MEMORY") || !strcmp(ci->name, "CONFIGURED")) {
+		if (ul_path_access(lsmem->sysmemconfig, F_OK, "memory0") == 0)
+			return false;
+		else
+			return true;
+	} else {
+		return false;
+	}
+}
+
 static void add_scols_line(struct lsmem *lsmem, struct memory_block *blk)
 {
 	size_t i;
@@ -236,6 +273,8 @@ static void add_scols_line(struct lsmem *lsmem, struct memory_block *blk)
 	for (i = 0; i < ncolumns; i++) {
 		char *str = NULL;
 
+		if (skip_memconfig_column(lsmem, i))
+			continue;
 		switch (get_column_id(i)) {
 		case COL_RANGE:
 		{
@@ -291,6 +330,14 @@ static void add_scols_line(struct lsmem *lsmem, struct memory_block *blk)
 				str = xstrdup(valid_zones);
 			}
 			break;
+		case COL_CONFIG:
+			if (lsmem->have_memconfig)
+				str = xstrdup(blk->config ? _("yes") : _("no"));
+			break;
+		case COL_MEMMAP:
+			if (lsmem->have_memconfig)
+				str = xstrdup(blk->memmap_on_memory ? _("yes") : _("no"));
+			break;
 		}
 
 		if (str && scols_line_refer_data(line, i, str) != 0)
@@ -400,6 +447,15 @@ static int memory_block_read_attrs(struct lsmem *lsmem, char *name,
 	if (errno)
 		rc = -errno;
 
+	if (lsmem->have_memconfig) {
+		if (ul_path_readf_s32(lsmem->sysmemconfig, &x, "%s/config", name) == 0)
+			blk->config = x == 1;
+		if (ul_path_readf_s32(lsmem->sysmemconfig, &x, "%s/memmap_on_memory", name) == 0)
+			blk->memmap_on_memory = x == 1;
+		blk->state = MEMORY_STATE_OFFLINE;
+		if (!blk->config)
+			return rc;
+	}
 	if (ul_path_readf_s32(lsmem->sysmem, &x, "%s/removable", name) == 0)
 		blk->removable = x == 1;
 
@@ -463,6 +519,10 @@ static int is_mergeable(struct lsmem *lsmem, struct memory_block *blk)
 				return 0;
 		}
 	}
+	if (lsmem->split_by_config && curr->config != blk->config)
+		return 0;
+	if (lsmem->split_by_memmap_on_memory && curr->memmap_on_memory != blk->memmap_on_memory)
+		return 0;
 	return 1;
 }
 
@@ -478,11 +538,33 @@ static void free_info(struct lsmem *lsmem)
 	free(lsmem->dirs);
 }
 
+static int memory_block_filter(const struct dirent *de)
+{
+	if (strncmp("memory", de->d_name, 6) != 0)
+		return 0;
+	return isdigit_string(de->d_name + 6);
+}
+
+static void read_memconfig(struct lsmem *lsmem)
+{
+	char dir[PATH_MAX];
+
+	if (ul_path_access(lsmem->sysmemconfig, F_OK, "memory0") != 0) {
+		lsmem->memconfig_ndirs = 0;
+		return;
+	}
+	ul_path_get_abspath(lsmem->sysmemconfig, dir, sizeof(dir), NULL);
+	lsmem->memconfig_ndirs = scandir(dir, &lsmem->memconfig_dirs,
+					 memory_block_filter, versionsort);
+	if (lsmem->memconfig_ndirs <= 0)
+		err(EXIT_FAILURE, _("Failed to read %s"), dir);
+}
+
 static void read_info(struct lsmem *lsmem)
 {
 	struct memory_block blk;
-	char buf[128];
-	int i;
+	char buf[128], *name;
+	int i, num_dirs;
 
 	if (ul_path_read_buffer(lsmem->sysmem, buf, sizeof(buf), "block_size_bytes") <= 0)
 		err(EXIT_FAILURE, _("failed to read memory block size"));
@@ -492,8 +574,17 @@ static void read_info(struct lsmem *lsmem)
 	if (errno)
 		err(EXIT_FAILURE, _("failed to read memory block size"));
 
-	for (i = 0; i < lsmem->ndirs; i++) {
-		memory_block_read_attrs(lsmem, lsmem->dirs[i]->d_name, &blk);
+	read_memconfig(lsmem);
+	if (lsmem->have_memconfig)
+		num_dirs = lsmem->memconfig_ndirs;
+	else
+		num_dirs = lsmem->ndirs;
+	for (i = 0; i < num_dirs; i++) {
+		if (lsmem->have_memconfig)
+			name = lsmem->memconfig_dirs[i]->d_name;
+		else
+			name = lsmem->dirs[i]->d_name;
+		memory_block_read_attrs(lsmem, name, &blk);
 		if (blk.state == MEMORY_STATE_ONLINE)
 			lsmem->mem_online += lsmem->block_size;
 		else
@@ -508,13 +599,6 @@ static void read_info(struct lsmem *lsmem)
 	}
 }
 
-static int memory_block_filter(const struct dirent *de)
-{
-	if (strncmp("memory", de->d_name, 6) != 0)
-		return 0;
-	return isdigit_string(de->d_name + 6);
-}
-
 static void read_basic_info(struct lsmem *lsmem)
 {
 	char dir[PATH_MAX];
@@ -539,6 +623,8 @@ static void read_basic_info(struct lsmem *lsmem)
 	/* The valid_zones sysmem attribute was introduced with kernel 3.18 */
 	if (ul_path_access(lsmem->sysmem, F_OK, "memory0/valid_zones") == 0)
 		lsmem->have_zones = 1;
+	if (ul_path_access(lsmem->sysmemconfig, F_OK, "memory0") == 0)
+		lsmem->have_memconfig = 1;
 }
 
 static void __attribute__((__noreturn__)) usage(void)
@@ -696,6 +782,9 @@ int main(int argc, char **argv)
 	lsmem->sysmem = ul_new_path(_PATH_SYS_MEMORY);
 	if (!lsmem->sysmem)
 		err(EXIT_FAILURE, _("failed to initialize %s handler"), _PATH_SYS_MEMORY);
+	lsmem->sysmemconfig = ul_new_path(_PATH_SYS_MEMCONFIG);
+	if (!lsmem->sysmemconfig)
+		err(EXIT_FAILURE, _("failed to initialized %s handler"), _PATH_SYS_MEMCONFIG);
 	if (prefix && ul_path_set_prefix(lsmem->sysmem, prefix) != 0)
 		err(EXIT_FAILURE, _("invalid argument to --sysroot"));
 	if (!ul_path_is_accessible(lsmem->sysmem))
@@ -745,6 +834,8 @@ int main(int argc, char **argv)
 		struct coldesc *ci = get_column_desc(i);
 		struct libscols_column *cl;
 
+		if (skip_memconfig_column(lsmem, i))
+			continue;
 		cl = scols_table_new_column(lsmem->table, ci->name, ci->whint, ci->flags);
 		if (!cl)
 			err(EXIT_FAILURE, _("failed to initialize output column"));
-- 
2.48.1

