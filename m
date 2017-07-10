Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f175.google.com ([209.85.128.175]:33723 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754758AbdGJRs7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 10 Jul 2017 13:48:59 -0400
Received: by mail-wr0-f175.google.com with SMTP id r103so148653789wrb.0
        for <util-linux@vger.kernel.org>; Mon, 10 Jul 2017 10:48:59 -0700 (PDT)
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Subject: Re: libblkid: ID_FS_VERSION
Date: Mon, 10 Jul 2017 19:48:54 +0200
Cc: util-linux@vger.kernel.org
References: <201707051349.26662@pali> <20170710111509.GB560@pali> <20170710115236.c45ivf43w5cjvfxm@ws.net.home>
In-Reply-To: <20170710115236.c45ivf43w5cjvfxm@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3805756.0FQFIHaL2h";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201707101948.55088@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart3805756.0FQFIHaL2h
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 10 July 2017 13:52:36 Karel Zak wrote:
> On Mon, Jul 10, 2017 at 01:15:09PM +0200, Pali Roh=C3=A1r wrote:
> > On Monday 10 July 2017 13:08:28 Karel Zak wrote:
> > > On Wed, Jul 05, 2017 at 01:49:26PM +0200, Pali Roh=C3=A1r wrote:
> > > > Hi! What is the meaning of the ID_FS_VERSION attribute? I'm
> > > > trying to find documentation about libblkid attributes, but
> > > > seems there is none.
> > >=20
> > > libblkid/src/superblocks/superblocks.c
> > >=20
> > >    * @VERSION: filesystem version
> > > :
> > > :-)
> >=20
> > That does not provide more information :-)
> >=20
> > > Well, the field is to provide more details about the filesystem,
> > > for example we have VERSION=3D"FAT16" TYPE=3D"vfat", and so on. Note
> > > that TYPE is usually name used by kernel (to be usable for
> > > "mount -t <type>").
> > >=20
> > > I guess the VERSION is used by some userspace stuff (udisks?) to
> > > get more information (or provide more details to end-users).
> > > It's probably nothing critical.
> >=20
> > I'm thinking if we can provide UDF revision/version of UDF
> > filesystem to userspace and looks like ID_FS_VERSION is good
> > candidate for it...
> >=20
> > What do you think?
>=20
> It seems blkid_probe_set_version() is nowhere used for UD now, so we
> have absolute freedom to use it in some way.
>=20
> > E.g. Linux kernel is able to read UDF filesystem up to revision
> > 2.50 and has read-write support up to revision 2.01. So for
> > userspace this information can be useful.
>=20
> Yes, sounds good.
>=20
>     Karel

https://github.com/karelzak/util-linux/pull/483

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3805756.0FQFIHaL2h
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlljvgcACgkQi/DJPQPkQ1JelACfbQzinKmaqhCB+Vjo1n554Nqr
gd0AniwxCOwXcls94P8ziFTjbxo8bbY/
=Cp+3
-----END PGP SIGNATURE-----

--nextPart3805756.0FQFIHaL2h--
