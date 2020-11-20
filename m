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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F8CC56201
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072002236F
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa/ofTPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgKTFG1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 20 Nov 2020 00:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgKTFG1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 20 Nov 2020 00:06:27 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528C7C0613CF
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:27 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id q1so7497009ilt.6
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G9reMvEahHJXoNdo3awA2pElRUv18ILqcLjGryHH0ow=;
        b=aa/ofTPPLQ58V03v0TZXkF81TgltbkMtEE8vnY7QxOFgLTSgsS3fumUQmn4SRQ81AT
         jC9iL2jzQsaV8S2IBtlEs5xJ4O4xY2e/VvQbOxRD+uB+6Nxwa202M1VqbgIR/R0zmwE0
         vcnH40eQuEJngysRqY883uRWX9vhCqhcTTzXHOOtKK5Kp00wIJAhP//3Ut7j/XlabObc
         pMye/ladQdOXb67cKy7Y8sEyLo5fPBfsL93uukNDH3ssEuqsuMoRttiElOiHsEHthP6j
         4aLmivyR6O8m/TQdTV8HzSiJNioLAXzno+ah1tWKGqNAJlEZEGZHJh60t7gnvPyywBMF
         /Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G9reMvEahHJXoNdo3awA2pElRUv18ILqcLjGryHH0ow=;
        b=PAuqvTDiQ+8kE8+MArHMtxRcbGWiOl/WlJTSxrjkIKW6MzwsjNCiEDtDEfcunSpHTb
         QR+xbnMCiCZXznQ/ZQqkVX7+aNuSiGqhBF9OamrrFMnaAI2Ni9jJ8BD5y4UD4xPBUopt
         JlVt/pKu0fEi86WmDJuT/0JGkMbsx+2OtXiG2VlVPHxcpdi12VM5CNg9GpdAbD3z53mW
         ot/GO1WTJvfLz1nycTajph7sHgRhq7V8Df/QnSo0f1troo6o2jHB7+vGbhyHfNUYnnD7
         UzkTkMNyibOO33OupoKwlLbmtbO7N1vn0YnRhBf95nqSQnjaop8a4aROK/+3fp8x2TKM
         GgkA==
X-Gm-Message-State: AOAM5319HXEK29ZyyrpXR4SPbPResF8BIIBwYRI/SYkvOai0KtzSt7Uz
        u/RmWHYV/5AOUPTZSLgKgC3tB0J2TA==
X-Google-Smtp-Source: ABdhPJzu3JGKRleJrhwRJKbo+Clq+L4EioO1VoZtVYxJ7Q7h4e25lkCAGg6YVMvMYh+JApdhug7gDg==
X-Received: by 2002:a92:5b8c:: with SMTP id c12mr25708082ilg.293.1605848786518;
        Thu, 19 Nov 2020 21:06:26 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id d23sm1101272ill.56.2020.11.19.21.06.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 21:06:25 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v3 3/5] lscpu-dmi: Move some functions related to DMI to lscpu-dmi
Date:   Fri, 20 Nov 2020 00:06:07 -0500
Message-Id: <20201120050609.17409-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120050609.17409-1-msys.mizuma@gmail.com>
References: <20201120050609.17409-1-msys.mizuma@gmail.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Move some functions related to DMI to lscpu-dmi.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/Makemodule.am |  1 +
 sys-utils/lscpu-dmi.c   | 79 +++++++++++++++++++++++++++++++++++++++++
 sys-utils/lscpu-virt.c  | 50 +-------------------------
 sys-utils/lscpu.h       | 28 +++------------
 4 files changed, 86 insertions(+), 72 deletions(-)
 create mode 100644 sys-utils/lscpu-dmi.c

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 5459a3a2e..df8fd403a 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -396,6 +396,7 @@ lscpu_SOURCES = sys-utils/lscpu.c \
 		sys-utils/lscpu-topology.c \
 		sys-utils/lscpu-virt.c \
 		sys-utils/lscpu-arm.c \
+		sys-utils/lscpu-dmi.c \
 		sys-utils/lscpu.h
 lscpu_LDADD = $(LDADD) libcommon.la libsmartcols.la $(RTAS_LIBS)
 lscpu_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
