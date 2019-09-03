Return-Path: <SRS0=om+s=W6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B459C3A5A2
	for <util-linux@archiver.kernel.org>; Tue,  3 Sep 2019 12:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1EE21881
	for <util-linux@archiver.kernel.org>; Tue,  3 Sep 2019 12:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shACxTOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfICMg7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:36:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39962 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfICMg7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 3 Sep 2019 08:36:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id v38so12499440edm.7
        for <util-linux@vger.kernel.org>; Tue, 03 Sep 2019 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+JOjjC9ZVu192uQtB4c+PagHpVwrX1ckHNApDJzFx4=;
        b=shACxTOdGhf746uYGbysRNVKvvDBq+FtlkRxg22lR/WWvFgbINsfw97jbqcnipn8d6
         7ziGigbhzXm9x7AejOCUflas0/quQhqoNytjxLpCD9bdIKohxu/00WQ3Zmllcxr7iJRL
         FwXbpOgMj9s47di5YPfJQETREm90LEaoMzY4lXoQ9UyB76yazUk8kp7n1wXbdux79g7Q
         fSWSoUtLh3GKb03ICbCrYirSWh3uXp3KvEWtLj8q+tm6BaCzXznROjEh5lqVTJolcos8
         6l2jnpSFhlTGwFT+N/WHZaQM2APatjKRGNqviGNVy2rAet+ovziIWK9OHAjMm/Br3VI0
         rOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+JOjjC9ZVu192uQtB4c+PagHpVwrX1ckHNApDJzFx4=;
        b=XXHnr9YCZ1UyR8xv8MP7i/yO/55e9kpINwreXoJNcvPQENE4hiLqzI7I21dLYwZp1x
         Pj9oh4loF5U3BUcAs80zDML+5FyvtBA9cKS8BrFYd4OgmPJinX2KIi5gFH9op6ZzQ1wm
         1W+aykHhSkzaQM4ML4tAQSPpQ4LkVxGK8d1ls6NtZ5BqXb1JEWwjy/zG+5P+5ICSXUs6
         MDx4+vaNMf+c8HAZxwiwDJxMqE1JCn0Cl8YU0RTPQ5V8rrSnD1bfdQClCirUFpec+WkF
         LXrC6GwRDrPodqUEryDyQkza39y4JDpErZ9tUB031oY+DvG3veZR9iWC1ufjY51y82DT
         MrkA==
X-Gm-Message-State: APjAAAXD5imOdC21YYwx70ZQc7yHEavim8eNaAED1D4Wv2ESaqadD5ox
        gWiL1ZV0IQyA163uV+EvvyaKKqHnwnN45yNllEs=
X-Google-Smtp-Source: APXvYqwsNfvafGEiRyz40BWvbFExKtfeTVOTJ5DuTi/JgrhmCKiKMbArB4z6BmT03Lr0MgzyGNeEzERLYJg+HPLgs64=
X-Received: by 2002:a50:a147:: with SMTP id 65mr17334939edj.241.1567514217476;
 Tue, 03 Sep 2019 05:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.1908291142470.17653@file01.intranet.prod.int.rdu2.redhat.com>
 <20190902105909.ah4pi4nwjefygskd@10.255.255.10>
In-Reply-To: <20190902105909.ah4pi4nwjefygskd@10.255.255.10>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 3 Sep 2019 15:36:46 +0300
Message-ID: <CADxRZqwURQJMCCAkY8TvjBaQnCL9j1AHN3mY6b1q3bN-VCZRyA@mail.gmail.com>
Subject: Re: [PATCH] blkid: retport block size of a filesystem
To:     Karel Zak <kzak@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>
Cc:     util-linux <util-linux@vger.kernel.org>,
        Mike Snitzer <msnitzer@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>, dm-devel@redhat.com,
        lvm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Sep 2, 2019 at 1:59 PM Karel Zak <kzak@redhat.com> wrote:
> Applied (with two small fixes), thanks!

Karel, Mikulas,

ts/blkid/low-probe started to fail on sparc64 with this patch:

        blkid: superblocks probing: [97] xfs-log             ... OK
        blkid: superblocks probing: [98] xfs                 ...
FAILED (blkid/low-probe-xfs)

but is "OK" on x86_64.

$ diff -u expected/blkid/low-probe-xfs output/blkid/low-probe-xfs
--- expected/blkid/low-probe-xfs        2019-09-03 12:45:18.779505561 +0300
+++ output/blkid/low-probe-xfs  2019-09-03 14:35:41.569815684 +0300
@@ -1,4 +1,4 @@
-ID_FS_BLOCK_SIZE=512
+ID_FS_BLOCK_SIZE=131072
 ID_FS_LABEL=test-xfs
 ID_FS_LABEL_ENC=test-xfs
 ID_FS_TYPE=xfs

$ md5sum output/blkid/images-fs/xfs.img
c4a59d4039b5ed5557e8502ca2906373  output/blkid/images-fs/xfs.img

(md5 is the same as on x86_64 test machine)

You can use gcc202 sparc64 machine from gcc compile farm for the test.

PS: can someone regenerate xfs.img(xz) with more recent XFS filesystem version?

$ xfs_info output/blkid/images-fs/xfs.img
xfs_info: V1 inodes unsupported. Please try an older xfsprogs.

$ dpkg -l xfsprogs
ii  xfsprogs       5.0.0-1      sparc64      Utilities for managing
the XFS filesystem
