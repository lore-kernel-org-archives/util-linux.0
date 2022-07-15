Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96163C43334
	for <util-linux@archiver.kernel.org>; Fri, 15 Jul 2022 14:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiGOOz2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 Jul 2022 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGOOz2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 Jul 2022 10:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86E01474DA
        for <util-linux@vger.kernel.org>; Fri, 15 Jul 2022 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657896926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Re+TN+bRsCsuIABLQAoEh29CoAPfrANC5gLV6nNXHVc=;
        b=PRmDzzISPfH4wOJivYKBwoD8d0nufKdd/VhhL5FkbITIiZuLM6zkd07OBCbdiPnJqZwLl2
        GfAk+5ugPGrqsVfr+EJylTjOjmiMB3w5VBlrR9vYVg6VbAOZAgQfaEAIa9LGSphl94r3m9
        bpMPeVK3ud9IAK84o+0pEEbmmjfuyN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-dfG6_MPvNxqrZ0d-3tegdw-1; Fri, 15 Jul 2022 10:55:17 -0400
X-MC-Unique: dfG6_MPvNxqrZ0d-3tegdw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2276C802E5C
        for <util-linux@vger.kernel.org>; Fri, 15 Jul 2022 14:55:17 +0000 (UTC)
Received: from b.redhat.com (unknown [10.33.36.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 327EC492C3B
        for <util-linux@vger.kernel.org>; Fri, 15 Jul 2022 14:55:16 +0000 (UTC)
From:   Andrew Price <anprice@redhat.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] uuid_copy: (man) Add missing parenthesis
Date:   Fri, 15 Jul 2022 15:55:13 +0100
Message-Id: <20220715145513.469044-1-anprice@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 libuuid/man/uuid_copy.3.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libuuid/man/uuid_copy.3.adoc b/libuuid/man/uuid_copy.3.adoc
index b600a6368..fee40d6bf 100644
--- a/libuuid/man/uuid_copy.3.adoc
+++ b/libuuid/man/uuid_copy.3.adoc
@@ -46,7 +46,7 @@ uuid_copy - copy a UUID value
 
 *#include <uuid.h>*
 
-*void uuid_copy(uuid_t __dst__, uuid_t __src__;*
+*void uuid_copy(uuid_t __dst__, uuid_t __src__);*
 
 == DESCRIPTION
 
-- 
2.36.1

