Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:42916 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbcDGQSE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 7 Apr 2016 12:18:04 -0400
Date: Thu, 7 Apr 2016 12:18:02 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Marcus Hoffmann <marcus.hoffmann@fu-berlin.de>
Cc: util-linux@vger.kernel.org
Subject: Re: unrecognized options: --without-capng
Message-ID: <20160407161802.GM6588@vapier.lan>
References: <20160407105400.jn66tldxy7s3rqyc@ws.net.home>
 <570667FB.8080104@fu-berlin.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPfYaGgGDl1Yw8pb"
In-Reply-To: <570667FB.8080104@fu-berlin.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ZPfYaGgGDl1Yw8pb
Content-Type: multipart/mixed; boundary="8mx9aVJBEtJYuazX"
Content-Disposition: inline


--8mx9aVJBEtJYuazX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07 Apr 2016 16:00, Marcus Hoffmann wrote:
> Dear all,
> in experimenting a bit with configure options I found the
> --without-capng option (as reported by configure --help) giving the
> following warning (and having no effect):
> > configure: WARNING: unrecognized options: --without-capng
>=20
> Looking into configure.ac I found the option should probably be named
> --without-cap_ng (AC_ARG_WITH([cap_ng],...).

yes, the help string is wrong.  it should be:
--- a/configure.ac
+++ b/configure.ac
@@ -1182,7 +1182,7 @@ AC_CHECK_FUNCS([setns])
=20
=20
 AC_ARG_WITH([cap_ng],
-  AS_HELP_STRING([--without-capng], [compile without libcap-ng]),
+  AS_HELP_STRING([--without-cap-ng], [compile without libcap-ng]),
   [], [with_cap_ng=3Dauto]
 )
 AS_IF([test "x$with_cap_ng" =3D xno], [have_cap_ng=3Dno],[

> But using this the configure script dies with the following message:
>=20
> > configure: error: conditional "HAVE_CAP_NG" was never defined.
> > Usually this means the macro was only invoked conditionally.
>=20
> --without-cap-ng produces the same result.
>=20
> I tried fiddling around with the autoconf macros but got no further than
> that.

the helper macros can sometimes obscure things

--- a/configure.ac
+++ b/configure.ac
@@ -1189,7 +1189,10 @@ AC_ARG_WITH([cap_ng],
   AS_HELP_STRING([--without-capng], [compile without libcap-ng]),
   [], [with_cap_ng=3Dauto]
 )
-AS_IF([test "x$with_cap_ng" =3D xno], [have_cap_ng=3Dno],[
+AS_IF([test "x$with_cap_ng" =3D xno], [
+  AM_CONDITIONAL([HAVE_CAP_NG], [false])
+  have_cap_ng=3Dno
+],[
   UL_CHECK_LIB([cap-ng], [capng_apply], [cap_ng])
 ])
=20
-mike

--8mx9aVJBEtJYuazX
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="conf.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 110c2c94c59742e9879f2f39e6aec79925dc1592 Mon Sep 17 00:00:00 2001
=46rom: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 7 Apr 2016 12:17:43 -0400
Subject: [PATCH] build-sys: fix cap-ng configure flag handling

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 configure.ac | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index e42a2c4..9e0e28b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1186,10 +1186,13 @@ AC_CHECK_FUNCS([setns])
=20
=20
 AC_ARG_WITH([cap_ng],
-  AS_HELP_STRING([--without-capng], [compile without libcap-ng]),
+  AS_HELP_STRING([--without-cap-ng], [compile without libcap-ng]),
   [], [with_cap_ng=3Dauto]
 )
-AS_IF([test "x$with_cap_ng" =3D xno], [have_cap_ng=3Dno],[
+AS_IF([test "x$with_cap_ng" =3D xno], [
+  AM_CONDITIONAL([HAVE_CAP_NG], [false])
+  have_cap_ng=3Dno
+],[
   UL_CHECK_LIB([cap-ng], [capng_apply], [cap_ng])
 ])
=20
--=20
2.7.4


--8mx9aVJBEtJYuazX--

--ZPfYaGgGDl1Yw8pb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXBog5AAoJEEFjO5/oN/WBX2YP/2RilY5t3b5hiEprHRrMadET
1sDf4NvB73GWj19y20RBj2GbJJIYV60YNiRINvYzr2olHs024f0eiheuOQIQEpH+
jVGkbtJqvceCbhZWFRIbzVrHDKnvrq7YNvDVkRJBvl6bwF4wDpJqtJVbQ+XAkmCA
m3nbS8BIiDYOsJmkbMojM2I8LTIMX0gsU21QANqBEmTtjQ/VmXwITQ4fVp4A2dMD
SEMzO0x6cRJrU7t4Ll31YVYo8PBJM6SnV6hLvc00EF4cMVo8rPou+E3XRKNz+yzu
hMtvcNW2YY+fwnYKJ3cMSSG5d1nfMfAISA3Mk1M85ASUxwj2HBofuVtm99V5k/Ao
RWSzUgRYijkc0S2B99nSuWQbxzhaHYlEQ1YewZbzPh1TqAzg8+ywVXHWIS+ILu9t
4GGJ4zCquP3jsiVoe1xbkYloc260QaGVVb44GupimIkgX/yhPu4xJzbiLryQaomc
dOu7ZuGXExgpd8D3U1iOckeFkcZwGZnEAI7sXJmP0WAV5pJ/z5hHWO0CVbiU4/yh
JDY0KOGnZOHC1MbGUesMoloeMglcFgYTsB+sWzV4IjUO/nJzqeKpozT7cvKwdwpQ
0KVWReV/sKUFlw6gGOdSL8OJ+fZE9dwMDmcqTVAIOM69+4fbCnDhTdeOYkQWZOPy
dYrrWd4BMnOwduc2DJSO
=6n5q
-----END PGP SIGNATURE-----

--ZPfYaGgGDl1Yw8pb--
