Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8732 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225Ab2JaOdh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 31 Oct 2012 10:33:37 -0400
Date: Wed, 31 Oct 2012 15:33:32 +0100
From: Karel Zak <kzak@redhat.com>
To: Kay Sievers <kay@vrfy.org>
Cc: Matt Burgess <matthew@linuxfromscratch.org>, util-linux@vger.kernel.org
Subject: Re: Discrepancies between real and symlinked mtab
Message-ID: <20121031143332.GA24992@x2.net.home>
References: <1351638239.1651.13.camel@kyoto.localdomain>
 <20121031122453.GB27908@x2>
 <CAPXgP1092MT36BonZtqMpxR0dFWPeYwPFH4oCHDEgy3X2r9ozA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPXgP1092MT36BonZtqMpxR0dFWPeYwPFH4oCHDEgy3X2r9ozA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 31, 2012 at 01:46:43PM +0100, Kay Sievers wrote:
> On Wed, Oct 31, 2012 at 1:24 PM, Karel Zak <kzak@redhat.com> wrote:
> > On Tue, Oct 30, 2012 at 11:03:59PM +0000, Matt Burgess wrote:
> 
> >> 1) mount(8)
> >>
> >> /dev/root on / type ext3 (rw,relatime,data=ordered)
> >
> >  I see (Fedora 17, util-linux 2.21.2)
> 
> >    /dev/sda4 on / type ext4 (rw,relatime,data=ordered)
> 
> We see that only if we use an initramfs. In case the kernel mounts the
> fs directly and internally, there is /dev/root showing up.

 Ah, good point.

> >> Nope, that's not /dev/sda3.  And what is /dev/root anyway? There's no
> >> such node under /dev here.
> 
> The kernel creates that node in its own 'rootfs' names filesystem, the
> parent of the entire filesystem mount tree; but this is never visible
> anywhere in the real system, and never was.
> 
> Ideally, the kernel would be fixed to use the root= string, and not
> invent a name that does never exist.

 Yes, hmm... I'll try to improve libmount to convert /dev/root to
 something usable.

> > if I good remember there was symlink in some distributions
> 
> Some distributions created /dev/root with udev rules which have been
> composed at bootup. We dropped all that, because it is logic backwards
> and nothing on the system should rely on /dev/root being available.
> Modern filesystems like btrfs do not follow the "there is a single
> device below that mountpoint logic".

 I guess it's still necessary to use some magic btrfs ioctls to get
 info about the filesystem, right? It would be nice to have something
 in /sys/fs/btrfs.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
