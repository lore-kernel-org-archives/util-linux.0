Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352C34DCD2
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629127; cv=none; b=mnDWowL5rCdqZJgjk9whz0YXrNbEkLjid4H4hK2h/e9VX8QPRD8VphmPF0Ueba9agnUIbvUKDX5I8qQuc0vNGRbohV9qfYy54l/vWC6GER8fh2lvFI52/mEZvxAYDSzt7reoL7Y7Ugjd56psZP3xhixt3O/OCuD2OTI5F/o7Dyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629127; c=relaxed/simple;
	bh=e1VpUg42iH/hiGOxvzyKCAujiTboZqGjcuJe0JwbSYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0NpURGLk0YKFGAEvw6jJlaIOFhdAiwqv0KCHgJAzWl1vBqHyyDL0VJZA4HM7A0vYN+jgfS09p1nLIK9oZgUVkIYWkCDVUy6dr9Li29ZtppRfsin48RgdZH7yK7HwO0jrEdI8tsx/MUncdERLagHLcRsdzORrlew7+6hKzUx81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZvdwsVcT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZvdwsVcT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GBRLci010143;
	Thu, 16 Oct 2025 15:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sqDemh
	DfqzdJ1vovX28xeo/UEv3I8imVZ5SgQ9nEmDw=; b=ZvdwsVcT3+z63DvmJa3qle
	lj+Xi9LROHB7t8TXEhBQ/zxCk58R/g2cDIB5X9XNXe963+WiWkMhyo5e0SaJR3+u
	R1HZteyxeO4FKDH/qFOfRctR/SROYG2iBQXWBwojiczRq/M3fSfNAQ01tN2LGFzu
	EM1ojsFmGAYAfevPcbiv+eJN8rktzSPR0EhRo+pli/xnelw+ewdA0uApDIgVvdin
	lFwTs8uyyR4gwXC5v8ns1JEShWj+HrYhnTMOuZDxvNCsrJ2U1EA0Fjpm84/MpuDR
	Y4mo2U1pVm62qmp6T7hgtYMPY60WajECDArM5kQIIY7cMPuj8w4PMKDKyjwaaA5g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewubn8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:38:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GDrWdi028035;
	Thu, 16 Oct 2025 15:38:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49tdg9dny9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:38:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GFcbLv61276560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 15:38:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCDE4200DF;
	Thu, 16 Oct 2025 15:38:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 937F3200DE;
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
Subject: [PATCH v2 4/6] chmem: add chmem documentation for dynamic (de)configuration of memory
Date: Thu, 16 Oct 2025 17:38:04 +0200
Message-ID: <20251016153808.3565873-5-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016153808.3565873-1-sumanthk@linux.ibm.com>
References: <20251016153808.3565873-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NsHEfZ3tqkEGXXd5Qn8X9vumS9bcGR40
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f11182 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=chBBJnHQjsqFfOd3Ob0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NsHEfZ3tqkEGXXd5Qn8X9vumS9bcGR40
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX0xhoYJjAG+ND
 h2P1NJbvg04ZHnAup8qU1U9gLDIGxsyBTELwXWZ4pYXo1jRm2JDTZiiKwqDWMCx/+cB6xXMWepa
 q9k/ZDswI6LNUI74ITp6rZyafBDaHNbCD7FZY22LGTB+ddroOMhgYEjW5jAmBvciKeQVOlqQfbj
 m7/CWxQ8XiaGs78kjswVLkFdWFq0kcZG1qTKrvgvKGEE6E/+T040jxHKvKtTNyarJku/8espe1k
 /TY+bRVl35n5uj421MqOrf6+e4WINDwqd+L5UUtB2qoFPtt5qpCeap7cC3q5LToMFSPXRkgIIGH
 holeqCPZ+eUNKJtfQDar/XjPUVVtR7X5nAJjzTq0VnGW6VolEyTKPHmCTaeh/noePYRhmS8wYii
 LaWNHv5lnF6nlD+X1bg4aROZij8CtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

