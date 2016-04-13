Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:54055 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760484AbcDMMwJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Apr 2016 08:52:09 -0400
Subject: Re: [PATCH 0/3] btrfs-safe implementation of -oloop
To: Karel Zak <kzak@redhat.com>
References: <570D3CC7.5060809@suse.cz>
 <20160413110857.ftvekbq2fnbb2fau@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <570E40F7.3020902@suse.cz>
Date: Wed, 13 Apr 2016 14:52:07 +0200
MIME-Version: 1.0
In-Reply-To: <20160413110857.ftvekbq2fnbb2fau@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Tue, Apr 12, 2016 at 08:21:59PM +0200, Stanislav Brabec wrote:

>> - If the same backing file is already used for a read-only loop device,
>>    there is no safe way to continue.
>
> Why? Just re-use the read-only loopdev. We don't have have to promise
> read-write device if the backend is read only. This is generic
> behavior used in another cases too. For example if you try to mount
> NFS exported by server in read-only mode than your "rw" is ignored and
> result is "ro", the same is with read-only media (CDROM, etc.).

There is a problem that mount itself initializes loop as R/O:

# ./mount -oro,loop /btrfs.img /mnt/1
# ./mount -oloop,subvol=/ /btrfs.img /mnt/2
mount: /btrfs.img is used as read only loop, mounting read-only

> IMHO all we need is a warning, "backing file already used as
> read-only, mounting read-only".

This is part of patch 3. See above. Feel free to improve the warning.

>>    - There is no way to turn R/O loop to R/W in kernel.
>>    - If another loop is initialized, changes will not propagate to R/O
>>      volume.
>>    - One would need to umount all R/O devices, initialize loop R/W, and
>>      then everything mount again.
>>    I can imagine partial solution: Introduce looprw option. Such option
>>    would cause to initialize loop device R/W even for R/O mount.
>
> Sounds like over-engineering :-)

I think that mounting / as R/W and /snapshots as R/O could be a legal 
use. If mount mounts /snapshots first, there is no way to mount / R/W.

>> - If the same backing file is already used for a loop device with
>>    correct offset, but incorrect sizelimit, there is no solution. The
>>    current implementation does not check for it.
>
> IMHO the current "check start offset only" is a poor solution if we want
> to re-use loopdevs. It would be better to think about offset+limit
> as about partition and about backing-file as about whole-disk.

I am aware that it is unsafe. But it was easy, and will work in most 
"normal" cases. Nobody has a reason to initialize loop device that 
contains only half of the partition.

> It means check if the area specified by offset+limit does not overlap
> any existing backing-file mapping. It should be possible to re-use
> loopdev (by mount(8)) only if offset and size matches.
 >
> It should be also forbidden to create a new (non re-used) loopdev if
> area specified by offset and sizelimit overlap any existing backing
> file mapping. This is important!
>
> Maybe we can also improve losetup to warn about overlapping loop
> devices.

This sounds as a 100% safe solution.

>> - There exists a change for a race condition between device lookup and
>>    mount syscall.
>
> Sure.

I was thinking about LO_FLAGS_OPEN_FD flag for 
loopcxt_find_by_backing_file(). It will use open() as soon as possible, 
and if it fails, it repeats the iteration.
loopctxt_close_fd() would then close it.

But it would need more work, as mount does not have access to loopctxt.

>> - The implementation does not check for crypto. I think it is not a big
>>    problem, as it makes no sense to initialize the same backing file as
>>    encrypted and non-encrypted at once.
>
> There is nothing like loop devices encryption :-)

Good to know. It is still a part of kernel structures.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
