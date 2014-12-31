Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:41440 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbaLaIaw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 31 Dec 2014 03:30:52 -0500
Date: Wed, 31 Dec 2014 03:30:46 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: setarch cannot set all listed architectures
Message-ID: <20141231083046.GF3906@vapier.wh0rd.info>
References: <1419438949.242820.206484249.1D540D03@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
In-Reply-To: <1419438949.242820.206484249.1D540D03@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24 Dec 2014 17:35, Benno Schulenberg wrote:
> The man page of setarch says for the option --list: "List the architectur=
es
> that can be set."  However...
>=20
> $ ./setarch --list  =20
> uname26
> linux32
> linux64
> i386
> i486
> i586
> i686
> athlon
> x86_64
> ia64
>=20
> $ ./setarch x86_64 uname -m
> setarch: x86_64: Unrecognized architecture
>=20
> Huh?
>=20
> $ ./setarch ia64 uname -m
> setarch: ia64: Unrecognized architecture
>=20
> $ ./setarch linux64 uname -m
> i686
>=20
> $ ./setarch --version
> setarch from util-linux 2.25.548-fe2c9
>=20
> Maybe --list should not be listing x86_64 and ia64 on this machine?
> Or maybe the error message in these cases should say "Cannot set
> the requested architecture" instead?

are you running a 32bit or 64bit kernel ?  is your compiled setarch 32bit o=
r=20
64bit ?  i'm going to guess both are 32bit.
-mike

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUo7Q2AAoJEEFjO5/oN/WBxV4QANlTn1Qja8S8hLsIktTtTEKh
I7plzBtP5Xk9yyJWZMhUg0ZYnw/RqOVcZnoRV07bk6jSZfhgWQAMhBqyY3VbANW9
Qq8RV1H0j8EKLLSMiJInnUIkLP++iR1Tx1fImhcBv0PLW/xWSpsnZ6Kp5CVV2t2x
XqniwGp7JQ/Uq7hI1yI7Pw+jPMWWauMRuscKxzCjJ2w5eELWFgsnLmIDIOilxvKl
LTpRDpISiYzO1uSCvP56ANKZVbJJCmT+svAxHBnef7MxSRnzzEDdICUtHRgAtbXC
5b/wwj1HmtMrR+/Jgl3pUysiuiLR11MovWqAQTn6VbSmVM5vt0TwPCgRCcER6Dl5
mLV3f36J884cASK8UpVaYtDzUQ0rctJcihPT/u+lzzZYZh8N1ufOfn63OLEckjbR
pOxYVfEu0d165xBCS6eKZlWdh4uSPbKYrubdkidehaIAApln6O4DeMyxrSqg5tpN
Y2v/XYlIlQUHN6/4k525H0gp5PpO80iKeSL3IBbcvPk8cu/odqiR2/zk8VM8beEZ
wBYTKL4JuXZScPW5T+sTz3UE36ZhZ8ItCkL3Iu0DGkklEXNCY8i6N4LBcu8RPQIr
1hWejGy/cjJo0FCGZdB7VXxsaG0YTAXGXQQd5e4q4C4N5bUMAWAI/o0CbWkRXbIp
L07vsgaVnvZoQR6IDH6n
=hbPd
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
