Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34714 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab2G0Lz2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Jul 2012 07:55:28 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 6AB70A0FF6
	for <util-linux@vger.kernel.org>; Fri, 27 Jul 2012 13:55:27 +0200 (CEST)
Date: Fri, 27 Jul 2012 13:55:23 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: 2.22-rc1 build fails if configured with --disable-static
Message-ID: <20120727115523.GA22051@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi list,

I just encountered that 2.22-rc1 build fails if

=2E/configure --disable-static
make

The error I'm getting is:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2E..
/bin/sh ./libtool  --tag=3DCC   --mode=3Dlink gcc -std=3Dgnu99 -DTEST_PROGR=
AM -I./libblkid/src -I./libblkid/src -I./libuuid/src -fmessage-length=3D0 -=
O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protector -funwind-tables -fasynchro=
nous-unwind-tables -g -D_GNU_SOURCE  libuuid.la -static  -o test_blkid_cach=
e libblkid/src/test_blkid_cache-cache.o libblkid.la =20
libtool: link: gcc -std=3Dgnu99 -DTEST_PROGRAM -I./libblkid/src -I./libblki=
d/src -I./libuuid/src -fmessage-length=3D0 -O2 -Wall -D_FORTIFY_SOURCE=3D2 =
-fstack-protector -funwind-tables -fasynchronous-unwind-tables -g -D_GNU_SO=
URCE -o test_blkid_cache libblkid/src/test_blkid_cache-cache.o  ./.libs/lib=
uuid.so ./.libs/libblkid.so /home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1=
/.libs/libuuid.so -Wl,-rpath -Wl,/home/abuild/rpmbuild/BUILD/util-linux-2.2=
2-rc1/.libs -Wl,-rpath -Wl,/usr/lib64
libblkid/src/test_blkid_cache-cache.o: In function `blkid_get_cache_filenam=
e':
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:113: u=
ndefined reference to `safe_getenv'
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:115: u=
ndefined reference to `blkid_strdup'
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:117: u=
ndefined reference to `blkid_strdup'
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:119: u=
ndefined reference to `blkid_read_config'
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:125: u=
ndefined reference to `blkid_free_config'
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:121: u=
ndefined reference to `blkid_strdup'
libblkid/src/test_blkid_cache-cache.o: In function `blkid_get_cache':
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:162: u=
ndefined reference to `blkid_read_cache'
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:158: u=
ndefined reference to `blkid_strdup'
libblkid/src/test_blkid_cache-cache.o: In function `blkid_put_cache':
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:178: u=
ndefined reference to `blkid_flush_cache'
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:188: u=
ndefined reference to `blkid_free_dev'
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:203: u=
ndefined reference to `blkid_free_tag'
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:205: u=
ndefined reference to `blkid_free_tag'
libblkid/src/test_blkid_cache-cache.o: In function `blkid_gc_cache':
/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1/libblkid/src/cache.c:233: u=
ndefined reference to `blkid_free_dev'
collect2: error: ld returned 1 exit status
make[2]: *** [test_blkid_cache] Error 1
make[2]: Leaving directory `/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/abuild/rpmbuild/BUILD/util-linux-2.22-rc1'
make: *** [all] Error 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Anyone else getting this?

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlASgasACgkQnZxG0T6qDD0l6QCfa/H9cOrJFEO9LperT45pCXOQ
DEAAn0WljDvHnJC//jwumOxPnenb9neU
=4NYn
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
