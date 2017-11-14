Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752278AbdKNKIO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Nov 2017 05:08:14 -0500
Date: Tue, 14 Nov 2017 11:08:10 +0100
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: what should blockdev getbpsz return 4k disks w/512e?
Message-ID: <20171114100810.3mflont7wwtnq7xp@ws.net.home>
References: <59FD83DF.805@tlinx.org>
 <20171106101938.a6l6t3r37qtqtuks@ws.net.home>
 <5A0A7311.8040007@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5A0A7311.8040007@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 13, 2017 at 08:37:37PM -0800, L A Walsh wrote:
> Karel Zak wrote:
> > On Sat, Nov 04, 2017 at 02:09:51AM -0700, L A Walsh wrote:
> > > I just tried blockdev on a HW raid device (/dev/sdb) composed of
> > > 4K disks that can (w/performance penalty) emulate 512 byte disk
> > > (i.e. have the 512e feature).  It is returning 512.
> > > 
> > > Any idea where this info should be showing up?
> > 
> > Try
> > 
> >  --getiomin                get minimum I/O size
> >  --getioopt                get optimal I/O size
> ----
> 
>  > sudo blockdev --getiomin /dev/sdb
>  512
>  > sudo blockdev --getioopt /dev/sdb
>  0
> > or
> > 
> >   lsblk --topology
> -----
> (some lines deleted for brevity):
> 
> NAME                 ALIGN IO:MIN OPT  PHYSEC LOGSEC ROT SCHED RQSZ  RA
> WSAME
> sda                    0    512    0     512    512   1   bfq  256   512
> 0B
> └─sda1                 0    512    0     512    512   1   bfq  256   512
> 0B
>  └─Backup-Media       0    512    0     512    512   1        128   128
> 0B
> sdb                    0    512    0     512    512   1   bfq  256   512
> 0B
> └─sdb1                 0    512    0     512    512   1   bfq  256   512
> 0B
>  ├─Data-Home          0    512    0     512    512   1        128   128
> 0B
>  └─Data-Edge          0    512    0     512    512   1        128   128
> 0B
> sdc                    0    512    0     512    512   1   bfq  256   512
> 0B
> ├─sdc1                 0    512    0     512    512   1   bfq  256   512
> 0B
> └─sdc10                0    512    0     512    512   1   bfq  256   512
> 0B
> 
> > It's possible that RAID (or another stacked device) uses 512
> > addressing, but for partitioning or mkfs-like tools we care about
> > minimal and optimal I/O.
> ----
>    Nothing but the RAID controller seems to know about the 4096 physical
> size.
>    (attached jpg from disk controller SW -- can see size under physical on
> right).
> 
>    If anything used a 512 byte offset anywhere, it would really impact
> performance, thus my concern about how or where a util would be able to read
> it...

Unfortunately userspace tools cannot play any usable role in this
story if your system (kernel) does not provide relevant information.
For mkfs and partitioning tools it's 512-bytes based devices... 

Let's ask kernel developers.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
