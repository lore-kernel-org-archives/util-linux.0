Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD22E3E8
	for <util-linux@vger.kernel.org>; Thu, 18 Jan 2024 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605079; cv=none; b=fuYetj4OxWP6R8u+VrNY+n7gg+XyVG9oSVgthI7a/nscLc+U3SV9h9m0cYm7B7Qe/IfX4oKKFF1rmb0LAKUDBBuQcpGtI9jkKADQoP+RFY5fR/7xLDMeND98vB7h33wRJqnM1i4CsAYBRrc8lzdjlInNDnOhNh9+9p1q/iBBh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605079; c=relaxed/simple;
	bh=LTi3ZqtRxgZBzKQ6Yot2aKxec+YvrA/RpoC0NDbmbdI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WHscR7t5SSIhXPY1uXZzKYcS/WCqLETLp7Dg1xoU/ooy/QVbAX+QJ6NNeU86SRZh14nY7VAdKIWewApHYYQ+NBPwdp1Y7oE+t6Yny9NFp53UpVypLvfm3aYtOhUji9K7gVUJ3DHTu+pnx73lCqOPq3sb4Wxa8bkniASHw8J0u1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=MboD7iUe; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="MboD7iUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1705605063;
	bh=LTi3ZqtRxgZBzKQ6Yot2aKxec+YvrA/RpoC0NDbmbdI=;
	h=Date:From:To:Subject:From;
	b=MboD7iUemgbJaZh5vtEiI+skhyswgKG1Vjr6NieKaZDW3lKEPNe6kn0pnNWoZ+eJ2
	 i+x3ClqxEfyBKcj74Duh2tnHC/8oBc83/jtsL5toYYIEcMQ/HizC6pwx2h4lsSGFcJ
	 ukdxM2O0mDkE1mXg3rdFlDIJqnnlNeUFdBjtGd4XfErWA0jwl/iEvQI86ON1J+CvPE
	 yUqYd85wiwlKGOLPbk8Qt+Z3Y9B5NapUD4s5/GAoHiWUyJU6kajNT0HlF5Z9OXSVch
	 HSlCKG7pzTJAzs09AdfDSGDlSRUJEvFeSSBc67Kmg47EJ7wF17kHFIwkEfFriLLSzl
	 faUNVSwqkkYgg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 175A0C88
	for <util-linux@vger.kernel.org>; Thu, 18 Jan 2024 20:11:03 +0100 (CET)
Date: Thu, 18 Jan 2024 20:11:02 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: util-linux@vger.kernel.org
Subject: [PATCH] gpt-partnames: add "ChromeOS firmware" & doc link
Message-ID: <r3td5hqd23d4li67qtnkodkffgsduh6tehvek2kibz3yeizpck@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eylmaym6wzhvtp2p"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--eylmaym6wzhvtp2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a Chromebook, with fdisk -l of the internal flash being:
  Disk /dev/mmcblk0: 29.12 GiB, 31268536320 bytes, 61071360 sectors
  Units: sectors of 1 * 512 =3D 512 bytes
  Sector size (logical/physical): 512 bytes / 512 bytes
  I/O size (minimum/optimal): 512 bytes / 512 bytes
  Disklabel type: gpt
  Disk identifier: 8648551F-D8FC-AC44-AA00-C0CA32C4A9BC
 =20
  Device            Start      End  Sectors  Size Type
  /dev/mmcblk0p1  8704000 61063119 52359120   25G Microsoft basic data
  /dev/mmcblk0p2    20480    53247    32768   16M ChromeOS kernel
  /dev/mmcblk0p3  4509696  8703999  4194304    2G ChromeOS root fs
  /dev/mmcblk0p4    53248    86015    32768   16M ChromeOS kernel
  /dev/mmcblk0p5   315392  4509695  4194304    2G ChromeOS root fs
  /dev/mmcblk0p6    16448    16448        1  512B ChromeOS kernel
  /dev/mmcblk0p7    16449    16449        1  512B ChromeOS root fs
  /dev/mmcblk0p8    86016   118783    32768   16M Microsoft basic data
  /dev/mmcblk0p9    16450    16450        1  512B ChromeOS reserved
  /dev/mmcblk0p10   16451    16451        1  512B ChromeOS reserved
  /dev/mmcblk0p11      64    16447    16384    8M unknown
  /dev/mmcblk0p12  249856   315391    65536   32M EFI System
 =20
  Partition table entries are not in disk order.
