Return-Path: john.lindgren@tds.net
Message-ID: <4DFF5712.4070606@tds.net>
Date: Mon, 20 Jun 2011 10:20:02 -0400
From: John Lindgren <john.lindgren@tds.net>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Andreas Dilger <adilger@sun.com>
Subject: Re: blkid: excessive random reads probing for ZFS on NTFS filesystem
References: <4DF50D58.9020800@tds.net> <20110620111640.GE17967@nb.net.home> <4DFF3613.9050705@tds.net> <20110620124612.GF17967@nb.net.home> <4DFF45A0.1040703@tds.net> <20110620140457.GI17967@nb.net.home>
In-Reply-To: <20110620140457.GI17967@nb.net.home>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 06/20/2011 10:04 AM, Karel Zak wrote:
> On Mon, Jun 20, 2011 at 09:05:36AM -0400, John Lindgren wrote:
>> I did try that; however, blkid checks *all* filesystems, even after it
>> finds a match, just in case two probes turn up positive.  Even passing
>> "-n nozfs" doesn't actually prevent it from checking for ZFS.
>  The name of the FS in libblkid is zfs_member :-)
>
>     blkid -p -o udev -n nozfs_member
>
>  Yeah, crazy name, see our TODO file:
>
>    - add something like "blkid --list-known" to list all supported
>      filesystems/raids
>      
>  Karel

My bad.  "-n nozfs_member" does work, so I will add it to my udev rules
locally.

Perhaps a "-q/--quick" option could be added to blkid to allow an early
exit once the first positive match is found?  Then more difficult checks
such as ZFS could be moved to the end of the list, as you suggest, with
a performance benefit.

-- John
