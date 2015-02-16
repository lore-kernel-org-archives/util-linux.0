Return-Path: vapier@gentoo.org
Date: Mon, 16 Feb 2015 05:48:48 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: Phillip Susi <psusi@ubuntu.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: libsmartcols patch
Message-ID: <20150216104848.GK4075@vapier>
References: <54A0AE98.70503@ubuntu.com>
 <20150216050053.GA4075@vapier>
 <20150216102726.GH11948@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+RZeZVNR8VILNfK"
In-Reply-To: <20150216102726.GH11948@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--x+RZeZVNR8VILNfK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16 Feb 2015 11:27, Karel Zak wrote:
> On Mon, Feb 16, 2015 at 12:00:53AM -0500, Mike Frysinger wrote:
> > On 28 Dec 2014 20:30, Phillip Susi wrote:
> > > --- libsmartcols/src/table_print.c	2014-12-24 23:59:55.780110296 +0200
> > > +++ libsmartcols/src/table_print.c	2014-12-28 22:45:20.347285226 +0200
> > > =20
> > > +	assert(ln);
> > > +	assert(buf);
> >=20
> > general note: libraries should never assert/abort/exit.
>=20
>  what about segfault?

that's a red herring.  you can't guarantee your codebase is bug free, but t=
hat=20
doesn't mean encouraging a policy of committing suicide is a good thing.

>  We use assert to detect fatal internal library bugs, for mistakes in
>  applications (e.g. incomplete arguments) it returns -EINVAL.

libsmartcols/src/table_print.c:
int scols_print_table(struct libscols_table *tb)
{
=2E..
    assert(tb);
    if (!tb)
        return -1;

looks like over-eagerness has already broken the public API ;).

>  Its' possible to remove CONFIG_LIBSMARTCOLS_ASSERT from smartcolsP.h,
>  but I don't think the library is already well tested.

odd ... why is that reimplementing the wheel ?  the standard assert.h alrea=
dy=20
supports NDEBUG for turning off asserts.

i see there's a bunch of such knobs in the codebase.  time for a=20
--{en,dis}able-asserts configure flag ?  you could delete all the existing=
=20
CONFIG_xxx_ASSERT defines and simply rely on configure adding -DNDEBUG to=
=20
CPPFLAGS.
-mike

--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU4csQAAoJEEFjO5/oN/WBSdEP+gKExRPfhIx4fdb0Gnr2MgXF
PIIQIad/bG0+6kRWLwjCD+VrK0nsuOaafXIePVb8r68jqJ3LFGXGjRyheiCzgYpm
Cwl8YC9/wfViK1ieOvQgMJo1N8InpZDbCXtWBNI37kk6Clpn3+ujH8jcFgohOT3J
IWiPk9JR3QZF0+ooUBJAkjej3oz4H4XiXfu9JJpzl84GExTZIwOo59sLbzJwO8PZ
zCWD9opfiizRTiT/7STh5fFwK0MxE6q1Z4BtsVAnswaY3TVMh1zL9eZOZ4kGTzkE
Fn2rRngIUmeSlw5TA/7opZguYyGSV9qvKno4rKZ4Rc13HRc0puD2/b9Re7A31Cry
tPW1O+uDaJx6acvSFUYNcvEsiwtJ9hrJpeDlQ/2fPizNNyi3RRYRBqg29fC0+u66
qbYa99qk+AQIyuvwBsVqLdreSKnUSW7KcDk71im67GSkTkHRQeF+2RJb6hIYL2eN
xROQLuvWBf59H/bBFx4lD/iYxGz3ajDDEycMVH6Bdov2DjvkFMBJOpMxeUk8QM5s
yj8W/KyZMoBrf6arikItiZv8QfPS7bFoPKrUP7AdbDiJBsPBeSEkT5HGvaCmEMB8
SZtN0i+xYxvq0BvJ8q5zncQWoYjKgNvV+L52mhlbaH9HNlUNF3vNVQYbkS4emBV5
kZELbB5MGzfEiEk40YIx
=5V/U
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
