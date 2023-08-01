Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889B9C00528
	for <util-linux@archiver.kernel.org>; Tue,  1 Aug 2023 19:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjHAT7g (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Aug 2023 15:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjHAT7f (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Aug 2023 15:59:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB312CC
        for <util-linux@vger.kernel.org>; Tue,  1 Aug 2023 12:59:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bba9539a23so8237045ad.1
        for <util-linux@vger.kernel.org>; Tue, 01 Aug 2023 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690919973; x=1691524773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ndRdI0Cm+WOxShn0Jolwlo+Vvxi1uILPN3FqBXbku0=;
        b=M+AuNAt857bEfzuuQIqi3jKji+IrkD1FmtIoqAb/kK/1CvNnOt4jV3CaDJJYrYt7Jr
         Zbcxa1ATUowQo28a1ntvKD6XGC2OiWpG1BxGxhRgOaE6X3dhJHfkjD0FrIupgvAHSC+s
         orRS1Sc47Ipjx9EJF436aeyP1VYlX8396JvU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690919973; x=1691524773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ndRdI0Cm+WOxShn0Jolwlo+Vvxi1uILPN3FqBXbku0=;
        b=gHRVJliB2W5bwyA0kLBVgn0GpOj+yFDXKUivhBaOSvWqKbg8ghSjRtkB8GIipin8Ac
         PXd7AbiqrB3VUD2/VarzlCxi4fzFzXi2ilpPpDaxaOcO0AesNofPLArQQhDjBNmvB4U/
         jbC1ZKrVxxrgAeIi+yOI2Khpma10eL0s/spUOO/lKlAS9PxuXYm4fWLEdKZAhfbf9bbO
         uOF5G7tW2yKXmYzc1r4dT4g3Z3YnXZK2fQyeCD2DtO9L4GaisOYfch4q4ZEypYKs06NN
         kcKQ8VVxIcm2jJC8zlzZukqD2wlmNWAB61zHrQGYQAcTbCyjs2ZpRShpjcLFukiSOJ5a
         zo3Q==
X-Gm-Message-State: ABy/qLZeOl7ZAOleDiiPLyLXBY0FVBYdCFWA8PXJzJvNNYc9RIKS/a3F
        GXjAhwxSTTvzWy6Kp8LM5zR5obYDBZqlf5wdrEi1Gw==
X-Google-Smtp-Source: APBJJlF3WJnCCqzlBSKkOk4F/3KoHh0IMGmJaU/E7H6G7X4WAO2iPTmbLKg+bnduFVNg5uS5dtbOlQ==
X-Received: by 2002:a17:903:244f:b0:1b3:ec39:f42c with SMTP id l15-20020a170903244f00b001b3ec39f42cmr13314126pls.5.1690919973368;
        Tue, 01 Aug 2023 12:59:33 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id g20-20020a17090ace9400b00263f40cf83esm9454461pju.47.2023.08.01.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 12:59:33 -0700 (PDT)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
        id D92F4418; Tue,  1 Aug 2023 12:59:31 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     util-linux mailing list <util-linux@vger.kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH 0/2] Improved libmount configure checks
Date:   Tue,  1 Aug 2023 12:59:25 -0700
Message-Id: <20230801195927.43090-1-mmayer@broadcom.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

To increase compatibility and prevent avoidable build errors, add two
explicit configure checks that allow libmount to successfully build in
more diverse environments rather than producing compiler errors in those
situations.

This applies to:
    - cross compiling
    - using older kernel headers (e.g. 4.9)
    - using alternate C libraries (e.g. musl)

Markus Mayer (2):
  libmount: check for linux/mount.h
  libmount: check for struct statx

 configure.ac              | 9 +++++++++
 include/fileutils.h       | 2 +-
 include/mount-api-utils.h | 4 ++--
 libmount/src/hook_idmap.c | 4 ++--
 libmount/src/hooks.c      | 2 +-
 libmount/src/utils.c      | 2 +-
 libmount/src/version.c    | 2 +-
 7 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.40.1

