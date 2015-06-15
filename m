Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755703AbbFONb4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Jun 2015 09:31:56 -0400
Date: Mon, 15 Jun 2015 15:31:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Tom Yan <tom.ty89@gmail.com>
Cc: util-linux@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: optimal io size / custom alignment
Message-ID: <20150615133154.GV1992@ws.net.home>
References: <CAGnHSE=gtd2WVcxOBoyfqnp3QtT4RHfK356GHastBbiK5mtmFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGnHSE=gtd2WVcxOBoyfqnp3QtT4RHfK356GHastBbiK5mtmFA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 13, 2015 at 10:52:04PM +0800, Tom Yan wrote:
> As I have mentioned in previous mails, I have an sata/usb3 adapter
> which could work in uas mode, and when it does, it has a weird optimal
> i/o size:
> 
> Disk /dev/sdb: 74.5 GiB, 80026361856 bytes, 156301488 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 33553920 bytes

This is no problem (33553920 % 512 = 0) with the current kernel and
the current util-linux git tree where we support non power of 2
alignment.

> http://www.linuxquestions.org/questions/linux-newbie-8/how-to-foramt-2tb-external-hard-drive-4175529792/
> 
> In the above link, there shows another similar case of an external
> drive with 4k physical sector.

from the link:

    Sector size (logical/physical): 512 bytes / 4096 bytes
    I/O size (minimum/optimal): 4096 bytes / 33553920 bytes

this is problem (33553920 % 4096 != 0) and frankly it seems like
pretty strange thing, maybe kernel guys can comment it (CC: to
Martin).

> I am not sure if there's anything wrong with the device(s) or the
> kernel, but anyway I doubt if fdisk should determine alignment with
> this size. As you can calculate, it may not necessarily be a multiple
> of the size of physical sectors, or that of common erase block of SSDs
> (which is not reported anywhere AFAIK).
> 
> Perhaps this I/O size does matter on alignment for certain cases, but
> shouldn't physical sector or erase block be at least of higher
> priority when it comes to alignment?

I think we can test "optimal_io_size % physical_sector_size" and use physical
sector size as the granularity if the optimal_io_size is a strange number.

> In any case, it would be nice if fdisk can allow customize alignment
> (like gdisk does), so that users can at least decide how partitions
> should be aligned in weird cases like this. With that, the long-time
> deprecated "dos compatibility" might be able to go as well.

I'll think about it...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
