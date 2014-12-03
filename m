Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54120 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbaLCIg2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Dec 2014 03:36:28 -0500
Date: Wed, 3 Dec 2014 09:36:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Francis Moreau <francis.moro@gmail.com>,
        "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org,
        gabeblack@chromium.org, gwendal@chromium.org
Subject: Re: losetup on a image file containing (GPT) partition doesn't
 create partition devices
Message-ID: <20141203083617.GD1994@x2.net.home>
References: <542E7000.3040309@gmail.com>
 <201410031429.s93ET4wu014728@hobgoblin.ariadne.com>
 <201410031958.s93JwTuY026155@hobgoblin.ariadne.com>
 <542F065C.2080505@gmail.com>
 <54304C03.6020309@gmail.com>
 <201410061547.s96Fl0sN021617@hobgoblin.ariadne.com>
 <5432BBB0.30701@gmail.com>
 <20141027201625.GA25833@vapier>
 <547E1337.1080702@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547E1337.1080702@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 02, 2014 at 02:29:59PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 10/27/2014 4:16 PM, Mike Frysinger wrote:
> > we've been tracking the same bug in Chromium OS: 
> > http://crbug.com/411693 basically, under load, using `losetup -P`
> > randomly fails to create the relevant partition nodes.  atm we have
> > hacks in place to call `blockdev --rereadpt` when it looks like the
> > kernel has failed us.
> > 
> > it would be nice if the kernel didn't ignore the result of the
> > ioctl thus allowing all errors to go unnoticed.  you can see this
> > in drivers/block/loop.c where it calls ioctl_by_bdev multiple times
> > and doesn't check the return value.
> > 
> > since all current kernels are broken though, and might be for the
> > foreseeable future, having losetup issue the ioctl itself might be
> > a good tradeoff.  i think it'd trigger unnecessary overhead
> > (rescanning the device after it already worked), but seems better
> > than having losetup try and check other sources (like if arbitrary
> > partition nodes were created).
> 
> As long as the kernel has a flag that is supposed to cause it to
> interpret the partition table, then it should *work* and not silently
> fail.  This is a bug in the kernel that should be fixed.

Yes, I don't like the idea with the ioctl workaround in losetup. It's
fine to use such workarounds in stable branches or in distro specific
patches, but I really don't want to use workarounds for bugs in regular
releases (master branch). 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
