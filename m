Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119A1DC198
	for <util-linux@vger.kernel.org>; Fri, 22 Aug 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875418; cv=none; b=Nt0pUXrEhIj3g7MoCQH6OWGNkkxT/Np/+CER9RLGTPmMtpsSaS96uywEH4TMDoL1z/1VtQW31oDLJtt0FCFxihCpTNT33fUmB1MpN3g12Q2jQJP7jOb2a8x/BSBeEbv5u4hnwC2ON+0XDM6E2lSwrAIRurpP2re7ys3QGKfjwQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875418; c=relaxed/simple;
	bh=0iIi06J7u4ZFSix91ZvykTtToKdHWcVCoG9OOvYHNJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uc0EW8T0updbu0DiEdzC5uQra3y5UcCOtfcqOIiSyinEQz+H4ULWFKT2AaF61aMHcT4/MyHc+toniT/7WA3Pj9xO5KxdpeT9Mdk1kOc/YsbTfUEJ/CZTQYuPsIMjm78npsz23jJWqRj8v63IsIiv8ItaWnEuWxXH+Opqo+J4zs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NekMZ3NS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NekMZ3NS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MEcsEA008285;
	Fri, 22 Aug 2025 15:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=N2JycebTkqGHAxBDdljkxmD2qqtjLKawalHI1rbbK
	a0=; b=NekMZ3NSBRY/UIh5eLPrgX0xGJUV4fVgREEF05fvfnAkuMmTy04BURt2M
	Fwbowo9QmuVMln2S2GbcaBgYWg5XpuuFaQJh0uB2CzbSYMM5JesqGU9mcbwOpz9A
	GXHdZdY9yoCm/8ozn+ipW6trFIgXzmJhr9y/QhI/d0KMb0WmyskRz6W5UxevxH4f
	BPLHp6Fh/zXsEN2AecpDHu7cJJkfXCkgeWJkLPafhmNQzMuSUZfdZ03lh0+p1yKi
	oGlsSSuIdske7bpuEwZoaWSxWP0wtn6gRYtubgSwXvry04rGXSvqpV4dluDEnSRj
	1Fo3w4q6YIxRpjDZ9GKGOV+hd9NDA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w70e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 15:10:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCqCIc016030;
	Fri, 22 Aug 2025 15:10:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my42du39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 15:10:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57MFA78L51708382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 15:10:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E34220043;
	Fri, 22 Aug 2025 15:10:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4849C20040;
	Fri, 22 Aug 2025 15:10:07 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 15:10:07 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, sumanthk@linux.ibm.com
Subject: [PATCH] chmem: Remove commit - chmem print warnings about failures always
Date: Fri, 22 Aug 2025 17:09:51 +0200
Message-ID: <20250822150951.506617-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BISo5u6Zt3DbdodATxRJfTpuglCymFI_
X-Proofpoint-GUID: BISo5u6Zt3DbdodATxRJfTpuglCymFI_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX/o03WhbNeQsy
 nOvPGa0r1++mINmq14Eq/tbZfVCsuqxYmuOJGInU6Sn+Y8uUwKYf/6JQEWk5NVTonxkUgDY4Rad
 eWeueWjLWl/vkLz1IbmA6/ZIh3Qv44YisEocFvNMWc8o4HOvuegFYpBC+cuVFOfNm17qicxFnLx
 wjhszNR6gdDBa4hx+T9C6u3bhLbV6/MKMlVAkJ4JenRhY+3zlEDMWgsRGGH0AoetcOk+GETjOml
 /0dr18twk3rz0+5gVpzZ9s3Angr++At3mzL8cYY6zA3WsvegeDTcGYM867TBHTZ1tZSfNzlbauG
 kVo0kyF1Az9nsaJMQlfwZr80cZiD42ul6pW+FUDYiDJ2l0JY8s+4jkQCXi68BXmFvbrtwIiSjCi
 sw/jeKnKtrRoFqqiFxbdyRXzXkvs8A==
X-Authority-Analysis: v=2.4 cv=a9dpNUSF c=1 sm=1 tr=0 ts=68a88854 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=RcE6poM8lnotgKd6khcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

Users do not care which blocks are set offline, when using size option
Consistently printing warnings/errors in this case may confuse them and
create the false impression that the enable/disable operation itself has
failed.

If size option succeeds, chmem should not print errors/warnings.

Hence, revert commit
48675a744 ("chmem: print warnings about failures always (not only with --verbose)")
---
 sys-utils/chmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/chmem.c b/sys-utils/chmem.c
index 52e6f49b3..bee2a90f8 100644
--- a/sys-utils/chmem.c
+++ b/sys-utils/chmem.c
@@ -146,12 +146,12 @@ static int chmem_size(struct chmem_desc *desc, int enable, int zone_id)
 
 		idxtostr(desc, index, str, sizeof(str));
 		rc = ul_path_writef_string(desc->sysmem, onoff, "%s/state", name);
-		if (rc != 0) {
+		if (rc != 0 && desc->verbose) {
 			if (enable)
-				warn(_("%s enable failed"), str);
+				fprintf(stdout, _("%s enable failed\n"), str);
 			else
-				warn(_("%s disable failed"), str);
-		} else if (desc->verbose) {
+				fprintf(stdout, _("%s disable failed\n"), str);
+		} else if (rc == 0 && desc->verbose) {
 			if (enable)
 				fprintf(stdout, _("%s enabled\n"), str);
 			else
-- 
2.50.1

