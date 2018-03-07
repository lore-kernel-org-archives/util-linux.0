Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:59434 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753940AbeCGC3J (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Mar 2018 21:29:09 -0500
Received: from [IPv6:2001:4dd6:c168:0:81de:23d9:dbca:fcc6] (2001-4dd6-c168-0-81de-23d9-dbca-fcc6.ipv6dyn.netcologne.de [IPv6:2001:4dd6:c168:0:81de:23d9:dbca:fcc6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: whissi)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 7A0D3335C0A
        for <util-linux@vger.kernel.org>; Wed,  7 Mar 2018 02:29:08 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Thomas Deutschmann <whissi@gentoo.org>
Subject: uuid: uuidd ... FAILED (daemon start)
Message-ID: <a1b8906b-0077-79c9-db5a-2d91756c2ebb@gentoo.org>
Date: Wed, 7 Mar 2018 03:28:59 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uuca6BDCp1K9CVKljSMKuQyeJUWdDiPNS"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uuca6BDCp1K9CVKljSMKuQyeJUWdDiPNS
Content-Type: multipart/mixed; boundary="vRSmVTrCBKwCc9zrUMUHgcSQ3S4EGQhgj";
 protected-headers="v1"
From: Thomas Deutschmann <whissi@gentoo.org>
To: util-linux@vger.kernel.org
Message-ID: <a1b8906b-0077-79c9-db5a-2d91756c2ebb@gentoo.org>
Subject: uuid: uuidd ... FAILED (daemon start)

--vRSmVTrCBKwCc9zrUMUHgcSQ3S4EGQhgj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

on Gentoo Linux we often see

> uuidd: couldn't bind unix socket /var/tmp/portage/sys-apps/util-linux-2=
=2E31.1/work/util-linux-2.31.1-abi_x86_64.amd64/tests/output/uuid/uuiddkO=
cTUuoZ7kaP3: Address already in use
>          uuid: uuidd                                         ... FAILED=
 (daemon start)

test failures.

I think this is because we hit the

  char sun_path[108]

limit (=3Dsocket path is too long so it will be reduced...
however, it now collides with OUTPUT_FILE or
UUIDD_PID).

I guess there is not much you (upstream) can do about it, right?
So we will have to patch the test to use different names/path
in Gentoo...


--=20
Regards,
Thomas Deutschmann / Gentoo Linux Developer
C4DD 695F A713 8F24 2AA1 5638 5849 7EE5 1D5D 74A5


--vRSmVTrCBKwCc9zrUMUHgcSQ3S4EGQhgj--

--uuca6BDCp1K9CVKljSMKuQyeJUWdDiPNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQKTBAEBCgB9FiEEM8WEgsQCKS0uPFwGlwn5DDyW/8gFAlqfTmtfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDMz
QzU4NDgyQzQwMjI5MkQyRTNDNUMwNjk3MDlGOTBDM0M5NkZGQzgACgkQlwn5DDyW
/8jRjhAAp92UdoHoPmyCLOKjFvdWF7kF8Zpz6tbbw9ITLT7/926iivMdRq6v1Gkr
gm+ry/m8aBakOJzv9SNq7qC99+SLCoxfpMc1qx5DRQWT/LVt3p7Sfo1wJ6pFLy/K
NILKtiwNNB7YMWl7+IfEJ2XZ1o9nLmwGWYUYgMn+5pRfp83jVS5a14WjDLs5x57X
pgzvnZ9vG67ZH/ZMVGAoFFbeZJmuOwTHSzIYO5ExrV311VWN5bLwoPpW57dbN0V3
wymaFKRIzExHFPfd2TTHKqVEN4eP8QzoMVcP4AtEVv9T3CwXInrun6ffLq+knK69
ynTakW1sjQqWTAnvq3+TivrqWMzj23p/Gt6PFEdMoGbFG71zTT8hdIZslvP6hMau
F+gMmH/ejdwyoeQA5V28epscfarYxSOVAkeD9iXYEVBO3CqyPGzgWUEnvJ66Z8AL
kosLPcevgIjFCfVh5jRxK0Dr9os0zCEFoA765T9mN2csbz8cUkjyh6PGbDAsxd6J
cg10lRuE/PDKL4NLLStkTj+KqXYCM6wH/zevGcdmpd8xIo0AOx7FLrA33kA+xYsG
0RmqsoCncsBXZlsjFwuY4xC4OBP2AFJM2gqdlpXfFjK5Uy/q1PigNXOAzZvlSFQ0
C9/2wtnMOqFt04tcPhaKVj3x8EuJ/1XJauucyp2lp9v6TCkm1qg=
=sglP
-----END PGP SIGNATURE-----

--uuca6BDCp1K9CVKljSMKuQyeJUWdDiPNS--
