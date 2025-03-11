Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3625EFBA
	for <util-linux@vger.kernel.org>; Tue, 11 Mar 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709221; cv=none; b=cPYSVIv+DFkK70KE/BcOvJFO2N+EG9bgF8+y8+2K8aBsw07GMx1NXg3m6FsNzzi77OPqIkxJqQBotXJLr3u/YAYJnQJQ4GH2Shyjf0gbTm9kYZe5w5IGxavpsICOWwaqnmAs8AWSf4xqrYzl8Zckeamxh5JE7jkOAlAtZiku1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709221; c=relaxed/simple;
	bh=nO7v/s0k9GBXqFEcwXyztgzVf14kkKnIla9WpD7uw7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgMAT36VAV3JVrvrkyEoTjcxBq6Lzn5jIq0r+0MG8ayOiyC4Rm5mUFHYO9YPS/gsoHdRuGHjvN3lfRwDNKrLyhmd94c+Fzq+k9mp4z2xjXFMvk7FTY/0A69SLWUcCRZpo3nXhaFl8Li2lquHvEbLLlVJz1OecUhHDBwRA7Wnvy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Eq/1Crka; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Eq/1Crka"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72b0626c785so2176375a34.2
        for <util-linux@vger.kernel.org>; Tue, 11 Mar 2025 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741709218; x=1742314018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=13E2v3DuFs9DYscSQqqkmG7bVtEckv7UrzZxUb/2JLg=;
        b=Eq/1Crka7D1YYLKQ7A/oYDdi+mBFflMEPfR3n8u8RjfhA6ZEGorzSBrzU6P4VYN2dQ
         wysI6j8nX+KizNa8wwROe1qmLTEw+RPCiuIM01Cu1mNrTNRU5Tyy7PE+ApSPcjQHU04B
         PoTKkWeUucSTj3foSuIaVKSmFkzYUVKdIeJYwjxBdVmeztOGqTaJM9/GbzdYosC9Mvrw
         pA1Wwb53X8Mgnm1u4EcqJABetwoVf6xyOFU01/9FxOmc49TnPVhUoWI59xCc0aVSAkay
         xs6m2sxbahQvOMon6EfsquQ9vnaswNn9MUzXTivGCL1zZd1o6mh4fD8UGMxXNcX68vHF
         AVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709218; x=1742314018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13E2v3DuFs9DYscSQqqkmG7bVtEckv7UrzZxUb/2JLg=;
        b=UIads/HiGQmAnSTeYBZTM5unmgtlWnx0rS2zJ9v8n0+uCsoWezrwbuUr3qXUsqZxJs
         TFbG2kMDEUiXDvV4T/Igo7++2CkdONNNL/5y8dnDz6JLMtCKcp27CCdiKl6ICk3MzdtC
         mQ7i/mingHat4YcTisuF7+/knnZ6KVOAyciZQFlcYxcPYVGn2dAJ9mM4XmHJD3ftBWLt
         KJqAlD3ve4U89aw/ZcbFfMldGrha0ercoeMSFBOXDxBSxtpkwO14UXdRwM6g+2lHv3VB
         ZxkXESktggyv6nrTxKY0r3AWyeaAsDSJ8E5pWCgBdYSHuVUBkFrcojfc2CiQPlhvrdkg
         nzcg==
X-Gm-Message-State: AOJu0YyShaWMvGPnbEULBP4lw9Q1svlDpSaEwLuiGivB6mB+BEdN6DID
	eHoIqm4qTd7Kmt9T7j4b2mQn9X7bfe//DWsbwArEw57EB5Ri0TJKlCOfkstKq7Iwp86f+Z1wGMu
	csDU=
X-Gm-Gg: ASbGncuWxui8BfvYuqKjq1pbrhQoePNpNkNlZj1vTftOlhkC22k39brXZ0WHS6SfwAT
	f3MJ2pD+cKyf+ZkONH85SllyQJcH2ec1Vf0lTiQVpWl0Pz5ZH18DTrP1y25eyDWf5NCwy2IqUiz
	BX2bRGUr7EMc3D8PoA0bkdBxmRVadRHq3ck+lwzgN+A0dwhJda3RGX7j4Qvs3OqQVrsHG/tEF3b
	5/0K+CBAD1/rg1feckww8ZFuw9S+T22I9NYoHfSgF6lZc6imRQdcLYNuZxBqJmrZCZr5q9JUhCo
	k/1LdNjy9vyielhAWnRF4GHZJwnwWBhSh5A0Jjj9pkh56NJkLSmQnWNErZrND2qgC7g9nCaMkQS
	LZNt/3XvpQ2iTdxQ=
X-Google-Smtp-Source: AGHT+IG9ciwrAznUoFSONmeb1ArJNysbOug6k2jzYkhSDQXcvIZX379+YksJsn8KW4OQV/INZ8O03Q==
X-Received: by 2002:a05:6830:34a0:b0:72b:a064:fab0 with SMTP id 46e09a7af769-72ba064fc4fmr1104960a34.3.1741709218627;
        Tue, 11 Mar 2025 09:06:58 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c248df3424sm2639510fac.50.2025.03.11.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:06:57 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: util-linux@vger.kernel.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@rivosinc.com>,
	Karel Zak <kzak@redhat.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2] lscpu: RISC-V: Print ISA information in summary
