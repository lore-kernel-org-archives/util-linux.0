Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0DE32861D
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609876; cv=none; b=ToiQWS+sAK2xw3ZsaMg+7I01GGiu7EzDkUZTjPLg/RU0uPomvuLd74onxcXIPeKT7+toH0ZIM6ugzV7tnjQGMFupijdACEc2ZRiiGdIGuNeG2lyeizwE6YvXa1WqDgzO5viyK/vMEFxc719NqBJZLj8WX0rsPjhz/2Mq+tBPF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609876; c=relaxed/simple;
	bh=oqzzypTkZcs9yTrRGT+hOMIjqDZtw9JsVL43vLicxEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BH0mPxAkPaJzScQrOd/zneX4V77pTiq2E9c4yvy/04HpHdsMpD52/9+juTVVgs8iQefcVOU51YkWqrm9DQsb7RcAkM/QP/xZggx3sBO2mz/HVVCm69rRFwpxrsJY0yYaJWKePNbRkfqlxmBn7f551yIB3GgZ5sbqJvjoBuMhOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PpD1YSyT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PpD1YSyT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FNlQj5010243;
	Thu, 16 Oct 2025 10:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=z1RdeYEoJnXCOL4PVga4mDLSidBv
	OY9yx4X2nOtn7tk=; b=PpD1YSyTchVxnLPG6wzojOetSuUR3t7tEbLEKtK7Ij7w
	h4jazL6hcQtWO8Poor6M64Ux6DU66Lli8VLzwPKTt7DK9FVNzNhR3gLu+xeHbtBU
	/OVCgIX/bd3vE4IqmyCPivbuIsmdHF/pDl9EsQpv6h7t8q4LiXH2/LWreQ6JYJTb
	fNsc3hjViFiSK9/uG0oiEM4mSl1NwC97xEltAFuNkLZSlaCld/Vv9OcbdFFaDu5Y
	A8CaYWj0LVWQH+tq/cY3cud8JuDYcvqZwZQAL0TbxSJLyJiDgNLpm/HJl9wzQx4T
	FhQfWMpxuyifd44KiZRpYl5g/CjGUf6nenXJBmrp1Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewu9yjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G6mfZl028055;
	Thu, 16 Oct 2025 10:17:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49tdg9cafr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GAHlQt61800870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 10:17:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C47A92007D;
	Thu, 16 Oct 2025 10:17:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A39FA20063;
	Thu, 16 Oct 2025 10:17:47 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 10:17:47 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 0/6] chmem/lsmem: dynamic (de)configuration of memory
Date: Thu, 16 Oct 2025 12:16:47 +0200
Message-ID: <20251016101701.552597-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: msi1v1VrmxUpc0ZC1maXJOOcIFJ08Y48
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f0c650 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=7YYSGnMpRoyYo0DGkyIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: msi1v1VrmxUpc0ZC1maXJOOcIFJ08Y48
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX7AyurIF7jiDl
 wRYqykbL9pRFDmToyUixk/PJWZTn2/Mv3A1KGKZrr8cYDd2ATJ9G+F7ZeOX1/O0+M2JGKVD9dxg
 G0ndu6q1GitDtiFeJz8ixFKfcPMO1J8OU2lswRwv+6fCa5qoHwYJUkk7zCZT6Z2uptq1cQSOrwq
 FwDJs3aQlaMt+Eab4eMcbfGzuMwyPGWJM7WFxE5WU+nZax3r4jHtqIesafRbopHm5b9ocjsHhNO
 scj+RaOSZmwfAxIGu3ki0y/BfZ27odZ5SOb6cqkpRBeX5YrFMDr5Rh4dt9zihUvGtIexpTELKf2
 6d6y9o2uRqho9Ko+3wilnPwOmr8LvbdETBV9g4V+0eRPAiHcFYM4zrezPqBiYpaUe3kuSPM2yEl
 o0ikqiQhJCqS7ssuc3rhrmfYSUFWLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

Hi all,

Patchset extends chmem and lsmem with support for dynamically configuring and
deconfiguring hotpluggable memory blocks on s390, including per-block
memmap-on-memory handling.

On s390, the memmap-on-memory feature was
introduced to ensure that the struct page array (metadata) for hotpluggable
standby memory can be allocated from the memory block itself. This allowed
hot-add operations even under memory pressure, especially in systems with an
imbalance between boot-time online memory and standby memory.

The original implementation had few limitations:
* All hotpluggable standby memory was added at boot, making blocks
  visible for online/offline operations earlier.
* The use of memmap-on-memory was global and static, decided at boot
  time. Either all standby blocks used it, or none of them did.
* memmap-on-memory choice could not be changed at runtime, limiting
  flexibility.

The s390 kernel (linux-next) ff18dcb19aab ("s390/sclp: Add support for
dynamic (de)configuration of memory") no longer pre-adds all standby
memory at boot. Instead, users must explicitly configure a block before
it can be used for online/offline actions.  At configuration time, users
can dynamically decide whether to use optional memmap-on-memory for each
memory block, where value of 1 allocates metadata (such as struct pages
array) from the hotplug memory itself, enabling hot-add operations even
under memory pressure. A value of 0 stores metadata in regular system
memory and enables continuous physical memory across memory blocks.

Kernel changes for dynamic (de)configuration of memory (available on
linux-next):
https://lore.kernel.org/all/20251010085147.2175918-1-sumanthk@linux.ibm.com/
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/s390/char/sclp_mem.c

The kernel sysfs interface provides configuration and memmap-on-memory toggling:
echo 1 > /sys/firmware/memory/memoryX/config – configure block
echo 0 > /sys/firmware/memory/memoryX/config – deconfigure block
echo 1 > /sys/firmware/memory/memoryX/memmap_on_memory – enable memmap-on-memory
echo 0 > /sys/firmware/memory/memoryX/memmap_on_memory – disable memmap-on-memory

Patchset teaches chmem and lsmem to make use of these interfaces, mirroring
existing online/offline semantics:

chmem -c 128M -m 1 : configure memory with memmap-on-memory
chmem -g 128M : deconfigure memory
chmem -e 128M : configure (if supported by architecture) and online memory
chmem -d 128M : offline and deconfigure memory (if supported by
architecture)
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP-ON-MEMORY

memmap-on-memory can only be toggled when a block is in a deconfigured state,
and is supported via the --configure option.

Thank you

Sumanth Korikkar (6):
  lsmem: display global memmap on memory parameter
  lsmem: add support to display dynamic (de)configuration of memory
  chmem: add support for dynamic (de)configuration of hotplug memory
  chmem: add chmem documentation for dynamic (de)configuration of memory
  lsmem: add doc for dynamic (de)configuration and memmap-on-memory
    support
  lsmem,chmem: add configure/deconfigure bash completion options

 bash-completion/chmem  |   3 +
 bash-completion/lsmem  |   2 +-
 sys-utils/chmem.8.adoc |  47 +++++-
 sys-utils/chmem.c      | 372 +++++++++++++++++++++++++++++++++++++----
 sys-utils/lsmem.1.adoc |  46 ++++-
 sys-utils/lsmem.c      | 144 ++++++++++++++--
 6 files changed, 564 insertions(+), 50 deletions(-)

-- 
2.48.1

