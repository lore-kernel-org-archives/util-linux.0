Return-Path: petr.uzel@suse.cz
Date: Wed, 23 May 2012 10:23:53 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/4] last: use min() from c.h
Message-ID: <20120523082353.GD3705@foxbat.suse.cz>
References: <1337240469-24539-1-git-send-email-petr.uzel@suse.cz>
 <20120523081302.GJ14560@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
In-Reply-To: <20120523081302.GJ14560@x2.net.home>
List-ID: <util-linux.vger.kernel.org>


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2012 at 10:13:02AM +0200, Karel Zak wrote:
> On Thu, May 17, 2012 at 09:41:06AM +0200, Petr Uzel wrote:
> >  login-utils/last.c |   10 +++-------
> >  1 files changed, 3 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/login-utils/last.c b/login-utils/last.c
> > index 34558bb..62fc55c 100644
> > --- a/login-utils/last.c
> > +++ b/login-utils/last.c
> > @@ -72,15 +72,11 @@ static struct utmp	utmpbuf;
> >  #define	LMAX	(int)sizeof(utmpbuf.ut_line)	/* size of utmp tty field */
> >  #define	NMAX	(int)sizeof(utmpbuf.ut_name)	/* size of utmp name field */
> > =20
> > -#ifndef MIN
> > -#define MIN(a,b)	(((a) < (b)) ? (a) : (b))
> > -#endif
> > -
> >  /* maximum sizes used for printing */
> >  /* probably we want a two-pass version that computes the right length =
*/
> > -int hmax =3D MIN(HMAX, 16);
> > -int lmax =3D MIN(LMAX, 8);
> > -int nmax =3D MIN(NMAX, 16);
> > +int hmax =3D min(HMAX, 16);
> > +int lmax =3D min(LMAX, 8);
> > +int nmax =3D min(NMAX, 16);
>=20
>  Please, test your patches... you cannot use min() (as defined in c.h)
>  outside functions.

Oops, I normally do, but this one seemed so trivial that I did not
test it :( Lesson learned. Sorry.

>  It seems that {h,l,n}max are not modified in the code so we can use
>  macros there. Applied the patch below.

Thanks,

        Petr

>=20
>     Karel
>=20
>=20
>=20
> From 69c9e8387b90025d1f75356f5e2369d0262ee603 Mon Sep 17 00:00:00 2001
> From: Karel Zak <kzak@redhat.com>
> Date: Wed, 23 May 2012 10:07:57 +0200
> Subject: [PATCH] last: use min() from c.h
>=20
> Signed-off-by: Karel Zak <kzak@redhat.com>
> ---
>  login-utils/last.c |   20 ++++++++------------
>  1 files changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/login-utils/last.c b/login-utils/last.c
> index 34558bb..1b1bee1 100644
> --- a/login-utils/last.c
> +++ b/login-utils/last.c
> @@ -72,15 +72,11 @@ static struct utmp	utmpbuf;
>  #define	LMAX	(int)sizeof(utmpbuf.ut_line)	/* size of utmp tty field */
>  #define	NMAX	(int)sizeof(utmpbuf.ut_name)	/* size of utmp name field */
> =20
> -#ifndef MIN
> -#define MIN(a,b)	(((a) < (b)) ? (a) : (b))
> -#endif
> -
>  /* maximum sizes used for printing */
>  /* probably we want a two-pass version that computes the right length */
> -int hmax =3D MIN(HMAX, 16);
> -int lmax =3D MIN(LMAX, 8);
> -int nmax =3D MIN(NMAX, 16);
> +#define P_HMAX	min(HMAX, 16)
> +#define P_LMAX	min(LMAX, 8)
> +#define P_NMAX	min(NMAX, 16)
> =20
>  typedef struct arg {
>  	char	*name;				/* argument */
> @@ -187,19 +183,19 @@ print_partial_line(struct utmp *bp) {
>      char *ct;
> =20
>      ct =3D utmp_ctime(bp);
> -    printf("%-*.*s  %-*.*s ", nmax, nmax, bp->ut_name,=20
> -	   lmax, lmax, bp->ut_line);
> +    printf("%-*.*s  %-*.*s ", P_NMAX, P_NMAX, bp->ut_name,
> +	   P_LMAX, P_LMAX, bp->ut_line);
> =20
>      if (dolong) {
>  	if (bp->ut_addr) {
>  	    struct in_addr foo;
>  	    foo.s_addr =3D bp->ut_addr;
> -	    printf("%-*.*s ", hmax, hmax, inet_ntoa(foo));
> +	    printf("%-*.*s ", P_HMAX, P_HMAX, inet_ntoa(foo));
>  	} else {
> -	    printf("%-*.*s ", hmax, hmax, "");
> +	    printf("%-*.*s ", P_HMAX, P_HMAX, "");
>  	}
>      } else {
> -	printf("%-*.*s ", hmax, hmax, bp->ut_host);
> +	printf("%-*.*s ", P_HMAX, P_HMAX, bp->ut_host);
>      }
> =20
>      if (doyear) {
> --=20
> 1.7.7.6
>=20

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+8npkACgkQnZxG0T6qDD1u5QCfSIiR8Vl6olIkwJlHm/yz2v0y
YI4An2h+q9jrorEIKJLZl8sdqCkP4hb0
=wqno
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
