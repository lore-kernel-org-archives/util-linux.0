Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:60817 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755652AbcASToo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Jan 2016 14:44:44 -0500
Date: Tue, 19 Jan 2016 14:44:43 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: "Wayne R. Roth" <wayneroth42@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mkswap: Add warnings for insecure device
 permissions/owners
Message-ID: <20160119194443.GD14840@vapier.lan>
References: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
In-Reply-To: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 19 Jan 2016 10:37, Wayne R. Roth wrote:
> +        permMask = S_ISBLK(ctl.devstat.st_mode) ? 07007 : 07077;
> +        if ((ctl.devstat.st_mode & permMask) != 0)
> +                warnx(_("%s: insecure permissions %04o, %04o suggested."),
> +                                ctl.devname, ctl.devstat.st_mode & 07777,
> +                                ~permMask & 0666);
> +        if (S_ISREG(ctl.devstat.st_mode) && ctl.devstat.st_uid != 0)
> +                warnx(_("%s: insecure file owner %d, 0 (root) suggested."),
> +                                ctl.devname, ctl.devstat.st_uid);

i haven't read/tested the code, so my assumptions might be off, but this
seems to complain even when creating files as non-root.  mkswap should
not do that.  a perfectly reasonable use case is to create images as a
non-root user for use with something like qemu.

maybe you want to add a getuid() check in there, or scuttle it altogether.
-mike

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnpIrAAoJEEFjO5/oN/WBstUP/3UAK10cW6B31Ac398Qg9CKI
X/lnj/LNhsn3rLINlV4GVMtYX8+Wvv6vK4u3o01i9LkbxU+Wu3yJVay4RUiUL0g3
K3ox7/ebvHeahk+nKFw2BQ49LfY+F5dTTr2t60S54FVtIpWLAQzOuHIql+2j3ZEm
gv/Ax/nyC42tp/vBy0ZXG7WqZWvlIXDncKSVSeHmGKLarBgcHBrL+8DOoT2M0Ixf
pN7CS1fezT1GxLBPmgLrKZso81WOWz5lNxgY1Smx+d2xOOlWOgZmFQEfgkp3Rpfz
GPO7Y6KbuiEt0Yeu95aKm+CAuBkdl9DVZ4iIOYXZGnqoJuRAArgssUr1G1l9jMFu
PWjlVvTQKLwpSQ04sMtegU7ly4AloPvIc+nIXj+YPxJXfskD6DWbbscu0dCu2s2e
dz1jAnnoL/b5yohl446xXkTh97qYpnvZdu1C0DZz2GQcfSKBbFN9tfYb63Q+RH12
NF/UvLg2Yx21ZxHAjNQ6cz1vba22VpKwRKCPKfgasUT9tcKa19xo26Ir4djlKAMT
g7Ebin3AkYsfRsx13EjUXxXVQ26i/Lu60aKlOtekfunV5VAYnFG1mys5fpaEyvcx
pzzEr4YNLkSBkentD/46OAwNjg2RkemcIE1GSvXxoW0KCi1YtU7Y9TMELztN4d6I
wFFJOlkUbgsAxAaplXig
=oreH
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
