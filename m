Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37344 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbdELOjD (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 12 May 2017 10:39:03 -0400
Received: by mail-wm0-f51.google.com with SMTP id d127so17214227wmf.0
        for <util-linux@vger.kernel.org>; Fri, 12 May 2017 07:39:02 -0700 (PDT)
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: util-linux@vger.kernel.org, Steve Kenton <skenton@ou.edu>,
        =?utf-8?q?Vojt=C4=9Bch_Vladyka?= <xvlady00@stud.feec.vutbr.cz>,
        Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>
Subject: libblkid: udf: Incorrect implementation of Unicode strings
Date: Fri, 12 May 2017 16:38:59 +0200
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3052862.1CzK1kImSv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201705121638.59416@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart3052862.1CzK1kImSv
Content-Type: multipart/mixed;
  boundary="Boundary-01=_DkcFZeV6asQ1sYq"
Content-Transfer-Encoding: 7bit


--Boundary-01=_DkcFZeV6asQ1sYq
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

Since beginning libblkid's udf code handles 16bit OSTA compressed=20
unicode as UTF-16BE and 8bit OSTA compressed unicode as UTF-8.

In UDF 2.01 specification is written:
=3D=3D=3D=3D
=46or a CompressionID of 8 or 16, the value of the CompressionID shall=20
specify the number of BitsPerCharacter for the d-characters defined in=20
the CharacterBitStream field. Each sequence of CompressionID bits in the=20
CharacterBitStream field shall represent an OSTA Compressed Unicode d-
character. The bits of the character being encoded shall be added to the=20
CharacterBitStream from most- to least-significant-bit. The bits shall=20
be added to the CharacterBitStream starting from the most significant=20
bit of the current byte being encoded into. The value of the OSTA=20
Compressed Unicode d-character interpreted as a Uint16 defines the value=20
of the corresponding d-character in the Unicode 2.0 standard.
=3D=3D=3D=3D

So it means that 8bit OSTA compressed unicode buffer contains sequence=20
of Unicode codepoints, one per 8 bits. What effectively means=20
equivalence with Latin1 (ISO-8859-1) encoding.

And 16bit OSTA compressed unicode means sequence of Unicode codepoints,=20
one per 16 bits in big endian. What is probably only UCS-2 and not full=20
UTF-16.

So problem is with 8bit OSTA compressed unicode if contains bytes which=20
are not UTF-8 invariants (ASCII). As those those are decoded differently=20
with Latin1 and UTF-8.

Which means libblkid udf implementation of reading Unicode strings is=20
wrong and affects all read operations (Label, UUID, ...).

To verify this problem I prepared small udf image (attached) which has=20
logical volume identifier (known as label): 0x08 0xC3 0xBF 0x00 ... 0x03

According to spec it should be decoded as string "=C3=83=C2=BF"
(LATIN CAPITAL LETTER A WITH TILDE, INVERTED QUESTION MARK).

But blkid show me "=C3=BF" (LATIN SMALL LETTER Y WITH DIAERESIS).

I checked grub2 and Windows implementations and they show "=C3=83=C2=BF".

So... what to do with blkid implementation? Fixing it would mean to=20
break all existing labels and uuids on Linux. Not fixing it would mean=20
to have different labels across different systems which implements it=20
properly.

Problem appeared when I send patch for implementing same algorithm of=20
UUID into grub2. (Patch was not merged yet).

Note that Linux's mkudffs from udftools generates label correctly so is=20
also incompatible with blkid implementation. But because I tested only=20
ASCII characters and Unicode characters above U+FF I have not detected=20
this problem... (ASCII is same in UTF-8 and Latin1; and chars above U+FF=20
can be encoded only as UTF-16 resp. USC-2)

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--Boundary-01=_DkcFZeV6asQ1sYq
Content-Type: application/x-xz;
  name="udf.img.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="udf.img.xz"

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

--Boundary-01=_DkcFZeV6asQ1sYq--

--nextPart3052862.1CzK1kImSv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlkVyQMACgkQi/DJPQPkQ1L6YwCfT7JafhoAiRZeDO2L/HtcV5iS
joEAnAi7RBtf0AXbMxHmbgYiKNneL2Kd
=E8jT
-----END PGP SIGNATURE-----

--nextPart3052862.1CzK1kImSv--