and -lx being:
  Disk /dev/mmcblk0: 29.12 GiB, 31268536320 bytes, 61071360 sectors
  Units: sectors of 1 * 512 =3D 512 bytes
  Sector size (logical/physical): 512 bytes / 512 bytes
  I/O size (minimum/optimal): 512 bytes / 512 bytes
  Disklabel type: gpt
  Disk identifier: 8648551F-D8FC-AC44-AA00-C0CA32C4A9BC
  First usable LBA: 34
  Last usable LBA: 61063134
  Alternative LBA: 61063167
  Partition entries starting LBA: 2
  Allocated partition entries: 128
  Partition entries ending LBA: 33
 =20
  Device            Start      End  Sectors Type-UUID                      =
      UUID                                 Name       Attrs
  /dev/mmcblk0p1  8704000 61063119 52359120 EBD0A0A2-B9E5-4433-87C0-68B6B72=
699C7 D8331AD0-ED78-F442-87F4-78DF0130895A STATE     =20
  /dev/mmcblk0p2    20480    53247    32768 FE3A2A5D-4F32-41A7-B725-ACCC328=
5A309 CCFE5BD8-BBE4-A840-9C0B-BBA6427B6309 KERN-A     GUID:49,56
  /dev/mmcblk0p3  4509696  8703999  4194304 3CB8E202-3B7E-47DD-8A3C-7FF2A13=
CFCEC E71F6E02-1BC3-9D43-9EDD-2C7CA20D512A ROOT-A    =20
  /dev/mmcblk0p4    53248    86015    32768 FE3A2A5D-4F32-41A7-B725-ACCC328=
5A309 753B5AEB-254E-AE47-8B69-FF58D9AC7DEA KERN-B     GUID:48,56
  /dev/mmcblk0p5   315392  4509695  4194304 3CB8E202-3B7E-47DD-8A3C-7FF2A13=
CFCEC 8D0AAB90-FCDD-1B4E-88C1-25591367535A ROOT-B    =20
  /dev/mmcblk0p6    16448    16448        1 FE3A2A5D-4F32-41A7-B725-ACCC328=
5A309 A1F17DE0-C736-0749-9D46-C7AF964C0805 KERN-C     GUID:52,53,54,55
  /dev/mmcblk0p7    16449    16449        1 3CB8E202-3B7E-47DD-8A3C-7FF2A13=
CFCEC 9D3217B1-C796-694B-8F13-5266A7B03F3E ROOT-C    =20
  /dev/mmcblk0p8    86016   118783    32768 EBD0A0A2-B9E5-4433-87C0-68B6B72=
699C7 37A18CE9-ACF2-894B-9B67-C212C374C100 OEM       =20
  /dev/mmcblk0p9    16450    16450        1 2E0A753D-9E48-43B0-8337-B15192C=
B1B5E F534539C-EDAC-2C44-A6CD-827D7490CF50 reserved  =20
  /dev/mmcblk0p10   16451    16451        1 2E0A753D-9E48-43B0-8337-B15192C=
B1B5E E4248D3E-6EA0-B148-8215-B50269CE9678 reserved  =20
  /dev/mmcblk0p11      64    16447    16384 CAB6E88E-ABF3-4102-A07A-D4BB9BE=
3C1D3 530A6C46-BDFA-7C40-A446-FC05001BDA82 RWFW      =20
  /dev/mmcblk0p12  249856   315391    65536 C12A7328-F81F-11D2-BA4B-00A0C93=
