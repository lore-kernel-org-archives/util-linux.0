Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6B234EF1C
	for <util-linux@vger.kernel.org>; Sat,  7 Mar 2026 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772883807; cv=none; b=trX+WaAoPbBAG+LwQHp3+ztns7IepfzV474FWQ+s6f3EVFfJ3lA/1/dMc28e2CwWQwKWaHvmyq8Ockot9HM0DVUPOoBb5rqAQfQf4lAo4U5abu8DXKbLH+qVEp5SRkyhi9kff6rlfBH+Pw9se4DtxBDFJuuYoDSnRiSHsF+Z+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772883807; c=relaxed/simple;
	bh=1fyiZIyzOMDQMxKKjfjCpZpqZ+pFP9HDD61RuXeCb8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4pAwF7hpI/DjDUOg/B1ZXl3MK8+wyY1cqbjAXp5EimeTOV6iVNXdRhi966DIrpJWMsujhXD12nzcI0K8AuOuxnyhJyXZOsg3ynsHNc99xlmIdkTiVIv/sfGJQ/SOuwMFBSNzll6tFtu1MMQ2bx+SQCWSiTNy+/HHYZxVK/EN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=xPa3q2Qp; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="xPa3q2Qp"
X-KPN-MessageId: d9190fda-1a1a-11f1-969b-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d9190fda-1a1a-11f1-969b-005056abbe64;
	Sat, 07 Mar 2026 12:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=MhnGYvaPO9fqaFWIObsSEUlZd2HbNXI31QY8LyQ0Uc0=;
	b=xPa3q2Qp7HEC4+G9+S6MTGtYrRmygTBfjpRcd3SFi3fNYgtEIzPkiCCDpqQwjkM/DQ5chjkIPixEd
	 lTERnZiYH2DGhnzjy73F8pA1G8VeabIi4zxPwAfyT29kwHMb2pCamGxGcikq7AcTeoRjJkdNwAh2Cl
	 iygxXvjJUYYcIPeQ=
X-KPN-MID: 33|1+l82MosLQVtzK6rKrjzPI+HCAewCpBmxWll20cckmzqHCf2aCckxx55Xlx4Tah
 mmjl4PZ8pq3ZHnFgcczlu/Qm2H2blBt0ij+2+jOPGHpU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|uO6diTRZHkzz7pnsIUqGwcaJJ94R701Gt5QE+YoHpJTumUph431RhtztfXZYgpU
 pJVh71ATRLhD98OETzOOTjA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id d8ffd16c-1a1a-11f1-a6ca-005056abf0db;
	Sat, 07 Mar 2026 12:43:23 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 2/2] lsmem: (man) correct the markup of column names, and improve some grammar
Date: Sat,  7 Mar 2026 12:43:08 +0100
Message-ID: <20260307114308.7517-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307114308.7517-1-bensberg@telfort.nl>
References: <20260307114308.7517-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The column names should be marked in bold and not in italics, as they
are literal values, not placeholders.

Also, indent the list of column names, to make it clearer where the
list ends.  And add the missing markup for "RANGE" and the missing
name "REMOVABLE".

Furthermore, drop the small table, as it held nearly no information
and was confusing: the explicit numbers in the BLOCK column gave the
impression that block 0 can only be online, block 1 only offline but
configured, and block 2 only offline and deconfigured.  The content
of the MEMMAP-ON-MEMORY column being always "yes/no" was useless.
Leaving out those columns left only STATE and CONFIGURED, where the
values implied that memory can only be online when it is configured.
This information can be conveyed in a single sentence.

(The table was added in commit 6f1e4ff054 from five months ago.)

CC: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/lsmem.1.adoc | 65 +++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/sys-utils/lsmem.1.adoc b/sys-utils/lsmem.1.adoc
index 3fcdba625..bbc1bb8e0 100644
--- a/sys-utils/lsmem.1.adoc
+++ b/sys-utils/lsmem.1.adoc
@@ -16,57 +16,50 @@ lsmem - list the ranges of available memory with their online status
 
 == DESCRIPTION
 
-The *lsmem* command lists the ranges of available memory with their online status. The listed memory blocks correspond to the memory block representation in sysfs. The command also shows the memory block size and the amount of memory in online and offline state.
+The *lsmem* command lists the ranges of available memory with their online status. The listed memory blocks correspond to the memory block representation in sysfs. The command also shows the size of a single memory block and the total amounts of memory in online and offline state.
 
-The default output is compatible with original implementation from s390-tools, but it's strongly recommended to avoid using default outputs in your scripts. Always explicitly define expected columns by using the *--output* option together with a columns list in environments where a stable output is required.
+The default output is compatible with the original implementation from s390-tools, but it's strongly recommended to avoid using default outputs in your scripts. Always explicitly define expected columns by using the *--output* option together with a columns list in environments where a stable output is required.
 
-The *lsmem* command lists a new memory range always when the current memory block distinguish from the previous block by some output column. This default behavior is possible to override by the *--split* option (e.g., *lsmem --split=ZONES*). The special word "none" may be used to ignore all differences between memory blocks and to create as large as possible continuous ranges. The opposite semantic is *--all* to list individual memory blocks.
+The *lsmem* command always lists a new memory range when the current memory block differs from the previous block by some output column. This default behavior can be overridden with the *--split* option (for example: *lsmem --split=ZONES*). The special word *none* may be used with *--split* to ignore all differences between memory blocks and to create contiguous ranges that are as large as possible. The opposite semantics has *--all*, which lists all individual memory blocks.
 
