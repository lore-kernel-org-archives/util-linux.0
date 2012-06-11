Return-Path: beber@meleeweb.net
Date: Tue, 12 Jun 2012 00:29:38 +0200
From: Bertrand Jacquin <beber@meleeweb.net>
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] require C99, add robustness and small fixes
Message-ID: <20120611222938.GD25482@lemonhead.scabb>
References: <CAG27Bk1p9gqdiZSjmHcsWvTTs9WKU=vx0dYvtZVLCGJ1iuAnyg@mail.gmail.com>
 <20120611094851.GA21893@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
In-Reply-To: <20120611094851.GA21893@x2.net.home>
List-ID: <util-linux.vger.kernel.org>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

D'ar lun 11 a viz Mezheven 2012 e 11 eur 48, =C2=AB Karel Zak =C2=BB he deu=
s skrivet :
> On Sun, Jun 10, 2012 at 11:11:34PM +0200, Sami Kerola wrote:
> > diff --git a/configure.ac b/configure.ac
> > index 2280e7e..13c9637 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -80,6 +80,24 @@ AC_CANONICAL_HOST
> >  AC_C_CONST
> >  AC_C_VOLATILE
> >  AC_C_BIGENDIAN
> > +if test "$cross_compiling" =3D no; then
> > +  if test "x$ac_cv_prog_cc_c99" =3D "xno" || test "x$ac_cv_prog_cc_c99"
> > =3D "x"; then
> > +  # We might be on RHEL5 with a git checkout and so broken
> > +  # autoconf. Check if CC is gcc and if it bails when given -std=3Dgnu=
99.
> > +  # If not, use that.  Yuck.
> > +    if test "x$ac_cv_c_compiler_gnu" =3D "xyes"; then
> > +       CC=3D"$CC -std=3Dgnu99"
> > +       AC_RUN_IFELSE(
> > +          [AC_LANG_PROGRAM([],[[
> > +  return 0;
> > +      ]])],
> > +      [],
> > +      [AC_MSG_ERROR([Could not find a C99 compatible compiler])])
> > +    else
> > +      AC_MSG_ERROR([Could not find a C99 compatible compiler])
> > +    fi
> > +  fi
> > +fi
>=20
>  AC_PROG_CC_C99 sounds really like a better solution, although I have
>  autoconf 2.68 on Fedora 16 :-(

This is also present in autoconf-2.68 (lib/autoconf/c.m4:1360)

--=20
Beber

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/WcVIACgkQibjJUzm7jPS89wCglFtJMH05A2DvrMJNr6MuWiZ4
VfkAn0+2P6oDRwzM3QGhAprwGiXZbN+b
=DUhb
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
