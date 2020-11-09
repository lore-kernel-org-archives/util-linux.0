Return-Path: <SRS0=8RqP=EP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14371C388F9
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 02:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0531206B6
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 02:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCHvQiDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgKIC6R (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 8 Nov 2020 21:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIC6R (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 8 Nov 2020 21:58:17 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22558C0613CF
        for <util-linux@vger.kernel.org>; Sun,  8 Nov 2020 18:58:17 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g15so1410151qtq.13
        for <util-linux@vger.kernel.org>; Sun, 08 Nov 2020 18:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wnvNgM5RFmMMU5jrfAWXvwOodDrxkUkvAz4SFWNE6iQ=;
        b=gCHvQiDGssAws1NdnUJJIlYJcBtDeUoZGaEefVeIxgELJQxCVS0u8dlB7VcXiqkPiu
         gOVaprD+RNeZxSl5/MDZF3ovRxXwU8StT42sgodjNIlLWwsGoiTcQt+gB0BIHPMaqsv5
         gos/M58vaYIs6pJv2Mc7dIcPHxcm264D6rLREMgXV+cgGMtMo9TqK7iUTU3NeTR7O0+3
         f1MNgAYYJR2HWwUSQ+oCw75K/GeogDAh5CE+EZTsJON6GoNoo7vn/n9z07IJcHFt7+2w
         XGoGLWNy40PswJghgL2xQ46pnXGcbfraomDxDDgNeDC6s2eDI3q9JprimobgCuuD7m1g
         11Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wnvNgM5RFmMMU5jrfAWXvwOodDrxkUkvAz4SFWNE6iQ=;
        b=h1poGgFSO1S9eJK/V09L0E06Anng0Mp285YViY99svmAdwASGUAhQsR43kSiqk7dph
         mEZwe6Lt9X7954BfwO6EyedkzSM33l/qtNUrvCt+jQT6PAJSh00/i7NZk9BbnaVxotkQ
         rnQgWlMyCcCTKiDSV32dx4X1KPU7psz+ar/zbj8kqmAOE08Fk1HuclnsvG1bUbst3M9g
         XSF4WCFYzlMM89HeVZqDyuA3MRw+xj6uBx6Ocs4zPedMy9FE+mHB+CqtdE35rfpJOsyi
         gdarw0sv8/nWKCFxkgqOExN4GCTdnS9qoxss1fvLT9yEm65cFRzWr5iYqWhba+OFj8zz
         636w==
X-Gm-Message-State: AOAM532gANizOaa6iQtHRHArjKbWSx5pyhmFNo+2KXNdrIiPiPLate2E
        g1bztKoZQD4+vQ+BAZ5dsW6SEDdv8A==
X-Google-Smtp-Source: ABdhPJz1hxo3g/CsSlpoo2hduWZ46XJrxy2iAAONerZH+viuaXMSIyScuU02wBT7GRJ+XK1PtnaPdw==
X-Received: by 2002:ac8:7316:: with SMTP id x22mr11637884qto.386.1604890696224;
        Sun, 08 Nov 2020 18:58:16 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id v14sm5296085qkb.15.2020.11.08.18.58.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 18:58:15 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org, jbastian@redhat.com
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v3 1/2] lscpu-arm: Set the order to search the model name
Date:   Sun,  8 Nov 2020 21:58:05 -0500
Message-Id: <20201109025806.26567-1-msys.mizuma@gmail.com>
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

