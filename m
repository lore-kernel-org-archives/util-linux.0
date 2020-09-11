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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B33C433E2
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D6C206A2
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 16:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seozOSeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgIKQrE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgIKPID (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 11 Sep 2020 11:08:03 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5730FC0617B9
        for <util-linux@vger.kernel.org>; Fri, 11 Sep 2020 06:54:00 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o5so9883582qke.12
        for <util-linux@vger.kernel.org>; Fri, 11 Sep 2020 06:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XSE9VUs8oR8WjgXCsGL/YaMg35al4Qa7gPd0mb5txNw=;
        b=seozOSeNPEBa9rn+UNB9pRLKhPeVN8UrrPOP5HV5MPgWQlJ4pcYxDIaIAhZfSSkc/F
         rkyZNhKm3l10GovEp0c0pb3cABHBysvv56e9WoiMqe+Lx9n5SedBgTJc/8V3DuPMsmyp
         vgiv0F27B+EmuRR2DZUgdrskyQKZylSTR0mN9N8a+9i+RBYk1W1DZaCADVGmIBWaZkDZ
         b0KvTkQ4l/6ZzkoNdlu/uggjzsVdKvNQHQPiPy4wF+zDXgMVtaj9iGOiF00pRODY8AHR
         rDQ8Syhr8iopRNML+4NNyF8q4UKaULMBoV5WQZJgs5GKv7m9rVFtBlcpr4+lu6ODHm1s
         VR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XSE9VUs8oR8WjgXCsGL/YaMg35al4Qa7gPd0mb5txNw=;
        b=NhRMyjqmCQRO9Jhwu652lMws/TgTSURNaxF8NiGWzijC2hkAMj99eE12EBFwm8WUiF
         6PlE/bhLC7WzHxT3u8wTlRCQCcK6rEdTfogO6gK4VxD23JPtxVX6p8kbOGPG24OxIE3Y
         yjuLtosuUcx1C3tO2O7dp5vJibREvt0GvkAFKUoFWprCBCxtfym1XIDdIve1jxPe2DbD
         GINgWvghk/D2PRfWnhbCLSI2eLjvTUjptUcemGn1sP+R4tOQqcvPuP6nYIRXj2SdfSJi
         cnlbDk8t9LHZVFx7rZDmIBTlRJzFstVB9e3MStYwevkrIa/vD3hOFenKAJ8qWuLxRlwx
         JZqg==
X-Gm-Message-State: AOAM530w0KckSSLSiSUzdMTM+jGmc94CLiqNNrQ1Xq7kZMqmzTnbVWb1
        BSqzNC0bSSxLU0X0CYEghlrjqKxD3A==
X-Google-Smtp-Source: ABdhPJzHeDZZo8aKQTmKghlYyfelkDQVMovM4xOdtTX/g6MONa8KK6X4BQ0gGPBay2NmQ4Ue5J1D/A==
X-Received: by 2002:a37:4ac9:: with SMTP id x192mr1510442qka.294.1599832439469;
        Fri, 11 Sep 2020 06:53:59 -0700 (PDT)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id p68sm2869815qkd.29.2020.09.11.06.53.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:53:59 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 3/4] lscpu: add helper to get physical sockets
Date:   Fri, 11 Sep 2020 09:53:27 -0400
Message-Id: <20200911135328.1465-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911135328.1465-1-msys.mizuma@gmail.com>
References: <20200911135328.1465-1-msys.mizuma@gmail.com>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Add a helper function, get_number_of_physical_sockets_from_dmi(),
to get physical sockets from DMI table in case of the sysfs for
cpu topology doesn't have the physical socket information.

get_number_of_physical_sockets_from_dmi() parse the DMI table
and counts the number of SMBIOS Processor Information (Type04)
structure.

Note, ARM SBBR v1.0 and newer requires SMBIOS Processor Information
(Type04). And ARM SBBR v1.2 requires ACPI PPTT which has physical socket
information. So the helper function is useful for the machine base on
SBBR v1.0 and v1.1.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu-dmi.c | 30 ++++++++++++++++++++++++++++++
 sys-utils/lscpu.h     |  1 +
 2 files changed, 31 insertions(+)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index 64aac99f5..21c557aeb 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -46,6 +46,7 @@ struct dmi_info {
 	char *vendor;
 	char *product;
 	char *manufacturer;
+	int sockets;
 };
 
 static void *get_mem_chunk(size_t base, size_t len, const char *devmem)
@@ -137,6 +138,9 @@ static int parse_dmi_table(uint16_t len, uint16_t num,
 				di->manufacturer = dmi_string(&h, data[0x04]);
 				di->product = dmi_string(&h, data[0x05]);
 				break;
+			case 4:
+				di->sockets++;
+				break;
 			default:
 				break;
 		}
@@ -330,3 +334,29 @@ int read_hypervisor_dmi(void)
 
 	return rc < 0 ? HYPER_NONE : rc;
 }
+
+int get_number_of_physical_sockets_from_dmi(void)
+{
+	static char const sys_fw_dmi_tables[] = _PATH_SYS_DMI;
+	struct dmi_info di;
+	struct stat st;
+	uint8_t *data;
+	int rc = -1;
+
+	if (stat(sys_fw_dmi_tables, &st))
+		return rc;
+
+	data = get_mem_chunk(0, st.st_size, sys_fw_dmi_tables);
+	if (!data)
+		return rc;
+
+	memset(&di, 0, sizeof(struct dmi_info));
+	rc = parse_dmi_table(st.st_size, st.st_size/4, data, &di);
+
+	free(data);
+
+	if ((rc < 0) || !di.sockets)
+		return rc;
+	else
+		return di.sockets;
+}
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 13af2ad0a..4475a3d27 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -209,6 +209,7 @@ struct lscpu_modifier {
 };
 
 extern int read_hypervisor_dmi(void);
+extern int get_number_of_physical_sockets_from_dmi(void);
 extern void arm_cpu_decode(struct lscpu_desc *desc);
 
 #endif /* LSCPU_H */
-- 
2.27.0

