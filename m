Return-Path: vapier@gentoo.org
Date: Mon, 12 Dec 2016 12:52:19 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Message-ID: <20161212175219.GP10558@vapier.lan>
References: <20161019132505.cumn37cmgazlumcu@ws.net.home>
 <20161020151948.3y47rv5lwmqppubf@ws.net.home>
 <20161210171510.GH10558@vapier.lan>
 <201612121501.57462.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oNVW4gaiVGQBzhrj"
In-Reply-To: <201612121501.57462.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>


--oNVW4gaiVGQBzhrj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12 Dec 2016 15:01, Ruediger Meier wrote:
> On Saturday 10 December 2016, Mike Frysinger wrote:
> > On 20 Oct 2016 17:19, Karel Zak wrote:
> > > On Thu, Oct 20, 2016 at 01:34:24PM +0200, Ruediger Meier wrote:
> > > > For me it looks like the even the ncurses authors do not like
> > > > their own pc files. Disabled by default and it's a pain to get
> > > > them built with correct names and installed in the right
> > > > location. Even --prefix does not work for their pc files. Plus
> > > > the backward compatibility problem ...
> > >
> > > OK, I have applied:
> > >  =20
> > > https://github.com/karelzak/util-linux/commit/e5cc93b5a8854fce80537
> > >f86a244977df212dcb5
> > >
> > > with ncurses-config and fallback to old good AC_CHECK_LIB.
> > >
> > > We can add fallback to pkg-config too, but it sounds like overkill
> > > if ncurses-config is everywhere.
> >
> > ugh, this change makes things worse.  the point of using pkg-config
> > is also to get sane cross-compiling.  by always running `xxx-config`,
> > it now breaks cross-compiling.
>=20
> Works for me, when adding the ncurses5-config to the PATH
> $ /usr/i686-w64-mingw32/sys-root/mingw/bin/ncurses5-config  --libs
> -L/usr/i686-w64-mingw32/sys-root/mingw/lib -lncurses -ltinfo

don't take this the wrong way (seriously, it's not personal or anything),
but this statement implies you don't cross-compile regularly (or at all).
this hack doesn't scale at all and is a horrible horrible idea.  the fact
that you managed to execute an arbitrary shell script is irrelevant here.

> > why can't we just tell distros to fix their ncurses install ?  it's
> > not like 2.29, released a month ago, is getting rolled out to old
> > distros where people can't update their ncurses systems.
>=20
> I guess we should better fix ncurses upstream, to avoid having ncurses=20
> packages on any distros broken in different ways.

working with upstream ncurses to get better/smoother defaults is always
a good idea.  but that doesn't lead into the next point.

> > "it's hard" is a pretty weak argument for distro maintainers.
>=20
> No, no. This was about installing plain ncurses as a normal user=20
> (./configure --prefix ...). If upstream does not provide .pc files by=20
> default then we should not rely on them. You can't blame users nor=20
> package maintainers for installing a lib in a way like upstream=20
> recommends.

sure i can.  distro maintainers have like one job: maintain a distro.
the fact that they have to read the docs and configure options to get
a build with pc files isn't exactly onerous.

as for users building their own distro, that's pretty uncommon.  there
are a lot of ways you could play that angle in (wrongly) trying to make
the build system cater to their mistakes.  why should every random pkg
out there duplicate this kind of logic ?

that said, i'm not advocating for *requiring* pc files.  if util-linux
wants to support a *fallback* of executing the old config scripts, that
is fine.  but it shouldn't be to the detriment of properly configured
systems that have sane pc files available.
-mike

--oNVW4gaiVGQBzhrj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYTuPSAAoJEEFjO5/oN/WBQf0P/3MvlyQK8EeHFZe3Nqr4CXQE
+OdMESXvAz7G6/fPE1+jgCMg6XZ886YIWaImD1KOBlBqAkybvk+6jgzZ2xu09OYh
NudOen3sF5EFqC/saRkjhB29tNNyZV83FLXFEjxjvtWZqabCdr325RxUqo5aDsK5
LOy9eC0rc4rwk+wrO0OI9ZlVwEAJjajzFHtU7AgjuwOpR43LzGTSP+k08wEjuYIg
Xn6jmDE3TvIvOuEIZ8I7pRytLnm6UGjRpdLyKbmPNWkszaNcOPojFBtPsCpMP2/V
Ixy7g2YRrtdAigddBxymoprYF+blrNRNg88k5PHnmwebc0PJsf6l5fYAwzFDPlBC
BK/8YHQD/UuWiqajcpCUuTh+dcCOOjDWvFTg+L6LiqLokg5MN4OKVDjMiZX9bRoF
rnpjBK1PmSIlfibOKI7oUQrXaNls7HFYCELZDzYDlwtzsZYL9iUxsT9e5InHQL9V
+eyQpH2V7JjvroR3SGbRTLCZSirhx3CXjrbgGTSV9z133vC/UC+blaCYS8KzMcAN
ks3fFCs6DatIHM0PAvsqZBncbDZ4Ekmpr6+rxR+zLG6qBFqqEivdnVyMmvhX2Ejm
iUV4sjmS0jB6YqLKb/CVBNeR8Y2kJflkZCjUmEzUBL7ew7rSIjLQQ1iuEYSOM1Z8
Xk0XVJUNAvBOwZyykS8e
=Tuhf
-----END PGP SIGNATURE-----

--oNVW4gaiVGQBzhrj--
