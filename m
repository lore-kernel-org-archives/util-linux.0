Return-Path: john.lindgren@tds.net
Message-ID: <4DFF45A0.1040703@tds.net>
Date: Mon, 20 Jun 2011 09:05:36 -0400
From: John Lindgren <john.lindgren@tds.net>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Andreas Dilger <adilger@sun.com>
Subject: Re: blkid: excessive random reads probing for ZFS on NTFS filesystem
References: <4DF50D58.9020800@tds.net> <20110620111640.GE17967@nb.net.home> <4DFF3613.9050705@tds.net> <20110620124612.GF17967@nb.net.home>
In-Reply-To: <20110620124612.GF17967@nb.net.home>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 06/20/2011 08:46 AM, Karel Zak wrote:
>  Unfortunately, the old less expensive version of the ZFS detection
>  code was insufficient.  See Andreas' patches:
>
>  commit e54a76ca076625b1883ddf0595162eb8de81d5d1
>  Author: Andreas Dilger <adilger@sun.com>
>  Date:   Wed Feb 17 10:21:27 2010 +0100
>
>  commit a1fbeb3df35d1441c4ef64ea7e04c2b1fda38ba2
>  Author: Andreas Dilger <adilger@sun.com>
>  Date:   Thu Mar 11 15:16:46 2010 +0100

Understood.  The older implementation performed a less thorough search
for a valid uberblock, which I would expect to sometimes fail.

>> Andreas: As far as implementation, I think the ZFS code could be
>> improved by parsing the name-value pair list *before* searching for a
>> valid uberblock, rather than after.
> Doesn't depend the position of the list on the position of the valid
> uberblock?

No, it's at a fixed offset of 16k within the vdev label (before the
uberblock array, which is at 128k).

>> I don't have any ZFS filesystems
>> around to test with, or I would try to do this myself.
> There is a test image, see tests/ts/blkid/images-fs/zfs.img.bz2

Okay, thanks.

>  Maybe you can try to move zfs to the end of the probed filesystems 
>  in libblkid/src/superblocks/superblocks.c. It would be better to
>  probe for exotic and "expensive" filesytems later.

I did try that; however, blkid checks *all* filesystems, even after it
finds a match, just in case two probes turn up positive.  Even passing
"-n nozfs" doesn't actually prevent it from checking for ZFS.

Maybe it would be better to change this behavior and leave the ZFS code
as is?

-- John
