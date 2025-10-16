Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243CE32861A
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609878; cv=none; b=St7H7aMeysGLMakoF52qw5rjQiVKxywmyZc5lffCTS4fJB+m7TuLNGWpwbpHtwojzHcLky7SUGURd+jp0FW7QxRiPitKonqlChqxkO/IihbTLURUf2wggKLl822DRk6mhDHTpojRwhoR5y6rMTlvoYsz+H0qJi1bfUgA4EEZh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609878; c=relaxed/simple;
	bh=MUSWxz5bdQZLheGL9qs5weTBSzLf6r/2Z9250qihJtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfKF0IaCK9yrAw+ceTtQVkaaIqUOvfFrdrcWvMrLQmfCwogQR+wexVVV1GRJShmrF0i5BhCF2r8RvRgcxhZo/nvCUdVC3vNw+o3k3DtmtgGSbjxKq55qqxPd2P3xwAZ4r8aeKibZxPepXDyQvToPD1KakUzdoR8EMf3sR9RG408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iuuGXr+Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iuuGXr+Q"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G107ZW010783;
	Thu, 16 Oct 2025 10:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yM/2d75nYtP1n52tR
	ajCCRFpQOIOHhuS8ZP4KIiQtP4=; b=iuuGXr+QHtMXTaJ4cka17D1OJbRiNjqHQ
	URimaUxggwXGr+fgi3FSsJX53XZ8rrFcVIlE+YD53w7wqmmuzi+q4YEVBM/hwQtH
	ubAuzq50L16NN5U86Qnb13zE1XK86C0YiqeIAJmszr3i0ywvxWNqahLT76S/iuo4
	daOcxvefiy5mzviOODv5q5m9p6/m6JR9hV5uPqmVnsciM+nF79kbccLwEP3pWBKN
	jSEFK0Vi+eOHersvQddxkVq956DGYQBSiPZaXYsnPpl6cCJxvHSjjEIlc+An2UnI
	BNSiEv2p4foW83N84FP7XPCNIDiW5BL3oSH8EdKpToNeXH0cigHAQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewu9yjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G91XBw015204;
	Thu, 16 Oct 2025 10:17:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jsddcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GAHm8N31326480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 10:17:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBA862007E;
	Thu, 16 Oct 2025 10:17:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B21D920081;
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
Subject: [PATCH 6/6] lsmem,chmem: add configure/deconfigure bash completion options
Date: Thu, 16 Oct 2025 12:16:53 +0200
Message-ID: <20251016101701.552597-7-sumanthk@linux.ibm.com>
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
X-Proofpoint-GUID: X_3LFCvSuqlzU9nMJCUrAIKUJhPy_ZM8
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f0c652 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=n9yHTBj7tZKTC83s7TEA:9
X-Proofpoint-ORIG-GUID: X_3LFCvSuqlzU9nMJCUrAIKUJhPy_ZM8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX1jgHV+o7x7/8
 LbJ+r6fp5Vmt9LJZtHzsJhEbJRYwaFuxXnXdGprrrJN5g1Q9Ym1ArPavxazGjLO6drwshuLOoj6
 KqAA2XdhW+1yGeiwQ6TUzpQGXz2Ttc/7NZmhqouVdE3FzSwseLSWbQBVWfOttb1Rwhkk9MsxMGz
 83xr6i2DT4N5Rc7y5PG0M3kNF3/goDzKwtUXDLaTz7PgFxl9hKLpQQ6bZ1OlKgCJ7LnP/WDzMru
 6ogCznzCfah+lm3No/xA0h1j+sggWJUFsKHK2oHTY9pwNp617U3mCSl+dChOs8idXjvxC5MJt/3
 BWJMSVzw78vdNX21SRh7/B36E7UXRxA+rcgi1nSeCxh2JKELj5ks+zbnyJ7gaUoJTxMOx8VxGkm
 yS3G7rL+QCT3jUrDX+4zyYA2slZHRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

Add bash completion for configure/deconfigure options in chmem and lsmem.

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 bash-completion/chmem | 3 +++
 bash-completion/lsmem | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/bash-completion/chmem b/bash-completion/chmem
index 3e3af87ac..f10646677 100644
--- a/bash-completion/chmem
+++ b/bash-completion/chmem
@@ -14,6 +14,9 @@ _chmem_module()
 			OPTS="
 				--enable
 				--disable
+				--configure
+				--deconfigure
+				--memmap-on-memory
 				--blocks
 				--verbose
 				--zone
diff --git a/bash-completion/lsmem b/bash-completion/lsmem
index 7d6e84247..185a15fd2 100644
--- a/bash-completion/lsmem
+++ b/bash-completion/lsmem
@@ -9,7 +9,7 @@ _lsmem_module()
 			local prefix realcur OUTPUT_ALL OUTPUT
 			realcur="${cur##*,}"
 			prefix="${cur%$realcur}"
-			OUTPUT_ALL='RANGE SIZE STATE REMOVABLE BLOCK NODE ZONES'
+			OUTPUT_ALL='RANGE SIZE STATE REMOVABLE BLOCK NODE ZONES CONFIGURED MEMMAP-ON-MEMORY'
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
 					OUTPUT="$WORD ${OUTPUT:-""}"
-- 
2.48.1

