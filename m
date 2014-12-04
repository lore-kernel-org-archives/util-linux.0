Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:38261 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230AbaLDTmL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 4 Dec 2014 14:42:11 -0500
Received: by mail-wg0-f54.google.com with SMTP id l2so23722109wgh.27
        for <util-linux@vger.kernel.org>; Thu, 04 Dec 2014 11:42:09 -0800 (PST)
Received: from pali-latitude.localnet (eduroam92.ms.mff.cuni.cz. [195.113.16.92])
        by mx.google.com with ESMTPSA id hn2sm41784473wjc.5.2014.12.04.11.42.08
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 11:42:08 -0800 (PST)
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: util-linux@vger.kernel.org
Subject: Fwd: Re: util-linux: libblkid: UDF superblock
Date: Thu, 4 Dec 2014 20:42:06 +0100
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3539438.RYxeZNrIeT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201412042042.06702@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart3539438.RYxeZNrIeT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=2D---------  Forwarded Message  ----------

Subject: Re: util-linux: libblkid: UDF superblock
Date: Sunday 30 November 2014, 12:51:54
=46rom: Pali Roh=C3=A1r <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>

On Sunday 30 November 2014 12:36:49 Pali Roh=C3=A1r wrote:
> Hello!
>=20
> I looked at UDF specifications 1.50 [1] and 2.01 [2] and then
> on libblkid UDF superblock code.
>=20
> If I understand libblkid udf code then it set LABEL string
> from Primary Volume Descriptor --> VolumeIdentifier. This
> field can be set by mkudffs --vid=3D option.
>=20
> But in both UDF specifications for LogicalVolumeIdentifier is
> written:
>=20
> =3D=3D=3D
> This field is extremely important in logical volume
> identification when multiple media are present within a
> jukebox. This name is typically what is displayed to the
> user. =3D=3D=3D
>=20
> LogicalVolumeIdentifier can be set by mkudffs --lvid=3D option.
>=20
> About VolumeIdentifier (which is used by libblkid udf code)
> there is only one part in both specifications:
>=20
> =3D=3D=3D
> Part 3 ISO/IEC 13346 (in 2.01: ECMA 167) contains various
> Identifiers which, depending upon the implementation, maybe
> have to be presented to the user.
> * VolumeIndentifier
> =3D=3D=3D
>=20
> So I think that it is better to use LogicalVolumeIdentifier
> for libblkid LABEL. And not current VolumeIdentifier.
>=20
> What do you think?
>=20
> See also discussion about these identifiers at [3].
>=20
>=20
> And I have another question. UDF does not support UUID
> identifiers. But in both specifications there is something
> which can be used. Read description about
> VolumeSetIdentifier:
>=20
> =3D=3D=3D
> Interpreted as specifying the identifier for the volume set.
>=20
> The first 16 characters of this field should be set to unique
> value. The remainder of the field may be set to any allowed
> value. Specifically, software generating volumes conforming to
> this specification shall not set this volume to a fixed or
> trivial value. Duplicate disks which are intended to be
> identical may contain the same value in this field.
>=20
> NOTE: The intended purpose of this is to guarantee Volume Sets
> with unique identifiers. The first 8 characters of the unique
> part should come from CS0 hexadecimal representation of a
> 32-bit time value. The remaining 8 characters are fee for
> implementation use.
> =3D=3D=3D
>=20
> So first 16 characters are good candidate for libblkid UUID.
> What do you think about it?
>=20
> mkudffs set first 8 characters of VolumeSetIdentifier really
> to that time time. Next characters can be configured by
> mkudffs option --vsid=3D. Default is fixed "LinuxUDF". But we
> still have unique time identifier.
>=20
>=20
> [1] - http://www.osta.org/specs/pdf/udf150.pdf
> [2] - http://www.osta.org/specs/pdf/udf201.pdf
> [3] -
> http://superuser.com/questions/366808/in-udf-whats-the-differ
> ence-between-a-volume-identifier-volume-set-identifier

Now I looked at newfs_udf implementation (part of UDFclient=20
package [1], alternative to mkudffs) and it show this warning=20
message

newfs_udf: no logical volume name passed; not creating logical=20
volume descriptor

if you do not set -L option:

=2DL volumename  use `volumename' as logical volume name (discname)=20

which is presented as discname -- good candidate for LABEL. That=20
volumename is LogicalVolumeIdentifier what I suggested to use as=20
LABEL in previous name.

By default VolumeIdentifier (option -P) is set to some random=20
garbage and blkid identify UDF disk as:

/dev/loop0: LABEL=3D"555e3160" TYPE=3D"udf"

(I set volumename to human readable disk name)

So now I think that linux blkid should for LABEL use=20
LogicalVolumeIdentifier instead VolumeIdentifier.

newfs_udf set by default for VolumeSetIdentifier some random 8=20
chars (not 16!) but allows you to set also first 8 by option -S.=20
mkudffs does not allow you to set first 8 chars. They are always=20
time stamp.

[1] - http://www.13thmonkey.org/udfclient/

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

=2D----------------------------------------

--nextPart3539438.RYxeZNrIeT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlSAuQ4ACgkQi/DJPQPkQ1KrQACgjrFdnH6Bgdj0tDFYLhzMSWf2
ik4Ani5/fHj1154czeZgRBSWOQ7s7i5X
=uiOq
-----END PGP SIGNATURE-----

--nextPart3539438.RYxeZNrIeT--
