Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:56793 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025AbbKOSth (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Nov 2015 13:49:37 -0500
Date: Sun, 15 Nov 2015 13:49:36 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unshare -m for non-root user
Message-ID: <20151115184936.GE31395@vapier.lan>
References: <n26nkm$13l$1@ger.gmane.org>
 <20151114181716.GA3839@newbook>
 <n287q4$efd$1@ger.gmane.org>
 <n28krj$8i0$1@ger.gmane.org>
 <20151115012418.GC31395@vapier.lan>
 <n28pis$6uv$1@ger.gmane.org>
 <20151115062819.GD31395@vapier.lan>
 <n29sg5$15j$1@ger.gmane.org>
 <20151115124211.GA5949@vapier.lan>
 <n2a9uv$313$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
In-Reply-To: <n2a9uv$313$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15 Nov 2015 16:56, U.Mutlu wrote:
> Mike Frysinger wrote on 11/15/2015 01:42 PM:
> > On 15 Nov 2015 13:06, U.Mutlu wrote:
> >> Mike Frysinger wrote on 11/15/2015 07:28 AM:
> >>> On 15 Nov 2015 03:10, U.Mutlu wrote:
> >>>> Mike Frysinger wrote on 11/15/2015 02:24 AM:
> >>>>> On 15 Nov 2015 01:49, U.Mutlu wrote:
> >>>>>> So, then the question remains: how to give non-root user a secure =
mount
> >>>>>
> >>>>> no, it doesn't.  at least two people have already told you how to d=
o it:
> >>>>> use the usernamespace (-U) option that unshare already supports.
> >>>>
> >>>> It's not yet clear for me how to use that. Can you give an example?
> >>>> unshare -U /bin/bash
> >>>
> >>> the unshare(1) man page already includes an example:
> >>> $ unshare --map-root-user --user sh -c whoami
> >>> root
> >>
> >> No, firstly there is no such example in man unshare, secondly it doesn=
't do here:
> >> $ unshare --map-root-user --user sh -c whoami
> >> unshare: unshare failed: Operation not permitted
> >>
> >> Is there maybe a bug in the Debian version?
> >
> > complain to Debian.  iirc, they break their kernels on purpose by adding
> > non-standard caps which disallow userns usage.
>=20
> Ok, I found out that on Debian one needs to make the follwing entry in=20
> /etc/sysctl.conf:
> kernel.unprivileged_userns_clone =3D 1
> and reboot, or do sysctl -p /etc/sysctl.conf, or equivalently
> echo 1 > /proc/sys/kernel/unprivileged_userns_clone
>=20
> Now the above unshare command does work.

ah, thanks for the tip !
-mike

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWSNO/AAoJEEFjO5/oN/WBj0gP/AoH/R3C/6A8coBCQunHqnq9
BhaOhOqVlxLmjX9vztNH3WlqQTNrGokwCOXB5RvVzo+1pkAScGZtyIq3UxF2m5eT
cSrWOuAUjd0xjeq0PWXf8MSX4PhBMJ+j4krMhyvltm//HJdgC62b0GfPbPAgZY88
Tgis5vB0zAgascqNfZveq2FlZlQv59Ddd8E7a4Gu/x9DH0yAJtI3t6k8vMQ/cDn3
GE60jJOAFw7qFqor/JNPBvi48V1x3rjCNauoSNaXyRut+cuVrTd4gnWvVq6LRXr4
NYEV8uIgTRGrga8/pXvHo9zoIDZPAuP7Gc2BS1B8YfyQq3ENjpesVBORFQNMKmD1
KzpTPTcqGM0Tj9WRSCaCxxhEdIFf6hYOAf72603wh0ZBK7qxyApn9s3UCUAUUFNh
uxwyTJGDd2WgwMt+M3aZjCbkPgUbMY/AVLedf3wGxccUkhmgjXtCPH0o4eqb98BQ
EhfwH4nJhh6OWjt8Etulxh3RToU3A8oRDGii163v2yrEO9A3vLzeYw99EW7afuUB
+I0AFFu0Rs6fT738i73T4jSMeOwLIQi4VMAcx06yDyw3C2pToWkPLVBMl4ZH+b5y
zv3Wy7gz8ULrpAJ/JyKkIX/EfohGRXGGeqHGwUiHZqQdcz5Vjt5afLjVrIbmlIzT
7Wp6TAJQMdrZ8dmX1VtW
=40oE
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
