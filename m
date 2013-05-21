Return-Path: util-linux-owner@vger.kernel.org
Received: from fr1.as29.net ([88.190.23.70]:55087 "EHLO toothrot.meleeweb.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061Ab3EUNlT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 May 2013 09:41:19 -0400
Date: Tue, 21 May 2013 15:35:23 +0200
From: Bertrand Jacquin <beber@meleeweb.net>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk 2.20.1 --no-reread do BLKRRPART
Message-ID: <20130521133523.GB3078@lady-voodoo.exosec.local>
References: <20120216201617.GD7482@lemonhead.scabb>
 <20130520111523.GB19935@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
In-Reply-To: <20130520111523.GB19935@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 20 mai 2013 =E0 13h15, =AB Karel Zak =BB a =E9crit :
>=20
>  Sorry for the delay :-)

No rush at all ! This was only a report about some ugly report in some
scripts :)

> On Thu, Feb 16, 2012 at 09:16:18PM +0100, Bertrand Jacquin wrote:
> > When creating partitions on a destination that is not a block device,
> > sfdisk do a BLKRRPART ioctl even when --no-reread option is used, but
> > looking at documentation --no-reread only apply to the beginning
> > process.
> >=20
> > Would it be fine to extend that to the complete process ?
>=20
>  Not sure, but I think it should be enough to don't call BLKRRPART
>  ioctl for non-block devices.
>=20
> >   dd if=3D/dev/zero of=3D/tmp/disk.img bs=3D1024 count=3D4032
> >   strace -fF -s 1024 -e trace=3Dioctl \
> >     sfdisk --no-reread -C2 -H32 -S63 -q -f \
> >       /tmp/disk.img << EOF
> > unit: sectors
> >=20
> > part1 : start=3D 63, size=3D 3969, Id=3D83
> > part2 : start=3D 4032, size=3D 98784, Id=3D83
> > part3 : start=3D 102816, size=3D 22176, Id=3D83
> > part4 : start=3D 124992, size=3D 0, Id=3D83
> > EOF
>=20
> ...
>=20
> > Re-reading the partition table ...
> > ioctl(3, BLKRRPART, 0)                  =3D -1 ENOTTY (Inappropriate io=
ctl for device)
> > BLKRRPART: Inappropriate ioctl for device
>=20
>  This use case (disk images partitioning) should be fixed in the git
>  tree.

Seen and approved ! Thanks Karel

--=20
Bertrand Jacquin, EXOSEC (http://www.exosec.fr/)
ZAC des Metz - 3 Rue du petit robinson - 78350 JOUY EN JOSAS
Tel: +33 1 30 67 60 65  -  Fax: +33 1 75 43 40 70
GSM: +33 6 71 01 70 30  -  mailto:bjacquin@exosec.fr

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlGbeBsACgkQibjJUzm7jPT2twCeMKzqcfGSDP9zojeXhMSptWT5
LyIAn2VCyBufzlDYKHEGJ6qE77aimusd
=0AnT
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
