Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbdAWLdu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 23 Jan 2017 06:33:50 -0500
Date: Mon, 23 Jan 2017 12:33:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, util-linux@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH] Add blkzonecmd and blkreport ZAC/ZBC drives
Message-ID: <20170123113345.4jtjutolddgd4yy3@ws.net.home>
References: <1484816545-28033-1-git-send-email-shaun@tancheff.com>
 <3425316c-b457-daea-58f9-8e0d9dacf417@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3425316c-b457-daea-58f9-8e0d9dacf417@wdc.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 23, 2017 at 04:38:43PM +0900, Damien Le Moal wrote:
> Shaun,
> 
> On 1/19/17 18:02, Shaun Tancheff wrote:
> > +++ b/sys-utils/blkreset.c
> > @@ -0,0 +1,192 @@
> > +/*
> [...]
> > +
> > +	if (ioctl(fd, BLKGETSIZE64, &blksize))
> > +		err(EXIT_FAILURE, _("%s: BLKGETSIZE64 ioctl failed"), path);
> > +
> > +	blksectors = blksize << 9;
> 
> blksize being in bytes here, it looks like the shift is in the wrong
> direction here... i.e.
> 
> blksectors = blksize >> 9;

The ideal solution would be to avoid the ioctl and use
blkdev_get_sectors() or blkdev_get_size() from include/blkdev.h

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
