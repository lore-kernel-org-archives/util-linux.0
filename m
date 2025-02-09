Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977E1DA3D
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089537; cv=none; b=hM1u8ShciBQycXjs4NPa8fGJObqigy4azyrbji4OiPlhC1ilCcxXYgqkGEW5q0WqhlrF2IEe9mEbAXJdVytlnE7ZOwLEOJOBUn419Vp2FeJBIus5cOnuArR4vvA2pBuG9hlZtMWLUazKWEdiEirN5Dp3dJZ/HjLj7omKRfbJdg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089537; c=relaxed/simple;
	bh=TqltNuq7xoREQTbT4NHi31N4MTpNhuwBErkroKBDlro=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwyLug7lLFqtinHPeYHIvpOy/kS1l+d0jCskuea5KN62NzHmNNFIR/ANBOMXumgUDtz/ulkXVNNT60nFRcvuAW86kBdngDvuKyy6veFrHPGrRQwwQg7cbi9kp/vhDs+b7K6RmWs+YjTLXoTa6HXlyQgbQmA4LFyyBoJymHEWfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=SnrMtsFM; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="SnrMtsFM"
X-KPN-MessageId: af80bbb4-e6bf-11ef-aff5-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id af80bbb4-e6bf-11ef-aff5-005056abad63;
	Sun, 09 Feb 2025 09:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=e8ut4KC42/M5OIWP5Kz1Hfo2MgiZOA5pnIXg0dHWea4=;
	b=SnrMtsFMKS97rTLwp4WqwHjaU312HnwcNXt9kfl3D4eNh2DtEGEBnIKoh9/isH8i0gjSJiBpX+dQ8
	 dR4UqvU2nI5W928AXGJb3rkOEfJ16swJqtwP+BmHy7gNalu2xAuLISHcmRF4zwCv/hlk9wVFM7pu7i
	 IjhhnEyfxWky4j34=
X-KPN-MID: 33|UK5JfeFXb1pvHqfHh7vKS6jS834NgUAZIOZnIvuwe8Arqg8YKYeGF1vs9W+udGE
 FPAv1mADKhZFaclZ4HBWjCWalJItlSTM5DU3zXbXuT2A=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xrxHudgj7jVbgVFZHmYx3CRq7R6E4JjA+kstECOuDFMR0FEmAKx7Pl2sahlM65r
 lBGx2EtW85nl7oIgu67XiEg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 6ea8e22a-e6bf-11ef-99a4-005056ab7447;
	Sun, 09 Feb 2025 09:25:34 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/14] blkzone: correct the wording of an error message, from ioctl to function
Date: Sun,  9 Feb 2025 09:23:26 +0100
Message-ID: <20250209082330.4235-10-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209082330.4235-1-bensberg@telfort.nl>
References: <20250209082330.4235-1-bensberg@telfort.nl>
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
+		err(EXIT_FAILURE, _("%s: blkdev_get_sectors() failed"), ctl->devname);
 
 	if (blkdev_get_sector_size(fd, &ctl->secsize))
 		err(EXIT_FAILURE, _("%s: BLKSSZGET ioctl failed"), ctl->devname);
-- 
2.48.1

