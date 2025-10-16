Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3803328621
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609878; cv=none; b=MVjVucHogSjecqKC7aBzIdBgTYObZ+WnNxaxBaHXBGGu/p70ac2c+wQUmxbVzGXWgqBWdHorJaEVM595Puvl6/d+iH3g8QhgOpr3HpFje+k6eqLaOoSdJUZQR2t1kZDZAQTEPgt2fWwiqPIfZy230Ek3m6XvUf/3ZoKyDLEWdes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609878; c=relaxed/simple;
	bh=iZz2ct81BII2trFVJwLbDEv7J5HBt+ac/NXvxMbvsfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4NhDNl1MKCfRx/nREHOuhaMnQ/I7fD/A/pUM2ROTQGckeE7y+oJsky+4SJLb2y1IewgTK2RJYeUtzLDeqnQSFAlYVCq+EO1fiTfHREu9hMsEAWZuSjZXrOMR8kE2uFzHs2o92eUXpRi9MegY2vrCeq7d+XxplliF2zAaRGDb+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a5du9gJh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a5du9gJh"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G9ZQCl010197;
	Thu, 16 Oct 2025 10:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RCJsVVUpmJI03xYGp
	yNOTuyu9f81Y1oChP7q8m7vPUQ=; b=a5du9gJhJkt8Rk7N3KLdxkTfXQ9CrRBrP
	69JF9o4ZTlMZGIEeymzqTWmPWHuXIWrsrSdSlZM7wVcraoA58fJZlQ+PBL84z5dj
	d1eGn+a8yxUfo/h2Lc8ZXXkLYyTqJRnVfaOz2Xp5T7nChwrWB1QreK8M8M7YKhm3
	A1igy3bffuSfZn8GzumNqjcT7pliMYMJcEYmskXYpF8Hf43BN20AZtcw/uCzC2Xr
	tdll2qg2hnl9bWv9o3Zxychwq3jPAQlp+pO4qYIVGCKD7BRlpgFlT7URzt+t48x0
	f8Jb0Qs87A6sPpCkZ7QRiO2yFthKM9PTchELrRuf+p5EaFUHpDisw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewu9yju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G6F43L003626;
	Thu, 16 Oct 2025 10:17:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy5891-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:17:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GAHm8931326478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 10:17:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADDB82007D;
	Thu, 16 Oct 2025 10:17:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DD7420080;
	Thu, 16 Oct 2025 10:17:48 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 10:17:48 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 5/6] lsmem: add doc for dynamic (de)configuration and memmap-on-memory support
Date: Thu, 16 Oct 2025 12:16:52 +0200
Message-ID: <20251016101701.552597-6-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016101701.552597-1-sumanthk@linux.ibm.com>
References: <20251016101701.552597-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1wWDLKZXlcTCDk6poRYNKfl-WE4SdBZn
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f0c652 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Q-18vJqwCyPAAwtqNjQA:9
X-Proofpoint-ORIG-GUID: 1wWDLKZXlcTCDk6poRYNKfl-WE4SdBZn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX76TKYXScfxIN
 M8i5kYs2/FIr+fSOUwAbiVbQywFWkpcljPnVFKVEPggydGTlS01TUzq+txni6HiFQFwdaLmIJpM
 M8sDIgA+HJWBXlnEGwFoyV927dINwF2H2BK50TFV+2xsmKd++pYTXodu2cuNZT3ecjqqsKfv+hq
 On77nw3/lHKxg/r6QwaFDXgTAfCSFU0hhiIZnHYBeSqevqsMrDHjF8gDRlTaCzTVVE7fSPUNJK7
 d3rtNRlh6MG2xgLgJ+LdX7sGx+/XNRbJLzqCbSU4tUL7tMJZ1lFsZfXoShJp7Lbfq3qZIGILPDJ
 5nuEisH7HXt5mjn3qrjkeTqGn0pL9Z0ysirz0I/4U0stt2iOjuy9EPz26qado6QDYhokWt/aQIo
 4uoz3A2EVa1TeyxUWTNGkWskK+690Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

lsmem --output-all now displays two new columns:

CONFIGURED : yes/no indicating if a memory block has been explicitly
configured.

MEMMAP-ON-MEMORY : yes/no indicating whether the block uses
memmap-on-memory.

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP-ON-MEMORY
RANGE                   SIZE   STATE   BLOCK CONFIGURED MEMMAP-ON-MEMORY
0x00000000-0x7fffffff   2G     online  0-15  yes        no
0x80000000-0xffffffff   2G     offline 16-31 no         yes