-Note that some output columns may provide inaccurate information if a split policy forces *lsmem* to ignore differences in some attributes. For example if you merge removable and non-removable memory blocks to the one range than all the range will be marked as non-removable on *lsmem* output.
+Note that some output columns may provide inaccurate information if a splitting policy forces *lsmem* to ignore differences in some attributes. For example, if you merge removable and non-removable memory blocks into a single range, then the whole range will be marked as non-removable in *lsmem* output.
 
-The supported columns are RANGE, SIZE, STATE, REMOVABLE, BLOCK, NODE, ZONES, CONFIGURED, MEMMAP-ON-MEMORY.
-RANGE
-The start and end physical address of the memory range.
+The supported columns are *RANGE*, *SIZE*, *STATE*, *REMOVABLE*, *BLOCK*, *NODE*, *ZONES*, *CONFIGURED*, and *MEMMAP-ON-MEMORY*.
+____
+*RANGE*::
+The start and end physical addresses of the memory range.
 
-_SIZE_::
+*SIZE*::
 The size of the memory range, representing the total amount of memory in that range.
 
-_STATE_::
-The current online status of the memory range. Common states include online, offline or transitional states.
+*STATE*::
+The current online status of the memory range. Common states include online, offline, and transitional states.
 
-_BLOCK_::
-The specific memory block number.
+*REMOVABLE*::
+Whether the memory is removable.
 
-_NODE_::
+*BLOCK*::
+The specific memory block number or range.
+
+*NODE*::
 The NUMA (Non-Uniform Memory Access) node to which the memory block belongs.
 
-_ZONES_::
+*ZONES*::
 The memory zones to which the blocks belongs, such as DMA, Normal, Movable.
 
-_CONFIGURED_::
-The configuration state of a memory block. Refer to *chmem* for details on configuring or deconfiguring memory blocks.
+*CONFIGURED*::
+The configuration state of a memory block. Refer to *chmem*(8) for details on configuring or deconfiguring memory blocks.
 
-_MEMMAP-ON-MEMORY_::
+*MEMMAP-ON-MEMORY*::
 The memmap-on-memory state of the memory block at configuration time. This setting indicates where memory hotplug stores its internal metadata (the struct pages array or memmap). If MEMMAP-ON-MEMORY is set to 1, the metadata is allocated directly from the newly added hotplugged memory, enabling hot-add operations even when the system is under high memory pressure. If set to 0, the memmap metadata is allocated from existing system memory.
+____
 
-Possible BLOCK, CONFIGURED, STATE, MEMMAP-ON-MEMORY states::
+Not all columns are supported on all systems. If an unsupported column is specified, *lsmem* prints the column but does not provide any data for it. Additionally, *lsmem* may skip columns like *CONFIGURED* or *MEMMAP-ON-MEMORY* if these states are not relevant to the system's architecture.
 
-[cols="10,10,10,15,60", options="header"]
-|===
-| BLOCK | STATE   | CONFIGURED | MEMMAP-ON-MEMORY | Description
+On systems that can configure/deconfigure memory, memory needs to be configured
+before it can come online.
 
-| 0     | online  | yes        | yes/no           | The memory is configured with memmap-on-memory set to (1 or 0) and memory is currently online.
-
-| 1     | offline | yes        | yes/no           | The memory is configured, but memory is offline.
-
-| 2     | offline | no         | yes/no           | The memory is offline and deconfigured.
-|===
-
-Not all columns are supported on all systems. If an unsupported column is specified, *lsmem* prints the column but does not provide any data for it. Additionally, *lsmem* may skip columns like _CONFIGURED_ or _MEMMAP-ON-MEMORY_ if these states are not relevant to the system's architecture.
-
-Use the *--help* option to see the columns description.
-
-Memmap on memory parameter output displays the globally enabled memmap-on-memory setting for memory_hotplug. This is typically set on the kernel command line via memory_hotplug.memmap_on_memory.
+The "Memmap on memory parameter" summary line shows the global memmap-on-memory setting for memory_hotplug.  This is typically set on the kernel command line via memory_hotplug.memmap_on_memory.
 
 == OPTIONS
 
@@ -95,19 +88,19 @@ Produce output in the form of key="value" pairs. All potentially unsafe value ch
 Produce output in raw format. All potentially unsafe characters are hex-escaped (\x<code>).
 
 *-S*, *--split* _list_::
-Specify which columns are used to split memory blocks to ranges. The supported columns are STATE, REMOVABLE, NODE, ZONES, CONFIGURED, MEMMAP-ON-MEMORY or "none". The other columns are silently ignored. For more details see *DESCRIPTION* above.
+Specify which columns are used to split memory blocks into ranges. The supported columns are *STATE*, *REMOVABLE*, *NODE*, *ZONES*, *CONFIGURED*, *MEMMAP-ON-MEMORY*, and *none*. Other column names are silently ignored. For more details see *DESCRIPTION* above.
 
 *-s*, *--sysroot* _directory_::
 Gather memory data for a Linux instance other than the instance from which the *lsmem* command is issued. The specified _directory_ is the system root of the Linux instance to be inspected.
 
 *--summary*[**=**_when_]::
-This option controls summary lines output. The optional argument _when_ can be *never*, *always* or *only*. If the _when_ argument is omitted, it defaults to *"only"*. The summary output is suppressed for *--raw*, *--pairs* and *--json*.
+This option controls summary lines output. The optional argument _when_ can be *never*, *always* or *only*. If the _when_ argument is omitted, it defaults to *only*. The summary output is suppressed for *--raw*, *--pairs*, and *--json*.
 
 include::man-common/help-version.adoc[]
 
 == ENVIRONMENT
 
-LSMEM_COLUMNS=::
+*LSMEM_COLUMNS*::
 Specifies a comma-separated list of output columns to print. All columns listed in *--help* can be used.
 
 == AUTHORS
-- 
2.53.0

