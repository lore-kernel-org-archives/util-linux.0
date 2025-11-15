Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F61865FA
	for <util-linux@vger.kernel.org>; Sat, 15 Nov 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763202928; cv=none; b=qzYLagbP6pgCQwfJUY8RuWsOaLwWl57dNpLGsGylcTe4mhKd5nfR40mutVravJenS0tmOPH3pLLHngQEqpie/bq4EGCvfPVwIOfvk09rQBJ4MYi/rrkiwIdhb6mIPn8uN/XAuFPMo+aP91jhKO2Rt5jLVAxKjIncnCVK2iMVhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763202928; c=relaxed/simple;
	bh=U5Qu0OQNTAJOk7Y4JrHhI2mItuGZV4C8/jJai9tTalY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWWoPHdSo2bjBBHEU4p5QkTCCafq7Itw7odkPvpibEfrb35BOs7N2H0YMSMTWOqhNOt6dOBRaiKDLmdePii2MnS2ev0Ih5aHAJFGhX+fnU6p8hGSSbF5shLiJFE/KT4DA048nyHd6MNGwTjeSfC+0FUJ0l7TwgkW20NKHlcmGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=qQuJQKK3; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="qQuJQKK3"
X-KPN-MessageId: d536ec0a-c20e-11f0-84a0-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d536ec0a-c20e-11f0-84a0-005056abad63;
	Sat, 15 Nov 2025 11:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=7U9+KE3U+DHQXlToNIZmSwibvunNLrd4t8YAsY1kGJ0=;
	b=qQuJQKK3TlaNhjDXeJ8qmnmTchnG6Q2da6ZN+aogvjgIrCoWxSUyUaJzEGAsPZmeafoPmTwlPCvmd
	 zF4e/IdPvtJ2qlVsKe4FQzQjeflg/9O8+R2HfPMvjlBHwK76GJD8WIvE+QWuo8OF3QGeMlOickNYIS
	 1gX34qqkb/+DjDDU=
X-KPN-MID: 33|rjvuy+O2mZKZarj2lzUFqBM7RiF+jpvP6koqCbvdLVqQIgoPRshtkvFMA55HMyB
 xs+PCSc/yXwibDI7ZygTOYWYTH8Qgjy3y1P55tHoi7ek=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|H8KqNhj5EViDR0o+dxiugW7NY+6Dnh46Z8LDxzEpUbZdYoiTiitv+LYSPKNJzHH
 gT1kmy8d12cCj4D1JFB4lRQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id c5f28d86-c20e-11f0-8009-005056ab7447;
	Sat, 15 Nov 2025 11:35:15 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 2/2] chmem: do not word a configuration failure as an instruction to the user
Date: Sat, 15 Nov 2025 11:35:04 +0100
Message-ID: <20251115103504.6360-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251115103504.6360-1-bensberg@telfort.nl>
References: <20251115103504.6360-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the current machine does not support configuring/deconfiguring
memory, simply report that it cannot be done, instead of seemingly
telling the user to skip the configuring/deconfiguring.

Also, there is no need to mention `chmem` in the message: mentioning
just the recommended option (-e or -d) is enough.  Also, consistently
terminate all four messages with a period.

This improves upon commit ab2e709600 ("chmem: improve messages").

CC: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/chmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/chmem.c b/sys-utils/chmem.c
index 6ec66bb6b..dcec888d1 100644
--- a/sys-utils/chmem.c
+++ b/sys-utils/chmem.c
@@ -325,10 +325,10 @@ static int chmem_config_size(struct chmem_desc *desc, int configure)
 	if (!desc->have_memconfig) {
 		if (configure)
 			fprintf(stdout,
-				_("Skip configuration. Use chmem -e instead.\n"));
+				_("Cannot configure. Use -e instead.\n"));
 		else
 			fprintf(stdout,
-				_("Skip deconfiguration. Use chmem -d instead\n"));
+				_("Cannot deconfigure. Use -d instead.\n"));
 		return -1;
 	}
 	size = desc->size;
@@ -363,10 +363,10 @@ static int chmem_config_range(struct chmem_desc *desc, int configure)
 	if (!desc->have_memconfig) {
 		if (configure)
 			fprintf(stdout,
-				_("Skip configuration. Use chmem -e instead.\n"));
+				_("Cannot configure. Use -e instead.\n"));
 		else
 			fprintf(stdout,
-				_("Skip deconfiguration. Use chmem -d instead\n"));
+				_("Cannot deconfigure. Use -d instead.\n"));
 		return -1;
 	}
 	todo = desc->end - desc->start + 1;
-- 
2.51.2

