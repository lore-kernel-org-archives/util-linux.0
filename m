Received: from mister-muffin.de (mister-muffin.de [144.76.155.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424DE1DBB3A
	for <util-linux@vger.kernel.org>; Thu, 16 Jan 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.155.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032673; cv=none; b=fhFQ2uCVR5MvAVAuB8xPIeZf1GcB3P/uKD/ihjorvw78yNjuD+c6iiAe7M9RxoBovUNcmj6VyChN4dAZ5tHQAJ3DLTYG8/6VhS+6ldl+nnFzJl4efdMA4UTWB7DF91fNiu1KgZIv80SVPKC53rRcRt9PyZ2rtoKWndcCUyQahUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032673; c=relaxed/simple;
	bh=oRzHPklWuT0vX+aU7zJnBeiwAiHtSag89hEh1f7bfII=;
	h=Content-Type:MIME-Version:Content-Disposition:To:From:Subject:
	 Date:Message-ID; b=uMkCkQQrEGNI2FXqR6o3Ww2fGWJ0AhTKOeF/4/qh4kyW6eQ8chnhZqvlUw5/kNG7pAIrmMBkIebFMJlv3gOeC5bJLNITRv5LBwmQd3EKh6uLUadR31rBpGcOpOpR973weflOw8MRBtZ7BwVXBjJWJmDBEoSF0S6xabYaiFhzfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de; spf=pass smtp.mailfrom=mister-muffin.de; dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b=lA8ANtOx; arc=none smtp.client-ip=144.76.155.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mister-muffin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b="lA8ANtOx"
Received: from localhost (ip2504e6f8.dynamic.kabel-deutschland.de [37.4.230.248])
	by mister-muffin.de (Postfix) with ESMTPSA id 750892F9
	for <util-linux@vger.kernel.org>; Thu, 16 Jan 2025 13:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mister-muffin.de;
	s=mail; t=1737032315;
	bh=oRzHPklWuT0vX+aU7zJnBeiwAiHtSag89hEh1f7bfII=;
	h=To:From:Subject:Date:From;
	b=lA8ANtOxOwsbvtNDSETGUMbjkbIs6TUQ9UN4cO3teexXLxWEhqs+bUZYiWsI8IcCf
	 /hoGM1dFMLvHJc/Y1uoxrHQmT/ayZTHSAS1gM1R51FW6KYdER4uc2tc+bvu1ucRckN
	 8OQgj15Ls0ISoZVbGndAnkLBaWEjyXee/Hn783ck=
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="===============3143629015616209300=="
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
To: util-linux@vger.kernel.org
From: Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
Subject: fallocate: --insert-range does not work with --posix
Date: Thu, 16 Jan 2025 13:58:34 +0100
Message-ID: <173703231441.1463009.14898093986088300384@localhost>
User-Agent: alot/0.10

--===============3143629015616209300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Steps to reproduce:

    $ fallocate -l 1024 test.img
    $ fallocate --posix --insert-range --offset=3D0 --length=3D4096 test.img
    $ ls -l test.img
    -rw-r--r-- 1 root root 4096 Jan 12 16:57 test.img

The size of test.img should be 5120 bytes and not 4096. It works fine
without --posix.

This issue can also be expressed as another test:

--- a/tests/expected/misc/fallocate
+++ b/tests/expected/misc/fallocate
@@ -1 +1,2 @@
 384
+4480
--- a/tests/ts/misc/fallocate
+++ b/tests/ts/misc/fallocate
@@ -34,6 +34,9 @@ else
                && ts_skip "'${fs_type}' not supported"
 fi
=20
+$TS_CMD_FALLOCATE -x -i -o 0 -l 4096 $IMAGE >> $TS_OUTPUT 2>> $TS_ERRLOG
+stat -c "%s" $IMAGE >> $TS_OUTPUT 2>> $TS_ERRLOG
+
 rm -f $IMAGE
=20
 ts_finalize

I also wonder why the size of --insert-range has to be 4096. If I try
smaller sizes, it does not work on my machine even when not using
--posix. If this is by design, maybe it should be mentioned in the
man page?

I'm running Debian bookworm and reproduced this with util-linux from
git.

Thanks!

cheers, josch
--===============3143629015616209300==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElFhU6KL81LF4wVq58sulx4+9g+EFAmeJAnUACgkQ8sulx4+9
g+F+HQ/9FAgAvXntXGig9S0A/ruhS8uSONYr5YBcsLEixVgkd6w0x9XOVbU9HkDL
mtvtF1hbKR0A7BoMrlNKbDDAIbcaxJePMhfPpVUuRF5YRA2WSm6hOc09fOMx1pvP
2gN8vuV2z26xlND1eyEXT+2gt49zGJZYucuGywiV3AK+wuAQ+XsUqWRxQ2d3JtIY
zvxylVhwhPgnfkWzNxGcThyadvY1G7SOUvwHqZTJWBgZpiDZN0L7AswH+VU6dXeL
wFTs7PRcJYIuosc6Vrdl5LcM26W2UNhg9Zw3nKWsTkB40IcRts8hwT4F5He4HHHo
pxlD/UK3Ad38L7uoX6opL5WPjq66KeRmA21doa5PkZAFqLkaIpfixMVifs8PfrXb
8oCOxpNEGPxKoLDzoulEwaDLGGAAChUqObVwG1+loz95At6lePGB6VQUsZBOtNmb
roRHrX3RRiMFuv0zsS2eiCj1AZPyLBYoialisnUUHwBYbubFgW4WbEVdZ819lE4W
7LCFBUFQ0zzCw32PoUC8QM7XcHz6jB1Hf4e0Vumjnu3JfJg9S14uQdu4aTNoz8xi
q+7N8F+k+9WFKADHeuY/A4/EGlq90Ad4KOYhvil7eRjnPe0bMgs096lnvUcxL9lN
vzCYCIFNeqZJY8ac3xfvOFeYBhzo9BJlh9wy70t35IzrECTcvak=
=zdOL
-----END PGP SIGNATURE-----

--===============3143629015616209300==--
