Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C5439012
	for <util-linux@vger.kernel.org>; Sat, 28 Feb 2026 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772279579; cv=none; b=YgyoC/oukMg3Oxri1ecg5bRZmZk80/6KVA3UwfjPIp1PxrhL0ZdwgzTbXcZaZ/zsYnWLM6YBesfRQQpxp0xCPhP0/PxMEF2ObnLZN1USKpCcsF2dZguIDCpfxQoU+neSqCLJbQnaDpSkR9xSLyJVj9/LJ6RJoLd9muOBy7qpxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772279579; c=relaxed/simple;
	bh=b9dV3YsYryEj3jU/mqMgotV4AMeTGIEh+D/hk4iCNtw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SsYrhWoXHeF4m9Bk/huJsJl15Bv370ZYEkbFvd4AWdjvbHzeP7x6zDZYDLvvkvIUxgCS2t7b0O7HvL18M0BDkeWiTijS6LWbDFBJzcXRvDjOT9sPiVssxFida9i/1uTps7G+GxDZyUZslvTijrKDI7Ua/V4+Jfh/41ZXGpQ1nxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=FmORUFdi; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="FmORUFdi"
X-KPN-MessageId: 00d5b741-149c-11f1-b182-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 00d5b741-149c-11f1-b182-005056abad63;
	Sat, 28 Feb 2026 12:52:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=oiNNKiJR+bPBG3gF+pcvhO8/amXcFJk1NbGcSu5mg64=;
	b=FmORUFdiAz++CROSPNSrogvfZ7hbn2RJRe9W04KIpSc1nNC0gdtZHBAKG3kw8a7rdp4TCMy6KH5mR
	 n1JgcLMiVX3tRtpuIdokPZ06goO2TztkApd8wn41lqphzzB903EMFUnUcTIbLmoRlscPQIJCp3CONM
	 b/Ir7YZgN/tAzGoM=
X-KPN-MID: 33|aGOi6JFFmpVin5gbmY1mP6gHiFMnBVIqNBzXEtLKrYlpd2mrMCZP3OtWFBftJy2
 /qXPZ+KBQs9l8v/HMVNecdb+lliyfWNEZYAF4rl3oRgo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|5/QN7DJdesTEh23I23qbjY9BYBYzjmJMDQjC18xGnSjX21KTkIBHHMoMLgxaFtE
 cW6z7v1eKzDJncs7Ys5lr0w==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 00ac6e61-149c-11f1-bdab-005056ab1411;
	Sat, 28 Feb 2026 12:52:48 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] findfs: (man) improve the markup, the layout, and the wording
Date: Sat, 28 Feb 2026 12:52:45 +0100
Message-ID: <20260228115245.9553-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark NAME as a placeholder instead of a literal, and rename it to
TAGNAME to make it clearer what "tag" in the description refers to.

Indent the list of possible tags, to make it clearer where the
description continues.

Drop the angle brackets around placeholders -- those are used
in --help output, but in man pages it is just italics.

Also add a missing section header.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/findfs.8.adoc | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/misc-utils/findfs.8.adoc b/misc-utils/findfs.8.adoc
index 8783cdc25..02d08f953 100644
--- a/misc-utils/findfs.8.adoc
+++ b/misc-utils/findfs.8.adoc
@@ -16,36 +16,44 @@ findfs - find a filesystem by label or UUID
 
 == SYNOPSIS
 
-*findfs* *NAME*=_value_
+*findfs* _TAGNAME_**=**_value_
 
 == DESCRIPTION
 
-*findfs* will search the block devices in the system looking for a filesystem or partition with specified tag. The currently supported tags are:
+*findfs* will search the block devices in the system for a filesystem or partition
+with the specified tag. The currently supported tags are:
 
-*LABEL*=_<label>_::
-Specifies filesystem label.
+____
+**LABEL=**_label_::
+Specifies a filesystem label.
 
-*UUID*=_<uuid>_::
-Specifies filesystem UUID.
+**UUID=**_uuid_::
+Specifies a filesystem UUID.
 
-*PARTUUID*=_<uuid>_::
-Specifies partition UUID. This partition identifier is supported for example for GUID Partition Table (GPT) partition tables.
+**PARTUUID=**_uuid_::
+Specifies a partition UUID. Partition identifiers are supported for example for GUID Partition Table (GPT) partition tables.
 
-*PARTLABEL*=_<label>_::
-Specifies partition label (name). The partition labels are supported for example for GUID Partition Table (GPT) or MAC partition tables.
+**PARTLABEL=**_label_::
+Specifies a partition label (name). Partition labels are supported for example for GPT and MAC partition tables.
+____
 
-If the filesystem or partition is found, the device name will be printed on stdout. If the input is not in the format of NAME=value, then the input will be copied to the output without any modification.
+If the filesystem or partition is found, the device name will be printed on stdout.
+If the input is not in the format of _TAGNAME_**=**_value_, then the input will be
+copied to the output without any modification.
 
-The complete overview about filesystems and partitions you can get for example by
+You can get a complete overview about the filesystems and partitions in the system
+with one of the following commands:
 
 ____
 *lsblk --fs*
 
-*partx --show <disk>*
+*partx --show* _disk_
 
 *blkid*
 ____
 
+== OPTIONS
+
 include::man-common/help-version.adoc[]
 
 == EXIT STATUS
@@ -53,7 +61,7 @@ include::man-common/help-version.adoc[]
 *0*::
 success
 *1*::
-label or uuid cannot be found
+label or UUID cannot be found
 *2*::
 usage error, wrong number of arguments or unknown option
 
-- 
2.53.0

