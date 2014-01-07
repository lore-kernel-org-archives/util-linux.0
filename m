Return-Path: vapier@gentoo.org
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Date: Tue, 7 Jan 2014 13:44:07 -0500
Cc: Thomas =?iso-8859-1?q?B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi> <52CBCF17.50706@archlinux.org> <20140107101935.GA2658@x2.net.home>
In-Reply-To: <20140107101935.GA2658@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1941623.qXf41kxsIf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201401071344.09876.vapier@gentoo.org>
List-ID: <util-linux.vger.kernel.org>

--nextPart1941623.qXf41kxsIf
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 January 2014 05:19:35 Karel Zak wrote:
> On Tue, Jan 07, 2014 at 10:55:35AM +0100, Thomas B=E4chler wrote:
> > >> We already have such a cyclic dependency, since udevd depends on
> > >> libblkid+libuuid, and findmnt (from util-linux) depends on libudev.
> > >>=20
> > >  .. and nobody complains, good point :-) Thanks!
> > > =20
> > >     Karel
> >=20
> > Actually, now that I know you care about these things, I am complaining.
> >=20
>  :-)))
>  :
> > It has caused me (minor) trouble once already.
>=20
>  It's possible (first time) to compile util-linux without libudev,
>  compile systemd/udevd and then again recompile util-linux with
>  libudev.
>=20
>  IMHO libudev is very useful for findmnt and lsblk to get info about
>  devices.
>=20
>  Note that uuidd is absolutely unnecessary if you don't have huge SAP
>  installation (-- it means unnecessary for 99% of the all Linux users).

on a semi-related matter, it'd be nice if we could easily build util-linux=
=20
such that we only get the libraries.  the plethora of configure flags that=
=20
control utils is a nightmare to manage, and i'm not sure there's a flag for=
=20
every utility (i haven't checked myself, so i could easily be wrong).

if that were in play, the circular loop would be easy to address -- build=20
util-linux once just for its libs, then udev/systemd, then util-linux again.
=2Dmike

--nextPart1941623.qXf41kxsIf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSzEr5AAoJEEFjO5/oN/WBU4IP/juqFsrBFvm501VnmmYZcs8i
3UF4hHIC4Q9zL/pRlFQC0XCeMIM8AFh9L1gK0hckyJzAKxj4y0N1AvBf1zHqm5+X
eV3Y9R9WopwBqyKTjvUGwLzeo6Hz2eumxsJeE4+xpkS2xmegzxT5V31B0OKNoTbL
owgQiCOXR9iAkuFj82gOQMkTlRwgkfBD+zozPeAogN/FDXSSKIRP8K0jZD+kBHHI
SgGQ1bM0lVM7CXf0Gzcg69w5fr45Nnq/fmVp6CDQB4OF4JQSlDLDLKlqhdFO3ezz
2ognUF3tBwJqyngbrWPsi1+BjJzRZB8c3cZSyom+d2RPIH9dIJKYpOAUmOBSJhF5
PgMgQxodiJRunVMM/FyufGpj7KPpDUclgqqJkNMRMB582gf9fxaqvDciao/8N4Cl
JMRXAVNKGQSW2CEGW103eN1kF5UM0gvxGTPDeB0GiuD3foh/YUCVXHCdQNCY6FJ1
fQ9w+MoR2+ASCq0s3/A9TQxys2BJpvuYrAfIwJvs/CnItMCoM7ReDo3aY6RmNSXm
VJeFKjzRb8CTU81ykLHVP4fN603xWPYf7RSMRYp/3lPjwn7Y9VShAXUT1vf3JukN
3qOEHfmyvFHu5cOIdeCXXPxC1J2ue+rrOLS2ExB+rOy70c9uVsN98ZHMJUbXn9u7
g2nclPRmatdE7gIMr6eg
=mfHB
-----END PGP SIGNATURE-----

--nextPart1941623.qXf41kxsIf--
