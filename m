Return-Path: <SRS0=om+s=W6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523C9C3A5A2
	for <util-linux@archiver.kernel.org>; Tue,  3 Sep 2019 13:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D0C215EA
	for <util-linux@archiver.kernel.org>; Tue,  3 Sep 2019 13:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfICNCC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:02:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbfICNCC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 3 Sep 2019 09:02:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A299308FE8F;
        Tue,  3 Sep 2019 13:02:02 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-73.brq.redhat.com [10.40.204.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A07B21001B1A;
        Tue,  3 Sep 2019 13:01:53 +0000 (UTC)
Date:   Tue, 3 Sep 2019 15:01:50 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        util-linux <util-linux@vger.kernel.org>,
        Mike Snitzer <msnitzer@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>, dm-devel@redhat.com,
        lvm-devel@redhat.com
Subject: Re: [PATCH] blkid: retport block size of a filesystem
Message-ID: <20190903130150.iatqincnxf4re7ce@10.255.255.10>
References: <alpine.LRH.2.02.1908291142470.17653@file01.intranet.prod.int.rdu2.redhat.com>
 <20190902105909.ah4pi4nwjefygskd@10.255.255.10>
 <CADxRZqwURQJMCCAkY8TvjBaQnCL9j1AHN3mY6b1q3bN-VCZRyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqwURQJMCCAkY8TvjBaQnCL9j1AHN3mY6b1q3bN-VCZRyA@mail.gmail.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 03 Sep 2019 13:02:02 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Sep 03, 2019 at 03:36:46PM +0300, Anatoly Pugachev wrote:
> On Mon, Sep 2, 2019 at 1:59 PM Karel Zak <kzak@redhat.com> wrote:
> > Applied (with two small fixes), thanks!
> 
> Karel, Mikulas,
> 
> ts/blkid/low-probe started to fail on sparc64 with this patch:
> 
>         blkid: superblocks probing: [97] xfs-log             ... OK
>         blkid: superblocks probing: [98] xfs                 ...
> FAILED (blkid/low-probe-xfs)
> 
> but is "OK" on x86_64.
> 
> $ diff -u expected/blkid/low-probe-xfs output/blkid/low-probe-xfs
> --- expected/blkid/low-probe-xfs        2019-09-03 12:45:18.779505561 +0300
> +++ output/blkid/low-probe-xfs  2019-09-03 14:35:41.569815684 +0300
> @@ -1,4 +1,4 @@
> -ID_FS_BLOCK_SIZE=512
> +ID_FS_BLOCK_SIZE=131072

  blkid_probe_set_block_size(pr, xs->sb_sectsize * 256);

be16_to_cpu() is missing here :-) I'll fix it.

    Karel


>  ID_FS_LABEL=test-xfs
>  ID_FS_LABEL_ENC=test-xfs
>  ID_FS_TYPE=xfs
> 
> $ md5sum output/blkid/images-fs/xfs.img
> c4a59d4039b5ed5557e8502ca2906373  output/blkid/images-fs/xfs.img
> 
> (md5 is the same as on x86_64 test machine)
> 
> You can use gcc202 sparc64 machine from gcc compile farm for the test.
> 
> PS: can someone regenerate xfs.img(xz) with more recent XFS filesystem version?
> 
> $ xfs_info output/blkid/images-fs/xfs.img
> xfs_info: V1 inodes unsupported. Please try an older xfsprogs.

or we need to add another xfs image. I guess we want to support all
versions.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
