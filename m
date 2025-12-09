Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137E1E8342
	for <util-linux@vger.kernel.org>; Tue,  9 Dec 2025 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765292632; cv=none; b=mGoaU5xCdJuNcyRUxRzcJP+FTxMWPUwOiyF46AiuzbQvixI4iilboUZ4F147fKQ5FdxgdWdu7RB1Zd29AAy+sDqF1b5QJ1kx71ErElTxlZmH7fY8ofyPz1/sVQZZMrtH9zKRF8zP/881iCMinrAnmEtSu1CEuIYPWDRdPbv41qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765292632; c=relaxed/simple;
	bh=U5Qu0OQNTAJOk7Y4JrHhI2mItuGZV4C8/jJai9tTalY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iubnZEtqQhvCDgW+pIdI8RxPDGbcmQ3lcqlDZGgIDJkLEbSVT78Bz8zTa3zpvg0mEpbGJxN1NCS6MVkfGSzxuqUGobVZfyZEnNRyMAtuGmegoxd67FHkFafWJXRaZTjQto8Ve6zAYa3T0oAA+NwInkHBO4BQBl6Fkig/4dbm6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=BUuf9cXB; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="BUuf9cXB"
X-KPN-MessageId: 4f3963ff-d510-11f0-84a0-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4f3963ff-d510-11f0-84a0-005056abad63;
	Tue, 09 Dec 2025 16:04:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=7U9+KE3U+DHQXlToNIZmSwibvunNLrd4t8YAsY1kGJ0=;
	b=BUuf9cXBxt2zBS8D53Va+NxFte4Ja0CDCmHWndGQmPHL+11nE/GTJBiKxf4e+Oyi78UFk9E244USN
	 CmyMUrBn+PLud7+Srqi944bnczBRIAFgFNh/2ZGYQlxOxrXZ1B574pRVwrTp64gm9Goo/7iF9Q0Lpm
	 fR3duJzRgXmwLbQo=
X-KPN-MID: 33|VxHlpTXerRu1euhPJCg66NDP2j1hqx41v5n54BE+Qn951AQcAKLS/7mj2z0H+ml
 cE1UP3IY0M5W+jM9AHlJ9msr4wvGaoCYvbUR7q06V6kY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|BtJrteap/VQAm7gznhvhJIbfa1nq2LrDzw/sIMN4I2gYp4v+hDn7qsSh30a7pjm
 UpmIaCBrgNUyNKrdDbdFpxA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1ad0699a-d510-11f0-800c-005056ab7447;
	Tue, 09 Dec 2025 16:02:39 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 2/3] chmem: do not word a configuration failure as an instruction to the user
Date: Tue,  9 Dec 2025 16:02:21 +0100
Message-ID: <20251209150222.50981-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251209150222.50981-1-bensberg@telfort.nl>
References: <20251209150222.50981-1-bensberg@telfort.nl>
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

