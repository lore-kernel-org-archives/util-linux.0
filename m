Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43113 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbaLECZJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 4 Dec 2014 21:25:09 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so5437wid.11
        for <util-linux@vger.kernel.org>; Thu, 04 Dec 2014 18:25:08 -0800 (PST)
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: "Dale R. Worley" <worley@alum.mit.edu>
Subject: Re: Fwd: Re: util-linux: libblkid: UDF superblock
Date: Fri, 5 Dec 2014 03:25:06 +0100
Cc: util-linux@vger.kernel.org
References: <87oaric0fs.fsf@hobgoblin.ariadne.com>
In-Reply-To: <87oaric0fs.fsf@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1579508.6HPngyuVWt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201412050325.06569@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1579508.6HPngyuVWt
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 05 December 2014 03:09:11 Dale R. Worley wrote:
> Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:
> >> So I think that it is better to use LogicalVolumeIdentifier
> >> for libblkid LABEL. And not current VolumeIdentifier.
> >>=20
> >> What do you think?
>=20
> If you change how the LABEL value is read from the disk, every
> user will see different LABEL values than they saw in the
> past.
>=20
> Dale

Yes, but apparently other systems are using LABEL from=20
LogicalVolumeIdentifier. So now you see different labels on=20
different systems which is not good too.

Also that bsd project UDFclient (which is working on Linux too!)=20
is using LogicalVolumeIdentifier as volume/disk name in newfs_udf=20
tool.

I looked into grub2 code and it is identifying UDF label also=20
from LogicalVolumeIdentifier. So if you want to boot something=20
from UDF FS via grub you probably see label problems...

So I think that rather than using broken linux implementation is=20
better to fix it (which could bring problems with different label=20
names in new version). And I would like to see human readable=20
label as "555e3160".

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1579508.6HPngyuVWt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlSBF4IACgkQi/DJPQPkQ1IK8ACfSMhVJlDygQv5SmWeiNfgkL59
aEgAoK7l+7B1fEIvv//ZgPNmg9tU48Lq
=f5Lz
-----END PGP SIGNATURE-----

--nextPart1579508.6HPngyuVWt--
