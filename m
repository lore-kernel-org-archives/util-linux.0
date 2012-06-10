Return-Path: util-linux-owner@vger.kernel.org
Received: from fr1.as29.net ([88.190.23.70]:43628 "EHLO toothrot.meleeweb.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916Ab2FJVzD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 10 Jun 2012 17:55:03 -0400
Date: Sun, 10 Jun 2012 23:46:42 +0200
From: Bertrand Jacquin <beber@meleeweb.net>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] require C99, add robustness and small fixes
Message-ID: <20120610214642.GB25482@lemonhead.scabb>
References: <CAG27Bk1p9gqdiZSjmHcsWvTTs9WKU=vx0dYvtZVLCGJ1iuAnyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
In-Reply-To: <CAG27Bk1p9gqdiZSjmHcsWvTTs9WKU=vx0dYvtZVLCGJ1iuAnyg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> --- a/configure.ac
> +++ b/configure.ac
> @@ -80,6 +80,24 @@ AC_CANONICAL_HOST
>  AC_C_CONST
>  AC_C_VOLATILE
>  AC_C_BIGENDIAN
> +if test "$cross_compiling" =3D no; then
> +  if test "x$ac_cv_prog_cc_c99" =3D "xno" || test "x$ac_cv_prog_cc_c99"
> =3D "x"; then
> +  # We might be on RHEL5 with a git checkout and so broken
> +  # autoconf. Check if CC is gcc and if it bails when given -std=3Dgnu99.
> +  # If not, use that.  Yuck.
> +    if test "x$ac_cv_c_compiler_gnu" =3D "xyes"; then
> +       CC=3D"$CC -std=3Dgnu99"
> +       AC_RUN_IFELSE(
> +          [AC_LANG_PROGRAM([],[[
> +  return 0;
> +      ]])],
> +      [],
> +      [AC_MSG_ERROR([Could not find a C99 compatible compiler])])
> +    else
> +      AC_MSG_ERROR([Could not find a C99 compatible compiler])
> +    fi
> +  fi
> +fi

This break cross compiling as in this case -std=3Dgnu99 is not added to
$CC. Why not use AC_PROG_CC_C99 (present in autoconf-2.69) that is cross
compiling friendly and set CC to the correct value depending on which
compiler is used (GCC, AIX, HP ...)

I advise you to read autoconf/c.m4.

--=20
Beber

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/VFcIACgkQibjJUzm7jPSXtACaA1ZZdB7cVnCiane6z+aII1i4
Q+QAnjKSFRG8vQ4CS/o+P9NY3qs5qAWR
=P6hI
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
