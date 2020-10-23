Return-Path: <SRS0=26vR=D6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88F1C388F9
	for <util-linux@archiver.kernel.org>; Fri, 23 Oct 2020 20:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C1222261
	for <util-linux@archiver.kernel.org>; Fri, 23 Oct 2020 20:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUh/GKyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464789AbgJWUIF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Oct 2020 16:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373801AbgJWUIF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 23 Oct 2020 16:08:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F25C0613CE
        for <util-linux@vger.kernel.org>; Fri, 23 Oct 2020 13:08:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w23so1913698wmi.4
        for <util-linux@vger.kernel.org>; Fri, 23 Oct 2020 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=MBzWIglXzC4HR/lgMsVmYnoBVxuwPEd2g4HlOphNV0o=;
        b=aUh/GKyvDVhYbN80zD4a1vQg5AcU7bd/hb3mk1g5ZVeIXoL/hm4xC4wOFyL2D9uepT
         byyl7s1XLd2sDm+avY5hd12L0Eu0QitdCFYa8mh5aXsnzDyCYJSLJWs+t/bYtRS+bzT0
         NL/MmjYuffQqq/HiomhFEwDfNLRGz4JRc3e7X3mIa6SHgShAzVWFiN1tfT3oN7kBZM3S
         URW61qnoTVWKSFUSQnJY5ZSkoxrCTYgJqSqr8izEMBsVJfQ6C/dYwFKxlA9iJ/rwyY3Z
         0VxXTrDtWm/1hMuV2NmI+V2GmFeaTD+7T+1ZvkNGwHiyLBNCBqT8CTIYe7JgdXDyAdkt
         LOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:organization:content-transfer-encoding;
        bh=MBzWIglXzC4HR/lgMsVmYnoBVxuwPEd2g4HlOphNV0o=;
        b=UtFeteoIoRLwpc2XqacnPLiYAKPEtfKaYCMYg3Zbqa2T6ACE5oY5BYtJw9opbrsytB
         rLwa9DG24JgLvADl917CAoMyGgUEqYjzGQAd6BvaIAEWEnaQDD31PS2b7IwkdAAj4xUT
         c0xK4E+kRzFKEtnUYGah35gCNWTjEn/HLhAHdoIgQdvYbSFNVSwOMlOE1z029n08QUDc
         IWMHT4TsfAm4JI0uufyvF5aVlR3WBWu0cQimHc4hjzEwZlGBYZwyBOd2iWmOES5EYaX8
         JsGQCThp7GX+CpcyP/nE8qqupMhfbE3vWfwamjth40gIlZFHFw/XyMeCwAcBhTq1rg6U
         ZlYw==
X-Gm-Message-State: AOAM533ScLg6omwPs7itwgx0rWeEcYyRq4BzowIVi9XUeQpsskkcJZhS
        VDZySQCFpJhWubkHhmWhyeqWw+y4nxk=
X-Google-Smtp-Source: ABdhPJx5kKMztc8bbjkiOTvZ7Gx3IMhdOA+ApMDR+4B0sEKWCmEknEOqf8z5QVWerGlirLdWB/WJHw==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr3931396wmb.54.1603483683880;
        Fri, 23 Oct 2020 13:08:03 -0700 (PDT)
Received: from localhost ([2a02:8010:659f:0:a8d8:38f:5807:ac47])
        by smtp.gmail.com with ESMTPSA id v123sm4690691wme.7.2020.10.23.13.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 13:08:02 -0700 (PDT)
Sender: Sami Kerola <kerolasa@gmail.com>
From:   Sami Kerola <kerolasa@iki.fi>
To:     util-linux@vger.kernel.org
Cc:     Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] rfkill: stop execution when rfkill device cannot be opened
Date:   Fri, 23 Oct 2020 21:08:00 +0100
Message-Id: <20201023200800.7980-1-kerolasa@iki.fi>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Organization: Cloudflare
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Without this two error messages are printed when rfkill device
cannot be opened.

    $ rfkill
    rfkill: cannot open /dev/rfkill: No such file or directory
    rfkill: cannot read /dev/rfkill: Bad file descriptor

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rfkill.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sys-utils/rfkill.c b/sys-utils/rfkill.c
index b00bf753e..73fb4bab4 100644
--- a/sys-utils/rfkill.c
+++ b/sys-utils/rfkill.c
@@ -420,6 +420,8 @@ static int rfkill_list_old(const char *param)
 	}
 
 	fd = rfkill_ro_open(1);
+	if (fd < 0)
+		return -errno;
 
 	while (1) {
 		rc = rfkill_read_event(fd, &event);
@@ -492,6 +494,8 @@ static int rfkill_list_fill(struct control const *ctrl, const char *param)
 	}
 
 	fd = rfkill_ro_open(1);
+	if (fd < 0)
+		return -errno;
 
 	while (1) {
 		rc = rfkill_read_event(fd, &event);
-- 
2.29.0

