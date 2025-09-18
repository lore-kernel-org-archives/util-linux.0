Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017032E7635
	for <util-linux@vger.kernel.org>; Thu, 18 Sep 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185868; cv=none; b=YR2y6nGBsus83ClJmzSXSIIZdOsxKEgGAA0rtefsxP2k08ImH92O7H6+AZZKkytfq0YJjmUwhY+hdGszaZ1TnYtnDadQbKMVUro5Y6Sa5FOkILjO8uR++sCli5VESGOIWqcsraop+Oy8TJ4c7JbozCHtXBrzs7kLaqHdZR+FJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185868; c=relaxed/simple;
	bh=LMLiaZ3QaJ0FJFGD5GC6iKZjex+mSMPsyjIA6nzEgGY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZS3VzEOpI8YweoxjK36fby6/QemZkpY8vkFBVaxIi1KjfRVahNtFif5TmgnGyVIRXtATJ3HYImU5axQ5cykbBLYn5y26r424tGmE1zH2xA0eoaAwIkM4fZ4Z7/duVtudwEDxui5+jAcnhJX9L87SZ8127nnkHIx0Zy4gn2DvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=eq4UDyv6; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="eq4UDyv6"
X-KPN-MessageId: eabde008-946d-11f0-aad5-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id eabde008-946d-11f0-aad5-005056ab378f;
	Thu, 18 Sep 2025 11:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=0avyu+ZQyzGJ4Baxqb3WsVYImd41le7h96mmOBP929Q=;
	b=eq4UDyv6RDPp6ZFrqyaKOPkPGnCNnPy1Dw1zp+/o9shQlHtpQ9Grk0w7GneRVsY72ltNE5iOLiToF
	 OGl+f0hoEYKHsJnAf+eV1ggtZDAZQtoCQWZ770fngtkcZh601ds83W6F3jGoMKgISIleLuIaIg83Xz
	 WMbNyaIcXQnhlw10=
X-KPN-MID: 33|1fQ7FsA4Ta5pG3meUL5qWxWsD4QM1fFM86hmJqk78ONI/asa1HwI1SfLsb5wxqh
 ymxYkMEuuplBcaKXcjWnEhQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|cyaczzznPBB7yIkNnts5yDPvaBg4fzBkiZslNLWvXvUFHt2m2bWImwoRW51jkzb
 q2dBSu/VnHD4hhaxCaSVN+A==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 8a2084ab-946d-11f0-a7a5-005056ab1411;
	Thu, 18 Sep 2025 10:57:43 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/6] fallocate: (man) slightly improve the grammar of two sentences
Date: Thu, 18 Sep 2025 10:57:06 +0200
Message-ID: <20250918085707.41785-5-bensberg@telfort.nl>
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
 sys-utils/fallocate.1.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/fallocate.1.adoc b/sys-utils/fallocate.1.adoc
index 69602f01c..0b7ea39db 100644
--- a/sys-utils/fallocate.1.adoc
+++ b/sys-utils/fallocate.1.adoc
@@ -70,7 +70,7 @@ Enable POSIX operation mode. In that mode allocation operation always completes,
 *-z*, *--zero-range*::
 Zeroes space in the byte range starting at _offset_ and continuing for _length_ bytes. Within the specified range, blocks are preallocated for the regions that span the holes in the file. After a successful call, subsequent reads from this range will return zeroes.
 +
-Zeroing is done within the filesystem preferably by converting the range into unwritten extents. This approach means that the specified range will not be physically zeroed out on the device (except for partial blocks at the either end of the range), and I/O is (otherwise) required only to update metadata.
+Zeroing is done within the filesystem preferably by converting the range into unwritten extents. This approach means that the specified range will not be physically zeroed out on the device (except for partial blocks at either end of the range), and I/O is (otherwise) required only to update metadata.
 +
 Option *--keep-size* can be specified to prevent file length modification.
 +
@@ -81,7 +81,7 @@ Zeroes space in the byte range starting at _offset_ and continuing for _length_
 +
 Zeroing is done within the filesystem. The filesystem may use a hardware-accelerated zeroing command or may submit regular writes. The behavior depends on the filesystem design and the available hardware.
 +
-Options *--keep-size* cannot be specified for the write-zeroes operation because allocating written blocks beyond the inode size is not permitted.
+Option *--keep-size* cannot be specified for the write-zeroes operation because allocating written blocks beyond the inode size is not permitted.
 
 include::man-common/help-version.adoc[]
 
-- 
2.51.0

