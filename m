Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2031CB505
	for <util-linux@vger.kernel.org>; Mon,  2 Sep 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289581; cv=none; b=AmBnIOvfjrQ9rqbNIw89QBObys0FbV8SUIXjJhz6tJ0lo6lYRgfvLiHGWTuvrtL5P9JxUdqgrOJyiXVPCXLS5CFwgvDTQYSVP2E/zjqtWeh5ddMFJBT3ZeoWNjZZ3iwdO85LlppQBZIbb2PsTYMscnewOalcnHCpeLKTsiux0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289581; c=relaxed/simple;
	bh=n6Lit3AWwGmWPo6BnRR1lwftzGqTT9Rj6fu7E7W5im4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuM8/irkksFLVLA1HVgLEB5KBcMa4d/iumwhwjXi/1wkxtpL5iIkm38nDrGVpktUumhi96znN/btIRvHWo54UbXHhHvoIYJcdjsvQg8l69nmz7OOA695j5ke6bOvOhxS/TZurXvjaN7ZWiMBLpQZR3ONY7nbhlazZKGjwbKo5IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BiIG0xhu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BiIG0xhu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4829Mq5X022641
	for <util-linux@vger.kernel.org>; Mon, 2 Sep 2024 15:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=RWHsw1KrlwUwE1JbSrPjW5cVVE
	Nl5z1viHp/J6rApmQ=; b=BiIG0xhuO8E8PRUbAVlleUXWyyMxoA0f55NF4NBmc3
	hV0HF1eTRs+WE4zC+jiyVZPo4PY0lE/0gaKl2cwnUSOh+OdlHHnCPxKYUAreKjyU
	3b7GXseSdkus/q1AoF+HotZ+gc9htBd7lxQhDi6PmZD+cDTQ1QB9QX95XbNRMzMd
	l4jTf/AXvPTdsXLw9xVvOXGTF/o/CVge5mrnJKOTqlGfc9yfY63Q4TX6xg3sJjvn
	Tlse+Zqtm7v4aFi0ur0qKiauEqWSPAVpWaPVBL2gzC0WMjzI+nlvI7euLfDM7u8F
	Jx0bEXLNKx/k8JOArPnOS2JXXQ3pn27mtCcKjNhCHRzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwasg5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Mon, 02 Sep 2024 15:06:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 482F6Bnm007321;
	Mon, 2 Sep 2024 15:06:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwasg5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 15:06:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 482Bu5vq018672;
	Mon, 2 Sep 2024 15:06:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw0xstf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 15:06:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 482F66hD34406936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Sep 2024 15:06:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2574D2004B;
	Mon,  2 Sep 2024 15:06:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC7320043;
	Mon,  2 Sep 2024 15:06:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Sep 2024 15:06:05 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org, hca@linux.ibm.com
Subject: [PATCH 0/2] chcpu documentation update
Date: Mon,  2 Sep 2024 17:05:51 +0200
Message-ID: <20240902150553.1969571-1-meted@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UkDpM8L93XrGK5pL6ACeIbDLP15vGtRw
X-Proofpoint-GUID: 6fHx9KiDRmQrZrjYTwhIti853SM9p3ym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_04,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=633
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409020119

This patch series, fixes a typo and adds a CPU (de)configuration hint
to the chcpu manual.

Mete Durlu (2):
  chcpu(8): Fix typo
  chcpu(8): Document CPU deconfiguring behavior

 sys-utils/chcpu.8.adoc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.46.0

