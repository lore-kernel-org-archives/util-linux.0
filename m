Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbeJDQgH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 4 Oct 2018 12:36:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9599C81DF7
        for <util-linux@vger.kernel.org>; Thu,  4 Oct 2018 09:43:40 +0000 (UTC)
Date: Thu, 4 Oct 2018 11:43:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Vojtech Trefny <vtrefny@redhat.com>,
        Mike Snitzer <msnitzer@redhat.com>, dm-devel@redhat.com,
        lvm-devel@redhat.com, util-linux@vger.kernel.org
Subject: Re: libblkid filesystem block size
Message-ID: <20181004094329.z6b7y4ahhmb4ayj6@ws.net.home>
References: <alpine.LRH.2.02.1810031724070.7859@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.02.1810031724070.7859@file01.intranet.prod.int.rdu2.redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Ahoj,

On Wed, Oct 03, 2018 at 05:41:59PM -0400, Mikulas Patocka wrote:
> As you maintain libblkid, I'd like to ask - would it be possible to add 
> detection of filesystem block size to it? libblkid already has description 
> of various filesystem superblocks, so it shouldn't be too hard.

we had something like this (and also FS size) in our TODO for years.
So, I don't see problem to add it now. Send patch ;-)

All you need is to add 

 libblkid/src/superblocks/superblocks.c: blkid_probe_set_fs_blocksize() 

to add "BLKSZ" variable to the probing result (use for example
blkid_probe_set_version() as a template).

And then use this function in FS specific probers. The variable will
automatically visible for udev as ID_FS_BLKSZ=.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
