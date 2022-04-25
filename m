Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97F6C433F5
	for <util-linux@archiver.kernel.org>; Mon, 25 Apr 2022 15:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbiDYPMG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Apr 2022 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242632AbiDYPMF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Apr 2022 11:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E2056E4CA
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650899340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v7IHR3OaAjpR5H+/SzdygsSPfM7GtLpZ3B1g3V+WwXM=;
        b=EAoalU/a/5uqaDGGlk1BrLau5wPRuJLSHIZwxa30cyVrdQ2IyoOPoSVCgQVm+x3spdzFC0
        gpUaq4d1+/5yeM36Vr1jl+xAU4/uuU6LZl7xWyk711wiBPw39zSBHk0kJ/1mCUuN02ueFZ
        CW/oQbvcfvKYTF/uYKyvNUkHnZQqFcw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-DDmX5YfVNxmuboja1jfeIw-1; Mon, 25 Apr 2022 11:08:59 -0400
X-MC-Unique: DDmX5YfVNxmuboja1jfeIw-1
Received: by mail-ej1-f70.google.com with SMTP id sc26-20020a1709078a1a00b006effb6a81b9so7470534ejc.6
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 08:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7IHR3OaAjpR5H+/SzdygsSPfM7GtLpZ3B1g3V+WwXM=;
        b=fWjWB8wAsvcKyZIY9VrOjZQC4zDgOezg/xUF2cv2YoCfZFZ3taxnWIpQygh9ZEUc5s
         BWMfMT5rpaNsydTXdnSS1fZjT6pGUuxeEzf1waObNj9VVX9CDFvODnpbFghMf94XDnzK
         8Iu/PPZ4C2CSiFqXFPLH4hTJ6ht4ZaQL5dsc6NnROKDFthQ3b52X8WTvuppSS6Cm6FQR
         FyOs6PTNK78Jlbk44/mb/pDCFJ9ivfEKhmenwUEBuDczRfosDyoejtH44Tu2MN1MMAPp
         rb74LpHhj8AVwEj90rVe5cQGvgRCMdXxp/1oA2Y3iQUuOD6xmGD2pI8NUQkLW13x6iP6
         f7Eg==
X-Gm-Message-State: AOAM531wf2rv6LnxeGrWomsL/Wf3GC6aO5GrI2Dfpw297Or4qC0HPtRM
        GrGcITyzdsiZGwbbtrFXUtyb3D3ClL+EHjbgtL8E71dh203eqbuNjVIUq7JIyLoMfCZWTMn56GU
        GCaCFc/DMJCJ4OupXw1I3v4qaWmENGqUyVsdzD7DcmatOBQ0AT/CzcPEiACeToZMsnYFJcAFr
X-Received: by 2002:a17:906:3ad3:b0:6cd:382b:86e5 with SMTP id z19-20020a1709063ad300b006cd382b86e5mr15948452ejd.145.1650899336567;
        Mon, 25 Apr 2022 08:08:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQuHBghZbBDivf+bZsT7A9WDUimu1BBW4DseDJ9wAb7QWtSj8WwLzh65wtL/8ymVbPXB1iWA==
X-Received: by 2002:a17:906:3ad3:b0:6cd:382b:86e5 with SMTP id z19-20020a1709063ad300b006cd382b86e5mr15948433ejd.145.1650899336355;
        Mon, 25 Apr 2022 08:08:56 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id i19-20020a1709061cd300b006f38920dbeesm1776878ejh.134.2022.04.25.08.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:08:55 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 0/3] libblkid: add FSSIZE with XFS implementation
Date:   Mon, 25 Apr 2022 17:08:36 +0200
Message-Id: <20220425150838.151020-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In discussion [1] it was suggested that adding new field FSSIZE
would be useful (size of filesystem, like in lsblk). These patches
add new FSSIZE field together with implementation for XFS.

[1]: https://bugzilla.redhat.com/show_bug.cgi?id=2064810

Changes from v1:
- Minor refactor: Make use of uint64_t, use
  blkid_probe_sprintf_value()
- Add patch #3 - enable FSSIZE in blkid and add new golden output in
  the tests

Andrey Albershteyn (3):
  libblkid: add interface for FSSIZE field
  libblkid: implement FSSIZE calculation for XFS
  blkid: add FSSIZE tag with tests for XFS

 libblkid/samples/superblocks.c         |  2 +-
 libblkid/src/blkid.h.in                |  1 +
 libblkid/src/superblocks/superblocks.c | 11 +++++++++++
 libblkid/src/superblocks/superblocks.h |  1 +
 libblkid/src/superblocks/xfs.c         | 10 ++++++++++
 misc-utils/blkid.c                     |  3 ++-
 tests/expected/blkid/low-probe-xfs     |  1 +
 tests/expected/blkid/low-probe-xfs-v5  |  1 +
 8 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.27.0

