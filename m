Return-Path: util-linux-owner@vger.kernel.org
Received: from storm.alittletooquiet.net ([67.23.28.199]:47332 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245Ab1ANO2q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 14 Jan 2011 09:28:46 -0500
Date: Fri, 14 Jan 2011 09:20:12 -0500
From: Forest Bond <forest@alittletooquiet.net>
To: "=?utf-8?Q?Przemys=C5=82aw_'Przemoc'_Pawe=C5=82czyk?="
	<przemoc@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk enhancement proposal - offset/shift support
Message-ID: <20110114142012.GA26786@alittletooquiet.net>
References: <AANLkTimJJDm-9vu_xcMjh0uQSghZE44Miz1XaHcx=p7j@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
In-Reply-To: <AANLkTimJJDm-9vu_xcMjh0uQSghZE44Miz1XaHcx=p7j@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 14, 2011 at 02:31:55PM +0100, Przemys=C5=82aw 'Przemoc' Pawe=C5=
=82czyk wrote:
> I have following suggestion for sfdisk:
> - adding offset/shift support for cumbersome raw disk images (like
> fixed-size VDI), that don't start at the beginning of the file.
>=20
> Required changes?
> IMO straightforward way is just adding another option (below is an
> example), global variable (e.g. shift) and fixing sseek() code and
> R.total_size in get_geometry() to take it into account.
>=20
>     -t# [or --offset #]  ignore the number of bytes at the beginning

Isn't this something you can just use a loopback device for?

  losetup -f -o $offset $image

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0wW5wACgkQRO4fQQdv5Ax4zACfT7Qy6VXJ4iIm+uM3k9K+Hlop
QRcAoMKMpRjM71sOIPFLoBJ/w23KrgTp
=j9Ha
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
