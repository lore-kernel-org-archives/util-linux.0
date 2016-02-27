Return-Path: util-linux-owner@vger.kernel.org
Received: from mta03.eastlink.ca ([24.224.136.9]:43051 "EHLO mta03.eastlink.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbcB0Et6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 26 Feb 2016 23:49:58 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta03.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0O35008BMNF6WF53@mta03.eastlink.ca> for
 util-linux@vger.kernel.org; Sat, 27 Feb 2016 00:19:55 -0400 (AST)
Received: from peter by llama.cordes.ca with local (Exim 3.36 #1 (Debian))
	id 1aZWMF-0001S0-00	for <util-linux@vger.kernel.org>; Sat,
 27 Feb 2016 00:19:55 -0400
Date: Sat, 27 Feb 2016 00:19:55 -0400
To: util-linux@vger.kernel.org
Subject: cfdisk UI problem with a small partition starting and ending	before
 sector 2048 (1MiB)
Message-id: <20160227041955.GT20685@cordes.ca>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary=CgTrtGVSVGoxAIFj
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--CgTrtGVSVGoxAIFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I tested sfdisk/cfdisk from the latest git while setting up a new disk.
It finds some free space where there isn't any:


                          Disk: /dev/sde
     Size: 2.7 TiB, 3000592982016 bytes, 5860533168 sectors
  Label: gpt, identifier: 7E471862-5089-4C54-A3BC-722ADD08808A
					      =20
Device           Start        End              Sectors  Size Type
/dev/sde1           40       2047                 2008 1004K BIOS boot
Free space        2048         39 18446744073709549608   16E
/dev/sde2         2048   30722047             30720000 14.7G Linux RAID
=2E..


sfdisk --dump dumps/restores it just fine.  (Thanks fixing that bug last
year with sfdisk refusing to create the boot partition starting at
sector 40.)

Here's the dump so you can recreate it easily:

label: gpt
label-id: 7E471862-5089-4C54-A3BC-722ADD08808A
device: /dev/sde
unit: sectors
first-lba: 34
last-lba: 5860533134

/dev/sde1 : start=3D          40, size=3D        2008, type=3D21686148-6449=
-6E6F-744E-656564454649, uuid=3D336580CD-6D34-4148-8708-DB3308CE667C, name=
=3D"BIOS boot partition"
/dev/sde2 : start=3D        2048, size=3D    30720000, type=3DA19D880F-05FC=
-4D3B-A006-743F0F84911E, uuid=3DA3F01280-2490-4925-B2D7-4A31F0B8556A
/dev/sde3 : start=3D    30722048, size=3D      614400, type=3D0657FD6D-A4AB=
-43C4-84E5-0933C84B4F4F, uuid=3DB07E3680-FC7E-4BE3-A14A-568011F9D410
/dev/sde4 : start=3D    31336448, size=3D   134217728, type=3DA19D880F-05FC=
-4D3B-A006-743F0F84911E, uuid=3DCA777D0F-0DA2-4F9C-98D8-67187479BA81
/dev/sde5 : start=3D   165554176, size=3D   209715200, type=3DA19D880F-05FC=
-4D3B-A006-743F0F84911E, uuid=3DC7C67ABA-9483-4FF7-9D96-5BC37BED19FF
/dev/sde6 : start=3D   375269376, size=3D  5485263759, type=3DA19D880F-05FC=
-4D3B-A006-743F0F84911E, uuid=3DFE8DFE27-11B1-438B-BA24-0CD64B474897



--=20
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

--CgTrtGVSVGoxAIFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iLwEAQEIAAYFAlbRI+sACgkQBaSaEuRa5FNu5AT7BMQirGgy5LlThU/0mPRG11jn
6xCsX4nyq9M0Zrg+M4EHPr9MtTNZy9qDx7EDHJQ0RmORGV21G3lH/ktTwYf9Gwkz
A4N3UTQrH5IyVx6/7aTfjUb6hYKand4zfdXSGo7I+K0VhqS6RTSIE2+64q/NGJBM
qx7ZipgoREJWITadX4+IoH2VAUq97RXVkA6WuuJx+3yPVzeuAgWBoQ0Hkcp+bw==
=NA77
-----END PGP SIGNATURE-----

--CgTrtGVSVGoxAIFj--
