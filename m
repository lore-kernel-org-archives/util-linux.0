Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:39487 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbaAGJzi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Jan 2014 04:55:38 -0500
Message-ID: <52CBCF17.50706@archlinux.org>
Date: Tue, 07 Jan 2014 10:55:35 +0100
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi> <20140107085831.GK31045@x2.net.home> <52CBCB08.1000702@archlinux.org> <20140107095408.GL31045@x2.net.home>
In-Reply-To: <20140107095408.GL31045@x2.net.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kvNkUNVFnLIc7J1TJLKWhT4W61CfFJPxS"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kvNkUNVFnLIc7J1TJLKWhT4W61CfFJPxS
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 07.01.2014 10:54, schrieb Karel Zak:
> On Tue, Jan 07, 2014 at 10:38:16AM +0100, Thomas B=E4chler wrote:
>> Am 07.01.2014 09:58, schrieb Karel Zak:
>>> On Mon, Jan 06, 2014 at 11:39:08PM +0000, Sami Kerola wrote:
>>>>  configure.ac             |   3 +
>>>>  misc-utils/Makemodule.am |   3 +-
>>>>  misc-utils/sd-daemon.c   | 520 ------------------------------------=
-----------
>>>>  misc-utils/sd-daemon.h   | 282 -------------------------
>>>>  misc-utils/uuidd.c       |   2 +-
>>>
>>>  Seems like a good idea, unfortunately I'm not sure about it.=20
>>> =20
>>>  The systemd (udevd) depends on libblkid+libuuid, it would be=20
>>>  probably better to keep util-linux without dependencies on systemd
>>>  libs otherwise we will introduce a cyclic dependence -- it could be
>>>  too tricky for some build systems and users :-) I'll think about it.=
=2E.
>>>
>>>     Karel
>>
>> We already have such a cyclic dependency, since udevd depends on
>> libblkid+libuuid, and findmnt (from util-linux) depends on libudev.
>=20
>  .. and nobody complains, good point :-) Thanks!
>=20
>     Karel

Actually, now that I know you care about these things, I am complaining.
It has caused me (minor) trouble once already.



--kvNkUNVFnLIc7J1TJLKWhT4W61CfFJPxS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJSy88XAAoJEChPw0yOSxolbkMP+gMZ16cqDFfHIGRKVH+ZZprk
LqY42hQ13i4Pf1aqz+aHUXwBDwT36X4/NNL0Lj0Z6uykww3Spmn3XIo1aL+jCbWJ
KIqSYfB7Zy9KfnuMcauC/GsAH00Npxx0pWnPXGrkfUQva8QhnWzCOPWVEXnq/myW
2MSKGPpScHWbERF8JhWIgE1Hkmf+keEetG+tOQkgRYEPLbB5qd8h9M292Vuvv79R
+3R49AhUDnuFI1Gp0TecVG+H7cu/jqSVR/0rLCE+3C+sozgdsKkwhiuFFsIrQnvf
Qk6oe2afCw5BjkQBnkXpEcn1Ix0C+k0xiTNtQAfd4CLQd3wX8puSV98iKjtJkXm3
Dso/KagmqIhxFmfnx/xOBJQy+1oJwESdQP+d/wLSmqdwe7agKKxjOulwVjBvrdFQ
qVQwyVGRqvtM6Zx5alfd2ssW03klSr/Ss9XR2ippEZriwZBktiQJB0eGDBTCJnvT
Y9fLD3L/If5rXE4OE0C/I8PxY1+cvgIVMweGrFpaO98KiSMVzzFVO7rB6KiGGHNc
IZBpkxF5mfW0zRSvSIXeCZoWaHHiZuRf4vcJI7gj7F9rUpraoJPkd10EgdLrDOTi
EJL2+YPNFjUObMCY7NqXrVTrbscqfzE3HsrQ6qsd5ayQUgzOBMCRZCojKx82zTEA
W0eNoNW4ZzfCMBtH4wSl
=v3O9
-----END PGP SIGNATURE-----

--kvNkUNVFnLIc7J1TJLKWhT4W61CfFJPxS--
