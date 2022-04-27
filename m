Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F04FC433FE
	for <util-linux@archiver.kernel.org>; Wed, 27 Apr 2022 17:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243759AbiD0RJM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbiD0RI5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 Apr 2022 13:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E30071126
        for <util-linux@vger.kernel.org>; Wed, 27 Apr 2022 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651079144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLcUWyzQ8L5CZTpzZsSR9pF/4WVzDxYCVQkwmNC0F7g=;
        b=VnVgHKXwepGGaQY6l53gI9jq0M9F9zdRVZsu2Lnb80bK7112TdzusrsIzYwP99vtt8H1ev
        1z7Dce239jenHW0+aApHKqlrlZ9i/UWxVB3FpRxQjn+1udVQJ6vJvgN9/oI+hZkHRkb7iv
        uMVCj4Ahg9/weUqfXW7i5noXg3f8CEI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-Zibp0UGvO2enWfVE7LgrqA-1; Wed, 27 Apr 2022 13:05:43 -0400
X-MC-Unique: Zibp0UGvO2enWfVE7LgrqA-1
Received: by mail-wm1-f72.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso792776wmq.3
        for <util-linux@vger.kernel.org>; Wed, 27 Apr 2022 10:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLcUWyzQ8L5CZTpzZsSR9pF/4WVzDxYCVQkwmNC0F7g=;
        b=lMnodk73eePPrCMR7gpF/1F9axBCuNABSFjTnn04htgFqgDYQRL/0Y2trjT9wcHEOg
         M31T2IS49078XBWVyT+rWwLq6Hu4Qc9Ec592dNoBzqmQ1r2wHV6mb5OuQRQsMcjxBCmi
         sH6o+aycixfie5GPqdmAxQtDeixYgSeLY+oRWZFPtrDdrgmYuPyFDE7Ko+Nc8+13pV/R
         YRNjfrZlRh9WZKb21Y9hxh4FKFpoAHSceSte/8WajS1z0vwenduseKlyDx6kE8GmQdQo
         KQEf35qwb8OEAmDfXQxXuSwOWpKn8pmjpPxo9sx9ako49W+/A+2HXuJZSUG2KIeQFPMy
         Aqiw==
X-Gm-Message-State: AOAM533/4yQX+E91tLsxY2oT+hEal1/z3Tvn3tOw0zRgM7xKBLQZFx9Q
        cG9lwhyKIaTvY+8snWZyBNENeSOynGmDK74qZoVQxP9zXtHb0qPvtWzLbeT2NCF1aN0vOpp+9vr
        eqavsF2uKyKX1o9whg9xKcBEnzmMmww4NyOC6TrpnKuhfTL2WJICbvJkdHt3WObdUmUuPy5r9
X-Received: by 2002:a7b:c5d6:0:b0:381:4127:84d3 with SMTP id n22-20020a7bc5d6000000b00381412784d3mr35646378wmk.24.1651079141645;
        Wed, 27 Apr 2022 10:05:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHl9FmWyEElvFDeIY1aq8TxoMkwUOYWN/appLMc7JdqmPnEe+TNkmPjFrLGBXXAL9BYKeVEA==
X-Received: by 2002:a7b:c5d6:0:b0:381:4127:84d3 with SMTP id n22-20020a7bc5d6000000b00381412784d3mr35646360wmk.24.1651079141388;
        Wed, 27 Apr 2022 10:05:41 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d604e000000b0020af46b0ffbsm288582wrt.9.2022.04.27.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:05:40 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH 1/4] libblkid: add FSLASTBLOCK field interface showing area occupied by fs
Date:   Wed, 27 Apr 2022 19:05:11 +0200
Message-Id: <20220427170514.317720-2-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220427170514.317720-1-aalbersh@redhat.com>
References: <20220427170514.317720-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add interface to let filesystem set FSLASTBLOCK which is basically
total number of fsblocks (area occupied by fs). Enable that field in
the 'superblocks' sample.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 libblkid/samples/superblocks.c         |  3 ++-
 libblkid/src/blkid.h.in                | 23 ++++++++++++-----------
 libblkid/src/superblocks/superblocks.c | 13 +++++++++++++
 libblkid/src/superblocks/superblocks.h |  1 +
 4 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/libblkid/samples/superblocks.c b/libblkid/samples/superblocks.c
index 38903ecee..b7f94ec14 100644
--- a/libblkid/samples/superblocks.c
+++ b/libblkid/samples/superblocks.c
@@ -44,7 +44,8 @@ int main(int argc, char *argv[])
 			BLKID_SUBLKS_UUID | BLKID_SUBLKS_UUIDRAW |
 			BLKID_SUBLKS_TYPE | BLKID_SUBLKS_SECTYPE |
 			BLKID_SUBLKS_USAGE | BLKID_SUBLKS_VERSION |
-			BLKID_SUBLKS_MAGIC | BLKID_SUBLKS_FSSIZE);
+			BLKID_SUBLKS_MAGIC | BLKID_SUBLKS_FSSIZE |
+			BLKID_SUBLKS_FSLASTBLOCK);
 
 	rc = blkid_do_safeprobe(pr);
 	if (rc == -1)
