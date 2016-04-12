Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:35832 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932223AbcDLRqy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Apr 2016 13:46:54 -0400
Received: from vapier.lan (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with SMTP id 15C5E340955
	for <util-linux@vger.kernel.org>; Tue, 12 Apr 2016 17:46:53 +0000 (UTC)
Date: Tue, 12 Apr 2016 13:46:53 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: libmount python bindings and header includes
Message-ID: <20160412174653.GA6588@vapier.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kmbfkEA+aDhe0DHX"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--kmbfkEA+aDhe0DHX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

i'm currently seeing these build warnings:
libmount/python/fs.c:110:40: warning: implicit declaration of function 'major'
libmount/python/fs.c:111:7: warning: implicit declaration of function 'minor'

this is handled for most of the code in include/c.h:
#ifdef HAVE_SYS_SYSMACROS_H
# include <sys/sysmacros.h>     /* for major, minor */
#endif

but the python code doesn't include that header.  i'm not sure what the
preference is here (make the python code pull in that header or just copy
over the sysmacros.h logic), so i'm skipping writing a patch.
-mike

--kmbfkEA+aDhe0DHX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXDTSNAAoJEEFjO5/oN/WBXBUP/3FfJYyRBKt2HCIx/m6Z4pCE
bxH3YVdaRBSsWMMSJMz9SjioQJGYPJ7VvLfJFJmAMqFX3sbu0+frXyfVQD7blyGO
b8k99LqTOOW/O6mxm4T4In4jfXnSgtrhRfSFRT7vPhp4nrUdKeaVmV2q3/ksVYYS
LOsy8iwvN+BsP9eXCwvm9v6U6RJbxDNyDxFYk9n/LquCxSOmHKPzTrznWaGiT7dO
rq4GKIBrF2aKNMrlzRwMVWO8WorL70KpYZZlFCSeGuoqnq13PEWlDXNtF1ZDCgBe
PTHc5Hfj9umekU3cv7P9zwBz1QlBnbUdWIg2VgToAZHTmFPBuN6ubA95E96dHSi/
AK+oGjrafu1Ncd4p0+h2DoARwgWdoT7hRQqpg1IUN571rFsg6P3o4aWHOeaP1/LH
xueMAyRUcvO1DmzSTrE3F9//voZx5GTJrEIgqNEG5ks+HvtJdo2PUxU4YNxnnhYr
6qTCw4WKzdt8+nxdktHs49C+W87LVUbLzgMiwitPraDUoNJrhoP8kDUVeUYPnkx1
Ae6m0TIO2KOsiP4d9dLaquJbgIaHI63aRKD6Ns1UzrGS9N+BXgQcflp2cMWF2ytD
FDGPtl/Xx5VAKu2k5ASi/5uViD3iVTjnRE0o7YkLJLEJam21lTzWaFswHuYxNuYf
D1MhrpE6C5Ja8MpUUmcs
=QR2T
-----END PGP SIGNATURE-----

--kmbfkEA+aDhe0DHX--
