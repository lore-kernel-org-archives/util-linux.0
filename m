Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:53720 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754849AbaAIQ4P (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Jan 2014 11:56:15 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Date: Thu, 9 Jan 2014 11:56:15 -0500
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Thomas =?iso-8859-1?q?B=E4chler?= <thomas@archlinux.org>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi> <201401081544.37516.vapier@gentoo.org> <1389220086-7475-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1389220086-7475-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6164919.4FmtxHxAiE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201401091156.16841.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart6164919.4FmtxHxAiE
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 08 January 2014 17:28:06 Sami Kerola wrote:
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -79,6 +79,7 @@ include libblkid/Makemodule.am
>  include libmount/Makemodule.am
>  include libfdisk/Makemodule.am
>=20
> +if HAVE_COMMANDS
>  include schedutils/Makemodule.am
>  include text-utils/Makemodule.am
>  include term-utils/Makemodule.am
> @@ -92,6 +93,7 @@ include fdisks/Makemodule.am
>  include bash-completion/Makemodule.am
>=20
>  include tests/Makemodule.am
> +endif	# HAVE_COMMANDS

aren't there some tests for the libs ?

> --- a/configure.ac
> +++ b/configure.ac
> @@ -704,6 +704,11 @@ AS_IF([test "x$with_utempter" =3D xyes], [
>    AM_CONDITIONAL([HAVE_UTEMPTER], [false])
>  ])
>=20
> +AC_ARG_ENABLE([binaries],
> +  AS_HELP_STRING([--disable-binaries], [build only libraries]),
> +  [], [enable_libraries_only=3Dyes]
> +)
> +AM_CONDITIONAL(HAVE_COMMANDS, test "x$enable_libraries_only" =3D xyes)

i'm not sure about this inversion of naming.  why can't it just use=20
enable_binaries everywhere ?

> --- a/login-utils/Makemodule.am
> +++ b/login-utils/Makemodule.am
> @@ -196,14 +196,3 @@ test_logindefs_SOURCES =3D \
>  	login-utils/logindefs.c \
>  	login-utils/logindefs.h
>  test_logindefs_CPPFLAGS =3D -DTEST_PROGRAM $(AM_CPPFLAGS)
> -
> -
> -install-exec-hook:
> -if BUILD_SU
> -if MAKEINSTALL_DO_SETUID
> -	chmod 4755 $(DESTDIR)$(bindir)/su
> -endif
> -endif
> -if BUILD_VIPW
> -	cd $(DESTDIR)$(usrsbin_execdir) && ln -sf vipw vigr
> -endif

why does this need to move ?  this module isn't included when commands are=
=20
disabled ...
=2Dmike

--nextPart6164919.4FmtxHxAiE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSztSwAAoJEEFjO5/oN/WBZ7EP/iN4avKLfgGvcT4uGa0ffk20
3YshVAE+OanIRZn2x/UTh/GQhf5GVoKSi9n9Wdpq23C7Ko8X9FD3uKxNZhp+XHeg
nMyvfZYDVI36/hSAdYfEIY8PyTwQoAIG9RUggDZMaIyPoaOjPnc+HSQcwcOI72Gj
WKfm0NH0RYZow45VbX7Bbss4XCn55GHB2n7c2+2OZSjxvOvwCMbDR0vKQkcS9WgZ
H5hmr3HujDhreR7O6TWJ0+Zw7hPnWkaraZM5H9SqalLCpz0ODjOOD4gBO3mnLXi6
155phc65fps2K8AgecfQFjagR9D+emiP5k9LhiLqA98ius6OrS8NOaNpUKbo3P4l
kpLm59SJGccWAgstFnujJeZ/BB27IrYA6zCQI8bDgIzfXrfxzunLOs+qisQqqHN2
/oB564zOK+uNLAcjUOei1wdGDR6pICDzEJrlYKUFqVPpTXk4eEscokgXShPcA0h4
ZvtPd0Db/qGe8vl2YZkdbwja7hXlGnUCqV2h5PCm1t80NMvYw0mh1ZdhZxgC1zaw
1RF/jKKlGm3eGFnOKcI5UgNxpDaR2onNSmCPK5YtGRhDTFUNFd6TtOp7tE+qz8sN
e3h2HNBAM6Ej5g43oHrBi6LqGL6K4hU/kSfMQkpsGsFE7JuDt7SOkb//aGJ2uyWh
A9r+xPObfCvWs9UhMhMt
=Xl8X
-----END PGP SIGNATURE-----

--nextPart6164919.4FmtxHxAiE--
