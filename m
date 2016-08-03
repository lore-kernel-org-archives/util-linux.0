Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH 0/8] losetup: re-use loop device
To: Karel Zak <kzak@redhat.com>
References: <aaabe320-5552-8963-4143-989e63ae3833@suse.cz>
 <20160803104721.y6wyq4644bgkza76@ws.net.home>
Cc: util-linux <util-linux@vger.kernel.org>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <5af5766e-98c0-1f53-7613-300f41f89e5c@suse.cz>
Date: Wed, 3 Aug 2016 15:30:22 +0200
MIME-Version: 1.0
In-Reply-To: <20160803104721.y6wyq4644bgkza76@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Dne 3.8.2016 v 12:47 Karel Zak napsal(a):
> On Tue, Aug 02, 2016 at 07:55:03PM +0200, Stanislav Brabec wrote:
>> Here is a patch set that is based on a "safe implementation of loop
>> reuse" patch set sent three weeks ago.
>
> I think it makes sense to reuse loop device by mount(8), because the
> goal is to mount FS and mount the same FS from two device may be
> disaster, but I'm not sure about losetup.
>
> Would be enough to keep it stupid and exit with error if the same
> backing file is already used and require --force to create duplicate
> loopdev?
>
>  if (!force && has_conflict(backing_file, ....))
>     err(EXIT_FAILURE, _("%s: already associated with %s"), ....);
>
That is why the patch is split to several parts. One adds conflict 
check, another adds re-use.

But I think, that it is useful. With the patch, you just can call 
"losetup --find --print loop.img" and don't care about the details. You 
will (nearly) always get a loop device, new or re-used.

For example:

Imagine that you want to write a script to mount btrfs snapshot, and you 
also want loopdev.

With the loop re-use feature:

#!/bin/sh
LOOPDEV=$(losetup --find --show /test.img)
fsck "$LOOPDEV"
mount -tbtrfs -osubvol=.snapshots/$1 $LOOPDEV /mnt/$1

Without the feature, r/w mount will cause data corruption,
and the correct script will require losetup --list output parsing.


I can imagine split of --force to two options:
--force: Ignore conflicts.
--new: Always allocate new loop device (the old behavior).


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
