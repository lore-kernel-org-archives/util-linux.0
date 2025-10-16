Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16E34DCD7
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629127; cv=none; b=bl7xpTi8BPnHhYta5VxTKc/fHDqdQiU22MeNyj81BoV/J2yDOura8J/XvWZtMZeHcii/rKaoJXirqOxKEFObEGQZRK+8RKm22CUlH8dB3+wasSn97QpixohbAW65sDE2J3B0dRdP75chRAMsb+o3cuDZ2e4JzHqk2gI5FR5ZJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629127; c=relaxed/simple;
	bh=YbwwTGFtKycBQ+nk/AIE9juGrkwU3Q96BaYCQOPaFVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lOu8LuuqKDBLXz7S6D9WQH2P2+r1+cj65NG06YmGm1G2Ae5aRFPaV89mHvW87cIRcF+EyLLiLuI2n681kHczF+TPLDYdurPvMAXQIBzd7iDW1QHICp9DISskdXmJVklA6nFoK7IJNDJF61l8gOZU2JDdYv0xkpr7NZIIzEZXL5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kr/cV9+q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kr/cV9+q"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GBneWd010794;
	Thu, 16 Oct 2025 15:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=dLnjmHwXbl4oem0TUwLi/nU6pe40
	I1DKGUnydhTgLi8=; b=Kr/cV9+qVlLnscvw0q4X0S+17uuKrhosP3OEKop9fAUh
	eXaqvGSb0F29v1Eo2L5iTv2QshA2JCiex2iuwjFBXmQz0/4lKaF875zHqf31uYa6
	PzaG6UPdYkrIM3tLZzylQAM8Jr5P6PyXhU0Tq1FoX64PPSd0Xzf094iPsbGCt4OW
	ihACF9y09Jvvyg7EvSrZGAp1LzygaL6ovQd1lau4CLI9iQ/0VBaM93pbWlbrQTPM
	h3931yEa4lc80TguLal/VKUCU2ADh7J6ukslu6C2+SdbYfP8E6q+43b3BsbUvoQk
	LrhRIrU8sHyTNYLJqYL161LsFuR+zT9ToThFKe3G1Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewubn8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:38:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GCs4X5003709;
	Thu, 16 Oct 2025 15:38:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy6kaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:38:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GFcbre61276552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 15:38:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07FFD200DE;
	Thu, 16 Oct 2025 15:38:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBD5D200DC;
	Thu, 16 Oct 2025 15:38:36 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 15:38:36 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v2 0/6] chmem/lsmem: dynamic (de)configuration of memory
Date: Thu, 16 Oct 2025 17:38:00 +0200
Message-ID: <20251016153808.3565873-1-sumanthk@linux.ibm.com>
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
X-Proofpoint-GUID: pNi30xKsQNc5LvOd-GTv6KqPl_VBzgZA
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f11182 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=iV0NRablTndQw4ncUN8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pNi30xKsQNc5LvOd-GTv6KqPl_VBzgZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX8+fZ7w6i6Ocy
 ECFioi91y01UYadAZ9KFBEmysdZ5HSn9RSP4wbL5OvhiD6pxiKle6QZXBLQZ3hgyrQXErGkVvRp
 qzK4FLzkgggk+FxevR7n5xZm/5OLJPJM1Gi6YGotGmV16ejNhtJ870cwm05BTp6bnwKN/3HXXln
 +sCIg75yT8QrOed2nqVf14lXMWsvcH93ywMPT26tdGUK+nxeuGCib+hRUqqrA03oFCZ+AHLAbR8
 56OMocZRg+E2n0Ixdqblmx0zpoSkoTUqaDDpIpYao2LQBQmcPSRewWFHulFjnjtw/xKLAW6QSTs
 ytxucahDxp6CK7k4hNy3gvwj6FPHR9uolGzUY85Vhs9fXc6grW56xuVoiFL7TE3ncUiIkU0yk6B
 4Vs8oMp3NPVlGR8Wp8SIPUPqzi/xjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
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

v2 (Thanks Karel):
* lsmem:
  * Use _PATH_SYS_MEMMAP_PARM instead of const char *path.
  * Use N_()/_() in get_memmap_mode()/printf().
  * Improve skip_memconfig_column().
  * Check /sys/firmware/memory/memory0 existance before read_basic_info(). 
    The latter can run after column setup. Doing so reduces
    ul_path_access(lsmem->sysmemconfig, F_OK, 'memory0') calls to just one.
* chmem:
  * Rename chmem_memmap_on_memory_option_enabled() to chmem_memmap_enabled().
  * Improve configure check in warn().
  * Optimization in chmem_set_memmap_on_memory().
  * Remove "\n" in warn().
  * Add _() when printing info.

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
 sys-utils/chmem.c      | 371 +++++++++++++++++++++++++++++++++++++----
 sys-utils/lsmem.1.adoc |  46 ++++-
 sys-utils/lsmem.c      | 136 +++++++++++++--
 6 files changed, 555 insertions(+), 50 deletions(-)

-- 
2.41.0

