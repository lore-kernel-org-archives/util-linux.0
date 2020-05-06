Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8ADC28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 19:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C812075A
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 19:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAru2r40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgEFTT3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 15:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgEFTT2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 15:19:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A621C061A0F
        for <util-linux@vger.kernel.org>; Wed,  6 May 2020 12:19:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so3553778wrt.1
        for <util-linux@vger.kernel.org>; Wed, 06 May 2020 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=qE2nD4T6ZMOZVizd2P+VHS9EWB2xwLfXlxzHYlL0Jzw=;
        b=YAru2r40i3XYCdxCgIfFTn+5/Ful7HAVLbt83On2HHcsSC35cEB+JFOvxbdCLZX2eR
         /uzZTnLqFxggyTiXUCg7wP6Rt1SywjcMkQs5JecagVrFhybpp5u0EIng31WLnCyvmU+1
         DGzGsVlpfIkROuqZu0chDqrorhaN029iRbQoP4qtSv5BG7SC5CbXmhmOC25cGgm/RO2Z
         7M/75PLrpmInQKZorFOucE3XzrmqZzbV3ruxRn28Kw6txjLOHefljx7NmFPlH0aTuwW+
         3veUdVEta7CT8uRfCJRLQdd5rjEPlSLEnMnbncho0/zs8DZrLLlKXYLh1SN4wN6zVDZt
         /+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:organization:content-transfer-encoding;
        bh=qE2nD4T6ZMOZVizd2P+VHS9EWB2xwLfXlxzHYlL0Jzw=;
        b=jCURKBlk9/0CnSLFB38r3mSiyMpvJJtlHTHTQs9u6n2XHlPZCvLCueIcrK4jQh/r+J
         xEI1q1K+VEeVSG/sy/ly6XZELWY9Ga8uAMOsVo7Y28N29kpXr70NZ9YP5kpMEi226iIt
         KHIghgF65GaCrMPPTAT/5FhESWnwNA/pk1KfhSlJOgI8owF3mm+fEBqAsQBTdlE5RBJX
         S2qh8COY1tmEX+HdwfuDL/kx5xaqfQIsFa1UULFSZ4IItjCC1+Iyhdhgbxnk5HvEQ0oO
         9QytJktStmup+k5H6BKvVnpL1uueFOcN8jFIZtKkuanDKDCpYW3AMvActHD+GlKsbVrb
         tTFw==
X-Gm-Message-State: AGi0PualnZOykh5EI16XpiJtzviNNjMKgbqoTVDwTFcnsOa0GITp3Nyl
        2p8c3JPcNVofkwo4raGRt230YYOE
X-Google-Smtp-Source: APiQypLmRrEhw3LZlqjpMbPZuxdDmxFquJ+xsqBSUpwreknwkTFCiAhxx/iezeF3gbJIwKK7o5IpWw==
X-Received: by 2002:adf:f4c4:: with SMTP id h4mr11591251wrp.142.1588792766659;
        Wed, 06 May 2020 12:19:26 -0700 (PDT)
Received: from localhost ([2a02:8010:659f:0:8b7c:8150:5102:21e9])
        by smtp.gmail.com with ESMTPSA id 1sm4434153wmi.0.2020.05.06.12.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 12:19:26 -0700 (PDT)
From:   Sami Kerola <kerolasa@iki.fi>
To:     util-linux@vger.kernel.org
Cc:     Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/2] more(1) use libmagic and make page up/down and arrow keys work
Date:   Wed,  6 May 2020 20:19:21 +0100
Message-Id: <20200506191923.5272-1-kerolasa@iki.fi>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Cloudflare
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

Here are two changes to more(1) that where requested in earlier github
pull[1] request to get review in maillist, so here we go.

[1] https://github.com/karelzak/util-linux/pull/1003

First one of the changes will link more(1) with libmagic so that various
binary formats can be detected with effect the pager will not mess up
termial.

Second change is perhaps a little bit more exciting.  It will add page-up,
page-down, arrow-up, and arrow-down movements to more(1).  This pager has
known now to scroll back and forth since long time ago, but most of the
people do not seem to know key bindings so lets help users by assigning the
most obvious buttons the way one might expect them to work. 

These changes can also be found from my github repo.

----------------------------------------------------------------
The following changes since commit 0d855a83095adc953cc9a0df8998a2f916242695:
  agetty: save the original speed on --keep-baud (2020-05-04 12:27:42 +0200)
are available in the Git repository at:
  git://github.com/kerolasa/util-linux.git more-features
for you to fetch changes up to 0cfa98c59a743a8c5dc0bec24bb46220a967ef85:
  more: make page and arrow up/down to update view (2020-05-06 19:57:56 +0100)
----------------------------------------------------------------

Sami Kerola (2):
  more: use libmagic to identify binary files
  more: make page and arrow up/down to update view

 configure.ac             |  12 ++
 text-utils/Makemodule.am |   2 +-
 text-utils/more.c        | 431 ++++++++++++++++++++++++---------------
 3 files changed, 284 insertions(+), 161 deletions(-)

-- 
2.26.2

