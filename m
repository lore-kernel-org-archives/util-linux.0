Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12CF155A52
	for <util-linux@vger.kernel.org>; Mon, 28 Oct 2024 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139648; cv=none; b=DsgWEBRaF/biEhCVabGY510xNZ+bJWbbwKEocGFwXuZq+KPRCUbp40KTUnKZ/CTu3VlXiZ3BzWI3lXSPs7GIrzqcbtdYRRSHvxJXGm3eizabttJ4nM/S4MegtbBPvGRJKyc2O/E6+MmwRrEAiEdQ+q6liUNGYUHOHK2e2Ie0tUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139648; c=relaxed/simple;
	bh=gDygnQyTO/WZZ3iw3xkpH5MGYB9Gntw7gq9AfqPADPI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RSVbYm8HESBVsNy7Oczd/9MCXxssOWA0s/6JQMoZBfhdL4Tm4kU7E95umCdOxmVwxMml/p7xUaRIWQa56YUMMduJ2ecUfYRQx1no1xeyZFvZFP33eczakJvtkLqb+NuulIJkfW4mVKU02cdIvRHpLZnsUnYzRXy9IHr0nzs9ir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=FuMJDj1L; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="FuMJDj1L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1730139555;
	bh=gDygnQyTO/WZZ3iw3xkpH5MGYB9Gntw7gq9AfqPADPI=;
	h=Date:From:To:Subject:From;
	b=FuMJDj1LBhB/yNlTkfMZjZnHnMUY/T7dMDlK9uZc1eJPKg82LdFFsRn+iB4Rvd3RB
	 REEiML5I9pCS1Ye8KwXMkuq1QnHQlBqLEIIHkKP5TIxAkO6jKH8LwUZJStqpoB+qNZ
	 ThxPjXZt1kbWKzLIsTlWYioYtd1nYlb0umxVcpJ59EPTcOyBZpK0Tt5WBZtYasUjZI
	 DJwhU3SG6ROaXvTYNS6iXCV/b8FDM60NP5kWTEJMyNxxeyOSGhMihG5rqPjcQQct9w
	 VpLfUEK9UyV5F3xWlQW/6ilm+0Gn46ZzNB2Dkst5FN8fZx968yuI8KVNhh6SaFakgx
	 G8fZicR3X8oFg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 328A65B88
	for <util-linux@vger.kernel.org>; Mon, 28 Oct 2024 19:19:15 +0100 (CET)
Date: Mon, 28 Oct 2024 19:19:14 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] hardlink.1: directory|file is mandatory
Message-ID: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="phomdravpvjehjtp"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--phomdravpvjehjtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

---
 misc-utils/hardlink.1.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/hardlink.1.adoc b/misc-utils/hardlink.1.adoc
index d11045941..b6f07ba70 100644
--- a/misc-utils/hardlink.1.adoc
+++ b/misc-utils/hardlink.1.adoc
@@ -18,7 +18,7 @@
=20
 =3D=3D SYNOPSIS
=20
-*hardlink* [options] [_directory_|_file_]...
+*hardlink* [options] _directory_|_file_...
=20
 =3D=3D DESCRIPTION
=20
--=20
2.39.2


--phomdravpvjehjtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmcf1aIACgkQvP0LAY0m
WPFDRw/+KOtSvou2r6DW6fSwBtOxiJh929Ar7/3rFZJFrggsqxh+Hh2+uryD2N8+
ysblxhuNYQPA85+go6QKeA3RLPbSIv2YpatlPDadSI+byyQoXkpeh0FBTdlSGQY7
YVrXXbfDfZIl5orjD5kOVbakjv0p0cT9z1qf7eBp2kSH3NJ7B/MmhD7Jya+LdxPo
MYm6bt68Tf2yFSieoDQv+hOv5f62U6+XBOqHogAl6ChXOpWDyjikJQWaXI80dh8d
HRzWcqPJ7zPD0IOxuoMeVT44V8wx617hin6NRlsEQnMW7C2zdYjKriekTlcDI/bb
9kfFksQ0aUKvh9zt5pxlVG1goHP/ovNxxgIo0dbLEXmnNAjSilxQw5H+duMFlbqU
dnFHMIGWCl0/r4KnvG+Gbo1JZU8E/O6qhVrzrQOdi2zbJD7bhBV/zg0jt4KBD23y
c7IjF8hydmrEzFznPhmtCYixXbBIja/GriBQyw5mVZ6G4KuaWH19NKtj/KZpaq5O
hmu3MadWHgkUO5QQmbzkh1xTFNK7k4TfWYbdkFko1EhXJEc2JETqJr34y8ZEzDQY
gbP58U093bfEZUeb4IAgL5CU3sFzhCVtQ+4b2JQBwRrsqILOPIHZkFjy8X2QHzOw
w/UL7szkJfLmdfsVwxvcnx7fnnFsQEcWAkwgNpbm2GVLnu6gOeM=
=RmeO
-----END PGP SIGNATURE-----

--phomdravpvjehjtp--
