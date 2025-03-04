Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5625F97C
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099339; cv=none; b=tzD06avIWc7/hRxm6/oCGEzh0TvsdcbTNE/xVEhv/2cDHmTNWDQQofuO4MBJtKS++hUuK34TceV96OrVqFVgnVk7AANGLwjFgNRFghb1a/lfsdVbsg0vpOZWJmAVS7nSVjMimYlQNok1fsKs1hGVEEeAr4U3xc0iA279ASL9GuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099339; c=relaxed/simple;
	bh=eMDToePrZwO1UYMyVgguZ3I6jBU1hYxDWJeCGv0S+Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ORVQwvhSZ9+3hfL1Bs5ReFwkK8GiSqEu/7Qkz4jOxiphgSgrrUSq9dRJMKBss7dgifsVBgADvQHdJ99PXBw6wTGR60dVFeYbN3y4bZoQsOt9mAhbXKlv+ekmaimxitozmwIb95QPUmCa7no+0J/wAxfh77DtsApmecRF0QG/BAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fC43up6N; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fC43up6N"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22382657540so61231285ad.2
        for <util-linux@vger.kernel.org>; Tue, 04 Mar 2025 06:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741099336; x=1741704136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xmeGPr4qPtiWrZRGPzwzuCf1xAq1zFTXoPr8j1L+78=;
        b=fC43up6NcdXg81641VbBhLHgDPfYrp95qYWrqUH/BelsBhFUVbihOJaHrPT+xqLWkg
         V9++CzOOMyPz3e+QzJqkSvxhEWssSV6SqcwGjAnZsBNQbHVGqeBByL0Ev2qKcSzFxnR/
         hAdldt8FJ+gUDrBmYC8G3bx5a5TAWOkkOROkkxmOTBThyvwUI52tCMkWqwsXYImgOFWx
         BM7d4FnRG9Fb9ApH9gh3uWg8RN7n4tqHgh/yov/4L6BHbht73amg0BY/e9Ii7dMj6c0I
         pM0cFUjdmjYQBT54ygW2oV8WwhnqJFOfZ184/ajhF2xmOpsgkTu5HVY/BNDnzYbgcD18
         qGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741099336; x=1741704136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xmeGPr4qPtiWrZRGPzwzuCf1xAq1zFTXoPr8j1L+78=;
        b=Z4fxW+ZbW3jdqsUj8x/k/RFVDPgzs7BCfjjWE5MaIFiq/g2wATyzeu5frkm8QAw2jj
         dPzYK9EK0AUKPrpgtDMKbCKEwqn1Q1RzAfKXx9pzW8ZfjgUWC3L9AorJOR+lbl1/qkzV
         eagyAotbKiN2MVELh3xr2saBBsnPk6kZtJj2cWayiVPlwi67tbHGe2p0LA/nSv7p5ePM
         qx4jiZ/YpGMaIc3TTAERUt5UXDdy3GOgmeCDdyY4oztumJwvc1i949qcf2Di9fqbBF21
         5UDFEs4icpoVCGdJ2JmuiJgEYjVZ8fn3ax3AnWBvLa57Cvh4bnUz8+MjHJosRtxtHBy6
         8xgA==
X-Gm-Message-State: AOJu0YzRxMMVG6IEg4WVouLoWn/uC2mw9Wii1k1Ay2BHbqp89RrygM8G
	uhN2oL9qRl/ZVYsHscmaYiqTcy6VlEz0hZtTy/URqWFmqg2hl+HB4/dVtKLre4//fPHUtpANfkh
	X+Q4=
X-Gm-Gg: ASbGnctQbUlDctPjwiiiI3LkNWUktP0GXEvjEwv2BMBx7D22v2W00tVjrkUVqXygepJ
	S8aqe81DrEFRitO2zFXCLNKBgDTaXkb18Iailiu4/iGtLokJCO/FigXS1xTtYtn/+zDXzDmmNyK
	mP3GneH/qj/VSzuPAFjUkv0olC1cDay+trf0aVrxY4sAqttOIpZFk2dkmAFJGZSwMpIikjR3dMj
	SFoUOsxmi/hUErAf76NfrXa3+cUv8ByAX7638wdouxwZ8OK/Umi8GfyPhM67toE5OsaF0vgKYpG
	z7E2hh6oF7jBT+F/eSOzy8Qin8L4i10vWbC+S7kxGhvDSX/hHsYdtkFqP+cNQf7agG4HEubTZAU
	2
X-Google-Smtp-Source: AGHT+IG2cTXIZl5J43gU0OMtaEAmgFmxqhzl6Ob0W+aWbpfGnAyUYTl2vihhYX3qd4v4Gc5WME/3ww==
X-Received: by 2002:a17:903:144c:b0:220:cd13:d0ec with SMTP id d9443c01a7336-2236926a646mr186312695ad.48.1741099336119;
        Tue, 04 Mar 2025 06:42:16 -0800 (PST)
Received: from sunil-laptop.tail07344b.ts.net ([106.51.199.215])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73643b17286sm5331585b3a.157.2025.03.04.06.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:42:15 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: util-linux@vger.kernel.org
Cc: Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH] lscpu: Print ISA information in summary
Date: Tue,  4 Mar 2025 20:12:10 +0530
Message-ID: <20250304144210.182961-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISA information for RISC-V is an important information to understand
the different extensions supported by the CPU. Print this information in
the summary.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 sys-utils/lscpu-cputype.c | 1 +
 sys-utils/lscpu.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/sys-utils/lscpu-cputype.c b/sys-utils/lscpu-cputype.c
index 739dd99c5..bdb33ac78 100644
--- a/sys-utils/lscpu-cputype.c
+++ b/sys-utils/lscpu-cputype.c
@@ -233,6 +233,7 @@ static const struct cpuinfo_pattern type_patterns[] =
 	DEF_PAT_CPUTYPE( "family",		PAT_FAMILY,	family),
 	DEF_PAT_CPUTYPE( "features",		PAT_FEATURES,	flags),		/* s390 */
 	DEF_PAT_CPUTYPE( "flags",		PAT_FLAGS,	flags),		/* x86 */
+	DEF_PAT_CPUTYPE( "isa",			PAT_ISA,	isa),		/* riscv */
 	DEF_PAT_CPUTYPE( "marchid",		PAT_FAMILY,	family),	/* riscv */
 	DEF_PAT_CPUTYPE( "max thread id",	PAT_MAX_THREAD_ID, mtid),	/* s390 */
 	DEF_PAT_CPUTYPE( "mimpid",		PAT_MODEL,	model),		/* riscv */
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index ffec37206..9f00b1757 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -954,6 +954,9 @@ print_summary_cputype(struct lscpu_cxt *cxt,
 
 	if (ct->flags)
 		add_summary_s(tb, sec, _("Flags:"), ct->flags);
+
+	if (ct->isa)
+		add_summary_s(tb, sec, _("ISA:"), ct->isa);
 }
 
 /*
-- 
2.43.0

