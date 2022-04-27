Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE56C433F5
	for <util-linux@archiver.kernel.org>; Wed, 27 Apr 2022 17:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbiD0RJL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243766AbiD0RIw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 Apr 2022 13:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA2A9111E
        for <util-linux@vger.kernel.org>; Wed, 27 Apr 2022 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651079139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=by/9bdgnmXIdb+AC/+BHa1gOVtGCAubUwMGjSC3DkDk=;
        b=K1g2nCLNJ8sWtaZKGUNtcPwWRjySvdwcatH9r/lEmEoxBGmpz1C5SKzW7io4BesoT+JyHo
        hYZKlFDq8LEBtu2wPVdMduPVQSZAHLiHlXMKjCY0FmMcOfL4ljACe9DhcEfIO8etZXvMKb
        TiQ5Wm3zA1D3hxL+pF9h11XeTTsrdoU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-rOp18dizMwqcSQpSptZdCA-1; Wed, 27 Apr 2022 13:05:38 -0400
X-MC-Unique: rOp18dizMwqcSQpSptZdCA-1
Received: by mail-wr1-f72.google.com with SMTP id w4-20020adfbac4000000b0020acba4b779so955973wrg.22
        for <util-linux@vger.kernel.org>; Wed, 27 Apr 2022 10:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=by/9bdgnmXIdb+AC/+BHa1gOVtGCAubUwMGjSC3DkDk=;
        b=a6NSkZYMfe9bj7lYE8zDd+9qQxqUaLQun55ykqEVHUoADBaRq7NmU/AJq2VjEtj3rl
         3V0jNEseFxSznjVq1PRsi1ZBIhUnSqB5jRpz7AAljEG06OfSmKXjXJYwpvz0DsKaGd1s
         tfpsdgsBp9384kzbQjclf2rSuDcsg5NLdHxwbc9xxMAupAaghR+r65ZgkfGVcLxetP91
         Wk+dYHTHxcVeCoRx0F6gYmN/wCsSw6AWL+pjCW1MIbm1h07DILgdv1lvlfh7l3EbQB/H
         tYR//nWZz5FZy7NlYyKWlMDKJK5EzLfXPhV7yUnsxkINmzBkdsSerWqWJaWVYEmbZtXq
         4Vtg==
X-Gm-Message-State: AOAM530ONLYy8OU7tRXnkKuB9UqMVIlCtwOuez2zRYXJoD7TZbYAiOR9
        zryNeQHviicrogkwd7s8f/rNjHUlEg80wzH2/7D3TGL4rvEmLbfnqu+I1pfbAoQqiAeq305b7Bo
        HOqVNMnLfvhKz5lxTtGRlvXYxqAA1juv7v+ldUSOOZvKEWOAI+vzVtzWFl0b4MnMxJoIVsBov
X-Received: by 2002:a05:600c:19c6:b0:392:88e2:7426 with SMTP id u6-20020a05600c19c600b0039288e27426mr26977404wmq.132.1651079136954;
        Wed, 27 Apr 2022 10:05:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQHxZG3Yg6/q5YL/ozjiA3JCELVf/da6HCuSWjN/4MzHPeICRYd+kzyw3km4F2buuFlGZNuQ==
X-Received: by 2002:a05:600c:19c6:b0:392:88e2:7426 with SMTP id u6-20020a05600c19c600b0039288e27426mr26977377wmq.132.1651079136660;
        Wed, 27 Apr 2022 10:05:36 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d604e000000b0020af46b0ffbsm288582wrt.9.2022.04.27.10.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:05:36 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH 0/4] Add FSLASTBLOCK tag and blkid with btrfs test
Date:   Wed, 27 Apr 2022 19:05:10 +0200
Message-Id: <20220427170514.317720-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

As discussed in [1] it would be useful to have FSLASTBLOCK tag
(size of the area occupied by filesystem). These few patches:
- add interface to set FSLASTBLOCK
- implement FSLASTBLOCK for ext2/3/4/jbd, xfs and btrfs
- add BTRFS image for blkid test
- update expected output for blkid tests to check FSLASTBLOCK

The BTRFS image is default 'mkfs.btrfs btrfs.img' (115M in size;
looks to be minimum required size)

[1]: https://bugzilla.redhat.com/show_bug.cgi?id=2064810

Andrey Albershteyn (4):
  libblkid: add FSLASTBLOCK field interface showing area occupied by fs
  libblkid: add FSLASTBLOCK implementation for xfs, ext and btrfs
  blkid: add image for btrfs testing
  blkid: add tests for FSLASTBLOCK tag

 libblkid/samples/superblocks.c         |   3 ++-
 libblkid/src/blkid.h.in                |  23 ++++++++++++-----------
 libblkid/src/superblocks/btrfs.c       |   5 +++++
 libblkid/src/superblocks/ext.c         |   5 +++++
 libblkid/src/superblocks/superblocks.c |  13 +++++++++++++
 libblkid/src/superblocks/superblocks.h |   1 +
 libblkid/src/superblocks/xfs.c         |   1 +
 misc-utils/blkid.c                     |   2 +-
 tests/expected/blkid/low-probe-btrfs   |   8 ++++++++
 tests/expected/blkid/low-probe-ext2    |   1 +
 tests/expected/blkid/low-probe-ext3    |   1 +
 tests/expected/blkid/low-probe-jbd     |   1 +
 tests/expected/blkid/low-probe-xfs     |   1 +
 tests/expected/blkid/low-probe-xfs-v5  |   1 +
 tests/ts/blkid/images-fs/btrfs.img     | Bin 0 -> 120586240 bytes
 15 files changed, 53 insertions(+), 13 deletions(-)
 create mode 100644 tests/expected/blkid/low-probe-btrfs
 create mode 100644 tests/ts/blkid/images-fs/btrfs.img

-- 
2.27.0