Date: Tue, 11 Mar 2025 21:36:46 +0530
Message-ID: <20250311160646.1257131-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISA information for RISC-V is important for understanding the
different extensions supported by the CPU. Print the ISA information in
the summary, with the Base ISA and single-letter extensions at the
beginning, followed by multi-letter extensions sorted in alphabetical
order. The information is the same as the cpuinfo information, except
that underscores are replaced by spaces and multi-letter extensions are
simply sorted instead of following any ISA string ordering rule.

The sample output below shows the difference between cpuinfo and lscpu.

cpuinfo output:
isa             : rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zawrs_zfa_zba_zbb_zbc_zbs_smaia_ssaia_sstc

lscpu output:
ISA:                rv64imafdch smaia ssaia sstc zawrs zba zbb zbc zbs zfa zicbom zicboz zicntr zicsr zifencei zihintntl zihintpause zihpm

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
Changes in v2:
	1) Format the ISA string instead of simply printing the same
	   from cpuinfo. (Feedback from Andrew Jones).
---
 sys-utils/Makemodule.am   |  1 +
 sys-utils/lscpu-cputype.c |  1 +
 sys-utils/lscpu-riscv.c   | 57 +++++++++++++++++++++++++++++++++++++++
 sys-utils/lscpu.c         |  5 ++++
 sys-utils/lscpu.h         |  2 ++
 sys-utils/meson.build     |  1 +
 6 files changed, 67 insertions(+)
 create mode 100644 sys-utils/lscpu-riscv.c

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 922cce5c5..1055312db 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -461,6 +461,7 @@ lscpu_SOURCES = sys-utils/lscpu.c \
 		sys-utils/lscpu-virt.c \
 		sys-utils/lscpu-arm.c \
 		sys-utils/lscpu-dmi.c \
+		sys-utils/lscpu-riscv.c \
 		sys-utils/lscpu.h
 lscpu_LDADD = $(LDADD) libcommon.la libsmartcols.la $(RTAS_LIBS)
 lscpu_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
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
diff --git a/sys-utils/lscpu-riscv.c b/sys-utils/lscpu-riscv.c
new file mode 100644
index 000000000..62f1ad7ab
--- /dev/null
+++ b/sys-utils/lscpu-riscv.c
@@ -0,0 +1,57 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ *
+ */
+#include "lscpu.h"
+#include "strutils.h"
+#include "strv.h"
+
+static int riscv_cmp_func(const void *a, const void *b)
+{
+	return strcmp(*(const char **)a, *(const char **)b);
+}
+
+bool is_riscv(struct lscpu_cputype *ct)
+{
+	const char *base_isa[] = {"rv32", "rv64", "rv128"};
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(base_isa); i++) {
+		if (!strncasecmp(ct->isa, base_isa[i], strlen(base_isa[i])))
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Reformat the isa string, but the length stays the same.
+ */
+void lscpu_format_isa_riscv(struct lscpu_cputype *ct)
+{
+	char **split;
+	size_t i;
+
+	split = strv_split(ct->isa, "_");
+
+	/* Sort multi-letter extensions alphabetically */
+	if (strv_length(split) > 1)
+		qsort(&split[1], strv_length(split) - 1, sizeof(char *), riscv_cmp_func);
+
+	/* Keep Base ISA and single-letter extensions at the start */
+	strcpy(ct->isa, split[0]);
+
+	for (i = 1; i < strv_length(split); i++) {
+		strcat(ct->isa, " ");
+		strcat(ct->isa, split[i]);
+	}
+
+	strv_free(split);
+}
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index ffec37206..7b2f28e5e 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -954,6 +954,11 @@ print_summary_cputype(struct lscpu_cxt *cxt,
 
 	if (ct->flags)
 		add_summary_s(tb, sec, _("Flags:"), ct->flags);
+
+	if (ct->isa && is_riscv(ct)) {
+		lscpu_format_isa_riscv(ct);
+		add_summary_s(tb, sec, _("ISA:"), ct->isa);
+	}
 }
 
 /*
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 459fea84d..bd7b64cc5 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -278,6 +278,7 @@ struct lscpu_cxt {
 		 CPU_ISSET_S((_cpu)->logical_id, (_cxt)->setsize, (_cxt)->present))
 
 int is_arm(struct lscpu_cxt *cxt);
+bool is_riscv(struct lscpu_cputype *ct);
 
 struct lscpu_cputype *lscpu_new_cputype(void);
 void lscpu_ref_cputype(struct lscpu_cputype *ct);
@@ -320,6 +321,7 @@ int lscpu_create_cpus(struct lscpu_cxt *cxt, cpu_set_t *cpuset, size_t setsize);
 struct lscpu_cpu *lscpu_cpus_loopup_by_type(struct lscpu_cxt *cxt, struct lscpu_cputype *ct);
 
 void lscpu_decode_arm(struct lscpu_cxt *cxt);
+void lscpu_format_isa_riscv(struct lscpu_cputype *ct);
 
 int lookup(char *line, char *pattern, char **value);
 
diff --git a/sys-utils/meson.build b/sys-utils/meson.build
index 2fdcc6393..d9817f922 100644
--- a/sys-utils/meson.build
+++ b/sys-utils/meson.build
@@ -184,6 +184,7 @@ lscpu_sources = files(
   'lscpu-virt.c',
   'lscpu-arm.c',
   'lscpu-dmi.c',
+  'lscpu-riscv.c',
 )
 lscpu_manadocs = files('lscpu.1.adoc')
 
-- 
2.43.0

