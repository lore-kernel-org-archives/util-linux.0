Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39409 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262Ab1FTO5V (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jun 2011 10:57:21 -0400
Date: Mon, 20 Jun 2011 16:57:17 +0200
From: Karel Zak <kzak@redhat.com>
To: John Lindgren <john.lindgren@tds.net>
Cc: util-linux@vger.kernel.org, Andreas Dilger <adilger@sun.com>
Subject: Re: blkid: excessive random reads probing for ZFS on NTFS
	filesystem
Message-ID: <20110620145717.GJ17967@nb.net.home>
References: <4DF50D58.9020800@tds.net> <20110620111640.GE17967@nb.net.home> <4DFF3613.9050705@tds.net> <20110620124612.GF17967@nb.net.home> <4DFF45A0.1040703@tds.net> <20110620140457.GI17967@nb.net.home> <4DFF5712.4070606@tds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DFF5712.4070606@tds.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 20, 2011 at 10:20:02AM -0400, John Lindgren wrote:
> On 06/20/2011 10:04 AM, Karel Zak wrote:
> > On Mon, Jun 20, 2011 at 09:05:36AM -0400, John Lindgren wrote:
> >> I did try that; however, blkid checks *all* filesystems, even after it
> >> finds a match, just in case two probes turn up positive.  Even passing
> >> "-n nozfs" doesn't actually prevent it from checking for ZFS.
> >  The name of the FS in libblkid is zfs_member :-)
> >
> >     blkid -p -o udev -n nozfs_member
> >
> >  Yeah, crazy name, see our TODO file:
> >
> >    - add something like "blkid --list-known" to list all supported
> >      filesystems/raids

 Implemented, 
 
    blkid -k

 lists all known filesystems/RAIDs now.

> Perhaps a "-q/--quick" option could be added to blkid to allow an early
> exit once the first positive match is found? 

 That's dangerous, and many times rejected by udev upstream. The
 mainstream distributions rely on the automatic FS detection on many
 places. We are not able to control mkfs and partitioning tools, so we
 are not sure that the device has been properly wiped and there is
 really only one valid superblock. We already have bad experience with
 FAT, linux swap, luks, ... some people already lost data. 

> Then more difficult checks
> such as ZFS could be moved to the end of the list, as you suggest, with
> a performance benefit.

 What about to set to blkid (during boot) greater I/O priority than to
 read-ahead?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
