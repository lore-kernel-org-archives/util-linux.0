Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:43196 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754904AbeASCgj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 18 Jan 2018 21:36:39 -0500
Date: Thu, 18 Jan 2018 21:36:37 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org, linux-man@vger.kernel.org
Subject: moving filesystem mount options from util-linux to man-pages
Message-ID: <20180119023637.GI7217@vapier>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

the mount(8) man page covers not only the mount command, but also the
various file system options that come from the kernel.  it seems like
the communities have settled on the man-pages project for holding all
the userland-facing documentation, it has good practices for tracking
features across versions, and updating it is a lot easier/safer (than
util-linux) and up-to-date on the web (via man7.org).  while looking
up some proc/ramfs options, i noticed util-linux was out of date by
over 6 years :/.

imo, it seems like we should move all kernel-specific documentation
out of the util-linux project and into man-pages.  obviously all the
mount command line options and such should remain.

specifically i'm looking at "FILESYSTEM-SPECIFIC MOUNT OPTIONS":
http://man7.org/linux/man-pages/man8/mount.8.html#FILESYSTEM-SPECIFIC_MOUNT_OPTIONS

we probably want to leave "FILESYSTEM-INDEPENDENT MOUNT OPTIONS"
in util-linux since those are all parsed by util-linux's mount
and turned into the MS_xxx bits.

thoughts ?  mount(2) doesn't seem like the best place, but these
are the fields that go in the "data" string to that syscall.
-mike

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAlphWbUACgkQQWM7n+g3
9YFoAQ//bwKRBddT8fnAYkZq7DjbbxZQtt3H3VUCoKAoJp8/36MadFWkbL3c9tlJ
+Xt74ihPrNfKlFMmiqmJP1XvpMfnwBQJrmhSLdPHidc0WIvvVjgbBtG4fUIF+Co+
hXTahZxyY6vx15mYiMnwoj49xGY0w6CD4o5OiILaktA/6Iy+Kn+jurvvxyrsbKBg
WmxRHukqywkOTpn142zadJ1jlOHE1QVzd062aU+hQCq3EmYwEiaob8kWYyp4k1dh
GbAXom1ruElwQDwbCdKV0g2wlt1FZxlcQsp5KrmRSrGnsFkn2Uxe1IjMJ3DPqInu
M2N01Lom7ZPNQ0zNLhyOeM0Rn6l8dyqN5yBYmZeKJKUk2iHV+A9Ih47XcPVOb9YE
GivQfPIW7kNCLZDbMB4xXqhHy/zFKm9n5VPyv7g3YOhj46v6fecZbal+5wnWd697
Jd0KPKcEICVSyJoUBNxM8a2APahdP8EOb5Oth+e1Sc3tO/teaZjj1TdF9jDi1D1Z
A4H/Q3da9LJZNETGX/nwWgrI/0EjYX6uyFGz++sPppAlC2+wGpLKMuLAZACM6coo
0hDDDZOEkozwZHkzAdbKrSWPItXzyJgqgsfC427QlbBivoSlb/NJ6wllQ4IH8Y4m
JU7rgeRBGxugYfYeG/ZjGCFfn/sIO1bARxFWEKXlnKV0sdDWob8=
=gNTl
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
