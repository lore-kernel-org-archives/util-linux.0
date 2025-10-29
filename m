Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B9304BA4
	for <util-linux@vger.kernel.org>; Wed, 29 Oct 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735919; cv=none; b=gjhvDDB9SE1zzXv2bOD8PY/nE1e0YzPhLHdcCYUyrgx+tOnEJhAEwipg31yI4ycnVa8AhUtObGFB6aJw2meY8dWHPAF80cuaRAjlLts4GU8AlKPkhmnUNG4olKgGFiqYPubWHv7vAwbbo+jPifAyWk1cFmTGk1ExWDl3YgYE8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735919; c=relaxed/simple;
	bh=D1SfoU9LCzwwxk5aeKn5Wp6hCt+zM8YxMfa1d0W2H1g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kxVHMvxXPG7RBGs/lTU/30yVLHNrynMiB9aFUEKvkKAzlxdC4yNipz4pRXW6kCJRo/1FYfnH+FtVd81WsoStjIzqpSmnYmbiX+akVlANWcTJeAQmdlFhJwetiN30cRbA6pSOk2FKg7Di3Axxx9Z5BxWcRSOlqMeAeWyQGtGy6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Dlx/5Ay0; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Dlx/5Ay0"
X-KPN-MessageId: 1f741372-b4b7-11f0-9c77-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1f741372-b4b7-11f0-9c77-005056ab378f;
	Wed, 29 Oct 2025 12:05:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ljAU9FbdbI/5kGnFR81yyXIIA5UT1cdM9isb7FAa/ng=;
	b=Dlx/5Ay00yRLNR27omZAIOXBe34EpqctOk8LfeETuC8LU3auVc/bC7+5MYNhtu36oJMAReH2RCXrh
	 YQBFFVwT+Uy0HY/5Pr4sNHgzEAlLyej0SsuNuMcFFG8788AAnnmx/a3OcxRcCObUSezrLzm3z5R6Q+
	 kLWIuEnvlvuo/LgI=
X-KPN-MID: 33|oh+5Tfpe/28IFhAj7OvEvT6hIoWDUo55L0i4v9oRtqeN13fPsOc2Fd3s1ol/dFU
 XxheJ2NW1QAxCBNudA66RSA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|L9dQCV21WnTebsBPmSgMiF7iy0p23p3oNAWr1hOE2JDDAApaFHTiKV7pUyDvGnb
 1jFYqakmaERxDKBhFd3Rl8Q==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id fdadcc86-b4b6-11f0-8004-005056ab7447;
	Wed, 29 Oct 2025 12:04:08 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] losetup: sort 'O' correctly for the mutual-exclusive check to work
Date: Wed, 29 Oct 2025 12:03:56 +0100
Message-ID: <20251029110358.18170-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The options need to be in strict ascending order.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/losetup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index c2eec5600..2a3257473 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -739,7 +739,7 @@ int main(int argc, char **argv)
 	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
 		{ 'D','a','c','d','f','j',OPT_REMOVE },
 		{ 'D','c','d','f','l',OPT_REMOVE },
-		{ 'D','c','d','f','O',OPT_REMOVE },
+		{ 'D','O','c','d','f',OPT_REMOVE },
 		{ 'J',OPT_RAW },
 		{ 0 }
 	};
-- 
2.51.2

