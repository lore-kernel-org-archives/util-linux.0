Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750739AbdKFKTl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 6 Nov 2017 05:19:41 -0500
Date: Mon, 6 Nov 2017 11:19:38 +0100
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: what should blockdev getbpsz return 4k disks w/512e?
Message-ID: <20171106101938.a6l6t3r37qtqtuks@ws.net.home>
References: <59FD83DF.805@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59FD83DF.805@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Nov 04, 2017 at 02:09:51AM -0700, L A Walsh wrote:
> 
> I just tried blockdev on a HW raid device (/dev/sdb) composed of
> 4K disks that can (w/performance penalty) emulate 512 byte disk
> (i.e. have the 512e feature).  It is returning 512.
> 
> If the disk is composed of 4K disks, shouldn't the raid show 4K
> as well?  Otherwise, how do utils know what alignment to use or
> not to use 512 due to penalty costs?  For my formatted disks, I
> use 4K allocation units, so for those, I shouldn't see problems,
> but some other disk subsystems or raw-disk using progs also need to
> know to allocate on 4K boundaries.
> 
> Any idea where this info should be showing up?

Try

 --getiomin                get minimum I/O size
 --getioopt                get optimal I/O size

or

  lsblk --topology

It's possible that RAID (or another stacked device) uses 512
addressing, but for partitioning or mkfs-like tools we care about
minimal and optimal I/O.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
