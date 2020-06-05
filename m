Return-Path: <SRS0=WsHy=7S=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E164AC433DF
	for <util-linux@archiver.kernel.org>; Fri,  5 Jun 2020 16:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2527206DB
	for <util-linux@archiver.kernel.org>; Fri,  5 Jun 2020 16:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgFEQP1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:15:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgFEQP1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 5 Jun 2020 12:15:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055G2mIj033523
        for <util-linux@vger.kernel.org>; Fri, 5 Jun 2020 12:15:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31f9dtuucd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Fri, 05 Jun 2020 12:15:26 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 055G2tbx034139
        for <util-linux@vger.kernel.org>; Fri, 5 Jun 2020 12:15:26 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31f9dtuubf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 12:15:26 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 055G66or012858;
        Fri, 5 Jun 2020 16:15:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 31bf47d3sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 16:15:23 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 055GFK5s6947022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jun 2020 16:15:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C988EA4040;
        Fri,  5 Jun 2020 16:15:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93B69A4057;
        Fri,  5 Jun 2020 16:15:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jun 2020 16:15:20 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     kzak@redhat.com, util-linux@vger.kernel.org
Cc:     heiko.carstens@de.ibm.com, tmricht@linux.ibm.com,
        svens@linux.ibm.com, Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH] lscpu: Add shared cached info for s390 lscpu -C
Date:   Fri,  5 Jun 2020 18:15:10 +0200
Message-Id: <20200605161510.17641-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_04:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 cotscore=-2147483648 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050120
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The shared cache info for s390 can be found in /proc/cpuinfo.
lscpu without any options already processes this info. Fix this
in lscpu -C and provide detailed stat.

Test for s390:
./lscpu -C
NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL  SETS PHY-LINE COHERENCY-SIZE
L1d      128K     256K    8 Data            1    64                     256
L1i      128K     256K    8 Instruction     1    64                     256
L2d        4M       8M    8 Data            2  2048                     256
L2i        2M       4M    8 Instruction     2  1024                     256
L3       128M            32 Unified         3 16384                     256
L4       672M            42 Unified         4 65536                     256

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 sys-utils/lscpu.c | 169 +++++++++++++++++++++++++++-------------------
 1 file changed, 101 insertions(+), 68 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index d6c3f2e83..d5ba84de3 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -319,7 +319,7 @@ lookup_cache(char *line, struct lscpu_desc *desc)
 	struct cpu_cache *cache;
 	long long size;
 	char *p, type;
-	int level;
+	int level, line_size, associativity;
 
 	/* Make sure line starts with "cache<nr> :" */
 	if (strncmp(line, "cache", 5) != 0)
@@ -350,6 +350,14 @@ lookup_cache(char *line, struct lscpu_desc *desc)
 	if (!p || sscanf(p, "size=%lld", &size) != 1)
 	       return 0;
 
+	p = strstr(line, "line_size=");
+	if (!p || sscanf(p, "line_size=%u", &line_size) != 1)
+		return 0;
+
+	p = strstr(line, "associativity=");
+	if (!p || sscanf(p, "associativity=%u", &associativity) != 1)
+		return 0;
+
 	desc->necaches++;
 	desc->ecaches = xrealloc(desc->ecaches,
 				 desc->necaches * sizeof(struct cpu_cache));
@@ -363,6 +371,11 @@ lookup_cache(char *line, struct lscpu_desc *desc)
 
 	cache->level = level;
 	cache->size = size * 1024;
+	cache->ways_of_associativity = associativity;
+	cache->coherency_line_size = line_size;
+	/* Number of sets for s390. For safety, just check divide by zero */
+	cache->number_of_sets = line_size ? (cache->size / line_size): 0;
+	cache->number_of_sets = associativity ? (cache->number_of_sets / associativity) : 0;
 
 	cache->type = type == 'i' ? xstrdup("Instruction") :
 		      type == 'd' ? xstrdup("Data") :
@@ -1673,82 +1686,102 @@ print_caches_readable(struct lscpu_desc *desc, int cols[], int ncols,
 			err(EXIT_FAILURE, _("failed to allocate output column"));
 	}
 
