Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:57067 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbbBPIwg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Feb 2015 03:52:36 -0500
Date: Mon, 16 Feb 2015 03:52:29 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Francis Moreau <francis.moro@gmail.com>,
        "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, gabeblack@chromium.org,
        gwendal@chromium.org
Subject: Re: losetup on a image file containing (GPT) partition doesn't
 create partition devices
Message-ID: <20150216085229.GF4075@vapier>
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
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
In-Reply-To: <547E1337.1080702@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02 Dec 2014 14:29, Phillip Susi wrote:
> On 10/27/2014 4:16 PM, Mike Frysinger wrote:
> > we've been tracking the same bug in Chromium OS:=20
> > http://crbug.com/411693 basically, under load, using `losetup -P`
> > randomly fails to create the relevant partition nodes.  atm we have
> > hacks in place to call `blockdev --rereadpt` when it looks like the
> > kernel has failed us.
> >=20
> > it would be nice if the kernel didn't ignore the result of the
> > ioctl thus allowing all errors to go unnoticed.  you can see this
> > in drivers/block/loop.c where it calls ioctl_by_bdev multiple times
> > and doesn't check the return value.
> >=20
> > since all current kernels are broken though, and might be for the
> > foreseeable future, having losetup issue the ioctl itself might be
> > a good tradeoff.  i think it'd trigger unnecessary overhead
> > (rescanning the device after it already worked), but seems better
> > than having losetup try and check other sources (like if arbitrary
> > partition nodes were created).
>=20
> As long as the kernel has a flag that is supposed to cause it to
> interpret the partition table, then it should *work* and not silently
> fail.  This is a bug in the kernel that should be fixed.

i agree the kernel should be fixed.  but like i said, it isn't today, and i=
t=20
won't be for a while, and even then it'll take a while for all those fixed=
=20
kernel versions to percolate out to distros.

> As a workaround though, you might consider just not using losetup -P
> in the first place and just run partx when you want to activate
> partitions.  This also has the advantage of working even when the loop
> module is not loaded with the max_parts argument.

thanks, wasn't aware of the partx tool
-mike

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU4a/NAAoJEEFjO5/oN/WBRq4QAKAGTZSp0gcTavowbTUqpaOI
jRAR5+bk6MxxOANMkUoGQlH3nXo7xQR+Tq0F4KqXxCFkz9BfCA7k5pgTdqSJLSH8
mCh8t6VDMFhUGViCJvKBoh1LEti6lVu1h9lSUlBIORAOV/FpGx2wXoSRKt9Svva1
bth9ANJAxmFQ3ootiUbVnMYol+0/oF8xU37B3fuUmjjoeHu2+gcooZEUDdv7a8dM
zRsELhfJEIXw8RgXI9nynDA2SmgTbHhc9X5cDwU1Jq59Qtw5XZbzQzeYy7w1W/IP
+bnbcr49yvPRAGq3PntxXFeCoTlQV6AtStwaZ6awAxtZfZQXElPmccqU8F0GrMiH
LHu5ZM6KKnhgtTRb7ZIruc/oW2O8NZMhuJANkVn84nGTGGtV9A80zezkyLxOyMQr
P9D49Ml+Txzhwcrj58wuCME7Xw/lok5q1QIoE4EBgQ8lA/AqLEinxcJ9GBxLq4w9
/QmZC1BiqFxeay7Mdl/e6fFnyX4YtXgliPyp3yviwkXOQBJiVRaQiyOuCL+fI+87
UVZHXejn2zOZa+NW44fpaqNFA+6gF3RY+HnG0XNXK9Z5hyJvaPGE+uxqN5x6x3kM
338SGAQ5Xp0XEe5POII8jCavXV+NGNPNW1ELMbGs8tk7Vj/h0VPoZ0e9vnpSEt58
0iXxZaS4WbPdrDpPRAxp
=JO2T
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
