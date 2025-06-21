Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417EA7E1
	for <util-linux@vger.kernel.org>; Sat, 21 Jun 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535469; cv=none; b=o7vza67qukris1Wcmdb+1GTHguHJtxI+LarEOsg+unaoblApMGmsppLwM9lqFt2WlsVSvnYavpzV7oEyGAi7Lir3S3s3Ks1fD67UVT1yKQFdP13s7vvkiSuOuS0Jdyc1w4VfIu/edUOCDu7xPGIDYVPI/eypMkyQdlj9q/tNJAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535469; c=relaxed/simple;
	bh=EYtJTR32rFPSZ597+86W/Yk8kXlzcV2aVVBAI0ToLrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rTLzk90ZsabyYLcWJxOfHJ6P9gvYQbbByWMzYA9CI3eo38uCsv6nayYDkcx4D1kgwmL5T2zy/umC7azK8VnoiIi2KxN/tUzwrXioQ+jOXteODV4QOUsCcqn3IWmcm3haq3VPpYWIvAGcEwOy8bztM7DotL+mxWg47Kbp47fLqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PTz0+sud; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PTz0+sud"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L9svHJ007576;
	Sat, 21 Jun 2025 19:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=O1XzOSwETy2MxsP3Z2gpTd3w1Ber
	9n57IG8n+5GALZ0=; b=PTz0+sudspopz9QtChfZahWwsIG/Exw77GGYtNOJxwfS
	TgKPlzkkIbUeKmicHdrWTdYIqzaUYLgiKP3RzQiQ7D3O4f3UYP5I64dz1Oz80GWC
	BAJ/AmP+KoEWkanrs8p4MapXi7cxxb+00v4QIveJTSuNOI2Re+r6faNReXVPfS1H
	DGQxEOKpP9d2FL1dQI8aMWrXeErw3TRaGyCFlLyQMeA2IxbSp9RU2Y1DV5uqLKsV
	zR0o1Pystma3IrgydeB3OyohaEcb1TjEKxLLkAV1AZkR17TJC/4xC82/nUtAhW24
	s8xtUyiAKiM1j1uT5TWbq24r3d0RoWkox07x/nIFNw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8hth9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:51:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55LJR86D010013;
	Sat, 21 Jun 2025 19:50:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47dnmjtn3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:50:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55LJougV16974098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 19:50:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0EA62004B;
	Sat, 21 Jun 2025 19:50:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 606F920043;
	Sat, 21 Jun 2025 19:50:53 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.73.245])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Jun 2025 19:50:52 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v4 0/3] chrt: Improve argument handling and allow optional priority
Date: Sun, 22 Jun 2025 01:20:45 +0530
Message-ID: <20250621195048.24900-1-vineethr@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDEyNiBTYWx0ZWRfXxNbVyjXzdwrf zlOsIJp4NeS2BstlZMIiTkJV2TP8ESHEiBAllIkrvaC1TlIgmKWuvvp1MTPlDNuxZJXJ1XcEFut bJPa7wdZ6ZLGYGue5cQ6TkkAt0VgeCeQEWozy4piFtcdq63IlqS6kPp2pkWvGxU6OoXue06rZmr
 1C6GUUSeQ0sJag6W3+4soMNAAdzS5EZq0SgJ/Nr5ta0L3Zo9NLizeb0kAkbzFnDcfFSyB98zY3B X+ZYkPGD/FUnlJlrVleyDbA0hZZ1SOV5zD5i+mQLfo4I3WdJWiThyncWPBLLvEqDJtLPLGsuhXM 9ldE0sXRupg2o7KKdqLzI3KaOTdMIg0ArznfBfKNRT8sYI5Zhq/LvKn6EeUJJTu8adyoM21W8Uw
 vyQj2Cm8RVhswna61vP61IObVbI5Sj7knc0OEasP13Ajj0+yH+J6FLAOhQZR7MHH7XIJYL75
X-Proofpoint-GUID: jAiRahjNTDhPCFkii9ykiWjwIeiNvCFe
X-Proofpoint-ORIG-GUID: jAiRahjNTDhPCFkii9ykiWjwIeiNvCFe
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=68570d24 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=svS2YZ0C6T2P7Q9mctUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=971 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210126

This series improves the usability and correctness of the chrt tool:

- Minor cleanups such as indentation fixes and correcting comment.
- Fixes an issue where specifying a policy without a priority would
  misleadingly print current settings
- Makes the priority argument optional for scheduling policies that
  ignore it, simplifying usage for tuning parameters like --sched-runtime

Changes in v4:
- Rectified my mistake of not giving proper space in a comment in v3

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

