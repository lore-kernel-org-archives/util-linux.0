Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:51153 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108Ab2JVUDG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Oct 2012 16:03:06 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 03/19] write: stop using MAXHOSTNAMELEN
Date: Mon, 22 Oct 2012 16:03:01 -0400
Cc: kerolasa@gmail.com, util-linux@vger.kernel.org
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi> <201210220201.02516.vapier@gentoo.org> <20121022080624.GA21724@x2.net.home>
In-Reply-To: <20121022080624.GA21724@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2217661.p5b9WBahBq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201210221603.02244.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2217661.p5b9WBahBq
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 22 October 2012 04:06:24 Karel Zak wrote:
> On Mon, Oct 22, 2012 at 02:01:01AM -0400, Mike Frysinger wrote:
> > On Thursday 18 October 2012 16:06:28 Sami Kerola wrote:
> > > On Mon, Oct 15, 2012 at 3:14 AM, Mike Frysinger wrote:
> > > > On Sunday 14 October 2012 16:20:59 Sami Kerola wrote:
> > > >> POSIX.1-2001 declares usleep is obsolete.
> > > >=20
> > > > this is true, but it seems like a better answer would be to add a
> > > > usleep test to configure and provide a local fallback using nanosle=
ep
> > > > if it doesn't exist.
> > >=20
> > > Is that necessary?  There has been for example in old mount since Mar=
ch
> > > 2007[1] nanosleep() call, and I cannot remember anyone complaining it
> > > causing problems.
> > >=20
> > > [1] commit dc8fdc57cd3ba0658cf4ab05031695c2d2965f93
> >=20
> > i think you misinterpreted my objection.  i don't have a problem with
> > calling nanosleep() -- when it makes sense.  replacing a simple call to
> > a function that, while no longer part of the latest standard, was
> > mandated for many many years, and will most likely never be removed from
> > C libraries that have already been providing it (since it'd be an ABI
> > break), with a more complicated call for no real reason is pointless
> > imo.  further, you'd be fighting a losing battle: developers will most
> > likely be working & testing on a glibc system where usleep does exist
> > and works fine, so they won't notice if it were added again.
> >=20
> > hence i suggested a trivial middle ground that is future proof and
> > doesn't penalize systems that do include usleep (i.e. glibc i.e. what
> > the majority of people run): if you actually have a system that lacks
> > usleep, then add usleep to the AC_CHECK_FUNCS tests in configure.ac, and
> > then add the simple replacement to include/c.h:
> > #ifndef HAVE_USLEEP
> > static inline int usleep(useconds_t usec)
> > {
> >=20
> > 	struct timespec waittime;
> > 	waittime.tv_sec =3D usec / 1000000L;
> > 	waittime.tv_nsec =3D  (usec % 1000000L) * 1000;
> > 	return nanosleep(&waittime, NULL);
> >=20
> > }
> > #endif
> >=20
> > now everything should "just work".
>=20
> Exactly this solution we use for now (since 2009):

heh.  too fast!

> $ cat include/usleep.h
>=20
> #ifndef UTIL_LINUX_USLEEP_H
> #define UTIL_LINUX_USLEEP_H
>=20
> #ifndef HAVE_USLEEP
> /*
>  * This function is marked obsolete in POSIX.1-2001 and removed in
>  * POSIX.1-2008. It is replaced with nanosleep().
>  */
> # define usleep(x) \
> 	do { \
> 		struct timespec xsleep; \
> 		xsleep.tv_sec =3D x / 1000 / 1000; \
> 		xsleep.tv_nsec =3D (x - xsleep.tv_sec * 1000 * 1000) * 1000; \
> 		nanosleep(&xsleep, NULL); \
> 	} while (0)
> #endif
>=20
> #endif /* UTIL_LINUX_USLEEP_H */

if you were to do something like:
	int foo =3D 10;
	usleep(foo++);

this define macro would misbehave because it expands x twice.  not that the=
=20
current code base does.

> ... so I don't think we have to check change anything.

indeed
=2Dmike

--nextPart2217661.p5b9WBahBq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQhaZ2AAoJEEFjO5/oN/WBibAP/RpjpuTee2y/pIqkNzQLdSfW
etOiKYuF5/paCEEgNveV0BHKmR1jVcF8Gf5e0hyG+6E0ufLfvXRc3H5P/cnJDSrf
zpVlY3u9iTHFFdsPTHxIW/HwSovDMQtgeiszXOk6Qe6mPIyLxM2Kpqv3wlOgNk2b
hKBZy2VTKlr8GwRkAuUww1wenMoa59qLogz9NFKL0iN1xsUQIFj1/oVLNCwF1jRm
iZLJ5Urv5flUIp1ckkhGsofXp5MMwFIYNmrdlpAz+1nQ/QTxTICsNYLK7q6lCISB
LW0NLzOShkrt4WiUfxklY8sDOJLEP15qq/5oS31UkPwqfKaCxaVSQVCbN8A5Gi+J
uggbwMUQQgvVXrxaxNswLsH6mzHyaAvwMGUEgptz2zGCXKMGcu2SX2D19mRedSS/
3YALTjg/SPAPUtEdxcCwPNEct6nnRfeFJFgDBB38/0bpz9P9xlFHTKKntTWkQQwx
JkJKl060L/4poLpIBK/NaWexQbzZGFwINo+emPKxElLvXYTGJSaJCI9UFG+OG1yB
xh2JCWkYJCqanLUQhYdiIFHV5jfs/kPUAg74qWrtH6z/XGwk8lf6PSd9v5orOGyv
9mVrsOHIb5hxPnJ5eIONoWBGuy5qB+pMYcff3T0aXtvGaBX6zUKJedLzQ+ljhkEw
ouHdhFl/tUMieZEJ+MTB
=ROpy
-----END PGP SIGNATURE-----

--nextPart2217661.p5b9WBahBq--
