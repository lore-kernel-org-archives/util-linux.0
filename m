Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1BFC43334
	for <util-linux@archiver.kernel.org>; Fri,  3 Jun 2022 12:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244350AbiFCM27 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Jun 2022 08:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiFCM2z (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Jun 2022 08:28:55 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A53A5D9
        for <util-linux@vger.kernel.org>; Fri,  3 Jun 2022 05:28:55 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e5e433d66dso10392863fac.5
        for <util-linux@vger.kernel.org>; Fri, 03 Jun 2022 05:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GIMmQiyEhHOCkIbvC9dOLJIXEa87+4aOg4dXIYOG9k=;
        b=gPQuRdgRbCoOs/Yx4Sz+AbwiiQDbSXUNrlgxZgALAwRKFny0zBHu7FwDrLSHAkZFfN
         DVlBCKkf89sXlkQPzihogFcRYWp8JTUvz4/FW/i6YDzsF8A0Pp4ipRhgLmSDLdUI1LG5
         bMMn1NiRD3WObKZL4eRO2JDWrSTJTfkTilG/hP/R8nRIVwZCLxg8zx7uHUJmNxMNRhyK
         NIc7azuwYUy8xWQmQx4/IS+B8Xjj+YB+82vXXk1Po+deezUqxSxuNqB8Ubhz5qedyuQw
         qT26gVt2+ncrG08h+w8uCPNKcv62iFD3IVACYAj3aiw8bnJV70mzDOubRnH3k83Qw0SX
         hKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GIMmQiyEhHOCkIbvC9dOLJIXEa87+4aOg4dXIYOG9k=;
        b=kGE9u+CPD81YN6c9fBpa/QfGhHFd5btz1Qh6IW7Sbfk6dkppr/tGFGEvRlfL+nHDqq
         44O2SXXUYIJ3Lr1EGoyhDelS1drmOeVkeVUyhPXv/6vYyCuOOH3dTCkxvPZ8CNgBEeHE
         rqPjvw8cu0n2/ph/0XlGJlp/tGJjWrsYYC3bEUaSo7nLB4hQ3PxnaPYtS6KzPJQdYFc8
         aVX4+TCUFnhqhaTiiHITPMTOokPPnSt+iRm8CTYlivOX58HrrYEk9nU0jWab1EEiuoP1
         oNKRP6EtH+jujv9EyAT337DdDGi8N/5Qy1I4pcRKb8OWy1WG4DtsjNsNFpZvyR4KotWw
         k2Og==
X-Gm-Message-State: AOAM5331qkaqn0NYDnifHz+xNkJtqk3cQ4OJ1l7ECrlmwCz5rOpAm84l
        RzJ7jdrdgUCzqAmEj5X4AlqraxsI6Vg8wQ==
X-Google-Smtp-Source: ABdhPJz4qyhI/u4fBhrny1zyNsgzQ+6XMbO2rAs5z+HAaUPrhJrJtAcSwontPtMHGt3ac4ld8rDSVw==
X-Received: by 2002:a17:90b:3a90:b0:1e6:a203:c7dd with SMTP id om16-20020a17090b3a9000b001e6a203c7ddmr6033869pjb.144.1654259322616;
        Fri, 03 Jun 2022 05:28:42 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id h1-20020a655181000000b003fbaae74971sm5173955pgq.72.2022.06.03.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:28:41 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 5/5] lsblk: enable 'MQ' for NVMe/virtio by default
Date:   Fri,  3 Jun 2022 20:24:02 +0800
Message-Id: <20220603122402.3274789-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603122402.3274789-1-pizhenwei@bytedance.com>
References: <20220603122402.3274789-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

NVMe/virtio devices typically has MQ feature, enable this column by
default for option '--nvme/--virtio'.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 misc-utils/lsblk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index d9c4ee982..a09ff2a1f 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -2233,6 +2233,7 @@ int main(int argc, char *argv[])
 			add_uniq_column(COL_SERIAL);
 			add_uniq_column(COL_TRANSPORT);
 			add_uniq_column(COL_RQ_SIZE);
+			add_uniq_column(COL_MQ);
 			break;
 		case 'v':
 			lsblk->nodeps = 1;
@@ -2242,6 +2243,7 @@ int main(int argc, char *argv[])
 			add_uniq_column(COL_TRANSPORT);
 			add_uniq_column(COL_SIZE);
 			add_uniq_column(COL_RQ_SIZE);
+			add_uniq_column(COL_MQ);
 			break;
 		case 'T':
 			force_tree = 1;
-- 
2.20.1

