Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5F1DE896
	for <util-linux@vger.kernel.org>; Mon, 10 Feb 2025 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739190957; cv=none; b=Q+Br6pAYUEWIpPhCCJtqCg5xrcE7x4HgzHGGlIOzg/mxij9eEL13Ck7QkJ8THLcRLZWjXdqoc+zlmMs6fZB87ufL9aEga2jR3gFpiqqiI/5iVpBbVqnharNx+0k08bDSn3wrhBtI4jd7Frfbjk1/SbeFnOWu/xDRvqxttt4jFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739190957; c=relaxed/simple;
	bh=/wSU7MCfgMRQsExv83GsU/j/TH8WTW0Nj7gOc4/rq+M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gFEXaliHdYrzYMcogZhokGVW3Fmn7clNzy66AMPMe29nrEdE06ZX6rhyq/igA5sDDtzPnwtTu7CXDalMi94/ToxhjrO+HOcggHo7U2gLJx5icN2QLK0kvBleFjmghB1rUCslvIU72+ag3zyJq/yktP1/PLrMT+CUfQZUOD4lqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=mIOz9MnJ; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="mIOz9MnJ"
X-KPN-MessageId: bcf55646-e7ab-11ef-8d8a-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bcf55646-e7ab-11ef-8d8a-005056aba152;
	Mon, 10 Feb 2025 13:37:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=2p0+Qm7s2ShO5ZBujk46bfmNKmafvRzgMNEn+ZiWj2s=;
	b=mIOz9MnJjnV4dDRlbhcWQRa6bI/hCIYoG39vM0VR8SPUE8b5yRJKv5sWrQk9muqtqj0CvAko3mkmn
	 +8ufASMr+fswb9tnIxjXDBAVnDHMEA/DZrUb3bftpoJ67j8qWu/Qibj2131/hc8yf86Xti6mK0HCoq
	 j5y6gLhkLynlRZNY=
X-KPN-MID: 33|Pm6vReyirYo6IcL6FwSlRZZ2bEQSSdmtOqlc+85i0vg81ur41XDKs4jyhdOWdD8
 2gp50/Vl4Tzy8ZzP9zlK9WaVt/ZX0gW+YXUOCaZMTIe0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|5oQRoENSPMd0DHT29FzZNNbqe7XEtz3c3i9o8nn0HsiZutTShgZMzmLxXBdtj1U
 z9lo6ItYibizAdZ84MTwPVA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 8c9c8f73-e7ab-11ef-a31e-005056abf0db;
	Mon, 10 Feb 2025 13:35:45 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/14 V2] blkzone: improve the wording of an error message
Date: Mon, 10 Feb 2025 13:35:29 +0100
Message-ID: <20250210123529.7034-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/blkzone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
index 843f3c7b0..9e648484b 100644
--- a/sys-utils/blkzone.c
+++ b/sys-utils/blkzone.c
@@ -149,7 +149,7 @@ static int init_device(struct blkzone_control *ctl, int mode)
 		errx(EXIT_FAILURE, _("%s: not a block device"), ctl->devname);
 
 	if (blkdev_get_sectors(fd, (unsigned long long *) &ctl->total_sectors))
-		err(EXIT_FAILURE, _("%s: blkdev_get_sectors ioctl failed"), ctl->devname);
+		err(EXIT_FAILURE, _("%s: failed to get number of sectors"), ctl->devname);
 
 	if (blkdev_get_sector_size(fd, &ctl->secsize))
 		err(EXIT_FAILURE, _("%s: BLKSSZGET ioctl failed"), ctl->devname);
-- 
2.48.1

