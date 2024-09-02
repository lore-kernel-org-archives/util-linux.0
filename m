Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946B1CB506
	for <util-linux@vger.kernel.org>; Mon,  2 Sep 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289583; cv=none; b=usYoHqUPeIQTj3Yb/nBnVt+VuuCCV/TwkHmdodDkCZPum/K7PUxfUBaDnEGH9Q3Hb5vhY+prFz/t15JYZKdzoQdFQpVK+DfgIseX80/u4IgkDyqj4lEspMV5EtgFF3w1ivROmYrYsJtmwSKeZ8ThdxQSqWzfasOAYzqAH+ofCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289583; c=relaxed/simple;
	bh=Wvrqmv+hjx6/v+JOvMo6qihamNGzJjEd4r/wLQ7o3qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rByMB5632DqOXtDSvu3H6aTzS4JgpQja1qY/J25CiGefXjMw8uD+ixffWbdBpY47UrxU//CQG442CNIRjQn+iDCbQQJbXfuWfDLG7IQGKNXDEhIvELSBcqRDzu1W2wIEDiafuP+9L8XAuGtEQ3yZavGvwGXqOEi/16Gw2c0i5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kLEcw7GM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kLEcw7GM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482D5Nqh007932
	for <util-linux@vger.kernel.org>; Mon, 2 Sep 2024 15:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=UmSMvBV97Y+tt
	utwHRSgdTIoVivR46mAMYEbv2KF9KI=; b=kLEcw7GMhIxdYO9x/uzqey4K8ZCHd
	f3/GNoPE3EKyPBBE0W13qR3cJBjc2ZqgsrBqY3e6iA8NBtNOkF7AdrCDccxke5in
	jwQnmbifvjnNqvb7EAJLal2imhYfKpcSvQtB4HCd37KYKq0l9E1vpd5o/CAdxhJ+
	u+pcanqTP+5aSaAPfTb3Gk4kW9xTguivJCo8l+mr7XxccJF+Zw9JXYfX83G1kMnY
	+8+7H4KiQ9/PFIZdmfpKd0zucPwAkg0lq4B3OUd9AiCkRBDVfNid8HP5Mk4Tyaru
	9hY6m8KI07yWKTsq1Ior4SQAoW7pW7o41/KvduS5k77fiqp5hbJJZ6buA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwasg66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Mon, 02 Sep 2024 15:06:14 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 482F6D8R007341;
	Mon, 2 Sep 2024 15:06:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwasg63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 15:06:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 482BxJ9J018726;
	Mon, 2 Sep 2024 15:06:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw0xsth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 15:06:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 482F68dt21627254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Sep 2024 15:06:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD8D72004B;
	Mon,  2 Sep 2024 15:06:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F94D20043;
	Mon,  2 Sep 2024 15:06:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Sep 2024 15:06:08 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org, hca@linux.ibm.com
Subject: [PATCH 2/2] chcpu(8): Document CPU deconfiguring behavior
Date: Mon,  2 Sep 2024 17:05:53 +0200
Message-ID: <20240902150553.1969571-3-meted@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: bNP1t8_N7xJ2DGfejj1zEuXXLoFJt8k6
X-Proofpoint-GUID: kTQ9mkinWFk1E-4GYPq3d3SyxbbtTPPw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_04,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=895
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409020119

If architecture supports (de)configuring CPUs, the user should
deconfigure disabled CPUs to prevent performance penalties.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 sys-utils/chcpu.8.adoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/chcpu.8.adoc b/sys-utils/chcpu.8.adoc
index 0b0bcbc57..f08b5a6ab 100644
--- a/sys-utils/chcpu.8.adoc
+++ b/sys-utils/chcpu.8.adoc
@@ -39,6 +39,8 @@ Enable the specified CPUs. Enabling a CPU means that the kernel sets it online.
 Deconfigure the specified CPUs. Deconfiguring a CPU means that the hypervisor removes the CPU from the virtual hardware on which the Linux instance runs and returns it to the CPU pool. A CPU must be offline, see *-d*, before it can be deconfigured.
 +
 *chcpu -g* is not supported on IBM z/VM, CPUs are always in a configured state.
++
+if *chcpu -g* is supported, any *disabled* CPUs should be *deconfigured* to inform the hypervisor that these CPUs won't be used, avoiding potential performance penalties.
 
 *-p*, *--dispatch* _mode_::
 Set the CPU dispatching _mode_ (polarization). This option has an effect only if your hardware architecture and hypervisor support CPU polarization. Available _modes_ are:
-- 
2.46.0

