Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f172.google.com ([209.85.216.172]:46653 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933973AbaLBTaT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Dec 2014 14:30:19 -0500
Received: by mail-qc0-f172.google.com with SMTP id m20so10106400qcx.3
        for <util-linux@vger.kernel.org>; Tue, 02 Dec 2014 11:30:18 -0800 (PST)
Message-ID: <547E1337.1080702@ubuntu.com>
Date: Tue, 02 Dec 2014 14:29:59 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Francis Moreau <francis.moro@gmail.com>,
        "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, gabeblack@chromium.org,
        gwendal@chromium.org
Subject: Re: losetup on a image file containing (GPT) partition doesn't create
 partition devices
References: <542E7000.3040309@gmail.com> <201410031429.s93ET4wu014728@hobgoblin.ariadne.com> <201410031958.s93JwTuY026155@hobgoblin.ariadne.com> <542F065C.2080505@gmail.com> <54304C03.6020309@gmail.com> <201410061547.s96Fl0sN021617@hobgoblin.ariadne.com> <5432BBB0.30701@gmail.com> <20141027201625.GA25833@vapier>
In-Reply-To: <20141027201625.GA25833@vapier>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/27/2014 4:16 PM, Mike Frysinger wrote:
> we've been tracking the same bug in Chromium OS: 
> http://crbug.com/411693 basically, under load, using `losetup -P`
> randomly fails to create the relevant partition nodes.  atm we have
> hacks in place to call `blockdev --rereadpt` when it looks like the
> kernel has failed us.
> 
> it would be nice if the kernel didn't ignore the result of the
> ioctl thus allowing all errors to go unnoticed.  you can see this
> in drivers/block/loop.c where it calls ioctl_by_bdev multiple times
> and doesn't check the return value.
> 
> since all current kernels are broken though, and might be for the
> foreseeable future, having losetup issue the ioctl itself might be
> a good tradeoff.  i think it'd trigger unnecessary overhead
> (rescanning the device after it already worked), but seems better
> than having losetup try and check other sources (like if arbitrary
> partition nodes were created).

As long as the kernel has a flag that is supposed to cause it to
interpret the partition table, then it should *work* and not silently
fail.  This is a bug in the kernel that should be fixed.

As a workaround though, you might consider just not using losetup -P
in the first place and just run partx when you want to activate
partitions.  This also has the advantage of working even when the loop
module is not loaded with the max_parts argument.





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUfhM3AAoJENRVrw2cjl5RvhcH/iaVXICM0zOxyc7YFTeQ4Tkk
5NgLJpZGy8yp4maxJcoPJ8Eryfs6SuQdglVtfjtGLhTOVEvUObe9ALey1/oilfUI
RCzBYyr+j9raD09MMA+yiNsYpeeptvWPRnPZF9TahRKWTMYSiOZoDMGQjvc1Rj3w
uSLDcmcknt/YA0nOSml8xuI84k1EeaV/s9Gt5Q9Rgjw8kvv3C5xROM9JfgC7unY8
4nF3n8F5jfGeGU/NtJAYJn+WnsX69AyAvveeo5e3GdO43NP818rF2K/6d9tyyN0Z
5159ZqRur75m/pC2PqQFMeoJ/3vefbWEMrQ3D73yH22f41ignZobzKHbGcDygD4=
=qPDy
-----END PGP SIGNATURE-----
