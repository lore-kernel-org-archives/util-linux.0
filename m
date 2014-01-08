Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:35759 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757396AbaAHUoe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Jan 2014 15:44:34 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: kerolasa@gmail.com
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Date: Wed, 8 Jan 2014 15:44:36 -0500
Cc: Karel Zak <kzak@redhat.com>,
        Thomas =?iso-8859-1?q?B=E4chler?= <thomas@archlinux.org>,
        "util-linux" <util-linux@vger.kernel.org>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi> <20140108092116.GA7516@x2.net.home> <CAG27Bk2S5ert+sjnai8ybEhhoUruYmX6P+U7c1AaghfjQ_s2TA@mail.gmail.com>
In-Reply-To: <CAG27Bk2S5ert+sjnai8ybEhhoUruYmX6P+U7c1AaghfjQ_s2TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1432312.Q5TH0hLYVS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201401081544.37516.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1432312.Q5TH0hLYVS
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 08 January 2014 15:37:30 Sami Kerola wrote:
> On 8 January 2014 09:21, Karel Zak <kzak@redhat.com> wrote:
> > On Tue, Jan 07, 2014 at 01:44:07PM -0500, Mike Frysinger wrote:
> >> On Tuesday 07 January 2014 05:19:35 Karel Zak wrote:
> >> > On Tue, Jan 07, 2014 at 10:55:35AM +0100, Thomas B=E4chler wrote:
> >> > > >> We already have such a cyclic dependency, since udevd depends on
> >> > > >> libblkid+libuuid, and findmnt (from util-linux) depends on
> >> > > >> libudev.
> >> > > >>=20
> >> > > >  .. and nobody complains, good point :-) Thanks!
> >> > > > =20
> >> > > >     Karel
> >> > >=20
> >> > > Actually, now that I know you care about these things, I am
> >> > > complaining.
> >> > >=20
> >> >  :-)))
> >> >  :
> >> > > It has caused me (minor) trouble once already.
> >> > =20
> >> >  It's possible (first time) to compile util-linux without libudev,
> >> >  compile systemd/udevd and then again recompile util-linux with
> >> >  libudev.
> >> > =20
> >> >  IMHO libudev is very useful for findmnt and lsblk to get info about
> >> >  devices.
> >> > =20
> >> >  Note that uuidd is absolutely unnecessary if you don't have huge SAP
> >> >  installation (-- it means unnecessary for 99% of the all Linux
> >> >  users).
> >>=20
> >> on a semi-related matter, it'd be nice if we could easily build
> >> util-linux such that we only get the libraries.  the plethora of
> >> configure flags that control utils is a nightmare to manage, and i'm
> >> not sure there's a flag for every utility (i haven't checked myself, so
> >> i could easily be wrong).
> >=20
> > not yet ;-)
> >=20
> >> if that were in play, the circular loop would be easy to address --
> >> build util-linux once just for its libs, then udev/systemd, then
> >> util-linux again.
> >=20
> > Yep, I know about the pain... I guess it would be enough to have
> > something like
> >=20
> >  ./configure --disable-all-builds --enable-libblkid
> >=20
> > where --enable/disable-all-builds controls the default of the
> > enable_<name>=3D variables (the current default is usually "check")
> > in configure.
> >=20
> > I'll try to implement it later (I'm working on new cfdisk now) -- or
> > maybe some volunteer...? :-)
>=20
> I could try to fiddle around with autotools in next days/weeks.
>=20
> The one thing I am thinking to change immediately is
> 's/--disable-all-builds/--enable-minimal/'.  Unfortunately, due I'm just
> a random contributor without distribution packaging experience at all I
> will need few hints from real pros.  Most important question being what
> the minimal should include?  I did think that option could be
> --enable-libaries-only, but is that too minimal to be practical?

i don't think general flags like "minimal" are useful.  a knob that'd disab=
le=20
all binaries would though as then we could use the existing library knobs t=
o=20
select the exact ones we want to build/install.
=2Dmike

--nextPart1432312.Q5TH0hLYVS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSzbi1AAoJEEFjO5/oN/WBQ1wP/0FhX8y5eEHT0q3WEgzh8efT
6gaHQh5f4UqNIDZ/AmYcgNlDZsVVDS6hopy4XnujL8FG9D2Dxt7CifMJEjOkNMJD
66DUEt45IleaYsfTNmc7bADgFqcnWY9Y1Uhx5Z/zu8ot4RSgiybl9CycSCGXH/Ei
NRkh2EHYu+skLR+yREe6ki6nWJE+GifAudFfqOVq4JTgGhnmjhgRPJ09VNzxm6tW
hNLDSgxDA9YFF/nxqZ3ozzxnx04CYmOBHcjd2PlDPJBl+WE75AjCAO8OH4OylMp6
1+QwHE+NoRmdtr4aH5iYBzClhwr+XdiNnrq+mflSef7W+999MPOpDeL1i3VHY76e
E/qT/ou55QCvzUycBKfrYXqgHp5WjX56Wh97C/MYQlrP2jSByAkaMgCQZ2SbrCf0
7rO9HQJ+jcY5I1QcttbJS6DuDvwxWw0l2DsjqoGOYAB6RnfbAsM5DG6O/l2Fux83
WYbni5pD80AL182vfia90KCzs8OiBZKt3/Mc6jEFqJ0UYSSfZqrM8fBAM8KlOo6B
9GwYVx0j2/J2RQ2zPQM/w7hko6xqaOrqS9/BudqjJfJSAoOrX2W47p/UwlSpbYCk
UAaoZY113XpL+jUyuzuJd/biLx6qih5Iu/wLi7uXalvZRXD+OgUvFY3PJSc9HFlm
ClkpX9NW3U0sY1S+zYjR
=GDPL
-----END PGP SIGNATURE-----

--nextPart1432312.Q5TH0hLYVS--
