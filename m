Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35034 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdFVIur (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 22 Jun 2017 04:50:47 -0400
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Jan Kara <jack@suse.cz>
Subject: Re: UDF & dstring
Date: Thu, 22 Jun 2017 10:50:42 +0200
Cc: Jan Kara <jack@suse.com>, Steve Kenton <skenton@ou.edu>,
        =?utf-8?q?Vojt=C4=9Bch_Vladyka?= <xvlady00@stud.feec.vutbr.cz>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <201706111710.03013@pali> <20170614094614.GA20247@quack2.suse.cz>
In-Reply-To: <20170614094614.GA20247@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2651272.T2METxLly0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201706221050.42859@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2651272.T2METxLly0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 14 June 2017 11:46:14 Jan Kara wrote:
> Hi,
>=20
> On Sun 11-06-17 17:10:02, Pali Roh=C3=A1r wrote:
> > 2.1.3 Dstrings
> >=20
> > The ECMA 167 standard, as well as this document, has normally
> > defined byte positions relative to 0. In section 7.2.12 of ECMA
> > 167, dstrings are defined in terms of being relative to 1. Since
> > this offers an opportunity for confusion, the following shows what
> > the definition would be if described relative to 0.
> >=20
> > 7.2.12 Fixed-length character fields
> >=20
> > A dstring of length n is a field of n bytes where d-characters
> > (1/7.2) are recorded. The number of bytes used to record the
> > characters shall be recorded as a Uint8 (1/7.1.1) in byte n-1,
> > where n is the length of the field. The characters shall be
> > recorded starting with the first byte of the field, and any
> > remaining byte positions after the characters up until byte n-2
> > inclusive shall be set to #00.
> >=20
> > If the number of d-characters to be encoded is zero, the length of
> > the dstring shall be zero.
> >=20
> > NOTE: The length of a dstring includes the compression code byte
> > (2.1.1) except for the case of a zero length string. A zero length
> > string shall be recorded by setting the entire dstring field to
> > all zeros. =3D=3D=3D=3D=3D
> >=20
> > Next in previous section 2.1.1 Character Sets is Compression
> > Algorithm table where IDs 0-7 are reserved.
> >=20
> > I'm not sure how to correctly interpret those sections.
> >=20
> > Does it mean that every dstring should consist of following buffer?
> >=20
> > L - length of encoded characters
> > N - size of dstring buffer
> >=20
> > buffer:
> >       1   byte: 0x08 (for Latin1) or 0x10 (for UCS-2BE)
> >  =20
> >   2 - L+2 byte: encoded characters (data either in Latin1 or
> >   UCS-2BE)
> >=20
> > L+2 - N-2 byte: 0x00
> >=20
> >       N-1 byte: number L+1
> >=20
> > And in special case when L =3D 0, then first and last byte is also
> > zero?
>=20
> Yes, apparently that's what the spec says.
>=20
> > Because currently we have different implementation in kernel udf
> > driver, util-linux blkid library and in mkudffs from udftools.
> > None of those implementation accept fully empty buffer as valid
> > dstring.
>=20
> As far as I'm looking, kernel handles this just fine. Note that
> 'dstring' is actually rather rare in UDF. E.g. filenames are
> recorded as d-characters which is something different. For
> converting dstrings (only used for getting volume and set
> identifiers) we use udf_dstrCS0toUTF8() which uses
> udf_name_from_CS0() and that handles input length of 0 just fine.
>=20
> > mkudffs stores at last byte length of encoded characters + 1 (for
> > compression id) as written above. On the other hand blkid from
> > util- linux things that last byte is part of encoded characters
> > and Linux kernel driver does not set last byte to some value.
>=20
> Linux kernel UDF driver never writes any dstring.
>=20
> > So... how should be understood that UDF specification? Should last
> > byte be set to length encoded characters + 1 or not? And should be
> > fully empty buffer (also with compression id set to 0x00 which is
> > reserved) treated as valid string (empty one)?
> >=20
> > And... we should unify implementation of blkid, kernel udf driver
> > and mkudffs.
>=20
> I think you understood the spec correctly. What I think we should do
> is to make udf-tools and blkid accept both variants but create the
> one defined in the spec (to have higher chances for
> interoperability).
>=20
> 								Honza

mkudffs creates non-zero dstrings correctly since beginning. Zero=20
dstrings have set compression ID (first byte) and length to 1 (last=20
byte). This can be fixed, but I'm note sure if it is needed as=20
LogicalVolumeId (and others too) according to specification should not=20
be empty... But maybe it would make sense to allow user for some=20
specific situation to create such disk image (if user knows what is=20
doing).

Problem is in blkid parser which includes last byte into buffer for=20
decoding. As blkid stops at null byte, problem is only when byte before=20
length is non-null. E.g. when LogicalVolumeId (label) has exactly 30=20
Latin1 characters (LogicalVolumeId is 32 byte dstring).

I created patch for blkid with test case there:=20
https://github.com/karelzak/util-linux/pull/468

Similar patch would be needed also for grub2.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2651272.T2METxLly0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAllLhOIACgkQi/DJPQPkQ1LTxACdFjU6LMADFNZAq8vNKatpvFL2
kK0An0LLAqNnHADgsw6PJ9CVROXQ7jxT
=SFi8
-----END PGP SIGNATURE-----

--nextPart2651272.T2METxLly0--
