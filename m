Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3E82D8E
	for <util-linux@vger.kernel.org>; Wed,  7 Feb 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328879; cv=none; b=CPqZ6e95jUJKxEtLmMlkNNUk1TdOLsPFiWWNQiWhNRjNzwEUEL3iWMWt09CgS4xIymh/Ogs+lvNy8KxiAUmyQWUR4/eSEmLMN+WVVrmyrxBX7R6rlsgWudGX1EEhCiuwgsiN47hqFHP6z5JMv7E7rFO2o+t38tQPa/yp0Aym778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328879; c=relaxed/simple;
	bh=hxXjlG/Q86XSb+ncDhOmRVFsEcLi+rwjVZ2tgazO5Rs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qKDt5DrErN//rMlBMvxnPcHeer8ZQGtK0EEB/ahZweMCJaSWLhVjh/5XPV32hivZDLkkgEqnYw39uexK7I4MyBy9AKPmBh0z80zsCbSRNNJx+Td7ykJ7cHIRTGQL1k425pqF+wNpN4/5k2eKSgtTAdSVTurEVqYp3WFRSCnYouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=C0z95L56; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="C0z95L56"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1707328367;
	bh=hxXjlG/Q86XSb+ncDhOmRVFsEcLi+rwjVZ2tgazO5Rs=;
	h=Date:From:To:Subject:From;
	b=C0z95L56aBxkfGCOGLkUz2MLFHKHwkaYgGauQb+WBuiOJfbHYdCpq7Nx4S2suO4l4
	 SBntyL/jgbzxrO14II7Iy1zhvlu4lTwLLtkVAQRQrKAOozwM84PPWU0YvIPWEPLO/+
	 5I6qrANBLTtHg2MtD2AC2zfQCXzm9TwsnfH9dTODRMbT0hLQTJnvZQd3z44xrtBINy
	 Tz/wF0TFTAS44Ec5Hp0E7wa8SGL49sS4soWUBouMY+TNw8Is8swHodKca3YOJwgNRo
	 biNSORo0G5ulvFTw41zwmHl8xbuU9n1Hmdb/ZRT1VztIHTKHL8Q7DRRelOijXNS8fX
	 IhdNoMcFSXuDw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 7A5DD1856
	for <util-linux@vger.kernel.org>; Wed,  7 Feb 2024 18:52:47 +0100 (CET)
Date: Wed, 7 Feb 2024 18:52:47 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: util-linux@vger.kernel.org
Subject: fsck exits 0 with no output (just version) when it doesn't find a
 type-specific fsck
Message-ID: <f63r2qpu2tzoaabfsuq5yjlqguystzu4tyjvok3etadzy4ouk6@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dcjygte2qm5s2uhd"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--dcjygte2qm5s2uhd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Downstream bug: https://bugs.debian.org/1062208

Just got
  [ 3030.473467] FAT-fs (mmcblk1p1): Volume was not properly unmounted. Som=
e data may be corrupt. Please run fsck.
great idea! After unmounting I did
  # fsck /dev/mmcblk1p1
  fsck from util-linux 2.39.3
which is just --version. Maybe
  # fsck -AR
  fsck from util-linux 2.39.3
so also no.

strace says
  close(6</sys/devices/platform/soc/11240000.mmc/mmc_host/mmc1/mmc1:e624/bl=
ock/mmcblk1/mmcblk1p1/start>) =3D 0
  close(5</sys/devices/platform/soc/11240000.mmc/mmc_host/mmc1/mmc1:e624/bl=
ock/mmcblk1/mmcblk1p1>) =3D 0
  close(3</dev/mmcblk1p1>)                =3D 0
  munmap(0xffffa8eb7000, 266240)          =3D 0
  munmap(0xffffa8e76000, 266240)          =3D 0
  munmap(0xffffa8e35000, 266240)          =3D 0
  munmap(0xffffa8df4000, 266240)          =3D 0
  close(4</dev/mmcblk1>)                  =3D 0
  faccessat(AT_FDCWD</root>, "/usr/local/sbin/fsck.vfat", X_OK) =3D -1 ENOE=
NT (No such file or directory)
  faccessat(AT_FDCWD</root>, "/usr/local/bin/fsck.vfat", X_OK) =3D -1 ENOEN=
T (No such file or directory)
  faccessat(AT_FDCWD</root>, "/usr/sbin/fsck.vfat", X_OK) =3D -1 ENOENT (No=
 such file or directory)
  faccessat(AT_FDCWD</root>, "/usr/bin/fsck.vfat", X_OK) =3D -1 ENOENT (No =
such file or directory)
  faccessat(AT_FDCWD</root>, "/sbin/fsck.vfat", X_OK) =3D -1 ENOENT (No suc=
h file or directory)
  faccessat(AT_FDCWD</root>, "/bin/fsck.vfat", X_OK) =3D -1 ENOENT (No such=
 file or directory)
  dup(1<pipe:[10683]>)                    =3D 3<pipe:[10683]>
  close(3<pipe:[10683]>)                  =3D 0
  dup(2<pipe:[10683]>)                    =3D 3<pipe:[10683]>
  close(3<pipe:[10683]>)                  =3D 0
  exit_group(0)                           =3D ?
  +++ exited with 0 +++
which looks like a failed path traversal and then nothing?

I think in -A mode it makes sense to silently ignore a lack of type-specifi=
c fsck.
But when explicitly requesting fsck /dev/whatever, that condition
should at /least/ warn (I'm assuming erroring out would be too invasive),
because right now fsck cleared my potentially-broken filesystem w/o checks.

Best,
=D0=BD=D0=B0=D0=B1

--dcjygte2qm5s2uhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmXDw20ACgkQvP0LAY0m
WPGewBAAurQyGJYzpZ/DonkpyFG5da2Qg6nMQHnUmclYaHjMFvnfbkjm597GDvP4
V94KSIi3ubLpfqSvERLQuVcmfs8wrmCysYpjcgzz4yTVyeTV7IW2oIb6aPZUi4dG
+yFcz07Y22aNvez3DLXoaMtAn4Xj7lCcKj+QvosB+i9tEqV0bfefH0XlpmbgdkBu
ygpoYTaSnSHPJgQcy8xmBOiN4gPCcSv5OhIo4B56zd6C6aNcZ78BYcNXxaM6byYS
jHMD2BIKEO6cG33yYSbse/+Eq/p3/Az1NR+GvZWaktBzEVCOpS8U08rWf1PqMnZ1
4JTBAqW8YLlyf+Yg3m3W3snhCtoBThTz5ihOyo/mvDbLg924P8RbTjkVpFNcFIXn
dYTs5aZkCY9a9UUQ8izMUlTY2J6Q1KBBr5M/zqQ1QoeqIGRpbhjPHNmOD0T0WJxv
HBd4Q20jXfiB8Xvy8bPi5bvDO/KNIbPaHb6h/7V0i3J3R+92mpoMOUCAfllLrHwU
UGQr7YiZumqxEXwy7ihLJVvY5HGk4X9MHLIyuCruk8zERli1YD6U3NVLtIxL0U02
MfOBk1Mn90+85rIkFxpGunqzk/7EHuWvkKEpTscPRXt0wv7cUG4sP3LsOSx/3oY1
3BPB5twB/bdaude8ENrLEWHpIo/LMijJS0ud7H/76WzI2b62Qq4=
=517q
-----END PGP SIGNATURE-----

--dcjygte2qm5s2uhd--
