Return-Path: vapier@gentoo.org
Date: Wed, 24 Jan 2018 23:23:03 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mount(8): drop redundant filesystem-specific sections
Message-ID: <20180125042303.GD1718@vapier>
References: <20180119184520.13067-1-vapier@gentoo.org>
 <20180122090110.vu2vbfm4wvoloime@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
In-Reply-To: <20180122090110.vu2vbfm4wvoloime@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22 Jan 2018 10:01, Karel Zak wrote:
> On Fri, Jan 19, 2018 at 01:45:20PM -0500, Mike Frysinger wrote:
> > -.SS "Mount options for tmpfs"
> > -.TP
> > -.BI size=3D nbytes
> > -Override default maximum size of the filesystem.
> > -The size is given in bytes, and rounded up to entire pages.
> > -The default is half of the memory.  The size parameter also accepts a =
suffix %
> > -to limit this tmpfs instance to that percentage of your physical RAM:
> > -the default, when neither size nor nr_blocks is specified, is size=3D5=
0%
>=20
> The "man tmpfs" describes the option size=3D only. There is no
> nr_blocks=3D, mode=3D, uid=3D, gid=3D and mpol=3D. Is it expected? Maybe =
we a
> patch to man-pages too.

i meant to send a patch to make sure man-pages had everything.
i'll get around to it ;).
-mike

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAlppW6YACgkQQWM7n+g3
9YGz6BAAivD2S/yQZ/Wsz7VGliqwUi4gMx9RmkTprYpSJo1szLLA2bg34a21nW7O
Ckxber5GJDGvHE2VeeAzH2VGjPwJJkzDDdZKhNW7QGDZ53YYIzruPLa/ey9QMx77
JCdTU45UkNCyWwruLAgQh6Cw0npBkeOYGCJM8A9QTXtnufCIDxiP5+kZsLB2uQBc
u5fjP9F9lUbSe7ibX3KM8ZJ5zytVYnDo6AV2UwtUJWMfYlZsQzOX2kc99f8vR1fn
JD0r7jc3h80ZldXgWkrs883NSH5fxCCSiYbFxWu3riKpYdza+QTGCAj0ujrrBvOx
tN2yozy8b5baAdhc3cVyyFdr4Gr81czoZve/W317c2+PtsgwMm7b7paW0voWl4Y9
Qi6Vqzv5UKUoLDefh/cT2WmuWjV8EgJlzhiCCHChXiKh54LJnw29IiTkvKvZV4d/
GpJNjb+OhmcBctW2VwSsRts32ZdlsP8NPgJ02KWfDW629cYmTZCNekXGYFvH/jH9
QBzWBYtAYpDE6QxDyazgXhknVvVAej1vaoibzFl7avfAYOMNqnT2u0Hd83xYd7Hu
/LWfiBOdqKbHwifbmb3H7rzsKu6VAFJWKRqfVnsrd47imuom3Y4eyQePxqYaKVII
+NFYzA5HGYHkzzHiCbAtOgGwAgDEj+xM8lq57DG+F8UyWVUonsI=
=fwVf
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
