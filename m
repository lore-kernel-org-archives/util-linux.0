Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC727C433FE
	for <util-linux@archiver.kernel.org>; Thu, 21 Apr 2022 13:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiDUNND (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiDUNM4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 Apr 2022 09:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA18A38B0
        for <util-linux@vger.kernel.org>; Thu, 21 Apr 2022 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650546605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jP00jMmaDdVYztni9YgQfSe3YdUSdnC2L48Bn7bNkNs=;
        b=V+lwp2wed5vLOrAmCKEVAnU/3OOEdTuqrZ7iVOdgX+EL6v9yqywdtAEfaP/bWbTSvJSZPG
        9oNpMfScbySVEIXMxwauP3B+hWnmbUo08PC3pzJ+TKouY4poFPYMbIOAn6m6PzYjn8pZGI
        hvVEdauShAIMItd5XrpHV2EBkBmSVcw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-KNpJi-tfNpalGYFm2MXQSw-1; Thu, 21 Apr 2022 09:10:03 -0400
X-MC-Unique: KNpJi-tfNpalGYFm2MXQSw-1
Received: by mail-wr1-f72.google.com with SMTP id w22-20020adf8bd6000000b0020aaff5af82so1127351wra.7
        for <util-linux@vger.kernel.org>; Thu, 21 Apr 2022 06:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jP00jMmaDdVYztni9YgQfSe3YdUSdnC2L48Bn7bNkNs=;
        b=32GhBE0g5lzyws74QmfgSDoPvDUBCLfbbc1kfFqbMNsgNE2ug4JXS73UyPUfBHAlpl
         Hxp6sfzt4jHQ3aN7H8DQmhVzC6UbPZVsxPvpLjkIYBWnBrdT3BF+/yInZXFW0z0hY4/q
         reMJ4dhF1e1bKnB+TyNZJ2CNKxIzPl2uEEhb+jGy0mr3oFCzUAu48q8q4myOKcphWpgm
         rqvkvXB1dGiawiQ0bXd4UBPA0son09CmZaZERY4y0Ri+Oq4IAmUOAlf8vrTeT6oirhNz
         9uLbKH2HEVqdlMvP4AQ5XGL/AsEGC2PWqCCtnShiiNAdEn4y3fIb9+F7VUYumfyrGJjf
         3euA==
X-Gm-Message-State: AOAM532AvFZ5Lc5GrZu2RtucZvyhNwwbmvFRzHui68aB6scYT798FDcZ
        XQL9V267ce572p+TOvthoMFkQW5PBJp3kafzkQBRZK50Xnh338ZB2r2HWENgQu/LUy2+LkE19/g
        V/qG/EdOrTRP18WLClpzZvhps8S9rkFOCSTARWxwanD8XiZLVe5WRDL5QepDmTmujT9bEHPFa
X-Received: by 2002:a1c:acc4:0:b0:392:9dd4:fbcc with SMTP id v187-20020a1cacc4000000b003929dd4fbccmr8434550wme.78.1650546601651;
        Thu, 21 Apr 2022 06:10:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj2QLE0t7c+W1A1zI66xtMe2VrmvbsInaE1mIB2dBlv25fFAS7XNtBJy/tayezvPH5sOeY0w==
X-Received: by 2002:a1c:acc4:0:b0:392:9dd4:fbcc with SMTP id v187-20020a1cacc4000000b003929dd4fbccmr8434523wme.78.1650546601339;
        Thu, 21 Apr 2022 06:10:01 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b00207982c7f4dsm2284875wrr.67.2022.04.21.06.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:10:00 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH 0/2] libblkid: add FSSIZE with XFS implementation
Date:   Thu, 21 Apr 2022 15:09:44 +0200
Message-Id: <20220421130946.318737-1-aalbersh@redhat.com>
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

I had a look into other fs, like ext4 and btrfs, to implement FSSIZE
for them, but I think I don't have enough expertize to do that as
they have not so trivial metadata overhead calculation :)

Andrey Albershteyn (2):
  libblkid: add interface for FSSIZE field
  libblkid: implement FSSIZE calculation for XFS

 libblkid/samples/superblocks.c         |  2 +-
 libblkid/src/blkid.h.in                |  1 +
 libblkid/src/superblocks/superblocks.c | 13 +++++++++++++
 libblkid/src/superblocks/superblocks.h |  1 +
 libblkid/src/superblocks/xfs.c         | 10 ++++++++++
 5 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.27.0

