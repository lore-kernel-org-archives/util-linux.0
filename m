Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB0FC6379D
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D1D2236F
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uopAT6e1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKTFGZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 20 Nov 2020 00:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgKTFGZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 20 Nov 2020 00:06:25 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FE6C0613CF
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:25 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id i9so8671140ioo.2
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i//UMRCAQ+a8/5LeaXMd7JfFDFcfdLxdkozLlQFbRUw=;
        b=uopAT6e1ghoECWOwV+BLHzLjkD85t/cdy+s/nGk5d+UV25dOOU5Ljg0Bgq+ZijnlGH
         9RtUsH/pftr9Nx89MSUThnnkslPX9Os5aqTwMPYPW+2qrko6t5rt31wilqupRxkMisMn
         YtseUDiAOQw5gCWr5XGHigyUtUGjdDl+iQ3dFE35A6ieTnWblIJ5GmjH84MdcStTSD3l
         qL8nZj+ue1ObkQp07abHUB06PrjlClGOdn/s5BUmHp36IRuKf35BUVUBYzucSUcbZ0KX
         CXP4230K+AfkeCqjUVC1hqmfwTGMpfDcL1tpLqxuki8hUfmKTbTaXiOopPr9YtcFa8YY
         XOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i//UMRCAQ+a8/5LeaXMd7JfFDFcfdLxdkozLlQFbRUw=;
        b=ABscmvnsipB829vOrT+jspqVe8ww6qD7fq9yjEjJQn4RniQtJHPO8dDFMHVxA+IpbI
         iWKj9mfyV1k1eQkJpGd2afh8ufoOjMSzUBFzL9+E4or7F49aqlB1BAajpHLYzQZwlb/D
         ERt0BVASHwLuD6bBhD3Oydm29bvxayOGqitOmYfC0MVkDSf0zjrqGCIkknp8zeZrsZtF
         tZDyhJ4NFZJr18j9CrvHpVxmpw/CD0qI9/uGLvNQXzbTn5+lkAC5xTFnwk5PRKy6UD0H
         Eq//6ufwPB3Zi0Nbno0ijX0eLYlfCPeajU8XRWMQ+S8rvxrK2ZL8HJ8ih3NpmaZInvYX
         B1OA==
X-Gm-Message-State: AOAM533Bvw57X4Gw56ekCWK6yjTJbbp/6iG2Erfpdj/IupBeupv85wn+
        zy4h5UHIasDTXouZoUJHoPjRyfjAlA==
X-Google-Smtp-Source: ABdhPJxl9Uc3dcaGF+ju1cqMJH2mT4FTyiWqUffu96l0SmQEilmwAHgYLF2DWT2PUXL4/SLnBhSvGA==
X-Received: by 2002:a5e:c810:: with SMTP id y16mr4703860iol.208.1605848784662;
        Thu, 19 Nov 2020 21:06:24 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id b1sm990495ils.41.2020.11.19.21.06.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 21:06:24 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v3 2/5] lscpu-virt: split hypervisor_from_dmi_table()
Date:   Fri, 20 Nov 2020 00:06:06 -0500
Message-Id: <20201120050609.17409-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120050609.17409-1-msys.mizuma@gmail.com>
References: <20201120050609.17409-1-msys.mizuma@gmail.com>
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
index 8d7c9b740..c86dae8c9 100644
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
index 7d42816c3..11b27fb14 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -305,6 +305,12 @@ struct lscpu_dmi_header
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

