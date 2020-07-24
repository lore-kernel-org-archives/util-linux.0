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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E599CC433E1
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE70E2065C
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqrxTi8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgGXKG2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKG2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 06:06:28 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB7C0619D3
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:06:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n22so9405712ejy.3
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85ZduUNEctsWQjxcTp7NgRbhTN+O50BuJtufgMGzBQ8=;
        b=AqrxTi8UxGPcaP22PlRTp55NQ2Ot5Yj329X7EtSc6TI+NAJDCJAEL+yNJWQavl3UKe
         wIxf9goztPLVKXT+iyzxyZerw/EdfoEcI7dS5Uhla0HFRDng1mrH1XCFxXEtSEY2RgJO
         kVGHJ/tEI1uHIgCnja9iJEtV9PHJo30ue/Wv3QytzHWn/9aw5PxtJnwJ/PulJGlRj5kI
         TJGF/KpHIxwhdA2Fd95Ay719xzC074jFraRDrTHVnfON0K8ElmgdPYOK4w3SmtX47+It
         8sqSmifsemtxfN09+sznO0aAv6rKWvu/4PDD1f4FJe5SVm+4TLcrMmyCKjBc/zrFl//H
         RG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85ZduUNEctsWQjxcTp7NgRbhTN+O50BuJtufgMGzBQ8=;
        b=h1YPJUDhalEQlRY3Fucgr+M4bnqJCKqD2HMl3BIFbOoi4dDJrQ1yJ2gcTM0LW02Cs9
         N00UTU/fkuna++a9HOjw2r2GyBblg+k1P7FsTlPL+d3U8l86ZOwUO1+KIfCf9cGvdB8b
         9vHPKCN+B0jPp6QvCsSoWBUMgT9iVES/vqF7+CjyBqqv9IzoVR3qakaYH4QjoHTavPcc
         KssO+01Pa3WnNgG/A/23xaLg2urVcZZfnGUcYJRRggyVEDjz8aoEJyVdSSumNhGKbEUn
         7CnWXSHbM678KK5/gj/cbkj18+TMqmtpguquu69nXuypu+Rg6Sl6buvE1HLoLZyeDBdA
         SUuA==
X-Gm-Message-State: AOAM533Y9iSG+Gu40VBjXx5jDd2OyDNZohziUQBWhWKdiH5yiGgVf2Du
        dtQOutfkzzCIzWusl1qhj7s=
X-Google-Smtp-Source: ABdhPJxpei3XPp2wYoNf9kKxdo4dRbrp0Q1qpq2NIDt3ImvvqreXfXuwsg06QIILh43vFU67qX4M8Q==
X-Received: by 2002:a17:907:11dd:: with SMTP id va29mr6980735ejb.470.1595585185470;
        Fri, 24 Jul 2020 03:06:25 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id b24sm449098edn.33.2020.07.24.03.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:06:24 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 01/12] Manual pages: blockdev.8: Minor wording and formatting fixes
Date:   Fri, 24 Jul 2020 12:06:07 +0200
Message-Id: <20200724100618.584918-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 disk-utils/blockdev.8 | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/disk-utils/blockdev.8 b/disk-utils/blockdev.8
index 361e6aad7..44ed9e1e9 100644
--- a/disk-utils/blockdev.8
+++ b/disk-utils/blockdev.8
@@ -31,7 +31,9 @@ Be quiet.
 Be verbose.
 .IP "\fB\-\-report\fP"
 Print a report for the specified device. It is possible to give multiple
-devices. If none is given, all devices which appear in /proc/partitions are
+devices. If none is given, all devices which appear in
+.I /proc/partitions
+are
 shown. Note that the partition StartSec is in 512-byte sectors.
 .IP "\fB\-h\fR, \fB\-\-help\fR"
 Display help text and exit.
@@ -44,8 +46,9 @@ Flush buffers.
 .IP "\fB\-\-getalignoff\fP"
 Get alignment offset.
 .IP "\fB\-\-getbsz\fP"
-Print blocksize in bytes.  This size does not describe device topology.  It's
-size used internally by kernel and it maybe modified (for example) by
+Print the blocksize in bytes.
+This size does not describe device topology.  It's
+the size used internally by ithe kernel and it may be modified (for example) by
 filesystem driver on mount.
 .IP "\fB\-\-getdiscardzeroes\fP"
 Get discard zeroes support status.
@@ -66,7 +69,9 @@ Get read-only. Print 1 if the device is read-only, 0 otherwise.
 .IP "\fB\-\-getsize64\fP"
 Print device size in bytes.
 .IP "\fB\-\-getsize\fP"
-Print device size (32-bit!) in sectors. Deprecated in favor of the \-\-getsz option.
+Print device size (32-bit!) in sectors. Deprecated in favor of the
+.B \-\-getsz
+option.
 .IP "\fB\-\-getss\fP"
 Print logical sector size in bytes \(en usually 512.
 .IP "\fB\-\-getsz\fP"
@@ -76,14 +81,21 @@ Reread partition table
 .IP "\fB\-\-setbsz\fP \fIbytes\fP"
 Set blocksize. Note that the block size is specific to the current file
 descriptor opening the block device, so the change of block size only persists
-for as long as blockdev has the device open, and is lost once blockdev exits.
+for as long as
+.B blockdev
+has the device open, and is lost once
+.B blockdev
+exits.
 .IP "\fB\-\-setfra\fP \fIsectors\fP"
-Set filesystem readahead (same like \-\-setra on 2.6 kernels).
+Set filesystem readahead (same as
+.B \-\-setra
+on 2.6 kernels).
 .IP "\fB\-\-setra\fP \fIsectors\fP"
 Set readahead (in 512-byte sectors).
 .IP "\fB\-\-setro\fP"
-Set read-only. The currently active access to the device may not be affected by the change. For example
-filesystem already mounted in read-write mode will not be affected. The change applies after remount.
+Set read-only. The currently active access to the device may not be affected by the change. For example,
+a filesystem already mounted in read-write mode will not be affected.
+The change applies after remount.
 .IP "\fB\-\-setrw\fP"
 Set read-write.
 .SH AUTHORS
-- 
2.26.2

