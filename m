Return-Path: <SRS0=4gC6=D2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8A0C433DF
	for <util-linux@archiver.kernel.org>; Mon, 19 Oct 2020 20:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DC42222C
	for <util-linux@archiver.kernel.org>; Mon, 19 Oct 2020 20:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAwqI/aI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbgJSU5L (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Oct 2020 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgJSU5K (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 19 Oct 2020 16:57:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731A9C0613CE
        for <util-linux@vger.kernel.org>; Mon, 19 Oct 2020 13:57:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t9so1213163wrq.11
        for <util-linux@vger.kernel.org>; Mon, 19 Oct 2020 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=eviubVap8XFQlUJ1uZD0o6Lm4VSvOEliUb01j3y2oxY=;
        b=mAwqI/aI9M7UFSaDR5qoIikwipZLb38Yu7SizVoBXrRz6FGDQ2rtq7Tc8nDxJPRwCq
         7C9QVt9UeWMx2QIFVpsHUU2gEfHAaYT8AmltjLiNwCz1/AvsEd7S9uTGhL+EqwFeWblB
         pvE2HLLpculX4z79snzLwlTsyYubr32+AtoFSXrVY5KEt4Wz72eo/n96wQxchLQ6o/js
         6dyZ/RE8fERu087yebkqqn9YDxWzeNsfzo/67hZ6GRu9lSRse8VRbtzFcGnuwFnfIiFt
         82Q3x0o2BZPlfUwy0JXOsJkiz4WMPaJhgdHys36J0AwYdsrbi6V1g0eMhmU3BOA0iVC9
         fqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:organization:content-transfer-encoding;
        bh=eviubVap8XFQlUJ1uZD0o6Lm4VSvOEliUb01j3y2oxY=;
        b=TQw/wdzLc64rMqbEldjvmIyTynf7zKOKVngPtw/79n5eQdToqYFXg72uetgge49fAT
         p0KC8bUKKx+MYdGQV8ri6NLiF6L+KyJi1qBVIGn5Wuthuf0v3wE9k3rq0XTfPBFkxBYB
         GtOvYU00To+0kFXytahYjseeOr6ecWYdLjga2sZTub6n6eae0dN+rcP+TCPCJeTwuUrY
         xs4FcvDcSLfyO6B/CGXxg9bEqvcEzZpSDXb4ujJI/GqFwhBvYq0RnvexrDcJfwcrXgpn
         ulXlffN9H6nYzDrm0GBsws7o1Otly/rJTwYExBFiqS6bgYOitHjvHwZa4Ctg6pamPlD9
         7gQg==
X-Gm-Message-State: AOAM533cmieUdzWX0XGiPFTOLbBPsZbHVeB2x5xqGmuQyG/0VZRxSNVd
        PzE7wT9IVbmdHTWhDPXS5tP1xo0ajHw=
X-Google-Smtp-Source: ABdhPJxtiSzLu+7SK5FOaBhkpV2l4ZdZbJP4eA71Rn/YrZaHHBR6RzkfW8KKQxP0fEKV937ARzJfzQ==
X-Received: by 2002:adf:9043:: with SMTP id h61mr1177131wrh.237.1603141028747;
        Mon, 19 Oct 2020 13:57:08 -0700 (PDT)
Received: from localhost ([2a02:8010:659f:0:a8d8:38f:5807:ac47])
        by smtp.gmail.com with ESMTPSA id d2sm1221161wrq.34.2020.10.19.13.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:57:07 -0700 (PDT)
Sender: Sami Kerola <kerolasa@gmail.com>
From:   Sami Kerola <kerolasa@iki.fi>
To:     util-linux@vger.kernel.org
Cc:     Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] colrm: fix argument parsing
Date:   Mon, 19 Oct 2020 21:57:04 +0100
Message-Id: <20201019205704.6762-1-kerolasa@iki.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Organization: Cloudflare
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Short options had all sortss of characters listed, that were clearly copied
from col(1) command getopt_long() invocation.  Luckily both -V and -h were
part of the short options, but lets get rid of the unnecessary ones.

Fixes: 1647d032a7bfcba36d3dabe627b858b372210d05
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/colrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/colrm.c b/text-utils/colrm.c
index f9dfd5938..7df5a7450 100644
--- a/text-utils/colrm.c
+++ b/text-utils/colrm.c
@@ -169,7 +169,7 @@ int main(int argc, char **argv)
 	close_stdout_atexit();
 
 	while ((opt =
-		getopt_long(argc, argv, "bfhl:pxVH", longopts,
+		getopt_long(argc, argv, "Vh", longopts,
 			    NULL)) != -1)
 		switch (opt) {
 		case 'V':
-- 
2.28.0

