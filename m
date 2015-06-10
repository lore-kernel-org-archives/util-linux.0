Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57252 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753814AbbFJLHc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Jun 2015 07:07:32 -0400
Date: Wed, 10 Jun 2015 13:07:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Tom Yan <tom.ty89@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: multiple alignment bugs / inconsistencies of fdisk
Message-ID: <20150610110730.GL1992@ws.net.home>
References: <CAGnHSE=QDqKbOKGrBH=4J_mv85V5ZumVmjoQ3Jpqig4CN4MU4Q@mail.gmail.com>
 <20150608153535.GE1992@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150608153535.GE1992@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 08, 2015 at 05:35:35PM +0200, Karel Zak wrote:
> >     Using default response p.
> >     Partition number (1-4, default 1):
> >     First sector (2048-468862127, default 2048):
> >     Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
> > 468862127): +1
> > 
> >     Created a new partition 1 of type 'Linux' and of size 1 KiB.
> > 
> >     Command (m for help): p
> >     Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
> >     Units: sectors of 1 * 512 = 512 bytes
> >     Sector size (logical/physical): 512 bytes / 512 bytes
> >     I/O size (minimum/optimal): 512 bytes / 512 bytes
> >     Disklabel type: dos
> >     Disk identifier: 0x344a2daa
> > 
> >     Device     Boot Start   End Sectors Size Id Type
> >     /dev/sda1        2048  2049       2   1K 83 Linux
> 
> Fixed, now:
> 
>       Device     Boot Start   End Sectors  Size Id Type
>       /dev/sdc1        2048  2048       1  512B 83 Linux

 I have reverted this small change, it's nonsense. The convention +<sectors>
 specifies Last sector relatively to the First sector.

  +0  means   start=2048  end=2048  size=1
  +1  means   start=2048  end=2049  size=2

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