Memory block size:                128M
Total online memory:                2G
Total offline memory:               2G
Memmap on memory parameter:        yes

Add documentation for new fields.

Reviewed-by: Maria Eisenhaendler <maria1@de.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 sys-utils/lsmem.1.adoc | 44 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lsmem.1.adoc b/sys-utils/lsmem.1.adoc
index 9c9397631..e7226725a 100644
--- a/sys-utils/lsmem.1.adoc
+++ b/sys-utils/lsmem.1.adoc
@@ -24,7 +24,45 @@ The *lsmem* command lists a new memory range always when the current memory bloc
 
 Note that some output columns may provide inaccurate information if a split policy forces *lsmem* to ignore differences in some attributes. For example if you merge removable and non-removable memory blocks to the one range than all the range will be marked as non-removable on *lsmem* output.
 
-Not all columns are supported on all systems. If an unsupported column is specified, *lsmem* prints the column but does not provide any data for it.
+The supported columns are RANGE, SIZE, STATE, REMOVABLE, BLOCK, NODE, ZONES, CONFIGURED, MEMMAP-ON-MEMORY.
+RANGE
+The start and end physical address of the memory range.
+
+SIZE
+The size of the memory range, representing the total amount of memory in that range.
+
+STATE
+The current online status of the memory range. Common states include online, offline or transitional states.
+
+BLOCK
+The specific memory block number.
+
+NODE
+The NUMA (Non-Uniform Memory Access) node to which the memory block belongs.
+
+ZONES
+The memory zones to which the blocks belongs, such as DMA, Normal, Movable.
+
+CONFIGURED
+The configuration state of a memory block. Refer to *chmem* for details on configuring or deconfiguring memory blocks.
+
+MEMMAP-ON-MEMORY
+The memmap-on-memory state of the memory block at configuration time. This setting indicates where memory hotplug stores its internal metadata (the struct pages array or memmap). If MEMMAP-ON-MEMORY is set to 1, the metadata is allocated directly from the newly added hotplugged memory, enabling hot-add operations even when the system is under high memory pressure. If set to 0, the memmap metadata is allocated from existing system memory.
+
+Possible BLOCK, CONFIGURED, STATE, MEMMAP-ON-MEMORY states::
+
+[cols="10,10,10,15,60", options="header"]
+|===
+| BLOCK | STATE   | CONFIGURED | MEMMAP-ON-MEMORY | Description
+
+| 0     | online  | yes        | yes/no           | The memory is configured with memmap-on-memory set to (1 or 0) and memory is currently online.
+
+| 1     | offline | yes        | yes/no           | The memory is configured, but memory is offline.
+
+| 2     | offline | no         | yes/no           | The memory is offline and deconfigured.
+|===
+
+Not all columns are supported on all systems. If an unsupported column is specified, *lsmem* prints the column but does not provide any data for it. Additionally, *lsmem* may skip columns like CONFIGURED or MEMMAP-ON-MEMORY if these states are not relevant to the system's architecture.
 
 Use the *--help* option to see the columns description.
 
@@ -45,7 +83,7 @@ Use JSON output format.
 Do not print a header line.
 
 *-o*, *--output* _list_::
-Specify which output columns to print. Use *--help* to get a list of all supported columns. The default list of columns may be extended if _list_ is specified in the format **+**__list__ (e.g., *lsmem -o +NODE*).
+Specify which output columns to print. Use *--help* to obtain a list of all supported columns. To extend the default list of columns specify _list_ in the format **+**__list__. For example, *lsmem -o +NODE*.
 
 *--output-all*::
 Output all available columns.
@@ -57,7 +95,7 @@ Produce output in the form of key="value" pairs. All potentially unsafe value ch
 Produce output in raw format. All potentially unsafe characters are hex-escaped (\x<code>).
 
 *-S*, *--split* _list_::
-Specify which columns (attributes) use to split memory blocks to ranges. The supported columns are STATE, REMOVABLE, NODE and ZONES, or "none". The other columns are silently ignored. For more details see *DESCRIPTION* above.
+Specify which columns are used to split memory blocks to ranges. The supported columns are STATE, REMOVABLE, NODE, ZONES, CONFIGURED, MEMMAP-ON-MEMORY or "none". The other columns are silently ignored. For more details see *DESCRIPTION* above.
 
 *-s*, *--sysroot* _directory_::
 Gather memory data for a Linux instance other than the instance from which the *lsmem* command is issued. The specified _directory_ is the system root of the Linux instance to be inspected.
-- 
2.48.1

