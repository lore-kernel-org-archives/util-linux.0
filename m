Return-Path: vapier@gentoo.org
From: Mike Frysinger <vapier@gentoo.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] conifigure: add a crosscompile path for scanf_cv_alloc_modifier
Date: Fri, 30 Mar 2012 15:49:37 -0400
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <1330103768-32139-1-git-send-email-bigeasy@linutronix.de> <20120228141226.GC22034@x2.net.home> <20120229213128.GA11628@linutronix.de>
In-Reply-To: <20120229213128.GA11628@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3287922.nbqaulRsmD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201203301549.39151.vapier@gentoo.org>
List-ID: <util-linux.vger.kernel.org>

--nextPart3287922.nbqaulRsmD
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On Wednesday 29 February 2012 16:31:28 Sebastian Andrzej Siewior wrote:
> My earlier assumption was that scanf_cv_alloc_modifier is unused. This
> is not true as pointed out by Karel since it used befoe checking for
> libmount. Argh. So instead saying no I add a test to check for glibc
> >=3D 2.7 which provides %m. As of uClibc v0.9.32-rc3 the situation looks
> the following:

the uClibc code you grepped for is printf("%m"), not scanf("%ms")

uClibc itself has a place holder for %as, but has never implemented it sinc=
e=20
it conflicts with C99.  and it hasn't gotten around to implementing the new=
 %ms=20
which is specified by the latest POSIX spec.

be nice if this patch was in 2.21.1, but i guess that ship has sailed, and=
=20
there prob won't be a 2.21.2 ...
=2Dmike

--nextPart3287922.nbqaulRsmD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPdg5TAAoJEEFjO5/oN/WBQ0AP/jHFbRQlvESMdS9oWvksQNIq
2D+xprJEAux79M9RASAzVhTiqPtISFoZ7jXV+Q4ygaeHh5ENpwO7R+bEIq9sQ2JD
k+DgNq8vSWQxzvO3juS93+Tfk2l/83BTX1dq3XVPa+yDWORc2Yp0tTcTqeUxMv2w
hGJ08NILm1n2yhiPwIRB/rBjtIIKY+nsSoHF15b6JQv7edupL8PSHXQ54hYwYxax
TNEyqagfYQekSzoGrnjtTL7ZStWxsKXrPoxS/bERyFMkkjCPZX8pNiZ5q8zsKfmr
bLW8WsMje+m9ygmKKDKpEoI+dCPY3sbdOs8wk5+DGjN0yJSGCyhd1ZuWy0XDQ5Q+
iSTk0hbncM4tO0xOFWsI8kW7l6iPcdXsXNF/CySqM6bQbxu2P/V0EH4HX7/FypbC
d1Uy7uhQ9YS6XVLh8IW4CfQnCyFdxwhEU+4X2vA4iaXyTyS07N5fx6GyOiDaGwB5
U2AagVWqDLaDo3wHlaohGESNO1XNkXpQE1p3ebbxQmw6rMbFfp3+R7/xDU/VdxsO
1C5XXgeheBGTKts1Lg8PvIPtkgnGEg3ar2B8zZaH4PfkFc9cxJK4EKKGQK49nXO2
rSYrXvouyyF8/L0iED20gEA5V6+HPH+ftlKJmd3N9ibYufRI0ptnwkN5koFIujLI
NNz2kB6+Pxw98o1ieqqG
=kRDj
-----END PGP SIGNATURE-----

--nextPart3287922.nbqaulRsmD--
