Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E1018E028
	for <util-linux@vger.kernel.org>; Sun, 20 Oct 2024 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729420211; cv=none; b=IBiP/Red2wKMJlym4AS5zqO6hzdWoA32bcTfAWHb4dP6Fg0QNsvgj1e/Sfmr9wk5MWOQMPm8NzJAbjibTCrXhqrUZDkyb4cgR3xdJCjGW18CfjCejgMtMo7H3ORFU73uejMMkEqr7hPxIe5JdlIRtTY7/CxNdY0a/K24i5PkZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729420211; c=relaxed/simple;
	bh=6LE16H26sTC7ppOSYAoi+Zg1v0r3Oz45OghIFSnltJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MfJilV+gNzmw1gsLwnK1zXp2H0Mb41GUSBxYFpwSuAyTg246kN6Yum8OEfKP35M0SAwN4d3K+Zmi5qA0hBHVqikyPfIOPHnWP5VWg6Sq3DM5QbwzgXLBIdWH2QTzDDT0Q+RGwRQrp1ePvRtP+SgWJTcNO8HiCDyPn4MEVwpK1jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nwVcrRxR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nwVcrRxR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49K8tcmO027842
	for <util-linux@vger.kernel.org>; Sun, 20 Oct 2024 10:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uOYuix
	2RT0j+JO5TX1Hs+sJVZeoR92Xv7ZkEnTqh/DI=; b=nwVcrRxRsDUQU/2C/cv4hm
	jozTQeOWefoelnzwT4XpGpTSLlMimk2AzelvWG9GOPeJVxOqhQ6HIAoZWZEvnpO8
	6Ml45PIF+kQBTBvu6VPYF/lhWkK+ln/1T8+G/dHBb70FrF6xHhvn8ecpaYzuGgco
	NXaa9UA3OFOqzHpFj32SP4ItbyMwzOqOHX2hzjpPi6V255xyAlsfL/DdQ+vGrYzi
	Xopgv7X27z63m7uAmiUfQMc+osT2ijqJ+bLpcM4aXI2xvY1ROSq36KrJV+uC8P+K
	+SAohDQyyISMKB+1dvB/XAqmQ1WC+/3MZpSBQHDjF7F61LEy7ZGaxe/MkL1pJOaA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fsm5a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Sun, 20 Oct 2024 10:30:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49K7t6X1029153
	for <util-linux@vger.kernel.org>; Sun, 20 Oct 2024 10:30:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42crkjs9bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Sun, 20 Oct 2024 10:30:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49KAU69i6554118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 10:30:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0330058051;
	Sun, 20 Oct 2024 10:30:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5B2E5805A;
	Sun, 20 Oct 2024 10:30:04 +0000 (GMT)
Received: from [9.43.92.46] (unknown [9.43.92.46])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Oct 2024 10:30:04 +0000 (GMT)
Message-ID: <5d52951c-82e6-435b-bb9b-1870b2a3d1ca@linux.vnet.ibm.com>
Date: Sun, 20 Oct 2024 16:00:03 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lscpu: fix incorrect number of sockets during hotplug
To: util-linux@vger.kernel.org
References: <20241018104335.3481856-1-anjalik@linux.ibm.com>
Content-Language: en-US
Cc: Anjali K <anjalik@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>
From: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
In-Reply-To: <20241018104335.3481856-1-anjalik@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: olnREwdapQetmbWSnKK_pJsx0garg4HY
X-Proofpoint-ORIG-GUID: olnREwdapQetmbWSnKK_pJsx0garg4HY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1011 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=855 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410200069

Hi,
I have verified the patch and it works fine!Here is my analysis:

LSCPU O/P on my system without enabling and disabling cpus

Architecture:             ppc64le
   Byte Order:             Little Endian
CPU(s):                   384
   On-line CPU(s) list:    0-383
Model name:               POWER10 (raw), altivec supported
   Model:                  2.0 (pvr 0080 0200)
   Thread(s) per core:     8
   Core(s) per socket:     12
   Socket(s):              4
   Physical sockets:       2
   Physical chips:         2
   Physical cores/chip:    12



Before applying the patch
While repeatedly onlining/offlining cpus on my system , saw that socket 
number is higher. It doesn't happen if i do online/offline of cpu single 
time.

Architecture:             ppc64le
   Byte Order:             Little Endian
CPU(s):                   384
   On-line CPU(s) list:    0-3,5-7,9,11-15,17-383
   Off-line CPU(s) list:   4,8,10,16
Model name:               POWER10 (raw), altivec supported
   Model:                  2.0 (pvr 0080 0200)
   Thread(s) per core:     8
   Core(s) per socket:     9
   Socket(s):              5
   Physical sockets:       2
   Physical chips:         2
   Physical cores/chip:    12



After applying the patch :
Tried the same scenario again to online and offline the cpus in a loop 
continuously and it didn't show any wrong topology:

Architecture:             ppc64le
   Byte Order:             Little Endian
CPU(s):                   384
   On-line CPU(s) list:    0-3,5-7,9,11-15,17-383
   Off-line CPU(s) list:   4,8,10,16
Model name:               POWER10 (raw), altivec supported
   Model:                  2.0 (pvr 0080 0200)
   Thread(s) per core:     8
   Core(s) per socket:     12
   Socket(s):              4
   Physical sockets:       2
   Physical chips:         2
   Physical cores/chip:    12

Tested-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>

Thanks,
Anushree Mathur
