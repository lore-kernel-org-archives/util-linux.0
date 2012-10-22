Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:52983 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754912Ab2JVGBN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Oct 2012 02:01:13 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: kerolasa@gmail.com
Subject: Re: [PATCH 03/19] write: stop using MAXHOSTNAMELEN
Date: Mon, 22 Oct 2012 02:01:01 -0400
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi> <20121015152558.GK18377@x2.net.home> <CAG27Bk3bRTppXcBpqEZeRSMhqK1+BTrQqje9E0NYPSgfqcm4fQ@mail.gmail.com>
In-Reply-To: <CAG27Bk3bRTppXcBpqEZeRSMhqK1+BTrQqje9E0NYPSgfqcm4fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11663323.KKVb8mbOUn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201210220201.02516.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart11663323.KKVb8mbOUn
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 18 October 2012 16:06:28 Sami Kerola wrote:
> On Mon, Oct 15, 2012 at 3:14 AM, Mike Frysinger wrote:
> > On Sunday 14 October 2012 16:20:59 Sami Kerola wrote:
> >> POSIX.1-2001 declares usleep is obsolete.
> >=20
> > this is true, but it seems like a better answer would be to add a
> > usleep test to configure and provide a local fallback using nanosleep
> > if it doesn't exist.
>=20
> Is that necessary?  There has been for example in old mount since March
> 2007[1] nanosleep() call, and I cannot remember anyone complaining it
> causing problems.
>=20
> [1] commit dc8fdc57cd3ba0658cf4ab05031695c2d2965f93

i think you misinterpreted my objection.  i don't have a problem with calli=
ng=20
nanosleep() -- when it makes sense.  replacing a simple call to a function=
=20
that, while no longer part of the latest standard, was mandated for many ma=
ny=20
years, and will most likely never be removed from C libraries that have=20
already been providing it (since it'd be an ABI break), with a more=20
complicated call for no real reason is pointless imo.  further, you'd be=20
fighting a losing battle: developers will most likely be working & testing =
on a=20
glibc system where usleep does exist and works fine, so they won't notice i=
f it=20
were added again.

hence i suggested a trivial middle ground that is future proof and doesn't=
=20
penalize systems that do include usleep (i.e. glibc i.e. what the majority =
of=20
people run): if you actually have a system that lacks usleep, then add usle=
ep=20
to the AC_CHECK_FUNCS tests in configure.ac, and then add the simple=20
replacement to include/c.h:
#ifndef HAVE_USLEEP
static inline int usleep(useconds_t usec)
{
	struct timespec waittime;
	waittime.tv_sec =3D usec / 1000000L;
	waittime.tv_nsec =3D  (usec % 1000000L) * 1000;
	return nanosleep(&waittime, NULL);
}
#endif

now everything should "just work".

> On Mon, Oct 15, 2012 at 6:39 PM, Mike Frysinger wrote:
> > On Monday 15 October 2012 04:36:43 Sami Kerola wrote:
> >> On Mon, Oct 15, 2012 at 3:17 AM, Mike Frysinger wrote:
> >> > On Sunday 14 October 2012 16:21:10 Sami Kerola wrote:
> >> >> +     if (utimensat(path, &epoch, 0) < 0)
> >> >=20
> >> > err, did you test this at all ?  utimensat() takes 4 args one of
> >> > which is
> >> > a reference file descriptor.
> >>=20
> >> I thought I did, but what ever I did where partly unsuccessful.
> >=20
> > cramfs isn't built by default, so you'll need to pass the right
> > configure flag
>=20
> *sigh* I see.  And I dropped the patch.
>=20
> I wonder if anyone is ever reaching code that requires INCLUDE_FS_TESTS
> defined.  Should there be a configure --enable-fs-crams-tests switch?  If
> that sort of switch is added it should perhaps be included when
> --enable-most-builds is set.  Comments, opinions?

i would add a new check target to disk-utils/Makemodule.am

check_PROGRAMS +=3D test_mkfs.cramfs
test_mkfs_cramfs_SOURCES =3D $(mkfs_cramfs_SOURCES)
test_mkfs_cramfs_LDADD =3D $(mkfs_cramfs_LDADD)
test_mkfs_cramfs_CFLAGS =3D -DINCLUDE_FS_TESTS

then see what happens when you run `make check` ...
=2Dmike

--nextPart11663323.KKVb8mbOUn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQhOEeAAoJEEFjO5/oN/WBVoQP/09apVpUdaEcHZwPVLN1Fsfb
Amu9y52iQ+eTmWVi0uwvPEs6e2DuGInPFcTSdcdS8toCuEc5PcKP1yCDMafjlHlC
r/UgCs9DBQnYR2U2FezGz/99yZG+7SkKqyqQRguVp+ydDvRdpre00LVwzIVPUdZn
01E6xtsW+BqeI/DG7bDtXrHPCEPw4yjJokXV+C+9V0ipJwvjLuMjep7MwQm2/Hki
UNnFLONk+OY8LXom5UMBshG69szmRqPiWNClSmBvdc4ITHC7OSaS7557b8PWI6/E
t20XnoOk7bKQTuSZeHhGI84NURDnuoRDhBcHg0saeMFyrOzoIMj5v2e6DGbITGRf
Qfenx1cXjo3/39s76FFwoYNNpJS9ckQ5av3OUfDGphN0toneV1f5tYcXpKuUcUDi
Mk0jnbWqDw0iJ1eG+2V11eShPAKGCeEoKWE272q0bs6Tp+fDgpzMKRI5I89jLFnZ
7GcPJ0An3ra0y6c5Ut7hZau7K2cyMKX9l/i9OU1S9SacIe37K9EG1aD5RmoqMYa7
uXrSWNMsMNxLvrQp8ZXyabj7VfgKPOY8GBOsVCdFFW6ezLEC7JZp/ShnR7nPfn7q
8NwPgFZCQt8BSzlNAufvO5UAc93TD6rquNBDN4NkI0xCbZsak5qlIKFA11HKZhZD
pzpbm2S+JIkJH710tkPU
=+bFC
-----END PGP SIGNATURE-----

--nextPart11663323.KKVb8mbOUn--
