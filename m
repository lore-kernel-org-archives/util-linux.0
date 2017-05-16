Return-Path: pali.rohar@gmail.com
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Subject: Re: libblkid: udf: Incorrect implementation of Unicode strings
Date: Wed, 17 May 2017 00:17:19 +0200
Cc: util-linux@vger.kernel.org,
 Steve Kenton <skenton@ou.edu>,
 =?utf-8?q?Vojt=C4=9Bch_Vladyka?= <xvlady00@stud.feec.vutbr.cz>,
 Jan Kara <jack@suse.cz>
References: <201705121638.59416@pali> <20170515100940.lggq2um6xt3dg66p@ws.net.home>
In-Reply-To: <20170515100940.lggq2um6xt3dg66p@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart49841347.Ebxh3aKSXK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201705170017.19752@pali>
List-ID: <util-linux.vger.kernel.org>

--nextPart49841347.Ebxh3aKSXK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 15 May 2017 12:09:40 Karel Zak wrote:
> On Fri, May 12, 2017 at 04:38:59PM +0200, Pali Roh=C3=A1r wrote:
> > Hi!
> >=20
> > Since beginning libblkid's udf code handles 16bit OSTA compressed
> > unicode as UTF-16BE and 8bit OSTA compressed unicode as UTF-8.
> >=20
> > In UDF 2.01 specification is written:
> > =3D=3D=3D=3D
> > For a CompressionID of 8 or 16, the value of the CompressionID
> > shall specify the number of BitsPerCharacter for the d-characters
> > defined in the CharacterBitStream field. Each sequence of
> > CompressionID bits in the CharacterBitStream field shall represent
> > an OSTA Compressed Unicode d- character. The bits of the character
> > being encoded shall be added to the CharacterBitStream from most-
> > to least-significant-bit. The bits shall be added to the
> > CharacterBitStream starting from the most significant bit of the
> > current byte being encoded into. The value of the OSTA Compressed
> > Unicode d-character interpreted as a Uint16 defines the value of
> > the corresponding d-character in the Unicode 2.0 standard. =3D=3D=3D=3D
> >=20
> > So it means that 8bit OSTA compressed unicode buffer contains
> > sequence of Unicode codepoints, one per 8 bits. What effectively
> > means equivalence with Latin1 (ISO-8859-1) encoding.
> >=20
> > And 16bit OSTA compressed unicode means sequence of Unicode
> > codepoints, one per 16 bits in big endian. What is probably only
> > UCS-2 and not full UTF-16.
> >=20
> > So problem is with 8bit OSTA compressed unicode if contains bytes
> > which are not UTF-8 invariants (ASCII). As those those are decoded
> > differently with Latin1 and UTF-8.
> >=20
> > Which means libblkid udf implementation of reading Unicode strings
> > is wrong and affects all read operations (Label, UUID, ...).
> >=20
> > To verify this problem I prepared small udf image (attached) which
> > has logical volume identifier (known as label): 0x08 0xC3 0xBF
> > 0x00 ... 0x03
> >=20
> > According to spec it should be decoded as string "=C3=83=C2=BF"
> > (LATIN CAPITAL LETTER A WITH TILDE, INVERTED QUESTION MARK).
> >=20
> > But blkid show me "=C3=BF" (LATIN SMALL LETTER Y WITH DIAERESIS).
> >=20
> > I checked grub2 and Windows implementations and they show "=C3=83=C2=BF=
".
> >=20
> > So... what to do with blkid implementation? Fixing it would mean to
> > break all existing labels and uuids on Linux. Not fixing it would
> > mean to have different labels across different systems which
> > implements it properly.
>=20
> The issue has never been reported, so I guess the number of the
> affected LABELs is pretty small :-)
>=20
> From my point of view it would be better to follow the standard, fix
> the issue and be compatible with the another utils and systems. It
> would be nice to fix it now for v2.30 where we already have changes
> in udf/iso stuff. Please, send the patch :-)

=46ix for all UDF strings except UUID is in this pull request:
https://github.com/karelzak/util-linux/pull/438

I hope it is correct now. UDF image with "=C3=83=C2=BF" is added to tests.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart49841347.Ebxh3aKSXK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlkbem8ACgkQi/DJPQPkQ1IrUQCfX0BqXx3DNRI8RM0MBWX9ecrz
Bg8An2Yx+Gxt0rFHBnyQBoWOelIle1NU
=DYtq
-----END PGP SIGNATURE-----

--nextPart49841347.Ebxh3aKSXK--
