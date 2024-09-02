Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A71CB50B
	for <util-linux@vger.kernel.org>; Mon,  2 Sep 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289583; cv=none; b=WhnIJIvPpVPJaAKTZrOlWUJY0PBll7gWf6ATHBwLKKQzb2tNsjk6Ox4eUjgF+uLD+YqbZjjxWqYKe5F860TjFgCVNHi8/VXTu2Dn6ASLr5gRm08n+oAzRBi/2Ted+sMmjVqNvaQlMB6dERC8Qu+ZXckR7h3rmhAzEeGt8F+3lw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289583; c=relaxed/simple;
	bh=bDVbVbvasJRWfkT7iBPSr0LY2d0BvNlm4MbFsa8Opx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRFdMKIbhAaiik0EBfV/WZwA5ZC+jmcw5ylQ4Rflr210dTCLGlSJyPRdWA8E6XoiUtzRUzwExPU8vhEo2gvF2sf4WyNbO1njDfLQv2oXoQRW8u54H4H/LDlQDejYHPRPRse/cWWvVkgLgOaGBrQ/UeJe1/g8Y51a6/uSGzK5Y/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kYjV2BR+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kYjV2BR+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482AdRSQ031826
	for <util-linux@vger.kernel.org>; Mon, 2 Sep 2024 15:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=2OCwovdqDnk00
	K6k7VgVTSHf1ttgSWb3p8hbBtv0MtM=; b=kYjV2BR+eHw2ytDQhiK/nTkSDhCBa
	kmZr2CZqtrGa4frOJADhAcVqMAmpTav8UsllLBArb2fu9Qh1GsZIcKdqQkvOobUV
	nQBZRJfbjb97zTqwadgr2Vmh1+pTfPynJZY3nbbh7+JMeLjkReorPu+NmJvcz/Gf
	TWkQQh1uCTYuSd55ap4P3JtHJetNDtWhVowsEITuAT+gzSsaO2ADasHphE3jzjDC
	/CT2emynw3srEW/taTBwLlsRCxV60emG4cX1dHYv3j1GwM2YcGjO6gyED4r0EQn+
	xykv/YnxF48Toz14XlJCGOchLwDRo3rDXfbqMYFhjHJVD2eDtzJaRVTzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btuwsg9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Mon, 02 Sep 2024 15:06:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 482F6D3K018007;
	Mon, 2 Sep 2024 15:06:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btuwsg9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 15:06:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 482CMt9v012045;
	Mon, 2 Sep 2024 15:06:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cegppmq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 15:06:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 482F68te35062400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Sep 2024 15:06:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09A2020043;
	Mon,  2 Sep 2024 15:06:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D074720040;
	Mon,  2 Sep 2024 15:06:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Sep 2024 15:06:07 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org, hca@linux.ibm.com
Subject: [PATCH 1/2] chcpu(8): Fix typo
Date: Mon,  2 Sep 2024 17:05:52 +0200
Message-ID: <20240902150553.1969571-2-meted@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902150553.1969571-1-meted@linux.ibm.com>
References: <20240902150553.1969571-1-meted@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HioDWJP-VzGzVVJXDPvpqsBQUxlGljEX
X-Proofpoint-ORIG-GUID: wRX7Dc2m0WT7veRgpjAF3XuYkuVUO-y-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_04,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=821 mlxscore=0 priorityscore=1501 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409020119

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 sys-utils/chcpu.8.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/chcpu.8.adoc b/sys-utils/chcpu.8.adoc
index 80dfc5f20..0b0bcbc57 100644
--- a/sys-utils/chcpu.8.adoc
+++ b/sys-utils/chcpu.8.adoc
@@ -38,7 +38,7 @@ Enable the specified CPUs. Enabling a CPU means that the kernel sets it online.
 *-g*, *--deconfigure* _cpu-list_::
 Deconfigure the specified CPUs. Deconfiguring a CPU means that the hypervisor removes the CPU from the virtual hardware on which the Linux instance runs and returns it to the CPU pool. A CPU must be offline, see *-d*, before it can be deconfigured.
 +
-*chcpu -g* is not supported on IBM z/VM, CPUs are always in a configured.
+*chcpu -g* is not supported on IBM z/VM, CPUs are always in a configured state.
 
 *-p*, *--dispatch* _mode_::
 Set the CPU dispatching _mode_ (polarization). This option has an effect only if your hardware architecture and hypervisor support CPU polarization. Available _modes_ are:
-- 
2.46.0

