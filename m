Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FA1C84AF
	for <util-linux@vger.kernel.org>; Sat, 15 Feb 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636429; cv=none; b=uBE7caV0znPC7bFR/+vv/vs1kZKhQw2JMI1V9cn9hDqVHJcCcOk3eNNk0QUFm9wWtwqQt8i6SkQvRncZ2YUKRmpGe/hPaPhAcvk3G/QZggyS1uan5tdxLMhbmKhwnSAmhoAQ0uchYrCIWtRr/utXmWH37Tu31Kord5wfEktnJd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636429; c=relaxed/simple;
	bh=mNHjXephOooPshWBBbh+r4jJyM7PXvHDFPo4OdAcW+w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9j/ZnZx8AzUTCN94BgGQ2YXZvfDQS669qQzPxHdX4+bIg8TDzQUJvSP+WaqksbcBcSedQD4oFn76wCGbLk/zJx8CALwxEeSBeAVLWwtuIuGYlH23d633DnaBMlV1QmQix+sXw4OegHxaT/MnWcUBuFKZw49PMA1lAEine0Ajno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ETZhuPla; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ETZhuPla"
X-KPN-MessageId: c4c7e52f-ebb8-11ef-8f0e-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c4c7e52f-ebb8-11ef-8f0e-005056aba152;
	Sat, 15 Feb 2025 17:20:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=SyP+csOrGAQkdoK1HXWfyIlfc67Nk7bpvwBNOIIrWR8=;
	b=ETZhuPlax+sdpdcE/YuaSjcwPAR4xFGqMnqhSBJV9pOyh1XbTO/padT+lZLq4xY67+BBYxDo/YALr
	 +OHAKgLjoGl5g9n0pt+1i97n7gEu3MMK1x8d5K05ojdEdusF3N0jog7alPqkghAXzr25x7wdnRomzi
	 b+WqxN6PS6J5ANpI=
X-KPN-MID: 33|Fw1Qten1u3nK+Wp/rgeVJWNrWw1rRS+XCkbKI05mPHM6UPScT2ssa/Aeh+PDWAQ
 WpW5X4uXduz0DeaqvKZ4JKA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|9zHG6yDEbGVxJ5UKBzjiv1U3pNnLutKPToGLD7O0Tmjoyi3jRBoqBCGCnVTy5L3
 q0Ff1GVBTqnhlIkbJJ5SwQg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id c3483652-ebb8-11ef-bc7e-005056abf0db;
	Sat, 15 Feb 2025 17:20:25 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/10] mkfs.cramfs: in usage text, separate two direct arguments from options
Date: Sat, 15 Feb 2025 17:18:41 +0100
Message-ID: <20250215161843.12053-8-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215161843.12053-1-bensberg@telfort.nl>
References: <20250215161843.12053-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/mkfs.cramfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index f4ada9052..51fa2122a 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -144,6 +144,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputsln(_(  " -s             sort directory entries (old option, ignored)"), stdout);
 	fputsln(_(  " -z             make explicit holes"), stdout);
 	fputsln(_(  " -l[=<mode>]    use exclusive device lock (yes, no or nonblock)"), stdout);
+	fputs(USAGE_SEPARATOR, stdout);
 	fputsln(_(  " dirname        root of the filesystem to be compressed"), stdout);
 	fputsln(_(  " outfile        output file"), stdout);
 	fputs(USAGE_SEPARATOR, stdout);
-- 
2.48.1

