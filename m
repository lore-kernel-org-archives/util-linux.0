Return-Path: util-linux-owner@vger.kernel.org
Received: from vmicros1.altlinux.org ([194.107.17.57]:43832 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeHDVhC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 4 Aug 2018 17:37:02 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7F3FF72D1DE
        for <util-linux@vger.kernel.org>; Sat,  4 Aug 2018 22:27:19 +0300 (MSK)
Date: Sat, 4 Aug 2018 22:27:19 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: use kernel crypto api
Message-ID: <20180804192719.GA1593@altlinux.org>
References: <20180804191706.10641-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <20180804191706.10641-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 04, 2018 at 08:17:06PM +0100, Sami Kerola wrote:
> Try to speed up md5 checksums by using hardware accelerators when they are
> present with use of kernel crypto api.
>=20
> Reference: http://www.chronox.de/libkcapi/html/ch01s02.html

What if there is no speedup?

See lengthy discussions in the gnulib mailing list (April..June) on this su=
bject.


--=20
ldv

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbZf4XAAoJEAVFT+BVnCUIZkQP/1KhRjqS6PBWdiJK6oc1Weml
nZ0NFyWTRzVU+WeJZpLMitVCOOuSWKU9X0xrUN8FZ/s3yipVxGS17Nr1K5ZhDKEg
VsWRYrb1nsZYL1tL9s0PyWQsVH1KnyFv6Vyaau1obk8SI01o1KOCfJBJPPSYUwAg
llvuB4aQ3UZQf3brz4yew58IfpJ6TOfunKkx/P+2syqrJe+gnGWxdZt/9dg8IaiI
tehXQoFusrZANtEGVxrHR+iLnlrRTaabflE6t8hmZtaf3GXgjebaRxrMg4e3w3SU
RiorjU0beAY0wXdPxl0CALX7BLkWvqERv+y8C9NbSD7Jp6qgLkga5xoBDV1Qo2ta
IMl0UrBSlM5fLs/Ue3ixM9z9tJBSGVIzA08uYc7LVl8rMDi0XFGGaMgUAFzqxzKS
X+BjFAl20qq51amkJFdy/ZhXjt0uw+khbN+3zBPep/v2Yw0DehqScEfGC/taZEOp
bGnGCMMKR/+2JPdwLWD/1C60QGI2A9JGrG5cYIBWJ/dyVw3SFKfDtFoutEdHntzC
T/iM0ZJAbPDA+ctTx3TjwOCd/qbb+TsvWA7aPoGvah8LWLltPa6lXufN2anqri88
ApV50Q0lh1vGgzAOuVttBg5WQLA/3gZthjd7Er8AXkk3Vz5+jTKcPmh3vPJr7lZP
ReyTG917F70ESAqOSOIT
=6yxD
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
