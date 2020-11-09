Return-Path: <SRS0=8RqP=EP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3298DC388F9
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 03:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBB3206E3
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 03:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJs1yx3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKIDES (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 8 Nov 2020 22:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIDES (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 8 Nov 2020 22:04:18 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B691FC0613CF
        for <util-linux@vger.kernel.org>; Sun,  8 Nov 2020 19:04:16 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id l2so6805838qkf.0
        for <util-linux@vger.kernel.org>; Sun, 08 Nov 2020 19:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JrIPkzFWDKzcRBQtw5Gg9Y7XdVhYai4Kk1vdM1b2imQ=;
        b=XJs1yx3HxA65ngEhkW1ygNNmZlu/hxRtt9cR8uPxrWutohztXdgPS2/hcW3q52Kpr2
         hJV1h7PBhXShXDgXxVu2Iz+ngs5p5vyjDYSATVslZDppl3SBGJixHq2BYxffV8WHSlpM
         rV88h9zr1t1IFRahut16rFrvQLpkIYBkFKuB/htP205IW6W1QSVVtMFzHgBWgsr1vck3
         52ovnwa87qE3RrdmsxBiFnoUGOdSI0EOuaJX8y/wWORXRgQjXiiwRbJLevt1uwd/ZZ7e
         QtvI8U47AmZuU8txpyXF3O0Cuvw4N3dz4Zyv2rFNZGAB6/dNIapgzVtG01AY++9fMIL5
         0hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JrIPkzFWDKzcRBQtw5Gg9Y7XdVhYai4Kk1vdM1b2imQ=;
        b=btAdDANAGcB4/r07VuqQfQbf3qKhj75Lkv6h4kzAV2gPCg8ccSDouS/o8ND1nNP9Dw
         XiaStQf83vsRaT0ecey5PDaeCrWTLqb1/aIR1gbooZN7unsNnCkS4qL5eDkQcoelH3w1
         qFhoXUhcrviAzWD1gjf5Txda6A7EuiDZFrRoNp0/QIfhxRYAnFutM+i1HuBlC29jUopp
         qupzUda69LSys+cly/WTTeQ19smGXuHIKG6RBNc4w/dszGDWN2r84VR5RXNRUMKVehcQ
         GNQUKMm6mGvO87XyH1KI8P30bvwze8qd+4rcaewoNGqCG2cSqcC0Is0toF+W1rllnaor
         6Uhg==
X-Gm-Message-State: AOAM5338Vka2zdlK2d0XF8LsaBJzMD2tdjtk4omeKRoPBn76bbngHOI5
        IAhwg824diONF0jiJWm5fXYvRF17ZA==
X-Google-Smtp-Source: ABdhPJwsS2K45danxcDIIl2Hi+A6SM/Uh41pywDecVrX4dQwuSJkdhNYtx18V9f0LsIl7HpRL+3gAQ==
X-Received: by 2002:a37:bb05:: with SMTP id l5mr11727638qkf.73.1604891055872;
        Sun, 08 Nov 2020 19:04:15 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id w25sm5490989qkj.85.2020.11.08.19.04.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 19:04:15 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org, jbastian@redhat.com
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v4 1/2] lscpu-arm: Set the order to search the model name
Date:   Sun,  8 Nov 2020 22:04:02 -0500
Message-Id: <20201109030403.26821-1-msys.mizuma@gmail.com>
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

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu-arm.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 20c7291e5..3f258a710 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -288,6 +288,7 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
 	struct lscpu_dmi_header h;
 	int fd;
 	ssize_t rs;
+	int use_smbios = 0;
 
 	fd = open(_PATH_SYS_DMI_TYPE4, O_RDONLY);
 	if (fd < 0)
@@ -301,16 +302,21 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
 
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
@@ -318,14 +324,11 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
 
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

