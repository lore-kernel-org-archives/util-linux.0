Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D57C5517A
	for <util-linux@archiver.kernel.org>; Wed, 11 Nov 2020 01:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5AC20825
	for <util-linux@archiver.kernel.org>; Wed, 11 Nov 2020 01:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZqkH40z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbgKKBYU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Nov 2020 20:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732013AbgKKBYU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 10 Nov 2020 20:24:20 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217DEC0613D1
        for <util-linux@vger.kernel.org>; Tue, 10 Nov 2020 17:24:20 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id v143so322391qkb.2
        for <util-linux@vger.kernel.org>; Tue, 10 Nov 2020 17:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VTr3DFbiJgDezbMUz1YNaWwF8yktLIOFqj0073qC0iM=;
        b=JZqkH40z1/XldbTEjGL9DWHQnSaVogf87eMDCzMNBmKH0CZ7bvbJZcFk6sOyr7+qDf
         YnAYss2FW3n8grWtzViOq5Ygv40wL7KCLiAY+rmPbJpPip1MQnxoyxy6kbsBElvG6G8O
         dfAcOnmVyqZmr0Om/SQNbA7XD2G6AIYoEMzxAZaAhwqwOlKDkDloTsIW1VOd4rypP3Ey
         rgqjj0NMhidEWG2zA6dKiiSHyY8PNwELEC6KtwRGswDyCspmincioLH6R8QR47latq69
         Hhv7zkJdf0+06J5WR8vxUFYppQBXNa/aNxbqGCcvIQAX3I84QeadU6/ZUn5cvTVvdHkI
         U8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VTr3DFbiJgDezbMUz1YNaWwF8yktLIOFqj0073qC0iM=;
        b=oKSAM7LrJC/pE5aKC5mWd9JtUMki0IPmaUBz/ynq5yUrgHhlEyhzxL40+WUhrvDP0k
         OrEH2h4pcd227MJfNFQSHXoFlGolca/BQcta75ItrLuhRB0K3PZitbmz0/xtHFkK9zxT
         YmNQqRc5o87zKsembrI4CtvBDCUWEEjp43VNLRL/CSAS+DPZ5HPz7blbT21ob5pldLTe
         UqDyoPasbOvMLjlXdZjUbdVI2pxU87sEauUVwtPtd+Rtn6G+KSpO2XTCZaJDeh3RuAQ/
         Vk5QgtGp4xKSYC1s0k9W1d7iWnOSfCBolJMfhSeNvRXug9FPobWd3A3E4h3Wa8vdEmtu
         feZw==
X-Gm-Message-State: AOAM533rAXelr3z15a0DWmx96k+I2e9l9Gzualiw3/WbXvMpBOdC+kJA
        UPdi0losUFvPWi0uYGUv5RdfpjN2xg==
X-Google-Smtp-Source: ABdhPJwRULllHa9aYnmp6+vExR8LQpJkrE4KAqsiwqDmR45vVSkSljx7uPJlw5kMgdNNKOU7irtJRA==
X-Received: by 2002:a05:620a:14b2:: with SMTP id x18mr5172091qkj.440.1605057859169;
        Tue, 10 Nov 2020 17:24:19 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id w5sm678419qkf.31.2020.11.10.17.24.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 17:24:18 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org, jbastian@redhat.com,
        jeremy.linton@arm.com
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v5] lscpu-arm: Add "BIOS Vendor ID" and "BIOS Model name" to show the SMBIOS information.
Date:   Tue, 10 Nov 2020 20:24:00 -0500
Message-Id: <20201111012400.23995-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

After commit: 367c85c47 ("lscpu: use SMBIOS tables on ARM for lscpu"),
Model name for A64FX shows like as:

   Model name:       461F0010

That's because 367c85c47 changes to get the modelname from Processor
Version of SMBIOS.

To fix that, use the hard corded table to show the "Model name" and
add two new lines; "BIOS Vendor ID" and "BIOS Model name" to show the
SMBIOS information.

