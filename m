Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D93CC433EB
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBDC206E3
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeH0toEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGXKHG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKHF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 06:07:05 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E86AC0619D3
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:07:05 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q4so3398828edv.13
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8MCMj+l60383jZUY0w6m06ytuSvbswEnAprbVs1mqE=;
        b=GeH0toEcaQANWIObE4yYslzxnaNHhNE5CkrqBdhn2Bbh2Lkz3lGzgWBXWPlk7uAd6B
         rBUIbPHQsXfSY1Ro0acpaBvdkyvGTTY+pk9Kx/WXxWcPUNNg5AoCKCm73VVusg7bd1Ly
         AjtPAVn2WfkSqlFnGmTHnxr7qs5WV45mm5XU3X0M0IFjqhKbj/LA8Q8YY4Ni3FYDRcMu
         XCqIuKM+uYlSFiA3INgf9JcWjs4KxkroLI6jxtWS8VQWMUQG2xkLSa8fuyySLiseEw12
         ORRkZ/jqh45RhISSbfW3zgjTMgXXrZUCWMNLoo3ACyg3nGFYAXLyfJHUDI/Z4gOz4DMG
         kMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8MCMj+l60383jZUY0w6m06ytuSvbswEnAprbVs1mqE=;
        b=FQRceSMXA2Z/hDWM56xhI48l8V3O5dxNpukSbXz1mqZaV2uJx3F0oH63xxp6Zb1DEC
         yyjicm36nzY2ceSPyZdVMBxoxDUEI/GheabI5J/J3pRX1mxpJ5OgGxh4Q5sprULZS4sR
         q4TYWoUS75t/M8QWsAtMdz9gVdDULAeCtzaxVZ1apE+tqjRqqfnAi5iZ04zVgNkqIZg+
         /D+0ZdWan1S9NpIYsFd5l1p90VLlyjjwBajSw1+niJKzjgxlDqVXK1vrIBRh9BF+b/Jz
         maOdZdryZlxnBi3RSdbLJLTLFxa6cn12RSl1V/9wtJ/zGtna2VFySqcCrlV/YmU2Qvba
         WGPw==
X-Gm-Message-State: AOAM532hW5HRjFGGexxLSFZurxBZR65KMb0UwmilFYTx1KHG9QolrKo3
        KzYeK2LmXhp5ZO3hJYQ2fC0=
X-Google-Smtp-Source: ABdhPJyZVFEPj2e9BoK1StxGmleZOauSAOgYEZ+vrlrQ83oVZ/ujPKgXeDgVY1sI8i6wNgqRnZq9Ew==
X-Received: by 2002:aa7:db06:: with SMTP id t6mr8261836eds.369.1595585224257;
        Fri, 24 Jul 2020 03:07:04 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id cm22sm398284edb.44.2020.07.24.03.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:07:03 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 09/12] Manual pages: lsblk.8: Minor formatting and typo fixes
Date:   Fri, 24 Jul 2020 12:06:15 +0200
Message-Id: <20200724100618.584918-9-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724100618.584918-1-mtk.manpages@gmail.com>
References: <20200724100618.584918-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 misc-utils/lsblk.8 | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 3da4e2e19..891b3f088 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -13,7 +13,9 @@ command reads the
 .B sysfs
 filesystem and
 .B udev db
-to gather information. If the udev db is not available or lsblk is compiled without udev support than it
+to gather information. If the udev db is not available or
+.B lsblk
+is compiled without udev support, then it
 tries to read LABELs, UUIDs and filesystem types from the block device. In this case root permissions
 are necessary.
 .PP
@@ -41,7 +43,9 @@ might be executed in time when
 does not have all information about recently added or modified devices yet. In this
 case it is recommended to use
 .B "udevadm settle"
-before lsblk to synchronize with udev.
+before
+.B lsblk
+to synchronize with udev.
 .SH OPTIONS
 .TP
 .BR \-a , " \-\-all"
@@ -162,7 +166,8 @@ than the tree branches are sorted by the \fIcolumn\fP.
 Print the zone model for each device.
 .TP
 .BR " \-\-sysroot " \fIdirectory\fP
-Gather data for a Linux instance other than the instance from which the lsblk
+Gather data for a Linux instance other than the instance from which the
+.B lsblk
 command is issued.  The specified directory is the system root of the Linux
 instance to be inspected.  The real device nodes in the target directory can
 be replaced by text files with udev attributes.
@@ -179,7 +184,9 @@ some specified devices found, some not found
 
 .SH ENVIRONMENT
 .IP LSBLK_DEBUG=all
-enables lsblk debug output.
+enables
+.B lsblk
+debug output.
 .IP LIBBLKID_DEBUG=all
 enables libblkid debug output.
 .IP LIBMOUNT_DEBUG=all
-- 
2.26.2

