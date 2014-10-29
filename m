Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:48185 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932226AbaJ2Th6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Oct 2014 15:37:58 -0400
Date: Wed, 29 Oct 2014 15:37:52 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] switch_root: use typeof() instead of __SWORD_TYPE
Message-ID: <20141029193752.GA32734@vapier.wh0rd.info>
References: <1414573745-15664-1-git-send-email-ncopa@alpinelinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
In-Reply-To: <1414573745-15664-1-git-send-email-ncopa@alpinelinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29 Oct 2014 09:09, Natanael Copa wrote:
> +			    (stfs.f_type =3D=3D (typeof(stfs.f_type))STATFS_RAMFS_MAGIC ||
> +			     stfs.f_type =3D=3D (typeof(stfs.f_type))STATFS_TMPFS_MAGIC))

typeof is a gcc extension and really should be __typeof__.  ignoring irony =
of=20
replacing on unportable behavior with another ;).
-mike

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUUUIQAAoJEEFjO5/oN/WBACwQANROMIRA53wxH5WzpZXdkVLl
VCyBBsy78yGxEV1Ay3Q7temiqs1/UWKEOH8DHe3rv9dn9Bnu/ZLLH5niAM3UevDW
vCA9DXnGGUtmcZxcV7AyPmdbpHi8b7DMKA3JhYYtKBdoLoJWY5FX9yyu5UHezIIF
2S9dNV3UZxNhoyNQ16WHCta+46MOkhh2CFJZ0or/oDqUwDI1YbwnL9WSZPIVPxQY
Oivav0l6JxMCO6VxdRaDqRfvNiKX0GVi8H9rGpC/qKOw7JsBEXRh2dveFosY+rAI
TTjE1Xeguj0kkjkFfxf8K7tgRZ00tNTD0sI+mfi3ahplDzZRj2vHgRMRW+MhUlCj
dSFPMt4orMBY406NUmTRxOJMaPAq7o6SNW9H8uXG1Nk+vIA0me2TCJABJLlt12G6
dnH1H9x88GzcgxA+3LI9u8YC0vwykxlNNjba0lWFn5yWDJQEEQRXbvgcscpU9igv
//M6qaKWyPX9SB6BfysSYAYJbkotCVf4MXudoK3sIQ/XNa86IWE0+yLSXbvX8BHu
bCHYVNgxXfjZSDoN6I1h8u01jTbkVDd2egtZLyF9syzkygyzD2Rkhb00VGhWOCkK
4vUMVhsr1Km8jzVku55IjakFTewBAiRZjJSGT258vTLgXNu5ypt5FYu1iRrzfbvB
dEstYkFcLeqQpn0mRool
=IOdh
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
