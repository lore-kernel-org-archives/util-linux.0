Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:35459 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbaAOPVU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Jan 2014 10:21:20 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Felix Miata <mrmazda@earthlink.net>, util-linux@vger.kernel.org
Subject: Re: global fdisk colors disable
Date: Wed, 15 Jan 2014 10:21:21 -0500
References: <52D62F0C.9060308@earthlink.net> <20140115082708.GH12700@x2.net.home> <52D696CB.5060606@earthlink.net>
In-Reply-To: <52D696CB.5060606@earthlink.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1441732.DIRlmhknsV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201401151021.22057.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1441732.DIRlmhknsV
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 15 January 2014 09:10:19 Felix Miata wrote:
> I have many logins on many installations. In what global config file (e.g.
> Debian, Fedora, Gentoo, Knoppix, Mageia, openSUSE, Slackware, etc.) can I
> make never the default for all users?

/etc/profile

or use ~/.bashrc and set up a system that syncs your ~/ files

if there was an env var, you could configure ~/.ssh/config to forward speci=
fic=20
env vars to the remote host automatically
=2Dmike

--nextPart1441732.DIRlmhknsV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJS1qdyAAoJEEFjO5/oN/WBfF4QANphWOAhN9CHsBPhr5K9RLbO
HGtXtNZd5VKte+qeReMZJQoSWENTB8qo4MKW8p+aa+R2qLwx9Rl4K6PdEzLS4q6p
N8/Q8nqAMPHs+EHF1T7g4xCDldHizpmTh76Qx2m2GH2RPlyJpBpuPvs/15s9Krlj
bRrEGudIs9AWpkvkcycBNOpSN+6eyjks7Z2qwQafaDQPTfRRV77B7El9Vj8bfRG/
gXehpG7aWEn4EQrsqhl2OIesF3m0bZeuz7/CLiAYbBput9uoXRslrtbHCaOwJEzA
Nzu6ZPuJ4S6QBaPy+bY+f6ffUICUEnK6kzlb+R/Gf6OtlMfrjURrFsZtAmWTtabx
sq+1hXSjMVYfksP+Yh21zLQlGLe7FHLn5YNqR5WxWk38wU30CyUvDpTe2fpOqz3a
C2ASXYE3trRvsSsmhbG8H+K/IAHOurcCausd9e9DnSKvLT7hYpSqr2DFe3bxkcrQ
mvddHwzcIfWCmIal01uQzg6cA39Fm2WoWtcTaFCRE3KRwz5cSNdSAooJo5T5bjO3
yCfgKTtByDv0wCXHAyk2U3cfzr/KNdbFHnjmS7mKB7B+9ZmIJGpKx1BAA7jA/SnY
W9Amq/8m+qO+fy2Z4WicNvY3yoJ7h48Ctld3ov7GAY4cm4Do7tob7Avx4lp8fhaM
6BImjgvKCXZlthoFksN2
=6JEg
-----END PGP SIGNATURE-----

--nextPart1441732.DIRlmhknsV--
