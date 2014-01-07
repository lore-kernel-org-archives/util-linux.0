Return-Path: vapier@gentoo.org
From: Mike Frysinger <vapier@gentoo.org>
To: Dave Reisner <d@falconindy.com>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Date: Tue, 7 Jan 2014 14:57:19 -0500
Cc: Karel Zak <kzak@redhat.com>,
        Thomas =?iso-8859-1?q?B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi> <201401071344.09876.vapier@gentoo.org> <20140107185154.GB580@rampage>
In-Reply-To: <20140107185154.GB580@rampage>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11593672.X149OsIukN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201401071457.21365.vapier@gentoo.org>
List-ID: <util-linux.vger.kernel.org>

--nextPart11593672.X149OsIukN
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 January 2014 13:51:54 Dave Reisner wrote:
> On Tue, Jan 07, 2014 at 01:44:07PM -0500, Mike Frysinger wrote:
> > On Tuesday 07 January 2014 05:19:35 Karel Zak wrote:
> > > On Tue, Jan 07, 2014 at 10:55:35AM +0100, Thomas B=E4chler wrote:
> > > > >> We already have such a cyclic dependency, since udevd depends on
> > > > >> libblkid+libuuid, and findmnt (from util-linux) depends on
> > > > >> libudev.
> > > > >>=20
> > > > >  .. and nobody complains, good point :-) Thanks!
> > > > > =20
> > > > >     Karel
> > > >=20
> > > > Actually, now that I know you care about these things, I am
> > > > complaining.
> > > >=20
> > >  :-)))
> > >  :
> > > > It has caused me (minor) trouble once already.
> > > =20
> > >  It's possible (first time) to compile util-linux without libudev,
> > >  compile systemd/udevd and then again recompile util-linux with
> > >  libudev.
> > > =20
> > >  IMHO libudev is very useful for findmnt and lsblk to get info about
> > >  devices.
> > > =20
> > >  Note that uuidd is absolutely unnecessary if you don't have huge SAP
> > >  installation (-- it means unnecessary for 99% of the all Linux users=
).
> >=20
> > on a semi-related matter, it'd be nice if we could easily build
> > util-linux such that we only get the libraries.  the plethora of
> > configure flags that control utils is a nightmare to manage, and i'm not
> > sure there's a flag for every utility (i haven't checked myself, so i
> > could easily be wrong).
> >=20
> > if that were in play, the circular loop would be easy to address -- bui=
ld
> > util-linux once just for its libs, then udev/systemd, then util-linux
> > again.
>=20
> We do this in Arch already to provide a 32bit libraries on 64bit
> systems:
>=20
> https://projects.archlinux.org/svntogit/community.git/tree/trunk/PKGBUILD=
?h
> =3Dpackages/lib32-util-linux

thanks, that illustrates my point exactly :).  those make targets are esote=
ric=20
if not internal to automake.  relying on them externally sucks.

> A quick grep through the git repo shows that I could get rid of the
> --without-ncurses flag, too.

pretty sure there are a bunch of configure checks that apply only to utils.=
 =20
pam and ncurses both come to mind.
=2Dmike

--nextPart11593672.X149OsIukN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSzFwhAAoJEEFjO5/oN/WB5Y8P/3Lz+ojnRLaBAKn8YLgNN0n2
oxNd756P80mmmQkPqmytGh4R2H8v89WwBoT9CQ796SnIJqPAn2pm/l19QSea7J8n
Ix60FjvE1VzFL9DsbV9zCIvzi4OO9bkxjf7jNb3k0y1BAFa/MxXshFw3Bu8t3WRO
2FV1/vsRCGiYCiRyheHhw77bFXptpp5qAz+8uNSWYqQD7SB1wAYk7JrrMPUu65X1
Dx4uOBKRdIpfxsf/txxBeKfIwVn30GcjuzSbdf9b+0JNvhMy6JAIQHAJ0BNpmZoc
Iv0h9RkQKoCcvQRui/XYXb8qPBYilgb5rKrpWiY6xWzQgwY0dnNXCTWtn54fW30f
4qFXCpjA6nS0CSrHxFD+IA+y4PVIArPew6ItVMqsHvGpaEweGNEelv6B8l5hhzj5
tsHD/yf4/Xl5eh6NsZdSkdblLh+Tqlja/ZSJ0eLS5AijtjUvq9FMTFcBZWz/ueWQ
14P4AYrq+mkqIX8LHuKA7Qk09Vq50dI0Ss9w/m/7IWq1DmHx1MDi+DKLXfIGCTPl
qBlX3Ckf39sNdms064lAiN9njRVEJyVBoNQJCoYYRH42X1DwowznmRfD3qskeVgg
1yjLgV3F1XAO3i2aAZMR2Ln/ttRsAdGb7l+YK0IxWXq4vX1QWHDwAFLz6nKtLdWO
aeomz1TjhvwO/sqz7fbZ
=/ISu
-----END PGP SIGNATURE-----

--nextPart11593672.X149OsIukN--
