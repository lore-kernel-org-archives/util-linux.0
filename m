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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72680C5519F
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3142236F
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ6ZwVLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgKTFG3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 20 Nov 2020 00:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgKTFG3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 20 Nov 2020 00:06:29 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAF1C0613CF
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:29 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x18so7514262ilq.4
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iKB63idP+MhibJvG130OHebKXAAM/ZQdonPjJw1OMfM=;
        b=BZ6ZwVLe/51mBK9cs7QPTFbmybN9a/IWCmmkFad4eEZ2S05ggngF+nND+dwXnZjfJE
         yUOgWeBMQ/8cmHsrLJaR4pu5dJg8MXX7GfkMtwnm2ebnd4d0BZxNof2FMjeKTcCIx3R3
         QEAsPTiH6Vav1AxvMLSM0hCeBCTAnz2H97MrclTCPk2E1qTbI5EdrTmteY6hJfeDZgxy
         XObn86j46JwrwiPmTUCuTXm9HGyWattJr5+Xv1+WVZlMfIsaeVdsnCT8TipxAZpagsNP
         V9E4XXTusmxf/UG0Ulh4GTiXZ91y6ilx/boEHU4gQD/t4ssHD4s/Y0TSr1HqdclRz1TL
         tBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iKB63idP+MhibJvG130OHebKXAAM/ZQdonPjJw1OMfM=;
        b=c+DBT2Ga7gUAKGXWKIh66rLMfWtQHm0/O8l6iRPdQrpd4BqJly8lfACnNTT3FNHtCD
         tp52cIQvHFmgzuh9KJTvbWUwaltwi1qItrH3g1DqfFk7gayYx/EknwS18jPwSOdvZyb0
         I3UguiI170tlc4aQUABUfIuiRWGT/TBIy0r/VtUfLYdrlZ6Mhk2aHICkYWMgRJlR2cs1
         4mAlV8xwLlwXAfgOmG0+ZQK1GNmpwpz6G/QURFYy5e1XKd4L+XgYj/U22E0mzFKXejrb
         OAUwMx8ZZtAvLhlv7Jcb3BeiP5IQEH/4l/iFrW6CRf8IdIRak1obxCeHMs8nxigBxrzc
         BE1w==
X-Gm-Message-State: AOAM5332XG7cciD96loIxAe14+PKq+Lbycy61ZfZhKipoqBuCHC8kV2M
        54/SGgzvDnryOfg/SjCLa13WA1U9IQ==
X-Google-Smtp-Source: ABdhPJyn/v0eudXQntASOj4Nqeg52ZdYIuPIwBsUg3nMJQ+MdxFxDHXd1AHu4yhw+4VBiumUDSad9Q==
X-Received: by 2002:a92:d03:: with SMTP id 3mr9056079iln.197.1605848788303;
        Thu, 19 Nov 2020 21:06:28 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id u12sm1020129ilg.10.2020.11.19.21.06.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 21:06:27 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v3 4/5] lscpu: add helper to get physical sockets
Date:   Fri, 20 Nov 2020 00:06:08 -0500
Message-Id: <20201120050609.17409-5-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120050609.17409-1-msys.mizuma@gmail.com>
References: <20201120050609.17409-1-msys.mizuma@gmail.com>
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

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu-dmi.c | 29 +++++++++++++++++++++++++++++
 sys-utils/lscpu.h     |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index 00d4439f8..e7ffa88d3 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -66,6 +66,9 @@ int parse_dmi_table(uint16_t len, uint16_t num,
 			di->manufacturer = dmi_string(&h, data[0x04]);
 			di->product = dmi_string(&h, data[0x05]);
 			break;
+		case 4:
+			di->sockets++;
+			break;
 		default:
 			break;
 		}
@@ -77,3 +80,29 @@ int parse_dmi_table(uint16_t len, uint16_t num,
 done:
 	return rc;
 }
+
+size_t get_number_of_physical_sockets_from_dmi(void)
+{
+	static char const sys_fw_dmi_tables[] = _PATH_SYS_DMI;
+	struct dmi_info di;
+	struct stat st;
+	uint8_t *data;
+	int rc = 0;
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
+		return 0;
+	else
+		return di.sockets;
+}
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 9ec3fca17..74c647e3a 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -311,10 +311,12 @@ struct dmi_info {
 	char *vendor;
 	char *product;
 	char *manufacturer;
+	int sockets;
 };
 
 
 void to_dmi_header(struct lscpu_dmi_header *h, uint8_t *data);
 char *dmi_string(const struct lscpu_dmi_header *dm, uint8_t s);
 int parse_dmi_table(uint16_t len, uint16_t num, uint8_t *data, struct dmi_info *di);
+size_t get_number_of_physical_sockets_from_dmi(void);
 #endif /* LSCPU_H */
-- 
2.27.0

