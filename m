Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29002D77ED
	for <util-linux@vger.kernel.org>; Thu, 18 Sep 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185875; cv=none; b=hkc1d8ncq1L7HL4o1NwIhPb/LXDhD3v8rRUsA8DSDpEum8ObIOTf+nCKk9ETTgnA8JkDAVvQtTc9mcx5i92MzipY4JG5UV0a9zfvITLzUCbC+KVNoWMEzKqoxvL6Soh+f5PU3DJFBxV5vvHj8rYieWStRGm71tA57iuNC8YVJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185875; c=relaxed/simple;
	bh=ci6uROaV2DxYFwKtiXS47TBJQzT3cZGgFrjzJ9L0veM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9g/G6FN1bEve8mtra4FCVD+R2yOKne9jDBU+gowyF4nEcKRuM7WB+mLYQEPQjEwFmFpchOhayfTDWxKxAH4xNOYvvHGr0RPqznhhT4PKuypin5u2fiIfnww2geUmjU7SXOU99ZyESUEp0eBPWSNMmdiXLBJEKBvU97AD7HDnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=QBcDCTkm; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="QBcDCTkm"
X-KPN-MessageId: b86edc62-946d-11f0-80ed-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b86edc62-946d-11f0-80ed-005056aba152;
	Thu, 18 Sep 2025 10:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=MyWA8h9GEgcgVa4R1Fcp5aXVIB5R+oQT0wCN5yTzneg=;
	b=QBcDCTkmZiI2GUdabIAaxlTjbYz/4b6a6YLr3yQmMK6ziJiQ5dtKLsRld/90y+bn6lFK7J3guqLkt
	 EWVH7Ut3xDcDizLL8HoFqoQcs2aG5hQvqaXXxlVc7PbsRHFROsl8n+oWQ3BeXCvCrMVyBuW5ZicutQ
	 xvQpAUWgWr3lbdno=
X-KPN-MID: 33|ijPzswKY8N3+3t793VFPaVrFNdxjiycABGyGeIgid+cq/wlRXaPkSja9j/j43FO
 C3Qj5jm//0znCKqlNCktX94A0GtuHkUnariIXGSASD+M=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|EtD5cIxL1JleCvkDT6JP0JjcW53SWreXDn5mi2DqzlsHaZG233GOgMz7+vRqhUY
 2yjGsNCURK5IfE1RIi9LlFQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 8f389339-946d-11f0-a7a5-005056ab1411;
	Thu, 18 Sep 2025 10:57:52 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/6] fallocate: (man,usage) correct the alphabetical sorting of the options
Date: Thu, 18 Sep 2025 10:57:07 +0200
Message-ID: <20250918085707.41785-6-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918085707.41785-1-bensberg@telfort.nl>
References: <20250918085707.41785-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/fallocate.1.adoc | 14 +++++++-------
 sys-utils/fallocate.c      |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sys-utils/fallocate.1.adoc b/sys-utils/fallocate.1.adoc
index 0b7ea39db..4a96d009d 100644
--- a/sys-utils/fallocate.1.adoc
+++ b/sys-utils/fallocate.1.adoc
@@ -64,6 +64,13 @@ Supported for XFS (since Linux 2.6.38), ext4 (since Linux 3.0), Btrfs (since Lin
 *-v*, *--verbose*::
 Enable verbose mode.
 
+*-w*, *--write-zeroes*::
+Zeroes space in the byte range starting at _offset_ and continuing for _length_ bytes. Within the specified range, written blocks are preallocated for the regions that span the holes in the file. After a successful call, subsequent reads from this range will return zeroes and subsequent writes to that range do not require further changes to the file mapping metadata.
++
+Zeroing is done within the filesystem. The filesystem may use a hardware-accelerated zeroing command or may submit regular writes. The behavior depends on the filesystem design and the available hardware.
++
+Option *--keep-size* cannot be specified for the write-zeroes operation because allocating written blocks beyond the inode size is not permitted.
+
 *-x*, *--posix*::
 Enable POSIX operation mode. In that mode allocation operation always completes, but it may take longer time when fast allocation is not supported by the underlying filesystem.
 
@@ -76,13 +83,6 @@ Option *--keep-size* can be specified to prevent file length modification.
 +
 Available since Linux 3.14 for ext4 (only for extent-based files) and XFS.
 
-*-w*, *--write-zeroes*::
-Zeroes space in the byte range starting at _offset_ and continuing for _length_ bytes. Within the specified range, written blocks are preallocated for the regions that span the holes in the file. After a successful call, subsequent reads from this range will return zeroes and subsequent writes to that range do not require further changes to the file mapping metadata.
-+
-Zeroing is done within the filesystem. The filesystem may use a hardware-accelerated zeroing command or may submit regular writes. The behavior depends on the filesystem design and the available hardware.
-+
-Option *--keep-size* cannot be specified for the write-zeroes operation because allocating written blocks beyond the inode size is not permitted.
-
 include::man-common/help-version.adoc[]
 
 == AUTHORS
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index afd615537..f06009483 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -97,12 +97,12 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -n, --keep-size      maintain the apparent size of the file\n"), out);
 	fputs(_(" -o, --offset <num>   offset for range operations, in bytes\n"), out);
 	fputs(_(" -p, --punch-hole     replace a range with a hole (implies -n)\n"), out);
-	fputs(_(" -z, --zero-range     zero and ensure allocation of a range\n"), out);
+	fputs(_(" -v, --verbose        verbose mode\n"), out);
 	fputs(_(" -w, --write-zeroes   write zeroes and ensure allocation of a range\n"), out);
 #ifdef HAVE_POSIX_FALLOCATE
 	fputs(_(" -x, --posix          use posix_fallocate(3) instead of fallocate(2)\n"), out);
 #endif
-	fputs(_(" -v, --verbose        verbose mode\n"), out);
+	fputs(_(" -z, --zero-range     zero and ensure allocation of a range\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(22));
-- 
2.51.0

