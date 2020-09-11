Return-Path: <SRS0=Tf+r=CU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF29C43461
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 16:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50666207FB
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 16:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbi1sHIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKQzM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgIKPFu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 11 Sep 2020 11:05:50 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFD6C0617B1
        for <util-linux@vger.kernel.org>; Fri, 11 Sep 2020 06:53:59 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id j10so5197580qvk.11
        for <util-linux@vger.kernel.org>; Fri, 11 Sep 2020 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l1A3bpoVcJjvWL7Jjv3ATyXA4P37j4vj4fUJydxi+2g=;
        b=Vbi1sHIgj4zQUeNmN4CHzmae97166Z108GeBxi+YxRRY6ocAlQYxYxDUo5GSH6KVaY
         18Xa9HSg+o+D3mPWxWzf9LZQun/R98pGX3CWS5o6qidB/ZxB894eKxcpEITqsUAY7y6L
         j3vWzudjrB5h7U+yFaTSBDllz7P55N2ar0rGqp6xyksksRdAk0VcxfIsbZ+miSzzgiQg
         49pY1vpsbT/iq6MkAaKFQNtF9w5uvYeBGePlBPfOBwNRbOT9ygZ6QJZ5yAPLC9brHG0I
         gFn1WUgECquL8KgNr71LPFMcGfXh28F18+Jmjo2FwOjSUth/RHyb78c1w2Wn18OwgGVY
         sGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l1A3bpoVcJjvWL7Jjv3ATyXA4P37j4vj4fUJydxi+2g=;
        b=OdzfiyDleDIFtG0oDJnNjN8NryAPaALvOHBv+zOfVb/KLcOmhZFP24ZPSCtzL9Pdx5
         9KmNY/YWIVY3SxGTPAMr6Lok8KyYS0ptJdjjgaeyuweeV0vsksCpzCAhMKQI0G2xXSLc
         rch234GkwJI/fxFhuA3VGBYnsVfXYhwJ8ViNMPxh8MuQFvHTh6qQUjeWMQSY4zFAjIwA
         nzvaBVeFzvM/jiiBO8FeAvPvE/ZWwDgJgE3fOwCdYTVqoiaxLEghVqljkh/g+iKr2FeI
         H3jaulnTaoqO8cKhEPtGvAp89N3k/frfw6wqXrcOgeaj+Hzv650pPEXRnPCPtY8eOuOg
         d5KA==
X-Gm-Message-State: AOAM533B3eXbAOhLu0JdgUPzfDSHiWuty09rNQMVyVZylaOxgkOu+m4L
        KpI4oluKbWCXleHj78oNAN9vMpLcDQ==
X-Google-Smtp-Source: ABdhPJzYKfC1t6DrunLV8C98AcXPnPGIgG8X0Pzz97+8c+O61Jx3PlermYpLyja5vhfHmLMBz9DaDg==
X-Received: by 2002:a05:6214:17ca:: with SMTP id cu10mr2053306qvb.6.1599832438240;
        Fri, 11 Sep 2020 06:53:58 -0700 (PDT)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id f33sm2637350qtb.45.2020.09.11.06.53.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:53:57 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 2/4] lscpu-dmi: split to parse dmi table
Date:   Fri, 11 Sep 2020 09:53:26 -0400
Message-Id: <20200911135328.1465-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911135328.1465-1-msys.mizuma@gmail.com>
References: <20200911135328.1465-1-msys.mizuma@gmail.com>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Split out a function to parse dmi table.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu-dmi.c | 60 ++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index edf0f31e0..64aac99f5 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -42,6 +42,12 @@ struct dmi_header
 	uint8_t *data;
 };
 
+struct dmi_info {
+	char *vendor;
+	char *product;
+	char *manufacturer;
+};
+
 static void *get_mem_chunk(size_t base, size_t len, const char *devmem)
 {
 	void *p = NULL;
@@ -95,20 +101,13 @@ static char *dmi_string(const struct dmi_header *dm, uint8_t s)
 	return bp;
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
-	int rc = HYPER_NONE;
-
-	data = buf = get_mem_chunk(base, len, devmem);
-	if (!buf)
-		goto done;
 
 	 /* 4 is the length of an SMBIOS structure header */
 	while (i < num && data + 4 <= buf + len) {
@@ -132,11 +131,11 @@ static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
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
@@ -145,15 +144,36 @@ static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
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
+	int rc = HYPER_NONE;
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
 		rc = HYPER_INNOTEK;
-	else if (manufacturer && strstr(manufacturer, "HITACHI") &&
-					product && strstr(product, "LPAR"))
+	else if (di.manufacturer && strstr(di.manufacturer, "HITACHI") &&
+					di.product && strstr(di.product, "LPAR"))
 		rc = HYPER_HITACHI;
-	else if (vendor && !strcmp(vendor, "Parallels"))
+	else if (di.vendor && !strcmp(di.vendor, "Parallels"))
 		rc = HYPER_PARALLELS;
 done:
-	free(buf);
+	free(data);
 	return rc;
 }
 
-- 
2.27.0