Describe chmem configure, deconfigure and memmap-on-memory options:

ff18dcb19aab ("s390/sclp: Add support for dynamic (de)configuration of
memory") s390 kernel no longer pre-adds all standby memory at boot.
Instead, users must explicitly configure a block before it can be used
for online/offline actions. At configuration time, users can dynamically
decide whether to use optional memmap-on-memory for each memory block,
where value of 1 allocates metadata (such as struct pages array) from
the hotplug memory itself, enabling hot-add operations even under memory
pressure. A value of 0 stores metadata in regular system memory, which
may require additional free memory, but enables continuous physical
memory across memory blocks.

Add documentation to reflect the following options:
* chmem --configure 128M --memmap-on-memory 1
* chmem --deconfigure 128M
* chmem --enable 128M # implicitly configure memory if supported by
  architecture and online it
* chmem --disable 128M  # offline memory and implicitly deconfigure if
  supported by the architecture.

Just like online and offline actions, memory configuration and
deconfiguration can be controlled through similar options. Also,
memmap-on-memory setting can be changed, only when the memory block is
in deconfigured state. This means, it is usable only via --configure
option.

Reviewed-by: Maria Eisenhaendler <maria1@de.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 sys-utils/chmem.8.adoc | 47 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/sys-utils/chmem.8.adoc b/sys-utils/chmem.8.adoc
index 5067a98b8..537beec63 100644
--- a/sys-utils/chmem.8.adoc
+++ b/sys-utils/chmem.8.adoc
@@ -12,7 +12,7 @@ chmem - configure memory
 
 == SYNOPSIS
 
-*chmem* [*-h*] [*-V*] [*-v*] [*-e*|*-d*] [_SIZE_|_RANGE_|*-b* _BLOCKRANGE_] [*-z* _ZONE_]
+*chmem* [*-h*] [*-V*] [*-v*] [*-c*|*-e*|*-d*|*-g*] [_SIZE_|_RANGE_|*-b* _BLOCKRANGE_] [*-z* _ZONE_] [*-m* _MEMMAP-ON-MEMORY_]
 
 == DESCRIPTION
 
@@ -26,23 +26,48 @@ The *chmem* command sets a particular size or range of memory online or offline.
 
 * Specify _ZONE_ as the name of a memory zone, as shown in the output of the *lsmem -o +ZONES* command. The output shows one or more valid memory zones for each memory range. If multiple zones are shown, then the memory range currently belongs to the first zone. By default, *chmem* will set memory online to the zone Movable, if this is among the valid zones. This default can be changed by specifying the *--zone* option with another valid zone. For memory ballooning, it is recommended to select the zone Movable for memory online and offline, if possible. Memory in this zone is much more likely to be able to be offlined again, but it cannot be used for arbitrary kernel allocations, only for migratable pages (e.g., anonymous and page cache pages). Use the *--help* option to see all available zones.
 
+* Specify _MEMMAP-ON-MEMORY_ as 1 or 0. A value of 1 allocates hotplug metadata (such as the struct pages array) from the hotplug memory itself, enabling hot-add operations even under memory pressure and without requiring additional system memory to do so. A value of 0 stores hotplugged memory metadata in regular system memory, which helps avoid issues related to fragmentation of continuous physical memory across memory blocks. The value can only be set when the memory block is in a deconfigured state, and *--memmap-on-memory* is valid only with *--configure*. If not specified, and if supported, *chmem* uses the default value shown in *lsmem* output.
+
+The *--enable* option configures the memory, if this is supported by the architecture. If configuring memory is not supported by the architecture, *--enable* still brings the memory online.
+
+The *--disable* option brings the memory offline and performs an optional deconfigure step if this is supported by the architecture.
+
+The *--configure* option requests memory from the hypervisor without bringing it online, when supported by the architecture, allowing explicit control and use of *--memmap-on-memory*.
+
+The *--deconfigure* option returns memory resources to the hypervisor if supported by the architecture.
+
 _SIZE_ and _RANGE_ must be aligned to the Linux memory block size, as shown in the output of the *lsmem*(1) command.
 
 Setting memory online can fail for various reasons. On virtualized systems it can fail if the hypervisor does not have enough memory left, for example because memory was overcommitted. Setting memory offline can fail if Linux cannot free the memory. If only part of the requested memory can be set online or offline, a message tells you how much memory was set online or offline instead of the requested amount.
 
-When setting memory online *chmem* starts with the lowest memory block numbers. When setting memory offline *chmem* starts with the highest memory block numbers.
+When setting memory online or when configuring memory, *chmem* starts with the lowest memory block numbers. When setting memory offline or deconfiguring memory, *chmem* starts with the highest memory block numbers.
+
+== ARCHITECTURE
+
+* s390 architecture:
+
+_MEMMAP-ON-MEMORY_: For memory blocks configured online at boot, the default value is 0 because they are added without memmap-on-memory support. Memory added dynamically at runtime uses the default value displayed in *lsmem* output.
 
 == OPTIONS
 
 *-b*, *--blocks*::
 Use a _BLOCKRANGE_ parameter instead of _RANGE_ or _SIZE_ for the *--enable* and *--disable* options.
 
+*-c*, *--configure*::
+Set the specified _RANGE_, _SIZE_, or _BLOCKRANGE_ of memory to be configured.
+
 *-d*, *--disable*::
 Set the specified _RANGE_, _SIZE_, or _BLOCKRANGE_ of memory offline.
 
 *-e*, *--enable*::
 Set the specified _RANGE_, _SIZE_, or _BLOCKRANGE_ of memory online.
 
+*-g*, *--deconfigure*::
+Set the specified _RANGE_, _SIZE_, or _BLOCKRANGE_ of memory to be deconfigured.
+
+*-m*, *--memmap-on-memory*::
+Select memmap-on-memory for the specified _RANGE_, _SIZE_, or _BLOCKRANGE_ of memory. This option is valid only with *--configure*.
+
 *-z*, *--zone*::
 Select the memory _ZONE_ where to set the specified _RANGE_, _SIZE_, or _BLOCKRANGE_ of memory online or offline. By default, memory will be set online to the zone Movable, if possible.
 
@@ -70,13 +95,25 @@ partial success
 This command requests 1024 MiB of memory to be set online.
 
 *chmem -e 2g*::
-This command requests 2 GiB of memory to be set online.
+This command requests 2 GB of memory to be brought online and, if supported by the architecture, configures the memory beforehand.
 
 *chmem --disable 0x00000000e4000000-0x00000000f3ffffff*::
-This command requests the memory range starting with 0x00000000e4000000 and ending with 0x00000000f3ffffff to be set offline.
+This command takes the memory range from 0x00000000e4000000 to 0x00000000f3ffffff offline and deconfigures it if supported by the architecture.
 
 *chmem -b -d 10*::
-This command requests the memory block number 10 to be set offline.
+This command takes memory block number 10 offline.
+
+*chmem -b -c 10 -m 1*::
+This command configures memory block 10 with  _MEMMAP-ON-MEMORY_ set. The block must be in a deconfigured state.
+
+*chmem -b -c 10*::
+This command configures memory block 10 with the default _MEMMAP-ON-MEMORY_ setting. The default value is displayed in *lsmem --output-all*. The block must be in a deconfigured state.
+
+*chmem -b -g 10*::
+This command deconfigures memory block 10. The block must be offline.
+
+*chmem -d 5g*::
+This command takes 5 GB of memory offline and deconfigures it if supported by the architecture. Blocks that are already offline but still configured are skipped and must be explicitly deconfigured with *--deconfigure*.
 
 == SEE ALSO
 
-- 
2.41.0