new file mode 100644
index 000000000..00d4439f8
--- /dev/null
+++ b/sys-utils/lscpu-dmi.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 FUJITSU LIMITED.  All rights reserved.
+ */
+
+#include "lscpu.h"
+
+void to_dmi_header(struct lscpu_dmi_header *h, uint8_t *data)
+{
+	h->type = data[0];
+	h->length = data[1];
+	memcpy(&h->handle, data + 2, sizeof(h->handle));
+	h->data = data;
+}
+
+char *dmi_string(const struct lscpu_dmi_header *dm, uint8_t s)
+{
+	char *bp = (char *)dm->data;
+
+	if (!s || !bp)
+		return NULL;
+
+	bp += dm->length;
+	while (s > 1 && *bp) {
+		bp += strlen(bp);
+		bp++;
+		s--;
+	}
+
+	return !*bp ? NULL : bp;
+}
+
+int parse_dmi_table(uint16_t len, uint16_t num,
+				uint8_t *data,
+				struct dmi_info *di)
+{
+	uint8_t *buf = data;
+	int rc = -1;
+	int i = 0;
+
+	 /* 4 is the length of an SMBIOS structure header */
+	while (i < num && data + 4 <= buf + len) {
+		uint8_t *next;
+		struct lscpu_dmi_header h;
+
+		to_dmi_header(&h, data);
+
+		/*
+		 * If a short entry is found (less than 4 bytes), not only it
+		 * is invalid, but we cannot reliably locate the next entry.
+		 * Better stop at this point.
+		 */
+		if (h.length < 4)
+			goto done;
+
+		/* look for the next handle */
+		next = data + h.length;
+		while (next - buf + 1 < len && (next[0] != 0 || next[1] != 0))
+			next++;
+		next += 2;
+		switch (h.type) {
+		case 0:
+			di->vendor = dmi_string(&h, data[0x04]);
+			break;
+		case 1:
+			di->manufacturer = dmi_string(&h, data[0x04]);
+			di->product = dmi_string(&h, data[0x05]);
+			break;
+		default:
+			break;
+		}
+
+		data = next;
+		i++;
+	}
+	rc = 0;
+done:
+	return rc;
+}
diff --git a/sys-utils/lscpu-virt.c b/sys-utils/lscpu-virt.c
index c86dae8c9..9b61eb6f8 100644
--- a/sys-utils/lscpu-virt.c
+++ b/sys-utils/lscpu-virt.c
@@ -52,7 +52,7 @@ static const int hv_graphics_pci[] = {
 #define WORD(x) (uint16_t)(*(const uint16_t *)(x))
 #define DWORD(x) (uint32_t)(*(const uint32_t *)(x))
 
-static void *get_mem_chunk(size_t base, size_t len, const char *devmem)
+void *get_mem_chunk(size_t base, size_t len, const char *devmem)
 {
 	void *p = NULL;
 	int fd;
@@ -76,54 +76,6 @@ nothing:
 	return NULL;
 }
 
-static int parse_dmi_table(uint16_t len, uint16_t num,
-				uint8_t *data,
-				struct dmi_info *di)
-{
-	uint8_t *buf = data;
-	int rc = -1;
-	int i = 0;
-
-	 /* 4 is the length of an SMBIOS structure header */
-	while (i < num && data + 4 <= buf + len) {
-		uint8_t *next;
-		struct lscpu_dmi_header h;
-
-		to_dmi_header(&h, data);
-
-		/*
-		 * If a short entry is found (less than 4 bytes), not only it
-		 * is invalid, but we cannot reliably locate the next entry.
-		 * Better stop at this point.
-		 */
-		if (h.length < 4)
-			goto done;
-
-		/* look for the next handle */
-		next = data + h.length;
-		while (next - buf + 1 < len && (next[0] != 0 || next[1] != 0))
-			next++;
-		next += 2;
-		switch (h.type) {
-			case 0:
-				di->vendor = dmi_string(&h, data[0x04]);
-				break;
-			case 1:
-				di->manufacturer = dmi_string(&h, data[0x04]);
-				di->product = dmi_string(&h, data[0x05]);
-				break;
-			default:
-				break;
-		}
-
-		data = next;
-		i++;
-	}
-	rc = 0;
-done:
-	return rc;
-}
-
 static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
 				uint16_t num, const char *devmem)
 {
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 11b27fb14..9ec3fca17 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -297,6 +297,8 @@ void lscpu_decode_arm(struct lscpu_cxt *cxt);
 
 int lookup(char *line, char *pattern, char **value);
 
+void *get_mem_chunk(size_t base, size_t len, const char *devmem);
+
 struct lscpu_dmi_header
 {
 	uint8_t type;
@@ -311,28 +313,8 @@ struct dmi_info {
 	char *manufacturer;
 };
 
-static inline void to_dmi_header(struct lscpu_dmi_header *h, uint8_t *data)
-{
-	h->type = data[0];
-	h->length = data[1];
-	memcpy(&h->handle, data + 2, sizeof(h->handle));
-	h->data = data;
-}
-
-static inline char *dmi_string(const struct lscpu_dmi_header *dm, uint8_t s)
-{
-	char *bp = (char *)dm->data;
-
-	if (!s || !bp)
-		return NULL;
-
-	bp += dm->length;
-	while (s > 1 && *bp) {
-		bp += strlen(bp);
-		bp++;
-		s--;
-	}
 
-	return !*bp ? NULL : bp;
-}
+void to_dmi_header(struct lscpu_dmi_header *h, uint8_t *data);
+char *dmi_string(const struct lscpu_dmi_header *dm, uint8_t s);
+int parse_dmi_table(uint16_t len, uint16_t num, uint8_t *data, struct dmi_info *di);
 #endif /* LSCPU_H */
-- 
2.27.0

