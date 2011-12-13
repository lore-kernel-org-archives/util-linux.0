Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:60225 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab1LMVVx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Dec 2011 16:21:53 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Roger Leigh <rleigh@codelibre.net>
Subject: Re: sysvinit-2.88dsf-14
Date: Tue, 13 Dec 2011 16:21:52 -0500
Cc: util-linux@vger.kernel.org
References: <20111213203001.GJ17458@codelibre.net>
In-Reply-To: <20111213203001.GJ17458@codelibre.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2410099.FNNB760XND";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201112131621.53521.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2410099.FNNB760XND
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 13 December 2011 15:30:01 Roger Leigh wrote:
> I'd like to upload the following to experimental, but wanted to
> run it past you in case there was anything you were unhappy
> with or which you would like changing.  I've attached a patch
> for the proposed upload, and the changelog is below.  Any
> comments would be appreciated.
>=20
> The main two parts are the removal of /lib/init/rw and the
> conversion of /etc/mtab to a symlink.

what's the relation to util-linux exactly ?  just the mention of /etc/mtab ?
=2Dmike

--nextPart2410099.FNNB760XND
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJO58HxAAoJEEFjO5/oN/WBZTEP/3gybS7Jxfw1PmeKngSxeqTh
7LbTlZ7A0AZ0ZQ33PDuT54+gt6NyrD2q4+l/TpT7TzfmgcktsaG7OyUP33P4C7om
asmAt5pkrnUcPFXavyDY1byp+wetkPc28HLs10RsA7hj0KNJ6bLwRrP/JiJ45rYk
64Tk7fNn83PRLyxub0D3reweSkttDh6SH4ketRCqnaKGLYXvhn/5jMuczrM1nA74
m5rzrlql29JEHAVG3fgQ+19Cke5WmKkWg255dx8rQhnyFfDJQSHfDsBDvMwQo2Yt
q+T1qguYaYXjiFaTWxhfcQaFhTA/uUVAfaaRIoiU/MGwIBBwHP01uDtfVtccRix8
Bje8QzlIrkSQ1rdIGKxyUbWmGXK0MHvD5pPLG3oxAun/Y9ONFlhhf5WmmPIaQXdd
e+LbmwJKoa8eFW9h39YJHibzBttz64v7spNH0SYLxc530JrYwO5i4Cwzlk62xv6H
r6X7oP3rEn8LHlyPQugXXdGdN+7xkmhOySbNhOTFYuFmGYqPLZzFPqc3/ktngb5c
D3SSskO0m5AWtxM6S5mZROihLFpVmqIpalLCrzIX/3j0UD9qfxbLWyy2Bgt3twos
XI+35DB67zLxK4vuzn9pC4/sT+K6UqIRcSyWB9AkTzeFlhWpqGEc7BGztWTTEYbD
JNwbRzM6VepHbHNBdcdF
=Xq6n
-----END PGP SIGNATURE-----

--nextPart2410099.FNNB760XND--
