Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDFBC433F5
	for <util-linux@archiver.kernel.org>; Mon, 25 Apr 2022 15:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbiDYPMJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Apr 2022 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241907AbiDYPMI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Apr 2022 11:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BCA26E4CD
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650899341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H7tYJMb0jsXOHo3eQppUqX7iNfnsSGLPf7FsMTYRWag=;
        b=O388CWfSqmtrzS4bR7/kQ1H4Gggvc0TVfMiyaJTj1EwXE3R+STZOLhOt+Xm6hgFRlXqdDm
        nt826pbZrtoprBBNs8+FmT+5prUgb1yaPrMMt9/PKsCTzIYl7lp9CIRe4h6gnfHVrkSVr7
        5wigORBN9tKYelmW146W4omaRuqUn3M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-nPDDO0juPLqJI3Q4nxmakg-1; Mon, 25 Apr 2022 11:08:59 -0400
X-MC-Unique: nPDDO0juPLqJI3Q4nxmakg-1
Received: by mail-ej1-f69.google.com with SMTP id dt18-20020a170907729200b006f377ebe5cbso2668662ejc.22
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 08:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7tYJMb0jsXOHo3eQppUqX7iNfnsSGLPf7FsMTYRWag=;
        b=3Cm4+SQTq2PUdwzYcaZFQfMUEoGQp+sHoPfp1T03F60kFDTRdMLcUfuhMNw+rIGeBt
         htRSI4CX8hkIx5cBKYeh5JfldMNfgm3VWK8UxaYrmIXPo0lnYoHl4mPC6h88URVMmg8z
         ip9wIv6B6CGDRtbX2GXvwh3+TqZjxVFXIZetbfxcnxDzU5tiVC81Cf843WQj+ihfB24J
         dHKF3cxop+Wkmh84+QJ1XC4TQRbyxOVtwLvjCC5ESWgbekTBtUEReh9tv8knqedJl3kc
         igjAk92ZucA6DJ0+ZJJdWiYzrH9PsDPz7w9eqHkA8P+UXI02UZrFPpwpmJQGsnFQI6P2
         TA5A==
X-Gm-Message-State: AOAM533szSjPj8a+LFo8VR1pha1qLIuuc0FIsuf1SFW7FHVMeHMcKubB
        GYMhbe7SSM+ayXT4hCqeot12dKvj5iN9R1l/EiTiUfFW3fGKuTKtOCDAZzNIixv5vAMW/f2OY8Z
        EFsIpqwylyb5FvLqFD4OUZ1k2BO8TofwqDLAlWg0oxCk7e4sBvX6tIXWOVxWL/SO736z0k8bu
X-Received: by 2002:a17:907:1c92:b0:6f0:f17:14a with SMTP id nb18-20020a1709071c9200b006f00f17014amr16245525ejc.475.1650899337889;
        Mon, 25 Apr 2022 08:08:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZNEy8kI9dMqXjETtjhTLnW0uzfj7Wc1hFGOWukbNGL+Vt3gcO4zJjg1FJaTV6dO63Yg9T8w==
X-Received: by 2002:a17:907:1c92:b0:6f0:f17:14a with SMTP id nb18-20020a1709071c9200b006f00f17014amr16245502ejc.475.1650899337630;
        Mon, 25 Apr 2022 08:08:57 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id i19-20020a1709061cd300b006f38920dbeesm1776878ejh.134.2022.04.25.08.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:08:56 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 1/3] libblkid: add interface for FSSIZE field
Date:   Mon, 25 Apr 2022 17:08:37 +0200
Message-Id: <20220425150838.151020-2-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220425150838.151020-1-aalbersh@redhat.com>
References: <20220425150838.151020-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add interface to let filesystem probe calculate and set FSSIZE.
Enable that field in the 'superblocks' sample.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 libblkid/samples/superblocks.c         |  2 +-
 libblkid/src/blkid.h.in                |  1 +
 libblkid/src/superblocks/superblocks.c | 11 +++++++++++
 libblkid/src/superblocks/superblocks.h |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/libblkid/samples/superblocks.c b/libblkid/samples/superblocks.c
index 7d9555771..38903ecee 100644
--- a/libblkid/samples/superblocks.c
+++ b/libblkid/samples/superblocks.c
@@ -44,7 +44,7 @@ int main(int argc, char *argv[])
 			BLKID_SUBLKS_UUID | BLKID_SUBLKS_UUIDRAW |
 			BLKID_SUBLKS_TYPE | BLKID_SUBLKS_SECTYPE |
 			BLKID_SUBLKS_USAGE | BLKID_SUBLKS_VERSION |
-			BLKID_SUBLKS_MAGIC);
+			BLKID_SUBLKS_MAGIC | BLKID_SUBLKS_FSSIZE);
 
 	rc = blkid_do_safeprobe(pr);
 	if (rc == -1)
diff --git a/libblkid/src/blkid.h.in b/libblkid/src/blkid.h.in
index 3cd4116d9..ad4becf0a 100644
--- a/libblkid/src/blkid.h.in
+++ b/libblkid/src/blkid.h.in
@@ -281,6 +281,7 @@ extern int blkid_probe_enable_superblocks(blkid_probe pr, int enable)
 #define BLKID_SUBLKS_VERSION	(1 << 8) /* read FS type from superblock */
 #define BLKID_SUBLKS_MAGIC	(1 << 9) /* define SBMAGIC and SBMAGIC_OFFSET */
 #define BLKID_SUBLKS_BADCSUM	(1 << 10) /* allow a bad checksum */
+#define BLKID_SUBLKS_FSSIZE	(1 << 11) /* read and define FSSIZE from superblock */
 
 #define BLKID_SUBLKS_DEFAULT	(BLKID_SUBLKS_LABEL | BLKID_SUBLKS_UUID | \
 				 BLKID_SUBLKS_TYPE | BLKID_SUBLKS_SECTYPE)
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index f21365538..9adc2cfa3 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -7,6 +7,7 @@
  * GNU Lesser General Public License.
  */
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
@@ -584,6 +585,16 @@ static int blkid_probe_set_usage(blkid_probe pr, int usage)
 	return blkid_probe_set_value(pr, "USAGE", (unsigned char *) u, strlen(u) + 1);
 }
 
+int blkid_probe_set_fssize(blkid_probe pr, uint64_t size)
+{
+	struct blkid_chain *chn = blkid_probe_get_chain(pr);
+
+	if (!(chn->flags & BLKID_SUBLKS_FSSIZE))
+		return 0;
+
+	return blkid_probe_sprintf_value(pr, "FSSIZE", "%" PRIu64, size);
+}
+
 int blkid_probe_set_id_label(blkid_probe pr, const char *name,
 			     const unsigned char *data, size_t len)
 {
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 9c489c438..67803679f 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -111,6 +111,7 @@ extern int blkid_probe_set_utf8_id_label(blkid_probe pr, const char *name,
 			     const unsigned char *data, size_t len, int enc);
 
 int blkid_probe_set_block_size(blkid_probe pr, unsigned block_size);
+int blkid_probe_set_fssize(blkid_probe pr, uint64_t size);
 
 extern int blkid_probe_is_bitlocker(blkid_probe pr);
 extern int blkid_probe_is_ntfs(blkid_probe pr);
-- 
2.27.0

