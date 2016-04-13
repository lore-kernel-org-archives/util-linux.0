Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:53866 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030681AbcDML3x (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Apr 2016 07:29:53 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 0/3] btrfs-safe implementation of -oloop
Date: Wed, 13 Apr 2016 13:29:35 +0200
Cc: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
References: <570D3CC7.5060809@suse.cz> <20160413110857.ftvekbq2fnbb2fau@ws.net.home>
In-Reply-To: <20160413110857.ftvekbq2fnbb2fau@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201604131329.35899.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 13 April 2016, Karel Zak wrote:
> On Tue, Apr 12, 2016 at 08:21:59PM +0200, Stanislav Brabec wrote:
> > Exactly this happened if -oloop is used multiple times with the
> > same source.
> >
> > It could not happen in past, but with introduction of btrfs
> > sub-volumes it has a perfectly legal use cases.
> >
> > This patch set introduces a new behavior of -oloop:
> >
> > First check, whether the same backing file with the same offset is
> > already used. If yes, reuse already initialized loop device.
> >
> > If not, initialize another loop device.
>
> I think this behaviour (re-use loopdev) is better, I thought about it
> years ago, but it has never been implemented due to backward
> compatibility. Now it's obvious it's the right way to go.
>
> > There are some controversial things with these patches. Some of
> > them cannot be fixed.
> >
> > - Kernel never returns EBUSY for LOOP_CLR_FD. It prevents errors
> > when mount will steal other's loop device. But I am not sure,
> > whether it will work correctly in all possible situations. Anyway,
> > I don't see a better solution.
> >
> > - If the same backing file is already used for a read-only loop
> > device, there is no safe way to continue.
>
> Why? Just re-use the read-only loopdev. We don't have have to promise
> read-write device if the backend is read only. This is generic
> behavior used in another cases too. For example if you try to mount
> NFS exported by server in read-only mode than your "rw" is ignored
> and result is "ro", the same is with read-only media (CDROM, etc.).
>
> IMHO all we need is a warning, "backing file already used as
> read-only, mounting read-only".
>
> >   - There is no way to turn R/O loop to R/W in kernel.
> >   - If another loop is initialized, changes will not propagate to
> > R/O volume.
> >   - One would need to umount all R/O devices, initialize loop R/W,
> > and then everything mount again.
> >   I can imagine partial solution: Introduce looprw option. Such
> > option would cause to initialize loop device R/W even for R/O
> > mount.
>
> Sounds like over-engineering :-)
>
> > - If the same backing file is already used for a loop device with
> >   correct offset, but incorrect sizelimit, there is no solution.
> > The current implementation does not check for it.
>
> IMHO the current "check start offset only" is a poor solution if we
> want to re-use loopdevs. It would be better to think about
> offset+limit as about partition and about backing-file as about
> whole-disk.
>
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
>
> > - There exists a change for a race condition between device lookup
> > and mount syscall.
>
> Sure.
>
> > - The implementation does not check for crypto. I think it is not a
> > big problem, as it makes no sense to initialize the same backing
> > file as encrypted and non-encrypted at once.
>
> There is nothing like loop devices encryption :-)

openSUSE had cryptoloop before 12.2. But it's not supported anymore.
There was also losetup -e:
       -e, -E, --encryption encryption_type
              enable data encryption with specified name or number

cu,
Rudi
