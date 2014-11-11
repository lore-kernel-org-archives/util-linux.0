Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:41036 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbaKKCMv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Nov 2014 21:12:51 -0500
Date: Mon, 10 Nov 2014 21:12:50 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 6/6] tests: mark python libmount tests known to fail with
 AddressSanitizer
Message-ID: <20141111021250.GG3652@vapier.wh0rd.info>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
 <1415656195-20458-7-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z0mFw3+mXTC5ycVe"
In-Reply-To: <1415656195-20458-7-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Z0mFw3+mXTC5ycVe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10 Nov 2014 21:49, Sami Kerola wrote:
> The tests fail with an error similar to this.
>=20
> Traceback (most recent call last):
>   File "/home/src/util-linux/libmount/python/test_mount_tab_update.py", l=
ine 7, in <module>
>     import pylibmount as mnt
> ImportError: /home/src/util-linux/.libs/libuuid.so.1: undefined symbol: _=
_asan_option_detect_stack_use_after_return

if libuuid.so is built with ASAN, it should be linked with it too.  that me=
ans=20
passing the ASAN flags at link time.  or maybe libtool is filtering them ou=
t=20
when it goes to link the library ?
-mike

--Z0mFw3+mXTC5ycVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUYXCiAAoJEEFjO5/oN/WBHsYP/2Tsk7e/f9jS9S1TG76Vcynz
bM75TTom7wY9Z9phHw39eldAS+iX8H+yctPCnP4kAg/IEMaRGoZwUuHmmQMdbDGO
4wB2eRacEZrnvspvkhQaczdFLkMCHIn546fmxa0AMaWdGWnYdlea6LzYzrOkRHN8
7kPDaAdnijBsD8um5aqP+Pf8/gbY26LU2t0QEC8WwTlUwmk0DHk/x5p86DR9OHLk
3nE0Zjzmgn0ae82NYRb9Yw/9cdihnPv/HizY5Wa0+ysheU4Ch67v4V9Lb69vcqol
QvZsXU94Omo59ciEO4YN01y2HWHbpw+lsWPkASsDB+h2GXX2p8/3mEgILkdTNukL
j/ki+E0rck0B9ltjQokMNbCh2aJQHFYnfn9yMEomSiDeQUqG6rWdT0pSdEBxIl8N
yikOSSCVzD5jYREuVBNTeYIQ7Kh/hzxCGjgskW+OZkR26NuuU3aMt/AF1hkxt/+O
aQGxByHoQmM8LqXVJA1keITBvHLyo3YVZe94yVLQ5jFAz1TlLuqNMU9OzEuIVVAF
reC1Mn/JiiXM692s6LWPMiViKpLgXLdV6ilmNSUtdZctJR22bLJ++Xk3gR6zOZNf
tscXhzPonhQwucRBUUrdyUojBU4c3Qgd+ugmKIQKmFU6bBx8DZKIwrqH0m0GZqOF
+xKPiMAagnS52VlVSAVk
=qVdS
-----END PGP SIGNATURE-----

--Z0mFw3+mXTC5ycVe--
