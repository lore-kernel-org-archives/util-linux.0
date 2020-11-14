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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808D7C5519F
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A5F2225D
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpR3NLi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKNENa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 23:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNENa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 13 Nov 2020 23:13:30 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6682C0613D1
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:28 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id y11so6050449qvu.10
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pa6m/ZIvS9l50ES0dUpeAGOCzLEkO1uFJyqraHqfz4c=;
        b=XpR3NLi+BRNJDuqk9pJ10hZV6dkrCB2JdaSG0ewi7UKmDrHpavmTliYv7mFH6Fo/uS
         jzKI1m4wXvBIX40OuYRA4hHRn+L1IFKFPCVy/pHbxpXCklpxZ1TGT6l8+SxZXWoC2egO
         BQkEzCq6FrZBtHFSS4yrIb76ECNgu3K/z8750SDrgwFciB25W0czYMu17XJCal3kxPPS
         shNItyuBPObtQysB+BypRS/Ck8N2sqYYVgTaWuTlu4XeSlTgl/yV6ERD1OYJuwG81bUu
         /S9fmfAM7+p/5tEcEcVEbFbpTa/zuA822Y++KbiZryS9F83wDfy+CFGd2aD38tcyrqtJ
         C+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pa6m/ZIvS9l50ES0dUpeAGOCzLEkO1uFJyqraHqfz4c=;
        b=h8MSBiijLZIkus7sx/6/al4dl8CH2bIfTIajGZQsWfIftK493Z9TIiTrDpZMmpEHiw
         ezB8LIjCqtG/xsIfXmt8Kxk1KxkHwuEs95GtGBBY//FLibuFlV+/Qjo5iiZVxrJ551Ye
         51SUmRSo2RU8qtilnsKr7bAcnvjMz8e1IvRbFZlBb0bWpDRxq1/h/QihGLx6dhkqvm8h
         42HkVA6tsQeJMyB7kz49VP794omBTkUJkTjadfpl8nV+eA8n6Kx7qv+HA2xJ4Uhbbk+x
         2YxM20CFd1myYeDpQgV68/YUzVSLQmy9zxeyfkDsfOZmmlsjAu7vTEZfdjq4KuYAtwkM
         IjZw==
X-Gm-Message-State: AOAM5307kMFcdSNNbj4KSCj2UpbnEudKNbRabzegTGLQlhE5BVSpTkIJ
        /nSOwC43JLmCj5UudpB4UZebvopXmQ==
X-Google-Smtp-Source: ABdhPJxFcT+NFwUnK7k609kWz6Y2epUloMqAVLHxOAVvCKw6EEYorVlGgB9zY2tKmk8+fBxmKVoI4g==
X-Received: by 2002:a0c:b59a:: with SMTP id g26mr5433898qve.26.1605327207820;
        Fri, 13 Nov 2020 20:13:27 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id e6sm8079357qtb.32.2020.11.13.20.13.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 20:13:27 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v2 3/5] lscpu-dmi: Move some functions related to DMI to lscpu-dmi
Date:   Fri, 13 Nov 2020 23:12:27 -0500
Message-Id: <20201114041229.26417-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201114041229.26417-1-msys.mizuma@gmail.com>
References: <20201114041229.26417-1-msys.mizuma@gmail.com>
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
index 32558fd9f..3b9d090a2 100644
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
index b199de3dd..565f6aee5 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -298,6 +298,8 @@ void lscpu_decode_arm(struct lscpu_cxt *cxt);
 
 int lookup(char *line, char *pattern, char **value);
 
+void *get_mem_chunk(size_t base, size_t len, const char *devmem);
+
 struct lscpu_dmi_header
 {
 	uint8_t type;
@@ -312,28 +314,8 @@ struct dmi_info {
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

