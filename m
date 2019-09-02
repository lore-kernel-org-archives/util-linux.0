Return-Path: <SRS0=o1os=W5=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808CBC3A59E
	for <util-linux@archiver.kernel.org>; Mon,  2 Sep 2019 10:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540312168B
	for <util-linux@archiver.kernel.org>; Mon,  2 Sep 2019 10:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfIBK7T (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:59:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbfIBK7S (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 2 Sep 2019 06:59:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E745307CDD1;
        Mon,  2 Sep 2019 10:59:18 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-73.brq.redhat.com [10.40.204.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E90A8608C1;
        Mon,  2 Sep 2019 10:59:11 +0000 (UTC)
Date:   Mon, 2 Sep 2019 12:59:09 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Patrick Steinhardt <ps@pks.im>, util-linux@vger.kernel.org,
        Mike Snitzer <msnitzer@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>, dm-devel@redhat.com,
        lvm-devel@redhat.com
Subject: Re: [PATCH] blkid: retport block size of a filesystem
Message-ID: <20190902105909.ah4pi4nwjefygskd@10.255.255.10>
References: <alpine.LRH.2.02.1908291142470.17653@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1908291142470.17653@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 02 Sep 2019 10:59:18 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Aug 29, 2019 at 11:52:13AM -0400, Mikulas Patocka wrote:
>  libblkid/src/superblocks/apfs.c        |    2 
>  libblkid/src/superblocks/befs.c        |    3 +
>  libblkid/src/superblocks/btrfs.c       |    1 
>  libblkid/src/superblocks/exfat.c       |    2 
>  libblkid/src/superblocks/exfs.c        |    4 +
>  libblkid/src/superblocks/ext.c         |    3 +
>  libblkid/src/superblocks/f2fs.c        |    2 
>  libblkid/src/superblocks/gfs.c         |    1 
>  libblkid/src/superblocks/hfs.c         |    2 
>  libblkid/src/superblocks/hpfs.c        |    1 
>  libblkid/src/superblocks/iso9660.c     |    2 
>  libblkid/src/superblocks/jfs.c         |    1 
>  libblkid/src/superblocks/minix.c       |    5 ++
>  libblkid/src/superblocks/nilfs.c       |    3 +
>  libblkid/src/superblocks/ntfs.c        |    2 
>  libblkid/src/superblocks/ocfs.c        |    3 +
>  libblkid/src/superblocks/reiserfs.c    |   10 +++-
>  libblkid/src/superblocks/romfs.c       |    3 +
>  libblkid/src/superblocks/squashfs.c    |    2 
>  libblkid/src/superblocks/superblocks.c |    7 +++
>  libblkid/src/superblocks/superblocks.h |    2 
>  libblkid/src/superblocks/udf.c         |    2 
>  libblkid/src/superblocks/ufs.c         |    5 ++
>  libblkid/src/superblocks/vfat.c        |    2 
>  libblkid/src/superblocks/vxfs.c        |   18 +++++++
>  libblkid/src/superblocks/xfs.c         |    1 
>  libblkid/src/superblocks/zfs.c         |   76 ++++++++++++++++++++++++---------
>  27 files changed, 144 insertions(+), 21 deletions(-)

Applied (with two small fixes), thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
