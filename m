Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:42724 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933258AbcASXY7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Jan 2016 18:24:59 -0500
Received: from vapier.lan (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with SMTP id 8624634082B
	for <util-linux@vger.kernel.org>; Tue, 19 Jan 2016 23:24:58 +0000 (UTC)
Date: Tue, 19 Jan 2016 18:24:58 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: mount nofail: what failures should we allow ?
Message-ID: <20160119232458.GO14840@vapier.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLaBmHMi4cq+C/u4"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--yLaBmHMi4cq+C/u4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

i've received two requests for the "nofail" option.  the doc for the
option is a bit ... terse ... so it's hard to guess at the overall
intention.

(1) ignore ENOMEDIUM like:
sys-utils/mount.c could be updated to do:
    case ENOMEDIUM:
        if (uflags & MNT_MS_NOFAIL)
            return MOUNT_EX_SUCCESS;
        warnx(_("no medium found on %s"), src);
        break;
this is for cases like cd/dvd drives which happens to have no disk loaded.

(2) ignore unknown fs types.  e.g. when a kernel config/module is missing
support for the requested filesystem type.  so a fstab entry like:
	..src..  /mnt/foo  somefs defaults,nofail
rather than error out with:
	mount: unknown filesystem type 'somefs'
it would just issue a warning like it does for other nofail options.

if we go this route though, how far should we take it ?  should we make
all failures when nofail is active the same ?  i'm kind of leaning that
way ...
-mike

--yLaBmHMi4cq+C/u4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnsXKAAoJEEFjO5/oN/WB1tgQAJJYoNrRhES4U8QQ+7cGJOB3
r+qKvNrsP1Dnu4dSf8LoCaF3JbbxwGQ4X8PQgADaN/SIf7IcmukMFn0HBZxbYlq+
J3apkyH6JyK6AX0jse56wMRo6E6n7i19rtr5kOlBJTRV1ovOI6RRtC9O+tUTvnX6
ZvSuTjcrCi5jdIaK9BQhwEucpZT80pAf8ou4TObIWYZtw3rj5/hyUlrlrukPpT5L
uH+BxxPmi0por23PmAZ6DQiZIlaAFpMcV9N96Q5Qgjv94Qx/SvuWeIVX2f5wqOj2
8EaKuZq3M3OzHQ1wbY8HDIRy25/IhTcnFZOrFaGfD5OlgHa6Utkpvi1fH84tOQqz
ddQ39fI442RRHM3WUvJ4vtX+xowLK4XJqzgpNxZSEjNYBW8/dHxeCGBIsoeUT6bO
5yfECIdF0GItBwywGHOv55ESPLW/ju3xYquPNOfsd9+zprO5+ckWzuTaAmz/aQ0u
XGsXat4qzHlzIDFvOVNDERrx9JO2mm/c/6/pcu89Ck+U5FxHZkeIC8Kapf27g368
XMrA58Fdeb/f78AqOB7yMGNaZWle33V4l9XKgS10ifa+3ABm4I1FNt8yJxAj0FMU
WCDXTBYlFJHPHtLCy0uWNZG4oCgE+skhSGDtwUYUecRwIt03d93Fbw6m8FERbmuK
A8QUo/q1yfIejQEwsCuF
=ZWFw
-----END PGP SIGNATURE-----

--yLaBmHMi4cq+C/u4--
