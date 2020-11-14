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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365D6C56202
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5192225D
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZv44WV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKNEN1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 23:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNEN1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 13 Nov 2020 23:13:27 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2F8C0613D1
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:27 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g15so8829814qtq.13
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+wSxIfb+MoqVNTGCKH3PkIfSFF7zipe1YOM5hNBmE2M=;
        b=VZv44WV4T4+dPjqyDO0yDC0p42I+L9cGy7PW04JHFp2y1cGiQtgoFRBNtu4wNy7DpJ
         MWO6NvcT5cAvsZWeqCFXEYLifN/KdJjkwWaZ7gL6n3RnuEI3+ECdhq+1uh9cUkaCNqS6
         qMz9dXcnkfI01VemtbIdIyH6PNGWOKNZk/7WteWNC1VQt1FKmGDq7yyn68M8R0Q+XHNG
         FiZOGln3rOT+BWzIDTjxMjaT7UYIV3y3H/D2x9bZ0cV9EYz+FUQlSV1tE4ZIqNlAC7GD
         7d+lk2WUizWgRNxQTjF4fwizJC+a73zV+kFT02XZ/ki0ulQs73eIkZtBJ7ZzwfwUJZT1
         O9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+wSxIfb+MoqVNTGCKH3PkIfSFF7zipe1YOM5hNBmE2M=;
        b=kPB/UUtx979VQCTd40fTDQI/fSaJakldd+6GNYjLTPdD2DPM2bCAli5qS9lZzDJeqi
         D694vwpP4mSNi47CCyBVXv6mJAFLh9WrmngfbrsSNnsG8MBo9CtaI5k06RvysWH3fqlZ
         bbelnL1OoVx4tV/e1s+ozm4F6MT+gdts9MohgT2huuNiIS+qWtFiYDo0xIQYZ+21k38K
         5dET1AXEuVj9OaCagpPYyjcVrL4VhSyqeW6rCO0MLy0rBvO2vUxls+n7KQBeyfBQKHKb
         PLOMaoy6y6V6bG1kG8KpE3P3M4SvNj+aqWI8eiPm9gCgEA2NchQYdPZjy2Fo6UiMxoBC
         /29A==
X-Gm-Message-State: AOAM533oBzgqzmal88Rd2TNCcNGPbMRLthAakB7w0lZ+YQeWXF3cZVcB
        toWgMdWbQ/AmPcpco6+LqaZCNA7q4g==
X-Google-Smtp-Source: ABdhPJzq3m2IqaRMjxN9ZI9XMUTHftvz41y5CdARsGqEymXJt1zqk2GaEUhGtiSXymzjs38nr94IaQ==
X-Received: by 2002:a05:622a:142:: with SMTP id v2mr5052489qtw.169.1605327206371;
        Fri, 13 Nov 2020 20:13:26 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id w184sm3935935qkd.47.2020.11.13.20.13.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 20:13:25 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v2 2/5] lscpu-virt: split hypervisor_from_dmi_table()
Date:   Fri, 13 Nov 2020 23:12:26 -0500
Message-Id: <20201114041229.26417-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201114041229.26417-1-msys.mizuma@gmail.com>
References: <20201114041229.26417-1-msys.mizuma@gmail.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Split hypervisor_from_dmi_table() to parsing dmi table and checking the
hypervisor vendor.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu-virt.c | 54 ++++++++++++++++++++++++++----------------
 sys-utils/lscpu.h      |  6 +++++
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/sys-utils/lscpu-virt.c b/sys-utils/lscpu-virt.c
index 527f7caa4..32558fd9f 100644
--- a/sys-utils/lscpu-virt.c
+++ b/sys-utils/lscpu-virt.c
@@ -76,20 +76,13 @@ nothing:
 	return NULL;
 }
 
-static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
-				uint16_t num, const char *devmem)
+static int parse_dmi_table(uint16_t len, uint16_t num,
+				uint8_t *data,
+				struct dmi_info *di)
 {
-	uint8_t *buf;
-	uint8_t *data;
+	uint8_t *buf = data;
+	int rc = -1;
 	int i = 0;
-	char *vendor = NULL;
-	char *product = NULL;
-	char *manufacturer = NULL;
-	int rc = VIRT_VENDOR_NONE;
-
-	data = buf = get_mem_chunk(base, len, devmem);
-	if (!buf)
-		goto done;
 
 	 /* 4 is the length of an SMBIOS structure header */
 	while (i < num && data + 4 <= buf + len) {
@@ -113,11 +106,11 @@ static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
 		next += 2;
 		switch (h.type) {
 			case 0:
-				vendor = dmi_string(&h, data[0x04]);
+				di->vendor = dmi_string(&h, data[0x04]);
 				break;
 			case 1:
-				manufacturer = dmi_string(&h, data[0x04]);
-				product = dmi_string(&h, data[0x05]);
+				di->manufacturer = dmi_string(&h, data[0x04]);
+				di->product = dmi_string(&h, data[0x05]);
 				break;
 			default:
 				break;
@@ -126,15 +119,36 @@ static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
 		data = next;
 		i++;
 	}
-	if (manufacturer && !strcmp(manufacturer, "innotek GmbH"))
+	rc = 0;
+done:
+	return rc;
+}
+
+static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
+				uint16_t num, const char *devmem)
+{
+	uint8_t *data;
+	int rc = VIRT_VENDOR_NONE;
+	struct dmi_info di;
+
+	data = get_mem_chunk(base, len, devmem);
+	if (!data)
+		return rc;
+
+	memset(&di, 0, sizeof(struct dmi_info));
+	rc = parse_dmi_table(len, num, data, &di);
+	if (rc < 0)
+		goto done;
+
+	if (di.manufacturer && !strcmp(di.manufacturer, "innotek GmbH"))
 		rc = VIRT_VENDOR_INNOTEK;
-	else if (manufacturer && strstr(manufacturer, "HITACHI") &&
-					product && strstr(product, "LPAR"))
+	else if (di.manufacturer && strstr(di.manufacturer, "HITACHI") &&
+					di.product && strstr(di.product, "LPAR"))
 		rc = VIRT_VENDOR_HITACHI;
-	else if (vendor && !strcmp(vendor, "Parallels"))
+	else if (di.vendor && !strcmp(di.vendor, "Parallels"))
 		rc = VIRT_VENDOR_PARALLELS;
 done:
-	free(buf);
+	free(data);
 	return rc;
 }
 
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 227e7f391..b199de3dd 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -306,6 +306,12 @@ struct lscpu_dmi_header
 	uint8_t *data;
 };
 
+struct dmi_info {
+	char *vendor;
+	char *product;
+	char *manufacturer;
+};
+
 static inline void to_dmi_header(struct lscpu_dmi_header *h, uint8_t *data)
 {
 	h->type = data[0];
-- 
2.27.0

