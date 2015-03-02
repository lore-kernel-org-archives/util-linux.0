Return-Path: util-linux-owner@vger.kernel.org
Received: from mta04.eastlink.ca ([24.224.136.10]:32955 "EHLO
	mta04.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbbCBQTf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 Mar 2015 11:19:35 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta04.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NKL0070J2MQK7A1@mta04.eastlink.ca> for
 util-linux@vger.kernel.org; Mon, 02 Mar 2015 12:19:32 -0400 (AST)
Date: Mon, 02 Mar 2015 12:19:32 -0400
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: sfdisk problem with a partition starting early on a GPT disk
Message-id: <20150302161932.GX3933@cordes.ca>
References: <20150301155610.GW3933@cordes.ca>
 <20150302100652.GI8046@ws.net.home>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary=LSp5EJdfMPwZcMS1
In-reply-to: <20150302100652.GI8046@ws.net.home>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2015 at 11:06:52AM +0100, Karel Zak wrote:
> On Sun, Mar 01, 2015 at 11:56:10AM -0400, Peter Cordes wrote:
> > # the disk I partitioned manually:
> > $ sudo /usr/local/src/util-linux/sfdisk -d /dev/sde | tee tosh-partitio=
ns.sfdisk
> > label: gpt
> > label-id: 7E471862-5089-4C54-A3BC-722ADD08808A
> > device: /dev/sde
> > unit: sectors
> >=20
> > /dev/sde1 : start=3D          40, size=3D        2008, type=3D21686148-=
6449-6E6F-744E-656564454649, uuid=3D01F40706-97E6-43D1-80D3-0EA85BB5E8FD, n=
ame=3D"BIOS boot partition"
> > /dev/sde2 : start=3D        2048, size=3D    30720000, type=3DA19D880F-=
05FC-4D3B-A006-743F0F84911E, uuid=3D9898E8B2-C930-4E6E-826A-4D7305793E6A
> > /dev/sde3 : start=3D    30722048, size=3D   122880000, type=3DA19D880F-=
05FC-4D3B-A006-743F0F84911E, uuid=3DC0CF3D7C-A170-4E1E-9169-9AB4A4FF3164
> > /dev/sde4 : start=3D   153602048, size=3D   820695040, type=3DA19D880F-=
05FC-4D3B-A006-743F0F84911E, uuid=3DF9258FDA-14A3-4B72-B367-F3B1B244C407
> > /dev/sde5 : start=3D   974297088, size=3D     2457600, type=3D0657FD6D-=
A4AB-43C4-84E5-0933C84B4F4F, uuid=3D8EF2E18C-8E3D-41A3-86AF-EE4FDA7B103D
> > /dev/sde6 : start=3D   976754688, size=3D  4883777536, type=3DA19D880F-=
05FC-4D3B-A006-743F0F84911E, uuid=3D265297FD-E7AA-484F-BEC2-D03C385E75DD
> ...
> >  >>> Created a new GPT disklabel (GUID: 7E471862-5089-4C54-A3BC-722ADD0=
8808A).
> >  Sector 40 already used.
> >  Failed to add partition: Numerical result out of range
> >  Leaving.
> ...
>
> UEFI standard:
>=20
>   "First Usable LBA must be greater than or equal to 34.."
>=20
> so your setup correct, you have the first partition at LBA 40.

 That wording sounds like the partition utilities are allowed to make
GPT partition tables with first-usable-sector as high as they want.  So
the UEFI standard doesn't require that tools support stuffing a
partition before the first 1MiB.

> The libfdisk uses 1MiB offset for the
> First LBA to make sure that all partitions will be aligned. This
> is generic for all our fdisks.   (1MiB is almost standard now.)

 Yeah, since alignment requirements for pretty much any hardware
(except a partitionable RAID5/6) are so much smaller than device
capacity, it makes sense to just go way overboard and align to 1MiB.
That still only wastes a tiny fraction (~1MiB / 1TiB < 10^-6).

 Thanks for clearing up that this is just a side effect of a
restriction imposed while designing libfdisk to ensure standard
alignment.

 If libfdisk doesn't actually store anything after sector 33, it would
be nice if it wrote a GPT to disk that that has sector 34 as the
first-usable.  That way, I could use gdisk to add a boot partition on
each disk after copying the layout of the other partitions with
sfdisk.  (That would be a minimal fix that isn't as nice as actually
supporting copying arbitrary valid GPT partition tables.  But it
should be easier).  As it is, gdisk tells me that the GPT it read from
the disk has the first-usable-sector as 2048.

 I ended up using sfdisk (instead of dd, since I needed different
UUIDs).  Then gdisk, and put my gdisk-EF02 boot partition in the
unused ~500k at the end of the disk.  (Hopefully GRUB2's boot sector
can load its next component from > 2TiB.  Otherwise I could make room
next to my swap partitions or something.  I've already started copying
data to the other partitions.)



> I don't want to offer such possibility for standard partitioning (in
> cfdisk or fdisk), but for dumps or if you want to restore PT backups
> the library should be ready to accept smaller offsets.

 gdisk supports it.  As long as it's maintained, people can use that.

> Well, <1MiB for the first partition is like a black swan, it's
> unusual, but it exists :-)

 My thinking was that I don't even need 1MiB for this, and it just
felt clunky to make the first real partition start at 2MiB.  IMO,
right after the the partition table should be the standard location
for "bios boot" partitions (gdisk EF02 type code).

 The other advantage is that it makes it slightly simpler to dd
everything needed for booting (other than the partition containing
/boot, which can be a RAID10,f2 or whatever).

 I haven't tried setting my BIOS to UEFI boot mode, but if the EFI
system partition (containing a FAT FS) can fit in 1000kiB, that still
seems like the ideal location for it.

--=20
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iLwEAQEIAAYFAlT0jZMACgkQBaSaEuRa5FMapwUAkRLOnCdunPWZiMkVVb7Uonz0
Rxc3FKYZjGdoXt7Xw9U+ZPVH+LI8jlsz2DiT0Rhv20jDWyhQhdIXYj7PzfD/FFhr
nVYLy6BrBEkoKKNfXbToKrZ92ytqszTelil8uRZPqnpAaNHIn3pWvLI4ZmSHtFAo
e00zaTb6Ifoum1l8XNso7d9pvITbqq/siiVlSy7myiFJHnWK/gAHe6M3xL+NSQ==
=DXb0
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--
