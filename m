Return-Path: <SRS0=Z5ID=U7=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DDAC06510
	for <util-linux@archiver.kernel.org>; Tue,  2 Jul 2019 18:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3376B20989
	for <util-linux@archiver.kernel.org>; Tue,  2 Jul 2019 18:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBSOo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:14:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55101 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbfGBSOo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 2 Jul 2019 14:14:44 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x62IEdHR017474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Jul 2019 14:14:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 77D0F42002E; Tue,  2 Jul 2019 14:14:39 -0400 (EDT)
Date:   Tue, 2 Jul 2019 14:14:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mike Fleetwood <mike.fleetwood@googlemail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: blkid identifying whole disk ntfs as both ntfs and msdos
 partition table
Message-ID: <20190702181439.GB3032@mit.edu>
References: <CAMU1PDhRJRwawuSZ3x+NEAQx47afOhcSUw6wTsdcbNoz4th1hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMU1PDhRJRwawuSZ3x+NEAQx47afOhcSUw6wTsdcbNoz4th1hA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jul 02, 2019 at 11:43:34AM +0100, Mike Fleetwood wrote:
> Hi,
> 
> Tested with mkntfs from ntfsprogs and blkid and wipefs from util-linux git HEAD.
> Test case:
> 
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
> # ./wipefs /dev/sdb
> DEVICE OFFSET TYPE UUID             LABEL
> sdb    0x3    ntfs 3B64D28A5CF89146
> sdb    0x1fe  dos

So what we call the dos partition table, Microsoft calls the "boot
sector", and it's not necessarily a partition table at all.  (Note
also that normally, Microsoft won't let you put an ntfs file system on
the whole disk --- and you had to force this with mkntfs -F.  It's
actually a bad idea, because some versions of Windows will see what it
thinks is an empty disk, and the contents of that whole disk file
system can be very easily overwritten by a confused Windows OS.)

You can see this in include/layout.h in the ntfs-3g sources.

This is a pretty broad and general confusion; fdisk will get confused
and think it is an empty dos partition table, and blkid will as well.
I suspect the right answer here is if the oem_id is "NTFS ", we should
not consider it a dos partition table at all, even if there is an "end
of boot sector" magic value of 0xaa55 at the end of the sector.

   		      	       	      	 - Ted
