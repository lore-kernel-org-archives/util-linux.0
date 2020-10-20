Return-Path: <SRS0=06lJ=D3=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BB7C4363A
	for <util-linux@archiver.kernel.org>; Tue, 20 Oct 2020 17:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E775F2222D
	for <util-linux@archiver.kernel.org>; Tue, 20 Oct 2020 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqFtnLEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395369AbgJTRZZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Oct 2020 13:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395362AbgJTRZZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 20 Oct 2020 13:25:25 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A36BC0613CE
        for <util-linux@vger.kernel.org>; Tue, 20 Oct 2020 10:25:25 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y17so330132ilg.4
        for <util-linux@vger.kernel.org>; Tue, 20 Oct 2020 10:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2Benu2Z9Iv5c4+hD5Yt1vpnhhmALFq3RBjeTAawo67g=;
        b=PqFtnLEuSyjfOo38d59/N+JUd4IiFEmMbwjph/uVfcN+Bm2ksRB74rMGNGqH5d8wbt
         XZDTUrKynbOCY2Awcre03VeGTZIIMtY4cW21KpYuPkCb/IJrOMNfr/zODgcMH0Zd+t9V
         jrarq0wIBa2YBN2l6K3M99ifgwlL1VD1pKaI7LCptf/7DwdatAFiNyRFOzi46OCoj4dJ
         wZCBw5+1RLTOOCzNtdNpw1UZrHR1/G55eslrnMBg0Egspx+oKwo8ltoAejFkcHV9pRXu
         vVpzku56SsLuIXQxnsqombJx5MHN1o533j3+2ozJzJxQdqxnlM4lfMnk9cErLP3RuILQ
         pCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Benu2Z9Iv5c4+hD5Yt1vpnhhmALFq3RBjeTAawo67g=;
        b=KA5zQwqaN3qRwG7rA5SV0mXfRkvH6ZdWUKc9nkvjX17dXjZXG3tyusldYCSGkex5eV
         9mOxwOBtdHV2yR+Vk0rgzbddDHxAwSI7OFiryKE457/KWA7mCjDkBh778D39zCB9jPQs
         X5Gzx10GW4FYMC/aF4mSwWoDjUrpQosJocbLGAPQWjDdW2T8ntB/Uq7Zuhf7bR3nyYV2
         MrgzcPhmiQ3IdNNAEyy+QfrORwiiKlmqgiGbIwKk2W4rTkZ9XRG1enYcqXmjxXxv8IDS
         6ttFXhfXU4EdJKEDh6kByeSxSJ8xewCj84fVlRRi2kiYfbOGnBYKy/cFM7GEEHJof2HX
         WeWg==
X-Gm-Message-State: AOAM5309oo/1szI8YJ1gjFGutcYGlBAFC+f9P0vwG3Xl0KZvPWdK5W2z
        5Tmm2BEdLiuLu4KCfdpYxZ1ZXz8X/w==
X-Google-Smtp-Source: ABdhPJw/WiGFiEiuWtFHExlz+xTVuABhiGkquK/aEkC1Dr0IDYdAANrMwSeqUL9dR42v3dYDTnJAAQ==
X-Received: by 2002:a05:6e02:11a8:: with SMTP id 8mr2852712ilj.145.1603214724259;
        Tue, 20 Oct 2020 10:25:24 -0700 (PDT)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id x13sm2055385iox.31.2020.10.20.10.25.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 10:25:23 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v2] lscpu-arm: Set the order to search the model name
Date:   Tue, 20 Oct 2020 13:25:10 -0400
Message-Id: <20201020172510.9714-1-msys.mizuma@gmail.com>
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

The SMBIOS info would be great if the system is based on SBBR v1.2E and
BBR v1.0 because the specs require the Processor Version of SMBIOS
as "This field must provide a human readable description of the processor
part number".

However, it's not good for the systems aren't based on the specs,
like A64FX. Such systems need to have the model name to the hard
corded table.

Let's set the order; first, search the hard corded table, then SMBIOS.

Note, some systems, like APM X-Gene and Altra, may not match the information
between MIDR register (/proc/cpuinfo) and SMBIOS. To be consistency,
use Processor Manufacturer of SMBIOS when Processor Version is used
even if the hard corded table has the vendor id.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu-arm.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 20c7291e5..7812de96f 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -83,7 +83,6 @@ static const struct id_part arm_part[] = {
     { 0xd13, "Cortex-R52" },
     { 0xd20, "Cortex-M23" },
     { 0xd21, "Cortex-M33" },
-    { 0xd4a, "Neoverse-E1" },
     { -1, "unknown" },
 };
 
@@ -110,7 +109,6 @@ static const struct id_part cavium_part[] = {
 };
 
 static const struct id_part apm_part[] = {
-    { 0x000, "X-Gene" },
     { -1, "unknown" },
 };
 
@@ -288,6 +286,7 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
 	struct lscpu_dmi_header h;
 	int fd;
 	ssize_t rs;
+	int use_smbios = 0;
 
 	fd = open(_PATH_SYS_DMI_TYPE4, O_RDONLY);
 	if (fd < 0)
@@ -301,16 +300,21 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
 
 	to_dmi_header(&h, data);
 
-	str = dmi_string(&h, data[PROC_MFR_OFFSET]);
-	if (str) {
-		xstrncpy(buf, str, 127);
-		desc->vendor = xstrdup(buf);
+	if (!desc->modelname) {
+		str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
+		if (str) {
+			xstrncpy(buf, str, 127);
+			desc->modelname = xstrdup(buf);
+			use_smbios = 1;
+		}
 	}
 
-	str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
-	if (str) {
-		xstrncpy(buf, str, 127);
-		desc->modelname = xstrdup(buf);
+	if ((startswith(desc->vendor, "0x")) || use_smbios) {
+		str = dmi_string(&h, data[PROC_MFR_OFFSET]);
+		if (str) {
+			xstrncpy(buf, str, 127);
+			desc->vendor = xstrdup(buf);
+		}
 	}
 
 	return 0;
@@ -318,14 +322,11 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
 
 void arm_cpu_decode(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 {
-	int rc = -1;
+	__arm_cpu_decode(desc);
 
 	/* use SMBIOS Type 4 data if available,
 	 * else fall back to manual decoding using the tables above */
 	if (mod->system == SYSTEM_LIVE &&
 	    access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
-		rc = __arm_cpu_smbios(desc);
-
-	if (rc)
-		__arm_cpu_decode(desc);
+		__arm_cpu_smbios(desc);
 }
-- 
2.27.0

