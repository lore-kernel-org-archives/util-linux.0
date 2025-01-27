Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EFA13D281
	for <util-linux@vger.kernel.org>; Mon, 27 Jan 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991322; cv=none; b=K7P8qbE6fdnzk2wlWxp7MfdfUwqGDsrnvkOOC1EGF6fZybF24u8IACv3/xdJPlqW2ETAkgs7EJqoUOfq+l0TRODYPclTfqHiuRly04Q2kGScmUPfWYCme8xqHG3Ec/RGAHuzGB6coR1OiR4WPM1UnUGFV/fCM+oEKBAUT4qvqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991322; c=relaxed/simple;
	bh=Y2Bvvi/cy5MI2IpdVTO83x6HRb//lIbDNbWakpVbWD4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UsLnw+JDETsfJuYHSShbIz8TmMuvBr1FfSw/bBKwc0TsMALLTcUoRhcKopsFmnqzxH7yxKE0R5H+9EtpG/BtTBfUzJV7n0qPY0Nsb1saFNsU22BrMqkYqcgdfDOlkEdsudoFC51E7IA33Lwims5NyWA/ybbT3svXo334iWwTEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Ho3cqRox; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Ho3cqRox"
X-KPN-MessageId: 9f4ad82a-dcc2-11ef-8d8a-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9f4ad82a-dcc2-11ef-8d8a-005056aba152;
	Mon, 27 Jan 2025 16:23:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Byyd+1wchZat31uq/2eOiba31gGANGtgdulIX2MnMHs=;
	b=Ho3cqRox9pHC+bG+0ht56E3QtIMdAOao0VtgZPllR98ekZddZ1dRoajaIzGEKFgYtcDS4nPIMon+X
	 /jQTwIFwXenpVPe4BrgauRa9ZCF+sFejvGoJ8J3U/L5p4V7phoQxGCsYiHfP62zeSvKPyQcR17ddBA
	 bQ1qzVEyLs4ud+0U=
X-KPN-MID: 33|0PhRushCKxdWqLKKyCmkw9EXmQMgGmUwQ1noYqY2L8PClwLa5J25susqBStIr9J
 D4zxZeJhuyQKFiUYnzq/Lr2z2oU0mjsFtjWPz5Ld/zfU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|U9cKFFSdXQXcNGZiLFOcUlXRhywN75SebWi5g4BfD+fs8E2Aj66eAk1m1nPNJ/P
 UsBtPgArSZhbF2zFI/l7IgA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 6da6d5e5-dcc2-11ef-a313-005056abf0db;
	Mon, 27 Jan 2025 16:21:49 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] blkid: say "override" instead of "overwrite" in the --help text
Date: Mon, 27 Jan 2025 16:21:44 +0100
Message-ID: <20250127152144.11446-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `blkid` tool does not write anything to the probed device, so
seeing "overwrite" in the usage text was somewhat disconcerting.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/blkid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index d5fe4f1fa..63e61b5fa 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -96,7 +96,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(	" -p, --probe                low-level superblocks probing (bypass cache)\n"), out);
 	fputs(_(	" -i, --info                 gather information about I/O limits\n"), out);
 	fputs(_(        " -H, --hint <value>         set hint for probing function\n"), out);
-	fputs(_(	" -S, --size <size>          overwrite device size\n"), out);
+	fputs(_(	" -S, --size <size>          override device size\n"), out);
 	fputs(_(	" -O, --offset <offset>      probe at the given offset\n"), out);
 	fputs(_(	" -u, --usages <list>        filter by \"usage\" (e.g. -u filesystem,raid)\n"), out);
 	fputs(_(	" -n, --match-types <list>   filter by filesystem type (e.g. -n vfat,ext3)\n"), out);
-- 
2.48.1