-	for (i = desc->ncaches - 1; i >= 0; i--) {
-		struct cpu_cache *ca = &desc->caches[i];
-		struct libscols_line *line;
-		int c;
+	struct cpu_cache *ca, *cachesrc;
+	int end, j, shared_allsize;
+	for (j = 0; j < 2; j++) {
+		/* First check the caches from /sys/devices */
+		if (j == 0) {
+			cachesrc = desc->caches;
+			end = desc->ncaches - 1;
+			shared_allsize = 0;
+		}
+		else {
+			/* Check shared caches from /proc/cpuinfo s390 */
+			cachesrc = desc->ecaches;
+			end = desc->necaches - 1;
+			/* Dont use get_cache_full_size */
+			shared_allsize = 1;
+		}
 
-		line = scols_table_new_line(table, NULL);
-		if (!line)
-			err(EXIT_FAILURE, _("failed to allocate output line"));
+		for (i = end; i >= 0; i--) {
+			ca = &cachesrc[i];
+			struct libscols_line *line;
+			int c;
 
-		for (c = 0; c < ncols; c++) {
-			char *data = NULL;
-			int col = cols[c];
+			line = scols_table_new_line(table, NULL);
+			if (!line)
+				err(EXIT_FAILURE, _("failed to allocate output line"));
 
-			switch (col) {
-			case COL_CACHE_NAME:
-				if (ca->name)
-					data = xstrdup(ca->name);
-				break;
-			case COL_CACHE_ONESIZE:
-				if (!ca->size)
+			for (c = 0; c < ncols; c++) {
+				char *data = NULL;
+				int col = cols[c];
+
+				switch (col) {
+				case COL_CACHE_NAME:
+					if (ca->name)
+						data = xstrdup(ca->name);
+					break;
+				case COL_CACHE_ONESIZE:
+					if (!ca->size)
+						break;
+					if (mod->bytes)
+						xasprintf(&data, "%" PRIu64, ca->size);
+					else
+						data = size_to_human_string(SIZE_SUFFIX_1LETTER, ca->size);
+					break;
+				case COL_CACHE_ALLSIZE:
+				{
+					uint64_t sz = 0;
+					if (shared_allsize)
+						break;
+					if (get_cache_full_size(desc, ca, &sz) != 0)
+						break;
+					if (mod->bytes)
+						xasprintf(&data, "%" PRIu64, sz);
+					else
+						data = size_to_human_string(SIZE_SUFFIX_1LETTER, sz);
+					break;
+				}
+				case COL_CACHE_WAYS:
+					if (ca->ways_of_associativity)
+						xasprintf(&data, "%u", ca->ways_of_associativity);
 					break;
-				if (mod->bytes)
-					xasprintf(&data, "%" PRIu64, ca->size);
-				else
-					data = size_to_human_string(SIZE_SUFFIX_1LETTER, ca->size);
-				break;
-			case COL_CACHE_ALLSIZE:
-			{
-				uint64_t sz = 0;
 
-				if (get_cache_full_size(desc, ca, &sz) != 0)
+				case COL_CACHE_TYPE:
+					if (ca->type)
+						data = xstrdup(ca->type);
 					break;
-				if (mod->bytes)
-					xasprintf(&data, "%" PRIu64, sz);
-				else
-					data = size_to_human_string(SIZE_SUFFIX_1LETTER, sz);
-				break;
-			}
-			case COL_CACHE_WAYS:
-				if (ca->ways_of_associativity)
-					xasprintf(&data, "%u", ca->ways_of_associativity);
-				break;
+				case COL_CACHE_LEVEL:
+					if (ca->level)
+						xasprintf(&data, "%d", ca->level);
+					break;
+				case COL_CACHE_ALLOCPOL:
+					if (ca->allocation_policy)
+						data = xstrdup(ca->allocation_policy);
+					break;
+				case COL_CACHE_WRITEPOL:
+					if (ca->write_policy)
+						data = xstrdup(ca->write_policy);
+					break;
+				case COL_CACHE_PHYLINE:
+					if (ca->physical_line_partition)
+						xasprintf(&data, "%u", ca->physical_line_partition);
+					break;
+				case COL_CACHE_SETS:
+					if (ca->number_of_sets)
+						xasprintf(&data, "%u", ca->number_of_sets);
+					break;
+				case COL_CACHE_COHERENCYSIZE:
+					if (ca->coherency_line_size)
+						xasprintf(&data, "%u", ca->coherency_line_size);
+					break;
+				}
 
-			case COL_CACHE_TYPE:
-				if (ca->type)
-					data = xstrdup(ca->type);
-				break;
-			case COL_CACHE_LEVEL:
-				if (ca->level)
-					xasprintf(&data, "%d", ca->level);
-				break;
-			case COL_CACHE_ALLOCPOL:
-				if (ca->allocation_policy)
-					data = xstrdup(ca->allocation_policy);
-				break;
-			case COL_CACHE_WRITEPOL:
-				if (ca->write_policy)
-					data = xstrdup(ca->write_policy);
-				break;
-			case COL_CACHE_PHYLINE:
-				if (ca->physical_line_partition)
-					xasprintf(&data, "%u", ca->physical_line_partition);
-				break;
-			case COL_CACHE_SETS:
-				if (ca->number_of_sets)
-					xasprintf(&data, "%u", ca->number_of_sets);
-				break;
-			case COL_CACHE_COHERENCYSIZE:
-				if (ca->coherency_line_size)
-					xasprintf(&data, "%u", ca->coherency_line_size);
-				break;
+				if (data && scols_line_refer_data(line, c, data))
+					err(EXIT_FAILURE, _("failed to add output data"));
 			}
-
-			if (data && scols_line_refer_data(line, c, data))
-				err(EXIT_FAILURE, _("failed to add output data"));
 		}
+
 	}
 
 	scols_print_table(table);
-- 
2.23.0

