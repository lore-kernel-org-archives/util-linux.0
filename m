Return-Path: <SRS0=Z5ID=U7=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5F3C06510
	for <util-linux@archiver.kernel.org>; Tue,  2 Jul 2019 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9391E21850
	for <util-linux@archiver.kernel.org>; Tue,  2 Jul 2019 19:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfGBTGt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 2 Jul 2019 15:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBTGt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Jul 2019 15:06:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02EF83082B46;
        Tue,  2 Jul 2019 19:06:49 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B165C57D;
        Tue,  2 Jul 2019 19:06:46 +0000 (UTC)
Date:   Tue, 2 Jul 2019 21:06:44 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Mike Fleetwood <mike.fleetwood@googlemail.com>,
        util-linux@vger.kernel.org
Subject: Re: blkid identifying whole disk ntfs as both ntfs and msdos
 partition table
Message-ID: <20190702190644.57acag2rfaclu5e7@ws.net.home>
References: <CAMU1PDhRJRwawuSZ3x+NEAQx47afOhcSUw6wTsdcbNoz4th1hA@mail.gmail.com>
 <20190702181439.GB3032@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702181439.GB3032@mit.edu>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 02 Jul 2019 19:06:49 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jul 02, 2019 at 02:14:39PM -0400, Theodore Ts'o wrote:
> On Tue, Jul 02, 2019 at 11:43:34AM +0100, Mike Fleetwood wrote:
> > Hi,
> > 
> > Tested with mkntfs from ntfsprogs and blkid and wipefs from util-linux git HEAD.
> > Test case:
> > 
> > # mkntfs -Q -F /dev/sdb
> > /dev/sdb is entire device, not just one partition.
> > mkntfs forced anyway.
> > Cluster size has been automatically set to 4096 bytes.
> > Creating NTFS volume structures.
> > mkntfs completed successfully. Have a nice day.
> > # ./blkid --version
> > lt-blkid from util-linux 2.34.24-e3bb9  (libblkid 2.34.24, 14-Jun-2019)
> > # ./blkid /dev/sdb
> > /dev/sdb: UUID="3B64D28A5CF89146" TYPE="ntfs" PTTYPE="dos"
> > # ./wipefs /dev/sdb
> > DEVICE OFFSET TYPE UUID             LABEL
> > sdb    0x3    ntfs 3B64D28A5CF89146
> > sdb    0x1fe  dos

 Thanks for your report Mike.

> So what we call the dos partition table, Microsoft calls the "boot
> sector", and it's not necessarily a partition table at all.  (Note
> also that normally, Microsoft won't let you put an ntfs file system on
> the whole disk --- and you had to force this with mkntfs -F.  It's
> actually a bad idea, because some versions of Windows will see what it
> thinks is an empty disk, and the contents of that whole disk file
> system can be very easily overwritten by a confused Windows OS.)
> 
> You can see this in include/layout.h in the ntfs-3g sources.
> 
> This is a pretty broad and general confusion; fdisk will get confused
> and think it is an empty dos partition table, and blkid will as well.
> I suspect the right answer here is if the oem_id is "NTFS ", we should
> not consider it a dos partition table at all, even if there is an "end
> of boot sector" magic value of 0xaa55 at the end of the sector.

 Well, our MBR detection is more sophisticated check for 0xaa55 magic
 ;-) but NTFS is not in the game now. I'll fix it. We need extra check
 for NTFS (as we already use for some FATs or GPT+PMBR).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