lscpu shows the SMBIOS information when root user runs it because
accessing the SMBIOS information requires root privilege.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu-arm.c | 22 ++++++++--------------
 sys-utils/lscpu.c     |  4 ++++
 sys-utils/lscpu.h     |  2 ++
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 20c7291e5..52dbff804 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -281,7 +281,7 @@ static void __arm_cpu_decode(struct lscpu_desc *desc)
 #define PROC_MFR_OFFSET		0x07
 #define PROC_VERSION_OFFSET	0x10
 
-static int __arm_cpu_smbios(struct lscpu_desc *desc)
+static void __arm_cpu_smbios(struct lscpu_desc *desc)
 {
 	uint8_t data[8192];
 	char buf[128], *str;
@@ -291,41 +291,35 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
 
 	fd = open(_PATH_SYS_DMI_TYPE4, O_RDONLY);
 	if (fd < 0)
-		return fd;
+		return;
 
 	rs = read_all(fd, (char *) data, 8192);
 	close(fd);
 
 	if (rs == -1)
-		return -1;
+		return;
 
 	to_dmi_header(&h, data);
 
 	str = dmi_string(&h, data[PROC_MFR_OFFSET]);
 	if (str) {
 		xstrncpy(buf, str, 127);
-		desc->vendor = xstrdup(buf);
+		desc->bios_vendor = xstrdup(buf);
 	}
 
 	str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
 	if (str) {
 		xstrncpy(buf, str, 127);
-		desc->modelname = xstrdup(buf);
+		desc->bios_modelname = xstrdup(buf);
 	}
-
-	return 0;
 }
 
 void arm_cpu_decode(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 {
-	int rc = -1;
-
-	/* use SMBIOS Type 4 data if available,
-	 * else fall back to manual decoding using the tables above */
+	/* use SMBIOS Type 4 data if available */
 	if (mod->system == SYSTEM_LIVE &&
 	    access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
-		rc = __arm_cpu_smbios(desc);
+		__arm_cpu_smbios(desc);
 
-	if (rc)
-		__arm_cpu_decode(desc);
+	__arm_cpu_decode(desc);
 }
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index b7dc4dfb5..a3e7b4445 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -2146,6 +2146,8 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		add_summary_n(tb, _("NUMA node(s):"), desc->nnodes);
 	if (desc->vendor)
 		add_summary_s(tb, _("Vendor ID:"), desc->vendor);
+	if (desc->bios_vendor)
+		add_summary_s(tb, _("BIOS Vendor ID:"), desc->bios_vendor);
 	if (desc->machinetype)
 		add_summary_s(tb, _("Machine type:"), desc->machinetype);
 	if (desc->family)
@@ -2154,6 +2156,8 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		add_summary_s(tb, _("Model:"), desc->revision ? desc->revision : desc->model);
 	if (desc->modelname || desc->cpu)
 		add_summary_s(tb, _("Model name:"), desc->cpu ? desc->cpu : desc->modelname);
+	if (desc->bios_modelname)
+		add_summary_s(tb, _("BIOS Model name:"), desc->bios_modelname);
 	if (desc->stepping)
 		add_summary_s(tb, _("Stepping:"), desc->stepping);
 	if (desc->freqboost >= 0)
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 3de0abcce..d73583f77 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -98,10 +98,12 @@ struct lscpu_desc {
 
 	char	*arch;
 	char	*vendor;
+	char	*bios_vendor;	/* aarch64 */
 	char	*machinetype;	/* s390 */
 	char	*family;
 	char	*model;
 	char	*modelname;
+	char	*bios_modelname;  /* aarch64 */
 	char	*revision;  /* alternative for model (ppc) */
 	char	*cpu;       /* alternative for modelname (ppc, sparc) */
 	char	*virtflag;	/* virtualization flag (vmx, svm) */
-- 
2.27.0

