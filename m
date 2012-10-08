Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:44292 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab2JHJHV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Oct 2012 05:07:21 -0400
Date: Mon, 8 Oct 2012 11:06:40 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/14] ddate: remove from util-linux
Message-ID: <20121008090640.GB27761@foxbat.suse.cz>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
 <1349680100-18120-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
In-Reply-To: <1349680100-18120-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2012 at 08:08:07AM +0100, Sami Kerola wrote:
> See RedHat bug for reasons why the ddate is cleaned up.  The reference is
> where to get the command in future.
>=20
> Bug-Redhat: https://bugzilla.redhat.com/show_bug.cgi?id=3D823156
> References: https://github.com/bo0ts/ddate
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>

Since there is a fork of ddate at github
(https://github.com/bo0ts/ddate) and this IMHO does net belong to
util-linux, feel free to add

Acked-by: Petr Uzel <petr.uzel@suse.cz>

> ---
>  .gitignore                                      |   1 -
>  Documentation/howto-usage-function.txt          |   2 +-
>  Makefile.am                                     |   3 +-
>  configure.ac                                    |  11 -
>  man/ru/ddate.1                                  | 123 --------
>  misc-utils/Makemodule.am                        |   7 -
>  misc-utils/ddate.1                              | 114 --------
>  misc-utils/ddate.c                              | 374 ------------------=
------
>  tests/expected/build-sys/config-all             |   1 -
>  tests/expected/build-sys/config-all-devel       |   1 -
>  tests/expected/build-sys/config-all-non-nls     |   1 -
>  tests/expected/build-sys/config-devel           |   1 -
>  tests/expected/build-sys/config-devel-new-mount |   1 -
>  tools/checkmans.sh                              |   2 +-
>  14 files changed, 3 insertions(+), 639 deletions(-)
>  delete mode 100644 man/ru/ddate.1
>  delete mode 100644 misc-utils/ddate.1
>  delete mode 100644 misc-utils/ddate.c
>=20
> diff --git a/.gitignore b/.gitignore
> index a777d16..e85eb07 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -80,7 +80,6 @@ tests/run.sh.trs
>  /column
>  /ctrlaltdel
>  /cytune
> -/ddate
>  /delpart
>  /dmesg
>  /eject
> diff --git a/Documentation/howto-usage-function.txt b/Documentation/howto=
-usage-function.txt
> index 70116b2..1944bb7 100644
> --- a/Documentation/howto-usage-function.txt
> +++ b/Documentation/howto-usage-function.txt
> @@ -134,7 +134,7 @@ Some commands use peculiar options and arguments. The=
se are supported,
>  but such will not be accepted in future. See list bellow for a hint what
>  are meant this.
> =20
> -- Other than `-' used to define an option. See `+' for `more' or `ddate'
> +- Other than `-' used to define an option. See `+' for `more'
>    commands.
>  - Option string used as an option argument. See `more' command and `-num=
'.
>  - Short long option. See `setterm'.
> diff --git a/Makefile.am b/Makefile.am
> index a540f0e..6188f49 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -39,7 +39,6 @@ bin_PROGRAMS =3D
>  sbin_PROGRAMS =3D
>  dist_usrbin_exec_SCRIPTS =3D
>  systemdsystemunit_DATA =3D
> -ruman1_DATA =3D
>  check_PROGRAMS =3D
>  TESTS =3D
> =20
> @@ -51,7 +50,7 @@ INSTALL_DATA_HOOKS =3D
>  CLEAN_LOCALS =3D
>  CHECK_LOCALS =3D
> =20
> -EXTRA_DIST =3D man/ru/ddate.1
> +EXTRA_DIST =3D
>  CLEANFILES =3D
> =20
>  SUBDIRS =3D po
> diff --git a/configure.ac b/configure.ac
> index 9d2f589..d0a7b57 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -678,7 +678,6 @@ AC_ARG_ENABLE([most-builds],
>  )
>  if test "x$enable_most_builds" =3D xyes; then
>    enable_arch=3Dcheck
> -  enable_ddate=3Dyes
>    enable_elvtune=3Dcheck
>    enable_last=3Dyes
>    enable_line=3Dyes
> @@ -880,16 +879,6 @@ UL_REQUIRES_LINUX([arch])
>  AM_CONDITIONAL(BUILD_ARCH, test "x$build_arch" =3D xyes)
> =20
> =20
> -AC_ARG_ENABLE([ddate],
> -  AS_HELP_STRING([--enable-ddate], [do build ddate]),
> -  [], enable_ddate=3Dno
> -)
> -UL_BUILD_INIT([ddate])
> -AM_CONDITIONAL(BUILD_DDATE, test "x$build_ddate" =3D xyes)
> -ruman1dir=3D'${mandir}/ru/man1'
> -AC_SUBST([ruman1dir])
> -
> -
>  AC_ARG_ENABLE([eject],
>    AS_HELP_STRING([--disable-eject], [do not build eject]),
>    [], enable_eject=3Dcheck
> diff --git a/man/ru/ddate.1 b/man/ru/ddate.1
> deleted file mode 100644
> index cb10c57..0000000
> --- a/man/ru/ddate.1
> +++ /dev/null
> @@ -1,123 +0,0 @@
> -.\" All Rites Reversed.  This file is in the PUBLIC DOMAIN.
> -.\" Kallisti.
> -.TH DDATE 1 "59 Bureaucracy 3161" "" "Emperor Norton Utilities"
> -.SH =D0=98=D0=9C=D0=AF
> -ddate \- =D0=BF=D1=80=D0=B5=D0=BE=D0=B1=D1=80=D0=B0=D0=B7=D1=83=D0=B5=D1=
=82 =D0=B4=D0=B0=D1=82=D1=83 =D0=B2 =D0=B3=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D0=
=B8=D0=B0=D0=BD=D1=81=D0=BA=D0=BE=D0=BC =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=
=82=D0=B5 =D0=B2 =D1=81=D0=BE=D0=BE=D1=82=D0=B2=D0=B5=D1=82=D1=81=D1=82=D0=
=B2=D1=83=D1=8E=D1=89=D1=83=D1=8E =D0=B4=D0=B0=D1=82=D1=83 =D0=B2=20
> -=D0=B4=D0=B8=D1=81=D0=BA=D0=BE=D1=80=D0=B4=D0=B8=D0=B0=D0=BD=D1=81=D0=BA=
=D0=BE=D0=BC =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82=D0=B5
> -.SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> -.B ddate
> -.RI [ \fB+\fP=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82]
> -.RI [ =D0=B4=D0=B0=D1=82=D0=B0 ]
> -.SH =D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95
> -.B ddate
> -=D0=B2=D1=8B=D0=B2=D0=BE=D0=B4=D0=B8=D1=82 =D0=B4=D0=B0=D1=82=D1=83 =D0=
=B2 =D0=B4=D0=B8=D1=81=D0=BA=D0=BE=D1=80=D0=B4=D0=B8=D0=B0=D0=BD=D1=81=D0=
=BA=D0=BE=D0=BC =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82=D0=B5.
> -.PP
> -=D0=95=D1=81=D0=BB=D0=B8 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=20
> -.B ddate
> -=D0=B2=D1=8B=D0=B7=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B1=D0=B5=D0=B7 =D0=BF=D0=
=B0=D1=80=D0=B0=D0=BC=D0=B5=D1=82=D1=80=D0=BE=D0=B2, =D0=BE=D0=BD=D0=B0 =D0=
=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=D1=83=D1=
=89=D1=83=D1=8E =D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D1=83=D1=8E =D0=
=B4=D0=B0=D1=82=D1=83, =D0=BF=D1=80=D0=B5=D0=BE=D0=B1=D1=80=D0=B0=D0=B7=D1=
=83=D0=B5=D1=82 =D0=B5=D1=91 =D0=B2
> -=D0=B4=D0=B8=D1=81=D0=BA=D0=BE=D1=80=D0=B4=D0=B8=D0=B0=D0=BD=D1=81=D0=BA=
=D0=B8=D0=B9 =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82 =D0=B8 =D0=B2=D1=8B=D0=B2=
=D0=BE=D0=B4=D0=B8=D1=82 =D0=BD=D0=B0 =D1=81=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=
=D1=80=D1=82=D0=BD=D1=8B=D0=B9 =D0=B2=D1=8B=D0=B2=D0=BE=D0=B4. =D0=A2=D0=B0=
=D0=BA=D0=B6=D0=B5 =D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D1=83=D0=BA=D0=B0=D0=B7=
=D0=B0=D1=82=D1=8C =D0=B2
> -=D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=BD=D0=BE=D0=B9 =D1=81=D1=82=D1=
=80=D0=BE=D0=BA=D0=B5 =D0=B4=D0=B0=D1=82=D1=83 =D0=B2 =D0=B3=D1=80=D0=B8=D0=
=B3=D0=BE=D1=80=D0=B8=D0=B0=D0=BD=D1=81=D0=BA=D0=BE=D0=BC =D1=84=D0=BE=D1=
=80=D0=BC=D0=B0=D1=82=D0=B5, =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=B2 =D0=B2 =
=D1=87=D0=B8=D1=81=D0=BB=D0=BE=D0=B2=D0=BE=D0=BC =D0=B2=D0=B8=D0=B4=D0=B5 =
=D0=B4=D0=B5=D0=BD=D1=8C,=20
> -=D0=BC=D0=B5=D1=81=D1=8F=D1=86 =D0=B8 =D0=B3=D0=BE=D0=B4.
> -.PP
> -=D0=95=D1=81=D0=BB=D0=B8 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD =D1=81=D0=
=BF=D0=B5=D1=86=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=D0=BE=D1=80 =D1=84=D0=
=BE=D1=80=D0=BC=D0=B0=D1=82=D0=B0 =D0=B2=D1=8B=D0=B2=D0=BE=D0=B4=D0=B0, =D0=
=B4=D0=B0=D1=82=D0=B0 =D0=B2 =D0=B4=D0=B8=D1=81=D0=BA=D0=BE=D1=80=D0=B4=D0=
=B8=D0=B0=D0=BD=D1=81=D0=BA=D0=BE=D0=BC =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=
=82=D0=B5 =D0=B1=D1=83=D0=B4=D0=B5=D1=82
> -=D0=BE=D1=82=D0=BE=D0=B1=D1=80=D0=B0=D0=B6=D0=B5=D0=BD=D0=B0 =D0=B2 =D1=
=82=D0=BE=D0=BC =D0=B2=D0=B8=D0=B4=D0=B5, =D0=BA=D0=B0=D0=BA =D1=8D=D1=82=
=D0=BE =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BE =D1=81=
=D0=BF=D0=B5=D1=86=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=D0=BE=D1=80=D0=BE=D0=
=BC. =D0=AD=D1=82=D0=BE=D1=82 =D0=BC=D0=B5=D1=85=D0=B0=D0=BD=D0=B8=D0=B7=D0=
=BC=20
> -=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=B5=D1=82 =D0=BF=D0=BE=D0=B4=D0=
=BE=D0=B1=D0=BD=D0=BE =D0=BC=D0=B5=D1=85=D0=B0=D0=BD=D0=B8=D0=B7=D0=BC=D1=
=83 =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=
=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=8B
> -.B date(1),
> -=D0=BD=D0=BE =D0=BF=D0=BE=D1=87=D1=82=D0=B8 =D0=BF=D0=BE=D0=BB=D0=BD=D0=
=BE=D1=81=D1=82=D1=8C=D1=8E =D0=B8=D0=BD=D0=B0=D1=87=D0=B5. =D0=9F=D0=BE=D0=
=BB=D1=8F =D1=81=D0=BF=D0=B5=D1=86=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=D0=
=BE=D1=80=D0=B0 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B5:
> -.IP %A
> -=D0=9F=D0=BE=D0=BB=D0=BD=D0=BE=D0=B5 =D0=BD=D0=B0=D0=B7=D0=B2=D0=B0=D0=
=BD=D0=B8=D0=B5 =D0=B4=D0=BD=D1=8F =D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D0=B8 (=
=D0=BD=D0=B0=D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80, Sweetmorn)
> -.IP %a
> -=D0=94=D0=B5=D0=BD=D1=8C =D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D0=B8 =D0=B2 =D1=
=81=D0=BE=D0=BA=D1=80=D0=B0=D1=89=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC =D1=84=D0=
=BE=D1=80=D0=BC=D0=B0=D1=82=D0=B5 (=D0=BD=D0=B0=D0=BF=D1=80=D0=B8=D0=BC=D0=
=B5=D1=80, SM)
> -.IP %B
> -=D0=9F=D0=BE=D0=BB=D0=BD=D0=BE=D0=B5 =D0=BD=D0=B0=D0=B7=D0=B2=D0=B0=D0=
=BD=D0=B8=D0=B5 =D1=81=D0=B5=D0=B7=D0=BE=D0=BD=D0=B0 (=D0=B2=D1=80=D0=B5=D0=
=BC=D0=B5=D0=BD=D0=B8 =D0=B3=D0=BE=D0=B4=D0=B0) (=D0=BD=D0=B0=D0=BF=D1=80=
=D0=B8=D0=BC=D0=B5=D1=80, Chaos)
> -.IP %b
> -=D0=A1=D0=BE=D0=BA=D1=80=D0=B0=D1=89=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =D0=
=BD=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=81=D0=B5=D0=B7=D0=BE=D0=
=BD=D0=B0 (=D0=BD=D0=B0=D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80, Chs)
> -.IP %d
> -=D0=9F=D0=BE=D1=80=D1=8F=D0=B4=D0=BA=D0=BE=D0=B2=D1=8B=D0=B9 =D0=BD=D0=
=BE=D0=BC=D0=B5=D1=80 =D0=B4=D0=BD=D1=8F =D0=B2 =D1=81=D0=B5=D0=B7=D0=BE=D0=
=BD=D0=B5 (=D0=BD=D0=B0=D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80, 23)
> -.IP %e
> -=D0=A7=D0=B8=D1=81=D0=BB=D0=BE=D0=B2=D0=BE=D0=B5 =D0=BF=D1=80=D0=B5=D0=
=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=BE=D0=
=BC=D0=B5=D1=80=D0=B0 =D0=B4=D0=BD=D1=8F =D0=B2 =D1=81=D0=B5=D0=B7=D0=BE=D0=
=BD=D0=B5 (=D0=BD=D0=B0=D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80, 23rd)
> -.IP %H
> -=D0=9D=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=82=D0=B5=D0=BA=D1=
=83=D1=89=D0=B5=D0=B3=D0=BE =D0=BF=D1=80=D0=B0=D0=B7=D0=B4=D0=BD=D0=B8=D0=
=BA=D0=B0, =D0=B5=D1=81=D0=BB=D0=B8 =D1=82=D0=B0=D0=BA=D0=BE=D0=B2=D0=BE=D0=
=B9 =D0=B8=D0=BC=D0=B5=D0=B5=D1=82=D1=81=D1=8F
> -.IP %N
> -=D0=92=D0=BE=D0=BB=D1=88=D0=B5=D0=B1=D0=BD=D1=8B=D0=B9 =D0=BA=D0=BE=D0=
=B4 =D0=B4=D0=BB=D1=8F =D0=BF=D1=80=D0=B5=D0=B4=D0=BE=D1=82=D0=B2=D1=80=D0=
=B0=D1=89=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2=D1=8B=D0=B2=D0=BE=D0=B4=D0=B0 =D1=
=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=B3=D0=BE =D0=B7=D0=B0 =D0=
=BD=D0=B8=D0=BC =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82=D0=B8=D1=80=D0=BE=D0=
=B2=D0=B0=D0=BD=D0=B8=D1=8F,
> -=D0=B2 =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=B5, =D0=B5=D1=81=D0=BB=D0=B8 =
=D0=B4=D0=B0=D1=82=D0=B0 =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=
=D1=81=D1=8F =D0=BF=D1=80=D0=B0=D0=B7=D0=B4=D0=BD=D0=B8=D0=BA=D0=BE=D0=BC.
> -.IP %n
> -=D0=9D=D0=BE=D0=B2=D0=B0=D1=8F =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B0
> -.IP %t
> -=D0=A2=D0=B0=D0=B1=D1=83=D0=BB=D1=8F=D1=86=D0=B8=D1=8F
> -.IP %X
> -=D0=A7=D0=B8=D1=81=D0=BB=D0=BE =D0=B4=D0=BD=D0=B5=D0=B9 =D0=B4=D0=BE =D0=
=BD=D0=B0=D1=81=D1=82=D1=83=D0=BF=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=94=D0=
=BD=D1=8F X (X-Day). =D0=9E=D0=BF=D1=86=D0=B8=D1=8F =D0=BD=D0=B5 =D0=B4=D0=
=B5=D0=B9=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82, =D0=B5=D1=81=D0=BB=D0=B8 =D1=
=83=D1=82=D0=B8=D0=BB=D0=B8=D1=82=D0=B0=20
> -=D0=B1=D0=B5=D0=B7 =D0=BE=D0=BF=D1=86=D0=B8=D0=B8 SubGenius.
> -.IP %{
> -.IP %}
> -=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D1=83=D0=B5=D1=82=D1=81=D1=8F=
 =D0=B4=D0=BB=D1=8F =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=B8=D1=8F =D1=87=
=D0=B0=D1=81=D1=82=D0=B8 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B8, =D0=BA=D0=BE=
=D1=82=D0=BE=D1=80=D0=B0=D1=8F =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=B7=D0=B0=
=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B0 =D1=81=D0=BB=D0=BE=D0=B2=D0=B0=D0=BC=
=D0=B8=20
> -"St. Tib's Day", =D0=B5=D1=81=D0=BB=D0=B8 =D1=82=D0=B5=D0=BA=D1=83=D1=89=
=D0=B8=D0=B9 =D0=B4=D0=B5=D0=BD=D1=8C =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=
=D1=81=D1=8F =D0=94=D0=BD=D0=B5=D0=BC =D1=81=D0=B2=D1=8F=D1=82=D0=BE=D0=B3=
=D0=BE =D0=A2=D0=B8=D0=B1=D0=B0 (St. Tib's day).
> -.IP %\.
> -=D0=9F=D0=BE=D0=BF=D1=80=D0=BE=D0=B1=D1=83=D0=B9=D1=82=D0=B5 =D0=B8 =D1=
=83=D0=B2=D0=B8=D0=B4=D0=B8=D1=82=D0=B5.
> -.bp
> -.SH =D0=9F=D0=A0=D0=98=D0=9C=D0=95=D0=A0=D0=AB
> -.nf
> -% ddate
> -.br
> -Sweetmorn, Bureaucracy 42, 3161 YOLD
> -.PP
> -% ddate +'Today is %{%A, the %e of %B%}, %Y. %N%nCelebrate %H'
> -.br
> -Today is Sweetmorn, the 42nd of Bureaucracy, 3161.
> -.PP
> -% ddate +"It's %{%A, the %e of %B%}, %Y. %N%nCelebrate %H" 26 9 1995
> -.br
> -It's Prickle-Prickle, the 50th of Bureaucracy, 3161.
> -.br
> -Celebrate Bureflux
> -.PP
> -% ddate +"Today's %{%A, the %e of %B%}, %Y. %N%nCelebrate %H" 29 2 1996
> -.br
> -Today's St. Tib's Day, 3162.
> -.br
> -
> -.SH =D0=9E=D0=A8=D0=98=D0=91=D0=9A=D0=98
> -
> -.B ddate(1)
> -=D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=B2=D0=B5=D1=81=D1=82=D0=B8 =D1=81=D0=
=B5=D0=B1=D1=8F =D0=BD=D0=B5=D0=BF=D1=80=D0=B5=D0=B4=D1=81=D0=BA=D0=B0=D0=
=B7=D1=83=D0=B5=D0=BC=D0=BE, =D0=B5=D1=81=D0=BB=D0=B8 =D0=BF=D0=BE=D0=BF=D1=
=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=B2=D0=B5=D1=81=D1=82=D0=
=B8 =D0=B4=D0=B0=D1=82=D1=83 =D0=94=D0=BD=D1=8F =D1=81=D0=B2=D1=8F=D1=82=D0=
=BE=D0=B3=D0=BE =D0=A2=D0=B8=D0=B1=D0=B0
> -=D0=BD=D0=BE =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B0 =D1=81=D0=BF=D0=B5=D1=
=86=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=D0=BE=D1=80=D0=B0 =D1=84=D0=BE=D1=
=80=D0=BC=D0=B0=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D0=
=BF=D1=80=D0=B8 =D1=8D=D1=82=D0=BE=D0=BC =D0=BD=D0=B5 =D1=81=D0=BE=D0=B4=D0=
=B5=D1=80=D0=B6=D0=B8=D1=82 =D1=80=D0=B0=D0=B7=D0=B4=D0=B5=D0=BB=D0=B8=D1=
=82=D0=B5=D0=BB=D0=B5=D0=B9,
> -=D0=BF=D1=80=D0=B5=D0=B4=D1=83=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B5=D0=BD=
=D0=BD=D1=8B=D1=85 =D1=81=D0=BF=D0=B5=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=
=D0=BE =D0=B4=D0=BB=D1=8F =D1=8D=D1=82=D0=BE=D0=B3=D0=BE =D1=81=D0=BB=D1=83=
=D1=87=D0=B0=D1=8F (%{ =D0=B8 %}).
> -
> -.SH =D0=97=D0=90=D0=9C=D0=95=D0=A7=D0=90=D0=9D=D0=98=D0=AF
> -
> -=D0=9F=D0=BE=D1=81=D0=BB=D0=B5 =D1=82=D0=BE=D0=B3=D0=BE, =D0=BA=D0=B0=D0=
=BA =D0=94=D0=B5=D0=BD=D1=8C =D0=98=D0=BA=D1=81 (5 =D0=B8=D1=8E=D0=BB=D1=8F=
 1998 =D0=B3=D0=BE=D0=B4=D0=B0 - =D0=BF=D1=80=D0=B8=D0=BC. =D0=BF=D0=B5=D1=
=80.) =D0=BF=D1=80=D0=BE=D1=88=D0=B5=D0=BB =D0=B1=D0=B5=D0=B7=20
> -=D0=BF=D1=80=D0=BE=D0=B8=D1=81=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B8=D0=B9=
, =D0=A6=D0=B5=D1=80=D0=BA=D0=BE=D0=B2=D1=8C =D0=A1=D1=83=D0=B1=D0=93=D0=B5=
=D0=BD=D0=B8=D1=8F (Church of the SubGenius) =D0=BF=D1=80=D0=BE=D0=B2=D0=BE=
=D0=B7=D0=B3=D0=BB=D0=B0=D1=81=D0=B8=D0=BB=D0=B0,
> -=D1=87=D1=82=D0=BE =D0=BE=D0=BD =D0=B4=D0=BE=D0=BB=D0=B6=D0=B5=D0=BD =D0=
=BD=D0=B0=D1=81=D1=82=D1=83=D0=BF=D0=B8=D1=82=D1=8C =D0=B2 '=D0=B3=D0=BE=D0=
=B4=D1=83 =D0=B2=D0=B2=D0=B5=D1=80=D1=85 =D1=82=D0=BE=D1=80=D0=BC=D0=B0=D1=
=88=D0=BA=D0=B0=D0=BC=D0=B8' - =D0=94=D0=B5=D0=BD=D1=8C =D0=98=D0=BA=D1=81 =
=D0=BD=D0=B0=D1=81=D1=82=D1=83=D0=BF=D0=B8=D1=82 =D0=B2 8661
> -=D0=B3=D0=BE=D0=B4=D1=83 =D0=BD. =D1=8D., =D0=B0 =D0=BD=D0=B5 =D0=B2 199=
8 =D0=BD. =D1=8D. =D0=A2=D0=B0=D0=BA=D0=B8=D0=BC =D0=BE=D0=B1=D1=80=D0=B0=
=D0=B7=D0=BE=D0=BC, =D0=98=D1=81=D1=82=D0=B8=D0=BD=D0=BD=D1=8B=D0=B9 =D0=94=
=D0=B5=D0=BD=D1=8C =D0=98=D0=BA=D1=81 - =D1=8D=D1=82=D0=BE 40 =D0=B4=D0=B5=
=D0=BD=D1=8C
> -=D1=81=D0=B5=D0=B7=D0=BE=D0=BD=D0=B0 =D0=97=D0=B0=D0=BC=D0=B5=D1=88=D0=
=B0=D1=82=D0=B5=D0=BB=D1=8C=D1=81=D1=82=D0=B2=D0=B0 9827 =D0=B3=D0=BE=D0=B4=
=D0=B0 (Cfn 40, 9827).
> -
> -.SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
> -.nh
> -=D0=90=D0=B2=D1=82=D0=BE=D1=80 =D0=BE=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=
=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=
=BC=D0=BC=D1=8B Druel the Chaotic aka Jeremy Johnson=20
> -(mpython@gnu.ai.mit.edu)
> -.br
> -=D0=9F=D0=B5=D1=80=D0=B5=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 =D0=BF=D1=
=80=D0=B5=D0=B8=D0=BC=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D0=B5=D0=BD=D0=BD=
=D0=BE Lee H:. O:. Smith, KYTP, aka Andrew Bulhak=20
> -(acb@dev.null.org)
> -.br
> -=D0=9F=D1=8F=D1=82=D1=8C =D1=82=D0=BE=D0=BD=D0=BD =D0=BB=D1=8C=D0=BD=D0=
=B0.
> -
> -.SH =D0=A0=D0=90=D0=A1=D0=9F=D0=A0=D0=9E=D0=A1=D0=A2=D0=A0=D0=90=D0=9D=
=D0=95=D0=9D=D0=98=D0=95
> -
> -=D0=A1=D0=B2=D0=BE=D0=B1=D0=BE=D0=B4=D0=BD=D0=BE =D1=80=D0=B0=D1=81=D0=
=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=D0=B0=D0=BD=D1=8F=D0=B5=D0=BC=D0=BE=D0=B5=
 =D0=9F=D0=9E. =D0=92=D1=81=D0=B5 =D0=BF=D1=80=D0=B0=D0=B2=D0=B0 =D0=B7=D0=
=B0=D1=89=D0=B8=D1=89=D0=B5=D0=BD=D1=8B.
> -
> -.SH =D0=A1=D0=9C. =D0=A2=D0=90=D0=9A=D0=96=D0=95
> -
> -date(1),
> -.br
> -http://www.subgenius.com/
> -.br
> -=D0=9C=D0=B0=D0=BB=D0=B0=D0=BA=D0=BB=D0=B8=D0=BF=D1=81 =D0=9C=D0=BB=D0=
=B0=D0=B4=D1=88=D0=B8=D0=B9 (Malaclypse the Younger),
> -.I "Principia Discordia, =D0=B8=D0=BB=D0=B8 =D0=9A=D0=B0=D0=BA =D1=8F =
=D0=BD=D0=B0=D1=88=D0=B5=D0=BB =D0=91=D0=BE=D0=B3=D0=B8=D0=BD=D1=8E =D0=B8 =
=D1=87=D1=82=D0=BE =D1=8F =D1=81 =D0=9D=D0=B5=D0=B9 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BB =D0=BA=D0=BE=D0=B3=D0=B4=D0=B0=20
> -=D0=BD=D0=B0=D1=88=D0=B5=D0=BB"
> -
> -.SH =D0=94=D0=9E=D0=A1=D0=A2=D0=A3=D0=9F=D0=9D=D0=9E=D0=A1=D0=A2=D0=AC
> -=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0 ddate =D1=8F=D0=B2=D0=BB=D1=
=8F=D0=B5=D1=82=D1=81=D1=8F =D1=87=D0=B0=D1=81=D1=82=D1=8C=D1=8E =D0=BF=D0=
=B0=D0=BA=D0=B5=D1=82=D0=B0 util-linux =D0=B8 =D0=B4=D0=BE=D1=81=D1=82=D1=
=83=D0=BF=D0=BD=D0=B0 =D0=BF=D0=BE=20
> -ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
> -
> -.SH =D0=9F=D0=95=D0=A0=D0=95=D0=92=D0=9E=D0=94
> -=D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 Rino_ap_Codkelden <mavladi@gm=
ail.com> 2010
> \ No newline at end of file
> diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
> index 910e428..4c88532 100644
> --- a/misc-utils/Makemodule.am
> +++ b/misc-utils/Makemodule.am
> @@ -52,13 +52,6 @@ CLEANFILES +=3D misc-utils/chkdupexe
>  dist_man_MANS +=3D misc-utils/chkdupexe.1
>  endif
> =20
> -if BUILD_DDATE
> -usrbin_exec_PROGRAMS +=3D ddate
> -dist_man_MANS +=3D misc-utils/ddate.1
> -ddate_SOURCES =3D misc-utils/ddate.c
> -ruman1_DATA +=3D man/ru/ddate.1
> -endif
> -
>  if BUILD_LSLOCKS
>  usrbin_exec_PROGRAMS +=3D lslocks
>  dist_man_MANS +=3D misc-utils/lslocks.8
> diff --git a/misc-utils/ddate.1 b/misc-utils/ddate.1
> deleted file mode 100644
> index 0b01e09..0000000
> --- a/misc-utils/ddate.1
> +++ /dev/null
> @@ -1,114 +0,0 @@
> -.\" All Rites Reversed.  This file is in the PUBLIC DOMAIN.
> -.\" Kallisti.
> -.TH DDATE 1 "Bureaucracy 3161" "util-linux" "Emperor Norton User Command"
> -.SH NAME
> -ddate \- convert Gregorian dates to Discordian dates
> -.SH SYNOPSIS
> -.B ddate
> -.RI [ \fB+\fPformat]
> -.RI [ date ]
> -.SH DESCRIPTION
> -.B ddate
> -prints the date in Discordian date format.
> -.PP
> -If called with no arguments,
> -.B ddate
> -will get the current system date, convert this to the Discordian
> -date format and print this on the standard output. Alternatively, a
> -Gregorian date may be specified on the command line, in the form of a nu=
merical
> -day, month and year.
> -.PP
> -If a format string is specified, the Discordian date will be printed in
> -a format specified by the string. This mechanism works similarly to the
> -format string mechanism of
> -.B date(1),
> -only almost completely differently. The fields are:
> -.IP %A
> -Full name of the day of the week (i.e., Sweetmorn)
> -.IP %a
> -Abbreviated name of the day of the week (i.e., SM)
> -.IP %B
> -Full name of the season (i.e., Chaos)
> -.IP %b
> -Abbreviated name of the season (i.e., Chs)
> -.IP %d
> -Ordinal number of day in season (i.e., 23)
> -.IP %e
> -Cardinal number of day in season (i.e., 23rd)
> -.IP %H
> -Name of current Holyday, if any
> -.IP %N
> -Magic code to prevent rest of format from being printed unless today is
> -a Holyday.
> -.IP %n
> -Newline
> -.IP %t
> -Tab
> -.IP %X
> -Number of days remaining until X-Day. (Not valid if the SubGenius options
> -are not compiled in.)
> -.IP %{
> -.IP %}
> -Used to enclose the part of the string which is to be replaced with the
> -words "St. Tib's Day" if the current day is St. Tib's Day.
> -.IP %\.
> -Try it and see.
> -.bp
> -.SH EXAMPLES
> -.nf
> -% ddate
> -.br
> -Sweetmorn, Bureaucracy 42, 3161 YOLD
> -.PP
> -% ddate +'Today is %{%A, the %e of %B%}, %Y. %N%nCelebrate %H'
> -.br
> -Today is Sweetmorn, the 42nd of Bureaucracy, 3161.
> -.PP
> -% ddate +"It's %{%A, the %e of %B%}, %Y. %N%nCelebrate %H" 26 9 1995
> -.br
> -It's Prickle-Prickle, the 50th of Bureaucracy, 3161.
> -.br
> -Celebrate Bureflux
> -.PP
> -% ddate +"Today's %{%A, the %e of %B%}, %Y. %N%nCelebrate %H" 29 2 1996
> -.br
> -Today's St. Tib's Day, 3162.
> -.br
> -
> -.SH BUGS
> -
> -.B ddate(1)
> -will produce undefined behavior if asked to produce the date for St. Tib=
's
> -day and its format string does not contain the St. Tib's Day delimiters
> -%{ and %}.
> -
> -.SH NOTE
> -
> -After `X-Day' passed without incident, the Church of the SubGenius
> -declared that it had got the year upside down - X-Day is actually in 866=
1 AD
> -rather than 1998 AD.  Thus, the True X-Day is Cfn 40, 9827.
> -
> -.SH AUTHOR
> -.nh
> -Original program by Druel the Chaotic aka Jeremy Johnson (mpython@gnu.ai=
=2Emit.edu)
> -.br
> -Major rewrite by Lee H:. O:. Smith, KYTP, aka Andrew Bulhak (acb@dev.nul=
l.org)
> -.br
> -Five tons of flax.
> -
> -.SH DISTRIBUTION POLICY
> -
> -Public domain. All rites reversed.
> -
> -.SH SEE ALSO
> -
> -date(1),
> -.br
> -http://www.subgenius.com/
> -.br
> -Malaclypse the Younger,
> -.I "Principia Discordia, Or How I Found Goddess And What I Did To Her Wh=
en I Found Her"
> -
> -.SH AVAILABILITY
> -The ddate command is part of the util-linux package and is available from
> -ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
> diff --git a/misc-utils/ddate.c b/misc-utils/ddate.c
> deleted file mode 100644
> index c0b4ce4..0000000
> --- a/misc-utils/ddate.c
> +++ /dev/null
> @@ -1,374 +0,0 @@
> -/* $ DVCS ID: $jer|,523/lhos,KYTP!41023161\b"?" <<=3D DO NOT DELETE! */
> -
> -/* ddate.c .. converts boring normal dates to fun Discordian Date -><-
> -   written  the 65th day of The Aftermath in the Year of Our Lady of=20
> -   Discord 3157 by Druel the Chaotic aka Jeremy Johnson aka
> -   mpython@gnu.ai.mit.edu =20
> -      28 Sever St Apt #3
> -      Worcester MA 01609
> -
> -   and I'm not responsible if this program messes anything up (except yo=
ur=20
> -   mind, I'm responsible for that)
> -
> -   (k) YOLD 3161 and all time before and after.
> -   Reprint, reuse, and recycle what you wish.
> -   This program is in the public domain.  Distribute freely.  Or not.
> -
> -   Majorly hacked, extended and bogotified/debogotified on=20
> -   Sweetmorn, Bureaucracy 42, 3161 YOLD, by Lee H:. O:. Smith, KYTP,=20
> -   aka Andrew Bulhak, aka acb@dev.null.org
> -
> -   and I'm not responsible if this program messes anything up (except yo=
ur=20
> -   mind, I'm responsible for that) (and that goes for me as well --lhos)
> -
> -   Version history:
> -   Bureflux 3161:      First release of enhanced ddate with format strin=
gs
> -   59 Bcy, 3161:       PRAISE_BOB and KILL_BOB options split, other minor
> -                       changes.
> -
> -   1999-02-22 Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
> -   - added Native Language Support
> -
> -   2000-03-17 Burt Holzman <bnh@iname.com>
> -   - added range checks for dates
> -*/
> -
> -/* configuration options  VVVVV   READ THIS!!! */
> -
> -/* If you wish ddate(1) to print the date in the same format as Druel's=
=20
> - * original ddate when called in immediate mode, define OLD_IMMEDIATE_FM=
T=20
> - */
> -
> -#define OLD_IMMEDIATE_FMT
> -
> -/* If you wish to use the US format for aneristic dates (m-d-y), as oppo=
sed to
> - * the Commonwealth format, define US_FORMAT.
> - */
> -
> -/* #define US_FORMAT */
> -
> -/* If you are ideologically, theologically or otherwise opposed to the=
=20
> - * Church of the SubGenius and do not wish your copy of ddate(1) to cont=
ain
> - * code for counting down to X-Day, undefine KILL_BOB */
> -
> -#define KILL_BOB 13013
> -
> -/* If you wish ddate(1) to contain SubGenius slogans, define PRAISE_BOB =
*/
> -
> -/*#define PRAISE_BOB 13013*/
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include <time.h>
> -#include <stdio.h>
> -
> -#include "nls.h"
> -#include "closestream.h"
> -#include "c.h"
> -
> -#ifndef __GNUC__
> -#define inline /* foo */
> -#endif
> -
> -#ifdef KILL_BOB
> -int xday_countdown(int yday, int year);
> -#endif
> -
> -
> -/* string constants */
> -
> -char *day_long[5] =3D {=20
> -    "Sweetmorn", "Boomtime", "Pungenday", "Prickle-Prickle", "Setting Or=
ange"
> -};
> -
> -char *day_short[5] =3D {"SM","BT","PD","PP","SO"};
> -
> -char *season_long[5] =3D {=20
> -    "Chaos", "Discord", "Confusion", "Bureaucracy", "The Aftermath"
> -};
> -
> -char *season_short[5] =3D {"Chs", "Dsc", "Cfn", "Bcy", "Afm"};
> -
> -char *holyday[5][2] =3D {=20
> -    { "Mungday", "Chaoflux" },
> -    { "Mojoday", "Discoflux" },
> -    { "Syaday",  "Confuflux" },
> -    { "Zaraday", "Bureflux" },
> -    { "Maladay", "Afflux" }
> -};
> -
> -struct disc_time {
> -    int season; /* 0-4 */
> -    int day; /* 0-72 */
> -    int yday; /* 0-365 */
> -    int year; /* 3066- */
> -};
> -
> -char *excl[] =3D {
> -    "Hail Eris!", "All Hail Discordia!", "Kallisti!", "Fnord.", "Or not.=
",
> -    "Wibble.", "Pzat!", "P'tang!", "Frink!",
> -#ifdef PRAISE_BOB
> -    "Slack!", "Praise \"Bob\"!", "Or kill me.",
> -#endif /* PRAISE_BOB */
> -    /* randomness, from the Net and other places. Feel free to add (after
> -       checking with the relevant authorities, of course). */
> -    "Grudnuk demand sustenance!", "Keep the Lasagna flying!",
> -    "You are what you see.",
> -    "Or is it?", "This statement is false.",
> -#if defined(linux) || defined (__linux__) || defined (__linux)
> -    "Hail Eris, Hack Linux!",
> -#endif
> -    ""
> -};
> -
> -char default_fmt[] =3D "%{%A, %B %d%}, %Y YOLD";
> -char *default_immediate_fmt=3D
> -#ifdef OLD_IMMEDIATE_FMT
> -"Today is %{%A, the %e day of %B%} in the YOLD %Y%N%nCelebrate %H"
> -#else
> -default_fmt
> -#endif
> -;
> -
> -#define DY(y) (y+1166)
> -
> -static inline char *ending(int i) {
> -	return i/10=3D=3D1?"th":(i%10=3D=3D1?"st":(i%10=3D=3D2?"nd":(i%10=3D=3D=
3?"rd":"th")));
> -}
> -
> -static inline int leapp(int i) {
> -	return (!(DY(i)%4))&&((DY(i)%100)||(!(DY(i)%400)));
> -}
> -
> -/* select a random string */
> -static inline char *sel(char **strings, int num) {
> -	return(strings[random()%num]);
> -}
> -
> -void print(struct disc_time,char **); /* old */
> -void format(char *buf, const char* fmt, struct disc_time dt);
> -/* read a fortune file */
> -int load_fortunes(char *fn, char *delim, char** result);
> -
> -struct disc_time convert(int,int);
> -struct disc_time makeday(int,int,int);
> -
> -int
> -main (int argc, char *argv[]) {
> -    long t;
> -    struct tm *eris;
> -    int bob,raw;
> -    struct disc_time hastur;
> -    char schwa[23*17], *fnord=3D0;
> -    int pi;
> -    char *progname, *p;
> -
> -    progname =3D argv[0];
> -    if ((p =3D strrchr(progname, '/')) !=3D NULL)
> -	progname =3D p+1;
> -
> -    setlocale(LC_ALL, "");
> -    bindtextdomain(PACKAGE, LOCALEDIR);
> -    textdomain(PACKAGE);
> -    atexit(close_stdout);
> -
> -    srandom(time(NULL));
> -    /* do args here */
> -    for(pi=3D1; pi<argc; pi++) {
> -	switch(argv[pi][0]) {
> -	case '+': fnord=3Dargv[pi]+1; break;
> -	case '-':=20
> -	    switch(argv[pi][1]) {
> -	    case 'V':
> -		printf(_("%s (%s)\n"), progname, PACKAGE_STRING);
> -	    default: goto usage;
> -	    }
> -	default: goto thud;
> -	}
> -    }
> -
> -  thud:
> -    if (argc-pi=3D=3D3){=20
> -	int moe=3Datoi(argv[pi]), larry=3Datoi(argv[pi+1]), curly=3Datoi(argv[p=
i+2]);
> -	hastur=3Dmakeday(
> -#ifdef US_FORMAT
> -	    moe,larry,
> -#else
> -	    larry,moe,
> -#endif
> -	    curly);
> -	if (hastur.season =3D=3D -1) {
> -		printf("Invalid date -- out of range\n");
> -		return -1;
> -	}
> -	fnord=3Dfnord?fnord:default_fmt;
> -    } else if (argc!=3Dpi) {=20
> -      usage:
> -	fprintf(stderr,_("usage: %s [+format] [day month year]\n"), argv[0]);
> -	exit(1);
> -    } else {
> -	t=3D time(NULL);
> -	eris=3Dlocaltime(&t);
> -	bob=3Deris->tm_yday; /* days since Jan 1. */
> -	raw=3Deris->tm_year; /* years since 1980 */
> -	hastur=3Dconvert(bob,raw);
> -	fnord=3Dfnord?fnord:default_immediate_fmt;
> -    }
> -    format(schwa, fnord, hastur);
> -    printf("%s\n", schwa);
> -  =20
> -    return 0;
> -}
> -
> -void format(char *buf, const char* fmt, struct disc_time dt)
> -{
> -    int tib_start=3D-1, tib_end=3D0;
> -    int i, fmtlen=3Dstrlen(fmt);
> -    char *bufptr=3Dbuf;
> -
> -/*    fprintf(stderr, "format(%p, \"%s\", dt)\n", buf, fmt);*/
> -
> -    /* first, find extents of St. Tib's Day area, if defined */
> -    for(i=3D0; i<fmtlen; i++) {
> -	if(fmt[i]=3D=3D'%') {
> -	    switch(fmt[i+1]) {
> -	    case 'A':
> -	    case 'a':
> -	    case 'd':
> -	    case 'e':
> -		if(tib_start>0)	    tib_end=3Di+1;
> -		else		    tib_start=3Di;
> -		break;
> -	    case '{': tib_start=3Di; break;
> -	    case '}': tib_end=3Di+1; break;
> -	    }
> -	}
> -    }
> -
> -    /* now do the formatting */
> -    buf[0]=3D0;
> -
> -    for(i=3D0; i<fmtlen; i++) {
> -	if((i=3D=3Dtib_start) && (dt.day=3D=3D-1)) {
> -	    /* handle St. Tib's Day */
> -	    strcpy(bufptr, _("St. Tib's Day"));
> -	    bufptr +=3D strlen(bufptr);
> -	    i=3Dtib_end;
> -	} else {
> -	    if(fmt[i]=3D=3D'%') {
> -		char *wibble=3D0, snarf[23];
> -		switch(fmt[++i]) {
> -		case 'A': wibble=3Dday_long[dt.yday%5]; break;
> -		case 'a': wibble=3Dday_short[dt.yday%5]; break;
> -		case 'B': wibble=3Dseason_long[dt.season]; break;
> -		case 'b': wibble=3Dseason_short[dt.season]; break;
> -		case 'd': sprintf(snarf, "%d", dt.day+1); wibble=3Dsnarf; break;
> -		case 'e': sprintf(snarf, "%d%s", dt.day+1, ending(dt.day+1));=20
> -		    wibble=3Dsnarf; break;
> -		case 'H': if(dt.day=3D=3D4||dt.day=3D=3D49)
> -		    wibble=3Dholyday[dt.season][dt.day=3D=3D49]; break;
> -		case 'N': if(dt.day!=3D4&&dt.day!=3D49) goto eschaton; break;
> -		case 'n': *(bufptr++)=3D'\n'; break;
> -		case 't': *(bufptr++)=3D'\t'; break;
> -
> -		case 'Y': sprintf(snarf, "%d", dt.year); wibble=3Dsnarf; break;
> -		case '.': wibble=3Dsel(excl, ARRAY_SIZE(excl));
> -		    break;
> -#ifdef KILL_BOB
> -		case 'X': sprintf(snarf, "%d",=20
> -				  xday_countdown(dt.yday, dt.year));
> -				  wibble =3D snarf; break;
> -#endif /* KILL_BOB */
> -		}
> -		if(wibble) {
> -/*		    fprintf(stderr, "wibble =3D (%s)\n", wibble);*/
> -		    strcpy(bufptr, wibble); bufptr+=3Dstrlen(wibble);
> -		}
> -	    } else {
> -		*(bufptr++) =3D fmt[i];
> -	    }
> -	}
> -    }
> -  eschaton:
> -    *(bufptr)=3D0;
> -}
> -
> -struct disc_time makeday(int imonth,int iday,int iyear) /*i for input */
> -{=20
> -    struct disc_time funkychickens;
> -   =20
> -    int cal[12] =3D { 31,28,31,30,31,30,31,31,30,31,30,31 };
> -    int dayspast=3D0;
> -
> -    memset(&funkychickens,0,sizeof(funkychickens));
> -    /* basic range checks */
> -    if (imonth < 1 || imonth > 12) {
> -	    funkychickens.season =3D -1;
> -	    return funkychickens;
> -    }
> -    if (iday < 1 || iday > cal[imonth-1]) {
> -	    if (!(imonth =3D=3D 2 && iday =3D=3D 29 && iyear%4 =3D=3D 0 &&
> -		  (iyear%100 !=3D 0 || iyear%400 =3D=3D 0))) {
> -		    funkychickens.season =3D -1;
> -		    return funkychickens;
> -	    }
> -    }
> -   =20
> -    imonth--;
> -    funkychickens.year=3D iyear+1166;
> -    while(imonth>0) { dayspast+=3Dcal[--imonth]; }
> -    funkychickens.day=3Ddayspast+iday-1;
> -    funkychickens.season=3D0;
> -    if((funkychickens.year%4)=3D=3D2) {
> -	if (funkychickens.day=3D=3D59 && iday=3D=3D29)  funkychickens.day=3D-1;
> -    }
> -    funkychickens.yday=3Dfunkychickens.day;
> -/*               note: EQUAL SIGN...hopefully that fixes it */
> -    while(funkychickens.day>=3D73) {
> -	funkychickens.season++;
> -	funkychickens.day-=3D73;
> -    }
> -    return funkychickens;
> -}
> -
> -struct disc_time convert(int nday, int nyear)
> -{  struct disc_time funkychickens;
> -  =20
> -   funkychickens.year =3D nyear+3066;
> -   funkychickens.day=3Dnday;
> -   funkychickens.season=3D0;
> -   if ((funkychickens.year%4)=3D=3D2)
> -     {if (funkychickens.day=3D=3D59)
> -	funkychickens.day=3D-1;
> -     else if (funkychickens.day >59)
> -       funkychickens.day-=3D1;
> -    }
> -   funkychickens.yday=3Dfunkychickens.day;
> -   while (funkychickens.day>=3D73)
> -     { funkychickens.season++;
> -       funkychickens.day-=3D73;
> -     }
> -   return funkychickens;
> - =20
> - }
> -
> -#ifdef KILL_BOB
> -
> -/* Code for counting down to X-Day, X-Day being Cfn 40, 3164=20
> - *
> - * After `X-Day' passed without incident, the CoSG declared that it had=
=20
> - * got the year upside down --- X-Day is actually in 8661 AD rather than=
=20
> - * 1998 AD.
> - *
> - * Thus, the True X-Day is Cfn 40, 9827.
> - *
> - */
> -
> -int xday_countdown(int yday, int year) {
> -    int r=3D(185-yday)+(((yday<59)&&(leapp(year)))?1:0);
> -    while(year<9827) r+=3D(leapp(++year)?366:365);
> -    while(year>9827) r-=3D(leapp(year--)?366:365);
> -    return r;
> -}
> -
> -#endif
> diff --git a/tests/expected/build-sys/config-all b/tests/expected/build-s=
ys/config-all
> index c31bc40..e5888dd 100644
> --- a/tests/expected/build-sys/config-all
> +++ b/tests/expected/build-sys/config-all
> @@ -36,7 +36,6 @@ colrm:
>  column: =20
>  ctrlaltdel: =20
>  cytune: =20
> -ddate: =20
>  delpart: =20
>  dmesg: =20
>  elvtune: =20
> diff --git a/tests/expected/build-sys/config-all-devel b/tests/expected/b=
uild-sys/config-all-devel
> index 4b31e7e..1be319b 100644
> --- a/tests/expected/build-sys/config-all-devel
> +++ b/tests/expected/build-sys/config-all-devel
> @@ -54,7 +54,6 @@ uuidd:  libuuid
>  uuidgen:  libuuid=20
>  wipefs:  libblkid libuuid=20
>  cal:  libncursesw libtinfo=20
> -ddate: =20
>  kill: =20
>  logger: =20
>  look: =20
> diff --git a/tests/expected/build-sys/config-all-non-nls b/tests/expected=
/build-sys/config-all-non-nls
> index c31bc40..e5888dd 100644
> --- a/tests/expected/build-sys/config-all-non-nls
> +++ b/tests/expected/build-sys/config-all-non-nls
> @@ -36,7 +36,6 @@ colrm:
>  column: =20
>  ctrlaltdel: =20
>  cytune: =20
> -ddate: =20
>  delpart: =20
>  dmesg: =20
>  elvtune: =20
> diff --git a/tests/expected/build-sys/config-devel b/tests/expected/build=
-sys/config-devel
> index a2e0411..cb7fad3 100644
> --- a/tests/expected/build-sys/config-devel
> +++ b/tests/expected/build-sys/config-devel
> @@ -36,7 +36,6 @@ colrm:
>  column: =20
>  ctrlaltdel: =20
>  cytune: =20
> -ddate: =20
>  delpart: =20
>  dmesg: =20
>  elvtune: =20
> diff --git a/tests/expected/build-sys/config-devel-new-mount b/tests/expe=
cted/build-sys/config-devel-new-mount
> index 74c35c7..7e83630 100644
> --- a/tests/expected/build-sys/config-devel-new-mount
> +++ b/tests/expected/build-sys/config-devel-new-mount
> @@ -56,7 +56,6 @@ uuidgen:  libuuid
>  wipefs:  libblkid libuuid=20
>  blkid.static: STATIC
>  cal:  libncursesw libtinfo=20
> -ddate: =20
>  kill: =20
>  logger: =20
>  look: =20
> diff --git a/tools/checkmans.sh b/tools/checkmans.sh
> index e54ebed..4b149d0 100755
> --- a/tools/checkmans.sh
> +++ b/tools/checkmans.sh
> @@ -39,7 +39,7 @@ trap "rm -f ${ERROR_FILE}" 0
> =20
>  for I in $(
>  	find $(git rev-parse --show-toplevel) -name '*.[1-8]' |
> -	egrep -v '(Documentation|.git|/.libs/|autom4te.cache|ru/ddate)'
> +	egrep -v '(Documentation|.git|/.libs/|autom4te.cache)'
>  ); do
>  	# FIXME: the determination whether a manual does include
>  	# should probably be somewhat smarter.
> --=20
> 1.7.12.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlByl6AACgkQnZxG0T6qDD3f5ACfUvvyY5V+aSfglj2/E2jHeev6
DCkAn2kCQCwGkfJY9CBlgfjAZki1cmyy
=nsKX
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
