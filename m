Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:49661 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbaHCNeY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 3 Aug 2014 09:34:24 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount/buildsys: move SELINUX_LIBS to LDFLAGS
Date: Sun, 03 Aug 2014 09:34:25 -0400
Message-ID: <2625005.WTIbfJcupg@vapier>
In-Reply-To: <1407010261-17305-1-git-send-email-andreas@fatal.se>
References: <1407010261-17305-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1726248.YcNbZdjQm9"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart1726248.YcNbZdjQm9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Sat 02 Aug 2014 22:11:01 Andreas Henriksson wrote:
> According to a bug report filed in the Debian bug tracking system
> an unknown version of the package failed to cross-build because of
> the -lfoo flags for SELinux being placed in LIBADD rather then LDFLAG=
S.
> The build system still looks similar in this regard so it's possible
> the problem still remains and hopefully this change should make thing=
s
> more correct even if I still don't know if it solves the entire probl=
em.

please post the full details here.  linkage (like -lselinux) are not ld=
flags.
=2Dmike
--nextPart1726248.YcNbZdjQm9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJT3jphAAoJEEFjO5/oN/WBgoQQAOCfR9wBQY6JEGQenRly0owU
f7+QlYiv3V6ga5c0NC98zUBMVfo+ccNphORj5OYY0+kO91w784lO3I7cCspUnqLY
NlER2tDk6h/uVXwIGhew+/hjunnQl7RoZyC7MPw1OgJsXhcvVGHFX6ZuV8Lb6ELj
Bh86DbFtuikppGQRPfSwquj+fIUEZ/dXVMxHLqbP+KRb6UpYVAoSGn/ZzjH95FN1
jmeOM8Oe6UJT1JjsiDLiEx1wFAwsOwphY13RrNpcwRxEk6uAo2N/yKWKFp9NAHnf
mFTDvzgccRMh0ddgebAlzMXSAe0IJH89pDiXvX6EQq2uRc21ou1DIW/XlTG04zUx
XQ78SzEIKjSPrvN8nQIWvfVv9rnRhohayKuOUs6lTIX//JPjaxmDi99UC1JV8ZTc
J9hmW05gSRYucmoY6/MVoAVj1DB5eUf7Vu2dT6eaBz1EF6lXnvExW+HO9BbjluG2
L8XPZtmg/IbwF1MNHiNHAmBPrUHV7AsetkF661wGy9rrN7vXiojZsAS+sOOAcm2q
zqXZ8/10/UKVqULak0DcpcbKzQxBKVrc6Ufpf1jJt2m/FExtZBV/ZAy/cRRzw4vo
3YIe8geFjGqyBhJ7mmZ0X7MwW2+J/VbkfcLYLmF0lY3DYkdylPEdV6XZf369UBbU
lPROhCN1Tnq9X/N0lx4s
=5aiJ
-----END PGP SIGNATURE-----

--nextPart1726248.YcNbZdjQm9--

