Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:49414 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab2ASR0T (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 19 Jan 2012 12:26:19 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: configure --prefix default
Date: Thu, 19 Jan 2012 12:26:18 -0500
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
References: <4F17FE0D.4080901@bernhard-voelker.de>
In-Reply-To: <4F17FE0D.4080901@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1848342.hTh5TSc4PV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201201191226.19529.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1848342.hTh5TSc4PV
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 19 January 2012 06:27:09 Bernhard Voelker wrote:
> Usually, software built via `configure && make && make install` uses
> /usr/local as default for the prefix. Is there any reason for util-linux
> not to use the same?
>=20
> BTW: `configure --help` states that it would use /usr as default prefix:
>=20
>   --prefix=3DPREFIX         install architecture-independent files in PRE=
=46IX
>                           [/usr]
>=20
> ... but in fact e.g. chcpu is installed as "/sbin/chcpu" (i.e. without
> /usr). This doesn't sound correct.

look at the configure output.  if you don't specify a value yourself, the=20
default paths are tweaked to be a more natural install with some in / and s=
ome=20
in /usr.

> If someone relies on /usr/local as the default, then
> she overwrites the native version of the files of his distribution.

that's a PEBKAC issue.  anyone blindly doing `make install` is doomed to=20
killing their machine.
=2Dmike

--nextPart1848342.hTh5TSc4PV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPGFI7AAoJEEFjO5/oN/WB32sQANy/TIjNuANOEHLARzfcvkKs
r4DjLD2zl6a6Nsme5U8UdbfLs5XWkezvLru70gUrddkH0xQuYpafe8PGh1XY1E2e
xzC3E3S6zztsn+cMSeY2rXJWifIiPZLpEQx1HM7A1rO/wCB444tTGFzKfIdkhjIL
G8TXnooTMjHl0wENBR1XHQ3f4yINMa/UM0xZK7i30HPV1ydOotLyhWuu4ycTyKsh
wMoknYoaEtmDsWbtMIiSsAs88fxCSRLIYY7HO1wH7sp4z3er5l4LBL+eD6EErwez
u/gJQ3fr3lgAzuyLT6ZWhWihKn2hFLh1B/wW033Guo+8OKGV6SuJYUWQo+DUtflr
ERO7mG8HwbYRylUaf3LKnmvLKRSqNEDReN2yrA90zJGulJy03dWC/EIb5h6ZF1zM
BVCDfO19zxmT+0QXKgBJgUwix9CtVavX2T6nquup+WeWmtBq8j+vwf6zp1FU33By
TeC+kHg88Yza6osmFzjiuxKTZCAgUnG7hIshLX+zWwGX1a+2+2hcCp69DDSqJUH8
lo7uDeaDxAH9S3iNOrqN+O7ZmEdmiF97QENG1+VSx+tGQtmDYXvlZ7p49Mtcdyvm
RitlRe5qR7fcXde+ORMMo8nMsl8mA6K2CJhDMOjspFtrn5Oaa9V/gPF4bWTNoKeL
26yA3X/aETG3N+tNAX6M
=CBKS
-----END PGP SIGNATURE-----

--nextPart1848342.hTh5TSc4PV--
