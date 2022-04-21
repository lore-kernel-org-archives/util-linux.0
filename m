Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC55C433F5
	for <util-linux@archiver.kernel.org>; Thu, 21 Apr 2022 13:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiDUNNC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiDUNM4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 Apr 2022 09:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDCC838BA
        for <util-linux@vger.kernel.org>; Thu, 21 Apr 2022 06:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650546606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKzqjQkKZR9KaRwXsXKCrOg+hngSd0FMcvHXu3DOhBU=;
        b=JyMx0PqlrtWtKvSCvb+QHBbFp6vyUtKqufXE/S4bQc/Hdi3jAW9h+g2wEK0iEIUP92GpvJ
        hUypCRrP3+mjXCDZVt6DyG1iAcHiLaLO89rzUstvOOe8ZUn3KZsmllGzak94HW8edj3cMB
        3quQd2M0i0ffTIiCp9faZkUZQW71/b8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-5JDbeuhUOY2NsKzdeeQV3A-1; Thu, 21 Apr 2022 09:10:05 -0400
X-MC-Unique: 5JDbeuhUOY2NsKzdeeQV3A-1
Received: by mail-wr1-f71.google.com with SMTP id q4-20020adfc504000000b002079c9cc1bfso1125722wrf.11
        for <util-linux@vger.kernel.org>; Thu, 21 Apr 2022 06:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKzqjQkKZR9KaRwXsXKCrOg+hngSd0FMcvHXu3DOhBU=;
        b=iNm6C2ZzXNOaY0UFJL+YDihnNQzccLVmolH9K1xuCv93daqQl0pkSGQDPUOI7b3db5
         oXBkrY/P9qbhQLAWWPVgr0+1N2n4/prPO0wIPyrDQizKxE8EeNkjtZzu2g0K5LU1fYsR
         CHhcjwXqegyfhZIDQEmSp3eTum2NqomQeVyj5K0ybZjKjAnmQKGjdUMgFPooJ0eBoVrY
         p7OjpKcbroPf/zQh1fruBhP12AoivPNv4aNxUoZxaE1prqUrfIUr+Pu2Tjq3BerlRTZd
         HXXn1EJjMbz12cptCJ5FShuzaxVxciF2lDtiG+nVD1S2tHNYTE7adToCM2cXtFLVeYqJ
         bi6A==
X-Gm-Message-State: AOAM5312rJhQfqSKV+yQiXjGWUkZH6KrxdpnZw+zp57mL8WB7ZeoLA+P
        XY++awCWwVefIWH1L/3xl0Ap/P8vkXU8R4vhV3/XNcVIciQ8JIBPIJtrDKi+zOoUK0nRKT7ATFv
        2yfWLowf6+WsaHBo6b0/IPTOGDfhsRavRlY980B0fyr0jp+30W6RwFOw4E+LkjpM6SWzzEdda
X-Received: by 2002:a05:600c:3d0f:b0:38e:bc5f:5515 with SMTP id bh15-20020a05600c3d0f00b0038ebc5f5515mr8643106wmb.128.1650546603484;
        Thu, 21 Apr 2022 06:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7n07ooR/lisMRbZP6vOMwISo4w8KuFWGuDjbaRBXgkodNtH3wpdORihRKD00fMVktWlEUDA==
X-Received: by 2002:a05:600c:3d0f:b0:38e:bc5f:5515 with SMTP id bh15-20020a05600c3d0f00b0038ebc5f5515mr8643080wmb.128.1650546603218;
        Thu, 21 Apr 2022 06:10:03 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b00207982c7f4dsm2284875wrr.67.2022.04.21.06.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:10:02 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH 1/2] libblkid: add interface for FSSIZE field
Date:   Thu, 21 Apr 2022 15:09:45 +0200
Message-Id: <20220421130946.318737-2-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220421130946.318737-1-aalbersh@redhat.com>
References: <20220421130946.318737-1-aalbersh@redhat.com>
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
 libblkid/src/superblocks/superblocks.c | 13 +++++++++++++
 libblkid/src/superblocks/superblocks.h |  1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

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
index f21365538..090b618ce 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -584,6 +584,19 @@ static int blkid_probe_set_usage(blkid_probe pr, int usage)
 	return blkid_probe_set_value(pr, "USAGE", (unsigned char *) u, strlen(u) + 1);
 }
 
+int blkid_probe_set_fssize(blkid_probe pr, unsigned long long size)
+{
+	struct blkid_chain *chn = blkid_probe_get_chain(pr);
+	char u[20];
+
+	if (!(chn->flags & BLKID_SUBLKS_FSSIZE))
+		return 0;
+
+	snprintf(u, sizeof(u), "%llu", size);
+
+	return blkid_probe_set_value(pr, "FSSIZE", (unsigned char *) u, strlen(u) + 1);
+}
+
 int blkid_probe_set_id_label(blkid_probe pr, const char *name,
 			     const unsigned char *data, size_t len)
 {
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 9c489c438..58c11fc02 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -111,6 +111,7 @@ extern int blkid_probe_set_utf8_id_label(blkid_probe pr, const char *name,
 			     const unsigned char *data, size_t len, int enc);
 
 int blkid_probe_set_block_size(blkid_probe pr, unsigned block_size);
+int blkid_probe_set_fssize(blkid_probe pr, unsigned long long size);
 
 extern int blkid_probe_is_bitlocker(blkid_probe pr);
 extern int blkid_probe_is_ntfs(blkid_probe pr);
-- 
2.27.0