diff --git a/libblkid/src/blkid.h.in b/libblkid/src/blkid.h.in
index ad4becf0a..56e64f9ab 100644
--- a/libblkid/src/blkid.h.in
+++ b/libblkid/src/blkid.h.in
@@ -271,17 +271,18 @@ extern int blkid_superblocks_get_name(size_t idx, const char **name, int *usage)
 extern int blkid_probe_enable_superblocks(blkid_probe pr, int enable)
 			__ul_attribute__((nonnull));
 
-#define BLKID_SUBLKS_LABEL	(1 << 1) /* read LABEL from superblock */
-#define BLKID_SUBLKS_LABELRAW	(1 << 2) /* read and define LABEL_RAW result value*/
-#define BLKID_SUBLKS_UUID	(1 << 3) /* read UUID from superblock */
-#define BLKID_SUBLKS_UUIDRAW	(1 << 4) /* read and define UUID_RAW result value */
-#define BLKID_SUBLKS_TYPE	(1 << 5) /* define TYPE result value */
-#define BLKID_SUBLKS_SECTYPE	(1 << 6) /* define compatible fs type (second type) */
-#define BLKID_SUBLKS_USAGE	(1 << 7) /* define USAGE result value */
-#define BLKID_SUBLKS_VERSION	(1 << 8) /* read FS type from superblock */
-#define BLKID_SUBLKS_MAGIC	(1 << 9) /* define SBMAGIC and SBMAGIC_OFFSET */
-#define BLKID_SUBLKS_BADCSUM	(1 << 10) /* allow a bad checksum */
-#define BLKID_SUBLKS_FSSIZE	(1 << 11) /* read and define FSSIZE from superblock */
+#define BLKID_SUBLKS_LABEL		(1 << 1) /* read LABEL from superblock */
+#define BLKID_SUBLKS_LABELRAW		(1 << 2) /* read and define LABEL_RAW result value*/
+#define BLKID_SUBLKS_UUID		(1 << 3) /* read UUID from superblock */
+#define BLKID_SUBLKS_UUIDRAW		(1 << 4) /* read and define UUID_RAW result value */
+#define BLKID_SUBLKS_TYPE		(1 << 5) /* define TYPE result value */
+#define BLKID_SUBLKS_SECTYPE		(1 << 6) /* define compatible fs type (second type) */
+#define BLKID_SUBLKS_USAGE		(1 << 7) /* define USAGE result value */
+#define BLKID_SUBLKS_VERSION		(1 << 8) /* read FS type from superblock */
+#define BLKID_SUBLKS_MAGIC		(1 << 9) /* define SBMAGIC and SBMAGIC_OFFSET */
+#define BLKID_SUBLKS_BADCSUM		(1 << 10) /* allow a bad checksum */
+#define BLKID_SUBLKS_FSSIZE		(1 << 11) /* read and define FSSIZE from superblock */
+#define BLKID_SUBLKS_FSLASTBLOCK	(1 << 12) /* read and define FSLASTBLOCK from superblock */
 
 #define BLKID_SUBLKS_DEFAULT	(BLKID_SUBLKS_LABEL | BLKID_SUBLKS_UUID | \
 				 BLKID_SUBLKS_TYPE | BLKID_SUBLKS_SECTYPE)
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index adf4ee025..5b899a830 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -68,6 +68,8 @@
  *
  * @FSSIZE: size of filesystem (implemented for XFS only)
  *
+ * @FSLASTBLOCK: last fsblock/total number of fsblocks
+ *
  * @SYSTEM_ID: ISO9660 system identifier
  *
  * @PUBLISHER_ID: ISO9660 publisher identifier
@@ -595,6 +597,17 @@ int blkid_probe_set_fssize(blkid_probe pr, uint64_t size)
 	return blkid_probe_sprintf_value(pr, "FSSIZE", "%" PRIu64, size);
 }
 
+int blkid_probe_set_fslastblock(blkid_probe pr, uint64_t lastblock)
+{
+	struct blkid_chain *chn = blkid_probe_get_chain(pr);
+
+	if (!(chn->flags & BLKID_SUBLKS_FSLASTBLOCK))
+		return 0;
+
+	return blkid_probe_sprintf_value(pr, "FSLASTBLOCK", "%" PRIu64,
+			lastblock);
+}
+
 int blkid_probe_set_id_label(blkid_probe pr, const char *name,
 			     const unsigned char *data, size_t len)
 {
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 67803679f..251e2e386 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -112,6 +112,7 @@ extern int blkid_probe_set_utf8_id_label(blkid_probe pr, const char *name,
 
 int blkid_probe_set_block_size(blkid_probe pr, unsigned block_size);
 int blkid_probe_set_fssize(blkid_probe pr, uint64_t size);
+int blkid_probe_set_fslastblock(blkid_probe pr, uint64_t lastblock);
 
 extern int blkid_probe_is_bitlocker(blkid_probe pr);
 extern int blkid_probe_is_ntfs(blkid_probe pr);
-- 
2.27.0

