Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7135BC43334
	for <util-linux@archiver.kernel.org>; Fri,  3 Jun 2022 12:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbiFCM2d (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Jun 2022 08:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiFCM2c (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Jun 2022 08:28:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C293A5D9
        for <util-linux@vger.kernel.org>; Fri,  3 Jun 2022 05:28:27 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 15so7092558pfy.3
        for <util-linux@vger.kernel.org>; Fri, 03 Jun 2022 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxDek+HJSSGlIea0Kq2KhjZ104el4XtWxEgMB0IpshQ=;
        b=OPWTyiJJ9ES/O9/5affH7tRmSxTu81bNJ23ljRnkC8sv8y0BhhoP8TkhbJhdSNUYaY
         +vxmZ4e6G3M3fKsxV94+9t96i9uFu5SxKD5nxGKo8TKIEpvB6SsQRUGofKOAuotok2uR
         2/mWudBfd5tG0U9G+NAWsrNd8GXP1hJ/QP0lClpaZBphG1+e9KzQVyWBeoZIk1powa/N
         wwZUKFFgzzMqx7ZuN80P1hCz89vIVSFYWFplNoLv+rOmCX3uwCoh/A7OpGolpm7A/aMX
         5ieV8TcKGwGG/w5yrJUynFarlb1PnZ017Rx4VeZaOtHzt3BAkCyIARlI8pSHST7yMYO/
         HQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxDek+HJSSGlIea0Kq2KhjZ104el4XtWxEgMB0IpshQ=;
        b=q6orRLLFzia5o/1h4/BGMvXOaaJd1NZYN5Xu7RFg138yqar59BETDlBAnanggtLcn6
         SKnQtQP1JmgBb6h9NjkWwa3TiwQLsiEEmb6jS1kn+rdSdDopSR6q9veu24g6YEanxiJl
         Nt1v7kVFIcXNUOpw1ZDpowKVwkCQdtgIxK+WBU5wb3z1XB5x+SlbjAPFUHT6g3d1eSgT
         yzLsDkgzDUfzb5QOkQOrHfu1uotoKzBBPc+hEWe1oGBQrxa+4NXfxKBHUXDg0sMiS694
         ITms8+lSu2VO6zb5YU7LZKIhE1QQL+e7RSK95jXhVEPIH22tAO5P6PeztAhJRkLaho61
         8iBA==
X-Gm-Message-State: AOAM533byEakYI34bXGNKj/5MMBAPUEY+BqTkz6au/4QNkULqUg6Iq00
        3f+n0DG1G1j6jBcTzsylolQD9Q==
X-Google-Smtp-Source: ABdhPJw2t1z2dhWgTyMafDxocLTkXADDG2Wq4rVTTkLcyDASmEhDBgZdZMWREy68EQwCXmuApMWVnQ==
X-Received: by 2002:a05:6a02:201:b0:3fc:6071:a272 with SMTP id bh1-20020a056a02020100b003fc6071a272mr8965614pgb.518.1654259306582;
        Fri, 03 Jun 2022 05:28:26 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id h1-20020a655181000000b003fbaae74971sm5173955pgq.72.2022.06.03.05.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:28:25 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/5] Support --nvme/--virtio and MQ
Date:   Fri,  3 Jun 2022 20:23:57 +0800
Message-Id: <20220603122402.3274789-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

Originally, lsblk supports --scsi only. Also support --nvme/--virtio
to filter NVMe/virtio devices.

And introduce 'MQ' column to show multi-queues feature.

zhenwei pi (5):
  lsblk: add -N/--nvme
  lsblk: support virtio block
  lsblk: add -v/--virtio
  lsblk: introduce 'MQ' column
  lsblk: enable 'MQ' for NVMe/virtio by default

 bash-completion/lsblk   |  4 +-
 misc-utils/lsblk.8.adoc |  6 +++
 misc-utils/lsblk.c      | 84 ++++++++++++++++++++++++++++++++++++++++-
 misc-utils/lsblk.h      |  2 +
 4 files changed, 93 insertions(+), 3 deletions(-)

-- 
2.20.1

