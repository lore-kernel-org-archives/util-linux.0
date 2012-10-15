Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:56593 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603Ab2JORjF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Oct 2012 13:39:05 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: kerolasa@gmail.com
Subject: Re: [PATCH 19/19] fsck.cramfs: replace utime() with utimensat()
Date: Mon, 15 Oct 2012 13:39:05 -0400
Cc: util-linux@vger.kernel.org
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi> <201210142217.37008.vapier@gentoo.org> <CAG27Bk2aX0wDQ1NzMrtS1kCvWFto9hF-H8aLoXy-0Q+wTVN=sQ@mail.gmail.com>
In-Reply-To: <CAG27Bk2aX0wDQ1NzMrtS1kCvWFto9hF-H8aLoXy-0Q+wTVN=sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11761199.yALo5s2Aqz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201210151339.05660.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart11761199.yALo5s2Aqz
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 15 October 2012 04:36:43 Sami Kerola wrote:
> On Mon, Oct 15, 2012 at 3:17 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> > On Sunday 14 October 2012 16:21:10 Sami Kerola wrote:
> >> +     if (utimensat(path, &epoch, 0) < 0)
> >=20
> > err, did you test this at all ?  utimensat() takes 4 args one of which =
is
> > a reference file descriptor.
>=20
> I thought I did, but what ever I did where partly unsuccessful.

cramfs isn't built by default, so you'll need to pass the right configure f=
lag
=2Dmike

--nextPart11761199.yALo5s2Aqz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQfEo5AAoJEEFjO5/oN/WBbM0QAJ9k4ODHevLWZbERkOgcQt3z
5Wda1vpIIhNuHASwi8QGolKiM9d5eJDjmnfNXeUbtR0A7IamjsFjCkAa/kxnzoAh
W0MF16DR9ewGkOve2x2S9gxHLbFwJdfo0g6ClgVcgcFTUg2sX8S00JSgNi1eR/vm
5JBSFvlM2oR5Qh64enatYmesfKrKjhZxK5Q+t8qLtTai6h47c8RsVJZgzfwbzn+E
ANpMdnMW9m9EhQadO3lf7BzLyMhDFxhGinTCRM4If4JJ/chRoXiFTWvJrGrqcU4C
mFyDv7zMQXo+xAE9rC2y3xbxj8X2/snZ8bzQ9DaxScxrsP0wWCDZjvqN6XpjsTP/
J8c1YK0ql5m4i1z5kSWNOwlw/uy7kmf+B8QqJMWGPIK2Bojvwx7ILhaGe4QQyPdu
S3xviB58ENobxJ0nCSjY16X5VsM8s/QOFoVWovEU2063XFjpbvJEG2dxi1GsszQl
/N8N2A1R36TTGjqoEBcfqatiIQj/e2WwGLGTyUcIoYJf1sgbYYb0pbj2AECEcQwp
YkTjdVwNoYlPNAxozBznbWLR2a4Ov/g9B9ILX60aZNL8IXj+w8BVGGc47Sv2jqsc
kbPetCCGN2OXgoqF/Z+Ah7W46PW9W6GiuPBr62KCMt/CxiU4f9j3W2lC2/gLDCKZ
PKqJB+vtXXfB3tuAqdna
=OCxJ
-----END PGP SIGNATURE-----

--nextPart11761199.yALo5s2Aqz--