EC93B BCF61070-764A-004F-8ABD-590A44996A91 EFI-SYSTEM LegacyBIOSBootable
 =20
  Partition table entries are not in disk order.

Note part 11/RWFW being "unknown".
The fdisk on the device doesn't know it, and upstream doesn't either.

The only google result is
  https://chromium.googlesource.com/chromiumos/docs/+/d5eefaba799595d6cd302=
de047325ca8295dd87e/disk_format.md
which agrees with the other three ChromeOS definitions fdisk knows,
so add this one as well, and link to the live document.

fdisk -l now shows:
  /dev/mmcblk0p10   16451    16451        1  512B ChromeOS reserved
  /dev/mmcblk0p11      64    16447    16384    8M ChromeOS firmware
  /dev/mmcblk0p12  249856   315391    65536   32M EFI System
---
diff '--color=3Dauto' -u -r util-linux-2.39.3.orig/include/pt-gpt-partnames=
=2Eh util-linux-2.39.3/include/pt-gpt-partnames.h
--- util-linux-2.39.3.orig/include/pt-gpt-partnames.h	2023-11-30 11:26:09.6=
75522060 +0100
+++ util-linux-2.39.3/include/pt-gpt-partnames.h	2024-01-18 19:00:19.208308=
527 +0100
@@ -229,8 +229,10 @@
 DEF_GUID("49F48DAA-B10E-11DC-B99B-0019D1879648", N_("NetBSD RAID")),
=20
 /* ChromeOS */
+/* https://chromium.googlesource.com/chromiumos/docs/+/main/disk_format.md=
#partition-types */
 DEF_GUID("FE3A2A5D-4F32-41A7-B725-ACCC3285A309", N_("ChromeOS kernel")),
 DEF_GUID("3CB8E202-3B7E-47DD-8A3C-7FF2A13CFCEC", N_("ChromeOS root fs")),
+DEF_GUID("CAB6E88E-ABF3-4102-A07A-D4BB9BE3C1D3", N_("ChromeOS firmware")),
 DEF_GUID("2E0A753D-9E48-43B0-8337-B15192CB1B5E", N_("ChromeOS reserved")),
=20
 /* MidnightBSD */

--eylmaym6wzhvtp2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWpd78ACgkQvP0LAY0m
WPFxGxAAjT4EsRaKTYUfGE0TTtxsNiPCGn9doeJuOHkfeD2yZ+ti280tNNbDieVq
14U5p7ulLvD28AP1hxJHeALZ9PsMrFgFBWEXcEngJGTXUCWnCwZ0WlxKNOXRZhVm
+gozNM4J0XgP7BN1H1f1MHUdC6a6ey4i6F25fP+jMlv2tELH8nEyjM+sRhWgrxE8
7hvCGbTYlsc4Wyt6TY72pwA3YRIy4D+vzd6PQZl2LhrVRzyRmuTCENgnTXoPgNPl
3wY2FN+69K5EpKxeDjz/oRGZAfEvBx8Kx83vb3JkbH55rsboMfF+/tWVmeyIx/es
AnYrNcJ2+1wKYFtHTr3B0wmCOV+7qZ86Qi1JFqViu4d22XYmjjA5N3c/4Vl23qgo
ipGXkxRlmJ8vWJzYfGUa0HuWIrD2BYbh+/MtIJxTkyn8efiKh4i5XQs7Ys+Nluu7
nYT4xbSx45S1mvFyBKsxHEye5XlfJSvOA6jKTd1Ho0NG72egX9bjcmW8Oz+hXqZy
y1PyVx0LJZ+rGsnQndcHLs4X6OBstCj0f0gAcvT/KY66fpV8crgKpIh+oMn/prO2
Qkl1buVTPIvD4tbJ+vdf5M306e7vxOKBjhsaqOZ5LAxEMootBle+LHpkXMyDOywd
xdhbvS4QHi56UdV7CJ4nI62MidaJlo+gESIOG3h0dbRTKI7gn9U=
=fGCn
-----END PGP SIGNATURE-----

--eylmaym6wzhvtp2p--
