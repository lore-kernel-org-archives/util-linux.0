Return-Path: vapier@gentoo.org
Date: Sat, 10 Dec 2016 12:15:10 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Message-ID: <20161210171510.GH10558@vapier.lan>
References: <20161019132505.cumn37cmgazlumcu@ws.net.home>
 <201610201225.31755.sweet_f_a@gmx.de>
 <20161020110003.if5kjodyjqezynzp@ws.net.home>
 <201610201334.24945.sweet_f_a@gmx.de>
 <20161020151948.3y47rv5lwmqppubf@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x9NlMAausKqHAFUv"
In-Reply-To: <20161020151948.3y47rv5lwmqppubf@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--x9NlMAausKqHAFUv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20 Oct 2016 17:19, Karel Zak wrote:
> On Thu, Oct 20, 2016 at 01:34:24PM +0200, Ruediger Meier wrote:
> > For me it looks like the even the ncurses authors do not like their own=
=20
> > pc files. Disabled by default and it's a pain to get them built with=20
> > correct names and installed in the right location. Even --prefix does=
=20
> > not work for their pc files. Plus the backward compatibility=20
> > problem ...=20
>=20
> OK, I have applied:
>    https://github.com/karelzak/util-linux/commit/e5cc93b5a8854fce80537f86=
a244977df212dcb5
>=20
> with ncurses-config and fallback to old good AC_CHECK_LIB.=20
>=20
> We can add fallback to pkg-config too, but it sounds like overkill if
> ncurses-config is everywhere.

ugh, this change makes things worse.  the point of using pkg-config
is also to get sane cross-compiling.  by always running `xxx-config`,
it now breaks cross-compiling.

why can't we just tell distros to fix their ncurses install ?  it's
not like 2.29, released a month ago, is getting rolled out to old
distros where people can't update their ncurses systems.

"it's hard" is a pretty weak argument for distro maintainers.
-mike

--x9NlMAausKqHAFUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYTDgeAAoJEEFjO5/oN/WBIQkP/iF+h1FovNOYgZEeNT4N9Cc/
iqrHqS3cIZMK2ogRQyzIQyu5cjyUx5L3Nwgh6250Oc6fc1vHMUXC6KEsZuBv4/hT
DqnphzpebJ6DiitBF+/r+dWEwP4VkKlyUZW+FWZHtT83yBLrW3l7ExaaB85iweD/
XMd5RakFlqoxgb6Ggp2JSiPw3MhZwhVIf1eO2LkSeKDIgSFLaNpAOeszEVBnm5ae
DoTbG7dywwUZ1iiShnTOzVhXs/kcMC7DTlI8WEJUEKTkndlfgy3twDy1+BAnFkZe
KfHCI6m9SQKOuvFu6vsBhHq58zH4OhLeIVk3xeMk8/uauyGNvAe2TTqAnu5ngUgD
p10WpahnSxeJMB0c9OhvIDt7pBtKAT/lxfq+J50mMdZ2TOfYxm/ct15ONnFG1ebV
h6xSpX8gE0CkHJhKdeGvBWBH02DbumXXs/uNO2Q9/OulHkQo2qVcaWQGAtOL4I1B
jeyoOx0QB4sSEXjRr4TB5a4P3SAAwDqx0Cm/jEyU+U8HEClNQbkF8Nty7wuEtV5E
+iz/or3MSjSp41DA0Vk9ifpzdeDVIQKH4xp11eNKhe1Xk8HxXCyZQSppU1+2JeXg
udx3No8mJx5XKmfJGzj44mGicvZPxJ+ErsFZXMcPfcOFjwP3mmrMYJulWTk1Jux8
aHxHbQKTf87I2a8B5Coq
=BO8I
-----END PGP SIGNATURE-----

--x9NlMAausKqHAFUv--
