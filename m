Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:57984 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbbGGEZO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Jul 2015 00:25:14 -0400
Date: Tue, 7 Jul 2015 00:25:12 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt once the network addresses change if
 address displayed
Message-ID: <20150707042512.GI17734@vapier>
References: <1435928288-25644-1-git-send-email-stefw@redhat.com>
 <20150706140711.GF17734@vapier>
 <559ACFC3.6050303@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZa61AII3s1sGKYx"
In-Reply-To: <559ACFC3.6050303@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--YZa61AII3s1sGKYx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06 Jul 2015 13:58, Bruce Dubbs wrote:
> Mike Frysinger wrote:
> > On 03 Jul 2015 14:58, Stef Walter wrote:
> >    #ifdef AGETTY_RELOAD
> >>   # include <sys/inotify.h>
> >> +# include <linux/netlink.h>
> >> +# include <linux/rtnetlink.h>
> >
> > why not use libmnl instead ?
> > 	http://netfilter.org/projects/libmnl
>=20
> That would not work for the LinuxFromScratch project.  At the time=20
> util-linux is built, libmnl is not available.

then update the LFS insns to include libmnl, or build util-linux with the
reload option disabled.  i don't see how LFS's decisions are relevant here.
-mike

--YZa61AII3s1sGKYx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVm1SoAAoJEEFjO5/oN/WBc+MP/0TcV9p4IQisWEkhnDvwQNUi
6b75FN2STfBnM1sQZLx3ZUZDJv07PvkvxjWC1/dKrpZ/+fx71EQUyeAnjo7QCKh9
jSSXcUBnNHFuG6ygaqbGcSKQ/wRjGvd7KSJunAEiNGvEb+j1MnwVBDLqatfxEIE/
I5WNJ9I6gzZTruDZQMZGjb3L0IgaCu3Gw+2qtQ+28aSn9LJDMla0ci8n53+BF+lk
WZ0ZPYcELSz0gOgVfSB8LaH91T9Jka6ivoR3eS5IwPwNQ/R1Y1g0/IrfW2jr+PLg
WDN+JYGK7p6dYT5GenmAu8FyNRfGKpdetuAJurDOFsXaGKw80LUVReslMj0DthTq
kSMvqhPvc8a03BOjeSNiTX6qF/qZybSvIuhSRq1SPHtCiH8iTiNB7Y3autdOL7Dg
jD9N//b963PMXMcD62IWVvcEAJwku0b/nLcz0ZenAsNHSfKNF1ZrpVzLfcba2//O
tG9eepT/JTx5Gb/XdTL6AqSEUmn2E+CFZCiV5BPuoizQpJJOtUmk93l9G4r5pOF6
SdFd6jX3NZyL/wYO9MAIxu8JYCb3t8yp75n8cvlced7SDZauIh5duLuf5XLHOnyc
1iePw3WbQrPQvmWMoc7npglVqEwY3CkWocUbl65D3BohBEga9/l/3Rh1kGl6ggKc
tT9RYqpkrzwM1O8vG2tm
=GcPo
-----END PGP SIGNATURE-----

--YZa61AII3s1sGKYx--
