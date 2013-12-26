Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:35071 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab3LZH4a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Dec 2013 02:56:30 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Madhu Pavan <kmp@linux.vnet.ibm.com>
Subject: Re: util-linux-2.24 not compatible with ppc64le architecture
Date: Thu, 26 Dec 2013 02:56:34 -0500
Cc: kzak@redhat.com, util-linux@vger.kernel.org, deepakcs@linux.vnet.ibm.com,
        athunugu@linux.vnet.ibm.com
References: <52BBD37B.30609@linux.vnet.ibm.com>
In-Reply-To: <52BBD37B.30609@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2308263.d7UCrLoPrb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201312260256.36705.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2308263.d7UCrLoPrb
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 26 December 2013 01:58:03 Madhu Pavan wrote:
> We are in the process of adding support for new arch (ppc64le) and as
> part of that we wanted to send patches for config.guess and configure as
> appropriate.

as i explained to one of your coworkers (specifically, about GNU/patch &=20
libtool & ppc64le), and to others about aarch64 in config.{sub,guess}, you'=
re=20
approaching this all wrong.  your packaging system should be updating confi=
g.
{sub,guess} automatically, and you probably should implement something for=
=20
autoregenerating libtool stuff for ppc64le support.

you're going to hit this in every single package out there.  it is=20
unreasonable to go to every maintainer and ask them to regenerate their=20
autotools & re-release using bleeding edge tools (in this case, master bran=
ch=20
of libtool).  you're going to have to update your build scripts to do this=
=20
automatically.  this is expected behavior every time you release a new=20
architecture that requires changes in core autotool packages.
=2Dmike

--nextPart2308263.d7UCrLoPrb
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSu+E0AAoJEEFjO5/oN/WBSy4QANntLYMX1Wo83UcYfZzi2vBM
r0SOVUp5eREOtpVd7OjphFd3nmRs9uMtIwrlK2LGoSP+bnZ3W2YKyRYTjKdy/O9v
KR4b2C/vvgdf2RMMDOU1g/SzRn4ClMMkS3TXKw6RENu9pHlm6flFTwNMUFKTArJG
7fdlxVXFQfXpyBaTR1X+NRL/+AzYrPyF1/s1zVChTlYqkDHo9ipddgVXuDoy+VxY
rYIy2Y6IG6X3Sg8bppK64OgJNYhgwPic9bm9RfbtYsxOJ0dAH/tb50ulYaUpZJOH
8HOE9Tgz9CJO5+nZzNz266+mVE4cu/R6/QhacYA+x3nSNjC+H51RkaFpR1j7qZ4K
f4FCwVKSPluh86QLWqsg+oTVgEYTZ5sVemEhK9pH3ap2/OQaRcKCq/XpWQglHzCM
k0b2xsGsq+OjPKz42u/Ttw8txVt7KlTrENR/kzXpuhHaEUbuE/IHwIkbJv6ffWtF
/85BN9rSJX0fqoCUGai9OfqsvoMoNnGXMQNdeW12QusG9YF8ZaULUx7mOxwM2WYj
QkOgm37qq/EWzEm4GPfxLckP1+SGxxJ7wRo7kS6z9YzqZlhi4d7Cq31IXbyHAHG8
xvOAZ6eZPxSByN10uUqah4m/kKHqCsvUfyfyI+oxvEnWDgDpbXBuIbev/U5V/41A
IouktTNSkI+UlGapkaTm
=mgrN
-----END PGP SIGNATURE-----

--nextPart2308263.d7UCrLoPrb--
