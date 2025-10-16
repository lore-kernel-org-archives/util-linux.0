Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8E34DCD0
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629126; cv=none; b=Q9aoxIsz32ChIRvwVW2GXTrvzUsaLGUAqITz5wjPXwMNz2viSm1hRq3oALfR0Llybcu8RQI+Q0qu4I6+BLqYIrZ10X1lddRLCVlTwL0Il2kgjqyXrajfksTPKlnbPawGzKEoFPFlvS8GRogYmNI15wugXClxQrl5BUB9XZDqIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629126; c=relaxed/simple;
	bh=cI+uBWzbwuVfEF7BijHJcahpwSUBDV5Eg46BXYVxqQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XM53n301+5TT44yuJl9SZxFTFoZGwFWP2zGvEFzTScbDaeIdawnnksA2HLSjNT8cJbpAra8Pw99fM8gM8pmWdNOvg0Wuvva5Yk9WLZ68bk8K5mvr3qH/yeC/R450zPLUHBXbxUiWQoDkAorp486x93hECr7gmQdqa6XcwswRUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PtzrD3cy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PtzrD3cy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GAcWK3012300;
	Thu, 16 Oct 2025 15:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6L6kUgJYz1uVtofmf
	IrfYoka2udEJtloka9oIzNNz3U=; b=PtzrD3cyjEvWqFQe9blDzOTFtPF9DCSVQ
	Tw4vQfkM38iqZbdZ9AvHul/JDX0neJxdUQgI0DUjpEX2ecNIicPmaFMYQybtVNx3
	TZyyxCKEDBn8deMuKo/xFTAN2a57GM1b90N7foBn2DcqB1IhfGBo5RBqYuR1fuht
	3A541xQKXoudkRBH/TEvQ7UkKooZvAhbBolO4Bi8e7hU/QE2+5uC3JfPIYKbKZbO
	dqKPdfOq6fF5HsebA+vKQejcPtfTEnB1/fIlrp3yXBuZzjrj2TIgwT9mMxzbkbFM
	z0s7Xdc6c+u4vyy2l03dNNXnX7ENz9ocHu19R0rWMa7BlByGLKSsw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrjsv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:38:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GDmu4q018823;
	Thu, 16 Oct 2025 15:38:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jmxhba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:38:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GFccio31654326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 15:38:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A0E1200DC;
	Thu, 16 Oct 2025 15:38:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E585D200DF;
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
Subject: [PATCH v2 6/6] lsmem,chmem: add configure/deconfigure bash completion options
Date: Thu, 16 Oct 2025 17:38:06 +0200
Message-ID: <20251016153808.3565873-7-sumanthk@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68f11182 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=n9yHTBj7tZKTC83s7TEA:9
X-Proofpoint-GUID: 89gaCsiotRVk-NxoITdm3mGX0ZPv6Yaw
X-Proofpoint-ORIG-GUID: 89gaCsiotRVk-NxoITdm3mGX0ZPv6Yaw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX5WMFVQ1eVpFT
 4sTRwSqaTj/WxtQT3cxZEhNgbKv+3ELy9LEJ1v//trLeb6lZT2rDplmh5W0b27NHx7YrVLE4nrg
 FAMi0+ggZ/RhddJkusJQptELNb4vvhq2JZ2mSlPT/ExQqwbFychqx80yRFrnZH/OEcvMoE+scfp
 oZ7oxDkkng2xHN0KAKI/9GiWzQsT/Dx+2nXzu+ce9FR5q6fkJuxNOYkoz9zFN5n0sXq4MPac2Lv
 WGqxNXIejaKkRP6KIXK3luB5jJoKmP9gSUmr9V/nV5Sb1Fn7Etzqk13Cozozh3M0xXOBtf/H1n6
 cdvfWVT1heOquYCvsCnOHYII1nEtiE+7WB346QoZx7+6T/cgLfb0uS1O3+ozmaDhJ9GlNhI4EJZ
 JHXoHVDTypWv6grAI04URJWgeur5OQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140

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
2.41.0

