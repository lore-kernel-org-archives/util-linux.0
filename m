Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38603 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751987AbdEQSuw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 17 May 2017 14:50:52 -0400
Received: by mail-wm0-f41.google.com with SMTP id v15so26766461wmv.1
        for <util-linux@vger.kernel.org>; Wed, 17 May 2017 11:50:51 -0700 (PDT)
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Subject: Re: libblkid: udf: Incorrect implementation of Unicode strings
Date: Wed, 17 May 2017 20:50:48 +0200
Cc: util-linux@vger.kernel.org
References: <201705121638.59416@pali> <20170516140245.GE10015@pali> <20170517071333.wj4glanhfh2aje72@ws.net.home>
In-Reply-To: <20170517071333.wj4glanhfh2aje72@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2147606.tOzCa2by4I";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201705172050.48793@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2147606.tOzCa2by4I
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 17 May 2017 09:13:33 Karel Zak wrote:
> On Tue, May 16, 2017 at 04:02:45PM +0200, Pali Roh=C3=A1r wrote:
> > > > > If yes... then we can keep it unchanged, generate UUDI in the
> > > > > same way as now (hexadecimal digits). The "OSTA Unicode fix"
> > > > > maybe be used for LABEL=3D (etc) only. I guess nothing forces
> > > > > use to generate UUIDs from decoded VolSetId.
> > > > >=20
> > > > > Anyway, UUID has to be printable.
> > > >=20
> > > > Lets first define allowed characters in UUID and then what we
> > > > do with UDF's UUID.
> > > >=20
> > > > Printable means only printable ASCII? Or also printable from
> > > > Unicode? Or only alphanumeric?
> > >=20
> > > I'd like to be very conservative and avoid anything else than
> > > ASCII. It's identifier that should be usable everywhere.
> > >=20
> > > udev uses the UUID for paths and symlinks, "bad chars" are
> > > escaped and it's very user unfriendly. We should be also user
> > > friendly to non-UTF users, terminals, etc.
> > >=20
> > > IMHO the best solution would be to use lowercase hex-digits like
> > > for another filesystems (and super ideal would be follow UUID
> > > notation for formatting (e.g.
> > > "c5490147-2a6c-4c8a-aa1b-33492034f927") ;-).
> >=20
> > We have only 16 Unicode characters (and first 8 are hexdigits), so
> > above format for 128bit UUID notation is not possible.
> >=20
> > Currently VolSetID is parsed as bytes instead of (Unicode)
> > characters. We can correctly parse it, read first 16 chars,
> > convert then UTF-8 and then use those UTF-8 bytes as input for
> > generating UUID. This step has advantage that deals with Unicode
> > (and does not matter on internal representation of VolSetID string
> > stored in UDF) and also that produce normalized bytes which can be
> > later used...
> >=20
> > You want to have only lowercase hexdigits in UUID. I understand
> > this reason, it makes sense. But how to generate UUID from
> > (potentially arbitrary) UTF-8 sequence of 16 Unicode characters?
> > Because UTF-8 is variable length encoding.
> >=20
> > Currently UUID generator split those 16 chars/bytes into first and
> > second half because according to UDF standard that first half
> > should contain only hexdigits (and in most cases they really
> > are!). Half which is not alphanumeric is encoded via %02x per
> > byte. And final string truncated to 16 bytes (to have fixed
> > length).
> >=20
> > What we can do is to take UTF-8 sequence (instead raw UDF bytes)
> > and encode non-hexdigits bytes (instead non-alnum) via %02x. And
> > truncate again to 16 hexdigits.
>=20
> This is what I expected... don't think about it as about characters,
> but as about random bytes that we print as %02x. The result will be
> always the same for the same UDF header, right?

Still, more UDF disks created by Nero, new mkudffs or new udfclient have=20
only hexdigits stored in VolSetID. So it is better to use them directly=20
instead of encoding hexdigits characters via %02x.

I tried to modify current algorithm to take UTF-8 representation for its=20
input (therefore correctly handle both 8bit and 16bit OSTA Unicode) and=20
honor above hexdigits in VolSetID.

Please look at review my proposed changes:
https://github.com/karelzak/util-linux/pull/439

If you do not agree with changes or you have other idea comments let me=20
know.

> The another option would be use some hash sum to standardize
> arbitrary number of bytes (for example we use MD5 to generate UUID
> for libblkid/src/superblocks/hfs.c). In this case we can use also
> some another bytes from the header, for example
> volume_descriptor.tag. The disadvantage is dependence on checksum
> code, so bad portability to another projects (grub, etc.).

Looks like too complicated, specially decision on checksum/hash function=20
could be problematic to implement in other projects. Probably hash=20
functions does not have to be fast (even there are fast MD5=20
implementations).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2147606.tOzCa2by4I
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlkcm4gACgkQi/DJPQPkQ1JQKACcDP16jiFDES0IPkVoKD/pyhul
/GsAoKHzgC2txv8ups7HsWqlI2aXszMj
=5dPd
-----END PGP SIGNATURE-----

--nextPart2147606.tOzCa2by4I--
