Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01471E8332
	for <util-linux@vger.kernel.org>; Tue,  9 Dec 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765292624; cv=none; b=Bs3Virc91qLWL+1ratpiwhqTUeO0muy9iD0j9sVpyR6SMFqdC/8zjj6MvxMshvyFgwosfRCAuuySDaJdYrpAJ8b/YD+MaQYecZ+GWx4d6Hw285XRkRkiQDLj9cfMBEurQsWy5pd9s8KZxNB+UQKIGZ36KYuItNg+O6xjzwfc8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765292624; c=relaxed/simple;
	bh=AB5xB5nlw0Cil/9Q58Tm+TJyVN2pJTTKcg2acjsgiRM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OIfjH9Tt5PZAQnFj8lNueeODwNu3iSht566BaQkLh94bkDprSGVTafJGyXYx9kPVuBgaX8LlrglfunWnZqcdQYEXOx9uB5XFJAUwd4w+Gi31v4mUroM1ZEq1yjreoTvkWGP7oLcf9K5fjd6s7r79oNEqf1WsgFUvzMQyQGOHLyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=tPLNS4g7; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="tPLNS4g7"
X-KPN-MessageId: 6b8d2cb3-d510-11f0-9c78-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6b8d2cb3-d510-11f0-9c78-005056ab378f;
	Tue, 09 Dec 2025 16:04:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=eEK+3W4vJoh9ezpKhBfI5caT4mu/GH9muFFJYbl2yOQ=;
	b=tPLNS4g7VXf938sEDC0UQ/fH1g4dKMHAuRRSiTRz5KQqTSWBgsFhH8QFYV9Ek0Ahp5OilR8QR86qc
	 qHUby+O8LOvQAeC+xkTvwz4DaCx4ptMDAfr5JN92uEU9oIVncq4XKqPS8EOpk64KsjpxL5WdBCBTrO
	 8bR+5xDq+cAZYW/g=
X-KPN-MID: 33|yWJ8xIudb1/vBe+SCNwtJdT4eZggMtc/aN360k5flnlfBiPlTJ1i+jkt59SEfn2
 xXdiWjLeR9EzFOHVlnr+N9A==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|TUIicM2DK4N/NSoisrAgIPPZWrjKZfNFy6r0BGaaoWDYlEGe6NDL3z9W3zEkk55
 lrn9PeTSNRS2YHUEw7jswsQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 163b21e2-d510-11f0-bda3-005056ab1411;
	Tue, 09 Dec 2025 16:02:31 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] losetup: snip --verbose from bash-completion, and 'v' from options string
Date: Tue,  9 Dec 2025 16:02:20 +0100
Message-ID: <20251209150222.50981-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This should have been part of commit 7e27c81597 from two months ago.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 bash-completion/losetup | 1 -
 sys-utils/losetup.c     | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/bash-completion/losetup b/bash-completion/losetup
index 2d314c111..bf1591fbf 100644
--- a/bash-completion/losetup
+++ b/bash-completion/losetup
@@ -59,7 +59,6 @@ _losetup_module()
 				--read-only
 				--remove
 				--show
-				--verbose
 				--direct-io
 				--loop-ref
 				--sector-size
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 7da0ebbd0..fe30d70da 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -751,7 +751,7 @@ int main(int argc, char **argv)
 	if (loopcxt_init(&lc, 0))
 		err(EXIT_FAILURE, _("failed to initialize loopcxt"));
 
-	while ((c = getopt_long(argc, argv, "ab:cdDfhj:JlLno:O:PrvV",
+	while ((c = getopt_long(argc, argv, "ab:cdDfhj:JlLno:O:PrV",
 				longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
-- 
2.51.2

