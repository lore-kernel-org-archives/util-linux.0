Return-Path: linux-kernel-owner@vger.kernel.org
From: Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>
To: Karel Zak <kzak@redhat.com>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Curtis Gedak <gedakc@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux & FAT32 label
Date: Wed, 22 Nov 2017 14:29:59 +0000
Message-ID: <1902368.WZt2z4XbVx@laptop>
In-Reply-To: <20171122110352.lzzb7lwfx3cajij3@ws.net.home>
References: <20171004153332.GA6696@pali> <20171122085203.oyvtmbp4hpxnee5e@pali> <20171122110352.lzzb7lwfx3cajij3@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9216900.n9Ipxu9FZ5"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart9216900.n9Ipxu9FZ5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

2017 m. lapkri=C4=8Dio 22 d., tre=C4=8Diadienis 11:03:52 GMT ra=C5=A1=C4=97=
te:
> On Wed, Nov 22, 2017 at 09:52:03AM +0100, Pali Roh=C3=A1r wrote:
> > I can prepare patches for blkid (util-linux), but I do not like idea to
> > have different algorithm how is read label in fatlabel and blkid. Both
> > tools are used by different GUI programs and it is a bad if one GUI
> > program on linux (e.g. GParted) tells you that label is A and another
> > (e.g. KDE Partition Manager) that label is B. So I rather wait for final
> > decision.
>=20
> Maybe it's time to update all the GUI stuff to read LABELs and UUIDs
> (and another attributes) from udev db.
>=20
>     Karel
>=20
>=20

Indeed, it might be better. I can update KDE Partition Manager.
Maybe not too quickly, but sometime next year I can release it.

Andrius

=2D-=20
I encourage the use of end to end email encryption

GPG key:   https://stikonas.eu/andrius.asc
=46ingerprint:  1EE5 A320 5904 BAA2 B88C 0A9D 24FD 3194 0095 C0E1

--nextPart9216900.n9Ipxu9FZ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEA7vyw/TikxvaXjKoyGEVyAkXkuwFAloViecACgkQyGEVyAkX
kuxIMw//WgDrnpE+YlXu0r9IWpk234/HGOaz1SGQU+kX1GuUoDJUQRfsJ600JISv
lG1e8OZqq8Xl8jNYaPqzw3ajpjAj82bO5mvIpbJE1monbmA+3VNDB5fONXDtJn8/
JzW6+jSEQQ8xI6ng/6RGmzcj4W0Yc2JMBNQH9cvKkODCbgGIMvoGezE/W1Oo1kyi
mEo+6wE9P75CdNJ9RlhTWR9Vz1/F+6wwFVHIxKw4I61tQ+0vPwMjpj5ygmHEUfMC
NH/LUnE+vojencoq6pb7iIQz1F5yk8usY4IjAHFDKMxC5aMwzMgsSkSiU7Ts23hx
WpEF706BvxmFsQHqhCvrj9xHOHeER5UCLNFPA6Eh3jcv2TlYGsZqsTcQpoNUG3fN
gaguZyntf+lgATWC5cacBYKRwrFli1RIkixqQiUnOh/rvxaStVRaZDu3L0Ef+vQ3
OxIl6Kj9+eYDsiwjS3ot0etuOyr8fM8SAIUup7cI5ZoT12DZh585+GlHhv17NF4l
ar7ZN0L3D8KX+YxSVxJ4opJMkvut+LOHrN1sDEWrmZp3PQ2HQgJb1wvybAr3Y/Pm
gvCzvDiVP0dCK/6m0Mx1wPvtwtQsACE+QqPIOZ+WK3PGMnyH4gEjlNmcIMZ78/gS
mts5TDyFhaFZg+kUT7jNfG2DFgAESBbdouU8XHQuV9hZwkYA0FE=
=pMLn
-----END PGP SIGNATURE-----

--nextPart9216900.n9Ipxu9FZ5--
