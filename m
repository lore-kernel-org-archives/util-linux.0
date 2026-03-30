Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610D3D9057
	for <util-linux@vger.kernel.org>; Mon, 30 Mar 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880765; cv=none; b=eewugK4+kUGaucK/NBRs30YRD4opUxxTjSPRBXInJsA7XD9B/VrrvYUgqu3SAEVFg/cG0Jrr9giy1zcfpPkXWX9wbQRcggzkbn1gkhELICRUK+IjXaqsgtv1qjoeya24gf+YDtxwA04ylOV5SObi7sKWUpDuEAYB+xwqLNzDSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880765; c=relaxed/simple;
	bh=pfOEHbO08FdcSWuhbItEoXyBITlhj2W2vAEQgL58fC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9IvKGdOdSRAu5nBu0VkIrf9UefM8yLEuMbdNqOJpLTco3fw5VFowKYgnZaOdtFX1tF4yIVcoKf2JdyMx/JTjOtlOs5bJw9026vVDtTv75NLmZ8OMGlf/chvGmA8AR+UEhbQ4b5kzTDD6Z+T+D6Ks703/xLufD8ouGOFNFkAhw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=gg+W6Tu0; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="gg+W6Tu0"
X-KPN-MessageId: 5c40dfcc-2c44-11f1-8a9a-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5c40dfcc-2c44-11f1-8a9a-005056ab378f;
	Mon, 30 Mar 2026 16:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=XkWkpa59POIzRimkWEQL8r9sNwGqjFq5Nblt6/D/C6U=;
	b=gg+W6Tu0aCRBazndp7t1eGL6ykUxRGv7Uyo7z1aE1r1zN+Rs7K+14OjZVquhUwclopNz6j0k7dziX
	 akNgKCtXTXCwkhY58n0kefENI4Mik2e88vXtK2x5pas4ZuzeraA+yq7sUEiocohwHBRmMPjlefTRXU
	 wcDVczlu+htnhcs4=
X-KPN-MID: 33|PWkkxVLvVf6WgtZr8XeywYjdlhv+zEGitUua+bxDCur37EJ0WQ1UBq4iqJgtaq9
 YwQPFpLYMdUjzWA26tXZnfw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nkh17KMASNsWTlID66Of4U+H2jKvGv/HuceRNgk0eygftJPZIKcf5zKTp/c8oGO
 Cu0w7mhD9ABcl8OkyOOpMCw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 5c22c9f0-2c44-11f1-b8e8-005056ab7584;
	Mon, 30 Mar 2026 16:25:54 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Pedro Albuquerque <pmra@protonmail.com>
Subject: [PATCH] blkpr: fix a typo ("sp:ec" => "spec"), and drop an overemphatic comma
Date: Mon, 30 Mar 2026 16:25:51 +0200
Message-ID: <20260330142551.3706-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The typo was introduced in commit a2752fe270, three months ago.

(The comma is not in same sentence in the next string either.)

Reported-by: Pedro Albuquerque <pmra@protonmail.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/blkpr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/blkpr.c b/sys-utils/blkpr.c
index 5e5e107e3..f7e776713 100644
--- a/sys-utils/blkpr.c
+++ b/sys-utils/blkpr.c
@@ -63,7 +63,7 @@ static const struct type_string pr_type[] = {
 		PR_WRITE_EXCLUSIVE_ALL_REGS, "write-exclusive-all-regs", N_(
 "    Only initiators with a registered key can write to the device. Any\n"
 "    initiator can read from the device.  All initiators with a registered\n"
-"    key are considered reservation holders.  Please, reference the SPC sp:ec\n"
+"    key are considered reservation holders.  Please reference the SPC spec\n"
 "    on the meaning of a reservation holder if you want to use this type."
 		)
 	}, {
-- 
2.53.0

