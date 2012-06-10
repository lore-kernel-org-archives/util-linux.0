Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36504 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab2FJUV0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Jun 2012 16:21:26 -0400
Received: by bkcji2 with SMTP id ji2so3005361bkc.19
        for <util-linux@vger.kernel.org>; Sun, 10 Jun 2012 13:21:25 -0700 (PDT)
Message-ID: <4FD501AE.2070506@gmail.com>
Date: Sun, 10 Jun 2012 22:21:02 +0200
From: =?UTF-8?B?VmxhZGltaXIgJ8+GLWNvZGVyL3BoY29kZXInIFNlcmJpbmVua28=?=
	<phcoder@gmail.com>
MIME-Version: 1.0
To: dave@gnu.org
CC: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] allow to create a minix3fs with a blocksize != 1K
References: <4FAAE6EA.3080308@gmail.com>  <4FAAE7FB.2060808@gmail.com> <1339358318.3369.35.camel@offbook>
In-Reply-To: <1339358318.3369.35.camel@offbook>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enigEAD1F5AA14D87241CA6C2845"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEAD1F5AA14D87241CA6C2845
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10.06.2012 21:58, Davidlohr Bueso wrote:

> On Wed, 2012-05-09 at 23:56 +0200, Vladimir '=CF=86-coder/phcoder' Serb=
inenko
> wrote:
>> Have used it to test minixfs support with various block sizes.
>>
>=20
> Hi Vladimir,
>=20
> A few comments:
>=20
> +       if (MINIX_BLOCK_SIZE % 512 || MINIX_BLOCK_SIZE < 1024
> +           || MINIX_BLOCK_SIZE >=3D 65536)
> +               usage();
>=20
> This check should be part of the switch statement, perhaps in its own
> function.
> +       if (*tmp && ...)
>=20
>=20

Ok

> +       if (fs_version !=3D 3 && MINIX_BLOCK_SIZE !=3D MINIX12_BLOCK_SI=
ZE)
> +               usage();
>=20
> We should set -1/-2 options to be mutually exclusive with -B.
>=20

Ok

> +#define MAX_MINIX_BLOCK_SIZE 65536
> Isn't the max minix block size 4096?
>=20

No, Maximum for the on-disk format is 65535. Minix itself supports
everything from 1025 to 65536-512 as long as it's divisible by 512.
Linux driver is limited to 1024, 2048 and 4096

> +#define MINIX12_BLOCK_SIZE   1024
> This is the minimal block size, including v3. MINIX12_ doesn't describe=

> it well.
>=20

I use this constant specifically in places which only relate to v1 and v2=


>=20
> Also, please send the patches in the body of the message - just as with=

> the lkml.
>=20

Ok

> Thanks,
> Davidlohr
>=20
>=20



--=20
Regards
Vladimir '=CF=86-coder/phcoder' Serbinenko


--------------enigEAD1F5AA14D87241CA6C2845
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iF4EAREKAAYFAk/VAbsACgkQNak7dOguQgnJfQD/YIuVvGeVaN+KLtG4DIOren6O
1nr0hJ/B1t+IMiau57YA/0HUogFYHr8zSBmaSTwtyv+4HjzCiTpRWirV2+EbYAch
=FIdF
-----END PGP SIGNATURE-----

--------------enigEAD1F5AA14D87241CA6C2845--
