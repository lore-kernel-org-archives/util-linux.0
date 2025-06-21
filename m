Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A414B06C
	for <util-linux@vger.kernel.org>; Sat, 21 Jun 2025 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750533618; cv=none; b=kmH+cRq2489Fx38FXdCb0nbsA1oOKYg8JoBQpFAcdLI9HQLhhgHumQBdSmkKqqBfgq0gD+bfJ6jj7jqu1n10jnTn4rGlFn07WVuQzNirbW/nY5u6DCWFjmek/Yx0HTxRt9zMfFQ/Dglr502xsVOXqFfBpqkvfH7zG73GLgH2E/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750533618; c=relaxed/simple;
	bh=hMfNEkjdS41nXj4G8LgeWh2xDetrkNshsfF717OqVAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f1S6SZPK0sRE275OccvnAyQ6mVC2ujFGEc5EnHPtEzNsklBGYsxF/9HwAdOSBZel765xTOeOekVJc77TSV9/I91AarFVoLqAFDTWaCuJlxFMr/gx1wlDRET678A1JC0BbpyBEiat8IvaLCELa2+qGA3sFzWdX1iwbYcgR7kOzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QZaIvtqp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QZaIvtqp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LIxdGM009557;
	Sat, 21 Jun 2025 19:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=15aYwle0K9qu6qmAGKcQzFD9bS9B
	a8w4+w8Wb5dsnik=; b=QZaIvtqpJy2Fadw7ZIv7zzRNV6QRBmuvBDA2TB9f+rHk
	+eIzGzj7DlOKxHNi6kc4j3JukAwKyQ4y3X+t0zuGDHCXPKbY+KgucuntY+xuRMhg
	TdTP4cjHZjw8P9J0qpkNI6a9q4idsRDMR7txc7CPyoJRYcTAZuBu3i40OG6cIaFn
	IrCjipQulLXvacWClXIWxeP8Bsl7g1L/EfXLp2AmaG2eQZgNhaFG0MTsiIkc/H/t
	t/qjU1W/6ks75xQ1J9F/ufq3TPt42CpNB/3OjgZigzmD9+b/NQds8jGfpByYQQuW
	dCAzt8gKVCVpcCIdssQTS+IW2PbvK6uutZNRB6ldoQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk63akhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:20:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55LEaFYd010040;
	Sat, 21 Jun 2025 19:20:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47dnmjtjmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:20:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55LJK5L217629494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 19:20:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0FD520043;
	Sat, 21 Jun 2025 19:20:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA25C20040;
	Sat, 21 Jun 2025 19:20:01 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.73.245])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Jun 2025 19:20:01 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v3 0/3] chrt: Improve argument handling and allow optional priority
Date: Sun, 22 Jun 2025 00:49:53 +0530
Message-ID: <20250621191956.21142-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDEyMiBTYWx0ZWRfXzlOrYCZygoeh 466wdtalr7gN9g3WYFDuEhPVCJb1qpZRwtACSEV79PVJZJVg5R1MMWYi6BJKToVQCnPX42FmnP5 a5Yg0JISNQepAkvx+wxqb5WQzC5mYm89vknKzsl37mzLlOI6oXHtlMXqAEQXG4vp6ysR1ddiCp4
 DFO26DGJ9l6IG2s92L1DYsCcVpk5Bp0b++Km2Ed3aK11oggQ/sa2+i1eFpK1cUfxc+AWsYKKtup rdMCFyxZCrnB6Z/SnFSKJfxG4wIp3JbkPAK/nCdLKoo8zF38gl468jVCh84V+q420zoD2EnB5P8 ito3wKW1llKv/Gvwm7bZ1lCoRlesO6vtJOVpRoruPWenRUf+bElr9qFOYMnRXQdPiLyEEXcUFLd
 OjvHf2IE78fYcJrt0BhP/SjqTuB8hFgah7upODuQkfTMoWiGLUyls53oEEU1u8BOQyizd6Hh
X-Proofpoint-ORIG-GUID: RGKQWBrnEArN9tWfk2QZX3kRp-qmXsNs
X-Proofpoint-GUID: RGKQWBrnEArN9tWfk2QZX3kRp-qmXsNs
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685705e7 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=svS2YZ0C6T2P7Q9mctUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210122

This series improves the usability and correctness of the chrt tool:

- Minor cleanups such as indentation fixes and correcting comment.
- Fixes an issue where specifying a policy without a priority would
  misleadingly print current settings
- Makes the priority argument optional for scheduling policies that
  ignore it, simplifying usage for tuning parameters like --sched-runtime

Changes in v3: 
- Made --pid consistent throughout (Karel Zak)
- Change get policy to not have policy options (Karel Zak and Benno Schulenberg)

Changes in v2:
- Updated the man page to reflect the optional priority behavior (Karel Zak)
- Renamed variable to 'need_prio' (Karel Zak)

Madadi Vineeth Reddy (3):
  chrt: Make minor cleanups in chrt
  chrt: Only display current settings when no policy is specified
  chrt: Make priority optional for policies that don't use it

 schedutils/chrt.1.adoc | 24 +++++++++++++----------
 schedutils/chrt.c      | 43 +++++++++++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 19 deletions(-)

-- 
2.49.0

