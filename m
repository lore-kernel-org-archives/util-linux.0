Return-Path: <SRS0=VPyL=VO=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD623C76192
	for <util-linux@archiver.kernel.org>; Wed, 17 Jul 2019 11:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35C32173B
	for <util-linux@archiver.kernel.org>; Wed, 17 Jul 2019 11:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfGQLQQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 17 Jul 2019 07:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQLQQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 Jul 2019 07:16:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1461B87621;
        Wed, 17 Jul 2019 11:16:16 +0000 (UTC)
Received: from ws.net.home (ovpn-204-41.brq.redhat.com [10.40.204.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2817260BE2;
        Wed, 17 Jul 2019 11:16:13 +0000 (UTC)
Date:   Wed, 17 Jul 2019 13:16:11 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Mike Fleetwood <mike.fleetwood@googlemail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: blkid identifying whole disk ntfs as both ntfs and msdos
 partition table
Message-ID: <20190717111611.dfkjvyuvpuipfsmy@ws.net.home>
References: <CAMU1PDhRJRwawuSZ3x+NEAQx47afOhcSUw6wTsdcbNoz4th1hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMU1PDhRJRwawuSZ3x+NEAQx47afOhcSUw6wTsdcbNoz4th1hA@mail.gmail.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 17 Jul 2019 11:16:16 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jul 02, 2019 at 11:43:34AM +0100, Mike Fleetwood wrote:
> # mkntfs -Q -F /dev/sdb
> /dev/sdb is entire device, not just one partition.
> mkntfs forced anyway.
> Cluster size has been automatically set to 4096 bytes.
> Creating NTFS volume structures.
> mkntfs completed successfully. Have a nice day.
> # ./blkid --version
> lt-blkid from util-linux 2.34.24-e3bb9  (libblkid 2.34.24, 14-Jun-2019)
> # ./blkid /dev/sdb
> /dev/sdb: UUID="3B64D28A5CF89146" TYPE="ntfs" PTTYPE="dos"

Fixed version:

 # ./blkid -p /dev/sdc
 /dev/sdc: UUID="18CBAEE61457A850" TYPE="ntfs" USAGE="filesystem"

> # ./wipefs /dev/sdb
> DEVICE OFFSET TYPE UUID             LABEL
> sdb    0x3    ntfs 3B64D28A5CF89146
> sdb    0x1fe  dos

wipefs has a little bit different semantic, it tries to gather as
much as possible magic strings, so after the bug fix it still reports
"dos" on 0x1fe. It's expected behavior.

wipefs internally masks previously detected magic string (e.g. "ntfs")
to avoid any interaction with the next probing. This is because we
want to see all possibilities. Note wipefs wipes only the magic
strings (and nothing else), so if you wipe "NTFS" than it will be
interpreted as MBR ("dos") as there is no more valid NTFS.

> Note that the test ntfs image in util-linux doesn't cause this.  Just file
> systems created by mkntfs from ntfsprogs.
> 
> # dd if=/dev/zero bs=1M of=/dev/sdb
> # xzcat tests/ts/blkid/images-fs/ntfs.img.xz > /dev/sdb
> # ./blkid /dev/sdb
> /dev/sdb: LABEL="M-PM-^]M-PM->M-PM-2M-QM-^KM-PM-9 M-QM-^BM-PM->M-PM-<"
> UUID="09CBB6DE30C87310" TYPE="ntfs"
> # ./wipefs /dev/sdb
> DEVICE OFFSET TYPE UUID             LABEL
> sdb    0x3    ntfs 09CBB6DE30C87310 Новый том

Sounds like we need another test image :-)


Thanks for your reports!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
