Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:42862 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab3D2P3y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 29 Apr 2013 11:29:54 -0400
Message-ID: <517E8FFC.2040109@archlinux.org>
Date: Mon, 29 Apr 2013 17:21:32 +0200
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: Sami Kerola <kerolasa-X3B1VOXEql0@public.gmane.org>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/11] cal: convert function like definitions to functions
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi> <1367169067-23705-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367169067-23705-3-git-send-email-kerolasa@iki.fi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="----enig2TFNBBLVJNHJODVEKXNIS"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2TFNBBLVJNHJODVEKXNIS
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 28.04.2013 19:10, schrieb Sami Kerola:
> -/* leap year -- account for gregorian reformation in 1752 */
> -#define	leap_year(yr) \
> -	((yr) <=3D 1752 ? !((yr) % 4) : \
> -	(!((yr) % 4) && ((yr) % 100)) || !((yr) % 400))
> [...]=20
> +/* leap year -- account for gregorian reformation in 1752 */
> +int leap_year(int year)
> +{
> +	if (year <=3D 1752)
> +		return !(year % 4);
> +	else
> +		return !(year % 4 && (year % 100 || year % 400));
> +}

This formula is incorrect, there's a difference between the old version
and yours. The original (correct) version is:

( !(year % 4) && (year % 100) ) || !(year % 400)



------enig2TFNBBLVJNHJODVEKXNIS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJRfo//AAoJEChPw0yOSxoliocP/3d7Ldrv7qymp6e/JlGgoOnY
MPwkHM+2br3kXRtbCrvDdPdBljhII/+jAx5Vv6WHAShKQWAUIFZu445/GgC5HziP
8RgNDhGs1LDNeSE98gFVrIoFLGLzzdSe/X9g+XP7xjBpW0sIYlrw4tzG+P2bMZKo
hbnnp+ZvN7visXapZ/ESBiCy+rjMD+V8WLOC0GLnowkd1rQyWbV0IPo8sFyjbOmb
+vd4wjHjbaK26MxwgzV1znZJ1LNni9BCFjxQyHIyU/EGxLaQkflzLc/3Ngi+XwYx
ijIXxKWzfKW5UzSr+cM2K7uvM4meGbbkLb7yFMMMgT1LGvOPOA9Eigup3Ko1v4Hg
Y4TGjTk/D+N4wi58GqT7zInoSvIqQy9rMTiaaU4zs4gYTl0RXRrQXSu23+hLETUj
ZYoC/u4+eWRw+U5hDik2aLPt+noR/k4dnTlqr5QK+njG5WTZ/xKyu3i4rFDzQk30
fsrzr7wRVskOgmp4szvxSTTVySjsmtH7sMgS/BhP0bgSolNvn0FxOrji96sEPOs6
tthTER3poWNLER7VtNxy1cppBkGZHIe7gVfe8j3PRAH9015zp0OEBTjVCNe3rbjB
JtsdHRg36rxGxl2HgNtrf/Sww1qDQvY3mKEtr8z1AX6oL/xmJlrKRtrGVbBwUTCW
me1A8Ci+QJymsgh7Mj6b
=TXmb
-----END PGP SIGNATURE-----

------enig2TFNBBLVJNHJODVEKXNIS--
