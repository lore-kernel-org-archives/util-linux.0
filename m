Return-Path: pali.rohar@gmail.com
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Jan Kara <jack@suse.com>,
 Steve Kenton <skenton@ou.edu>,
 =?utf-8?q?Vojt=C4=9Bch_Vladyka?= <xvlady00@stud.feec.vutbr.cz>,
 Karel Zak <kzak@redhat.com>
Subject: UDF & dstring
Date: Sun, 11 Jun 2017 17:10:02 +0200
Cc: util-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1767945.9cR4CNWp6F";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201706111710.03013@pali>
List-ID: <util-linux.vger.kernel.org>

--nextPart1767945.9cR4CNWp6F
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I read UDF specification again I found another cryptic part:

=3D=3D=3D=3D=3D
2.1.3 Dstrings

The ECMA 167 standard, as well as this document, has normally defined=20
byte positions relative to 0. In section 7.2.12 of ECMA 167, dstrings=20
are defined in terms of being relative to 1. Since this offers an=20
opportunity for confusion, the following shows what the definition would=20
be if described relative to 0.

7.2.12 Fixed-length character fields

A dstring of length n is a field of n bytes where d-characters (1/7.2)=20
are recorded. The number of bytes used to record the characters shall be=20
recorded as a Uint8 (1/7.1.1) in byte n-1, where n is the length of the=20
field. The characters shall be recorded starting with the first byte of=20
the field, and any remaining byte positions after the characters up=20
until byte n-2 inclusive shall be set to #00.

If the number of d-characters to be encoded is zero, the length of the=20
dstring shall be zero.

NOTE: The length of a dstring includes the compression code byte (2.1.1)=20
except for the case of a zero length string. A zero length string shall=20
be recorded by setting the entire dstring field to all zeros.
=3D=3D=3D=3D=3D

Next in previous section 2.1.1 Character Sets is Compression Algorithm=20
table where IDs 0-7 are reserved.

I'm not sure how to correctly interpret those sections.

Does it mean that every dstring should consist of following buffer?

L - length of encoded characters
N - size of dstring buffer

buffer:
      1   byte: 0x08 (for Latin1) or 0x10 (for UCS-2BE)
  2 - L+2 byte: encoded characters (data either in Latin1 or UCS-2BE)
L+2 - N-2 byte: 0x00
      N-1 byte: number L+1

And in special case when L =3D 0, then first and last byte is also zero?

Because currently we have different implementation in kernel udf driver,=20
util-linux blkid library and in mkudffs from udftools.

None of those implementation accept fully empty buffer as valid dstring.

mkudffs stores at last byte length of encoded characters + 1 (for=20
compression id) as written above. On the other hand blkid from util-
linux things that last byte is part of encoded characters and Linux=20
kernel driver does not set last byte to some value.

So... how should be understood that UDF specification? Should last byte=20
be set to length encoded characters + 1 or not? And should be fully=20
empty buffer (also with compression id set to 0x00 which is reserved)=20
treated as valid string (empty one)?

And... we should unify implementation of blkid, kernel udf driver and=20
mkudffs.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1767945.9cR4CNWp6F
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlk9XUoACgkQi/DJPQPkQ1Ir/wCgorUEMCbRcy5wiiPh8mKaUUsn
v1IAoMQikGW6b9aCE50iaOSAbxlxfz6s
=42p5
-----END PGP SIGNATURE-----

--nextPart1767945.9cR4CNWp6F--
