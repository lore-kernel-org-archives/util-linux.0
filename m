Return-Path: vapier@gentoo.org
Date: Mon, 16 Feb 2015 04:35:33 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, "Dale R. Worley" <worley@alum.mit.edu>,
        =?utf-8?Q?P=C3=A1draig?= Brady <P@draigbrady.com>,
        mrmazda@earthlink.net, util-linux <util-linux@vger.kernel.org>
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
Message-ID: <20150216093533.GJ4075@vapier>
References: <54DC88BF.5040702@draigBrady.com>
 <87h9uqv6lv.fsf@hobgoblin.ariadne.com>
 <20150213092131.GM32318@ws.net.home>
 <CAG27Bk0JrVSbKEBqeEr63O4cz3B5zyDmGw_MFVzXYTbWjZ2URQ@mail.gmail.com>
 <20150213112523.GP32318@ws.net.home>
 <20150215111238.GG32251@vapier>
 <20150216091043.GA11948@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
In-Reply-To: <20150216091043.GA11948@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16 Feb 2015 10:10, Karel Zak wrote:
> On Sun, Feb 15, 2015 at 06:12:38AM -0500, Mike Frysinger wrote:
> > On 13 Feb 2015 12:25, Karel Zak wrote:
> > > On Fri, Feb 13, 2015 at 10:33:23AM +0000, Sami Kerola wrote:
> > > > On 13 February 2015 at 09:21, Karel Zak <kzak@redhat.com> wrote:
> > > > > On Thu, Feb 12, 2015 at 10:21:48PM -0500, Dale R. Worley wrote:
> > > > >> I don't particularly like colorization.  But technically, it see=
ms to me
> > > > >> that what is needed is a systematic way for the user to indicate=
 his
> > > > >> colorization preferences to *all* utilities.  And a correspondin=
g way
> > > > >> for the system to provide defaults for those user preferences.
> > > > >>
> > > > >>
> > > > >> Only when there is a systematic framework for colorization will =
all the
> > > > >> programs allow colorizing to be configured.
> > > > >
> > > > > It would be possible to create a shared library from our lib/colo=
rs.c
> > > > > to support terminal-colors.d/... :-)
> > > >=20
> > > > Or add the needed to ncurses. Isn't that better than adding a new
> > > > library?
> > >=20
> > > you want to link programs like dmesg, gcc or ls with ncurses monster?
> > >=20
> > > The another story is that ncurses provides completely abstract layer
> > > for colors and I didn't found a way how to use it together with color=
=20
> > > escape sequences. This is reason why for example cfdisk supports only
> > > enable/disable terminal-colors.d feature, but no schemes to specify
> > > colors.
> >=20
> > this is why ncurses has the ability to split its lib into a smaller lib=
tinfo. =20
> > you get all the logic for detecting terminal capabilities without all t=
he rest=20
> > of the ncurses layers.  for people who do want to kill colors across th=
e board,=20
> > they can use a different TERM that does not support them.  forcing peop=
le to=20
> > duplicate that in a new database seems wrong to me.
>=20
>  What we want to duplicate? What exactly in lib/colors.c is duplicate?
>  The code evaluates filenames and parses files with "name colorcode".

whether the terminal even supports color in the first place.  if i picked a=
=20
terminal that doesn't support color so i didn't have to worry about it, it'=
s a=20
bit crazy i also have to go to multiple config files and also tell them i d=
on't=20
want color otherwise i get corrupted output.
-mike

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU4bnlAAoJEEFjO5/oN/WBoJYQAJCxZ+evwKmIApSAxzucWlMG
sVSGQ1N0u0W5UZ5LCDemM9dLN7HEvxoiIkwpZ5A/1adgtKf5wPInwEMraAyRw8YH
Ws5/OHpOQrC4zAugFCRU4RzA4BdznlenXwR5Y9j/858Jkp6t30ZpbtdgNbQHt1Bs
wfxanU7KXxqa7bOvjHNX30ZT1S7UYCVlYcQ684+IQTvPj2hhbPsS8sc8iaRri4jG
CesL6AupilH5eAWE9nUwFOlOWP8VJPoQZrREMZoWu31I+pQi2ZZJw3b14SLA4TAL
UZ/vs0l9HLkaPI0tqEXgTqBZcT+TgIjCtVtBMxNcGTn/PgkGkjeSabdUGtwt9fRM
7d7KXQtT0hFdRDwm7ltZDMJ+LURHeiH+OFyhg4uTE4LQsPOzxQ/0PX2nZ31/z5A1
iq5JGbspeb/nKmSrETu8k4ZERIfuvGb7RoF310MVcIzSN55FEVrMmy4qA9S4jIm8
RP1ccpqKkI223E+YcbMEwMjfV0XvwLdnNgbwu3eHUvmhTk4Hnu4RIrlftCkUdP6X
LeBC4ZVYO5c51NtGRl7umG1S+L8q3/IzOocnjhIxHI5UzJljGS/LS/56oMXiVyhg
49E2GGfMmNUJhZ8tNKCLTf8YkwvQ23P6+eSMOrn+lU02QRkSps4g9ZEce9sUMAd4
JWixGI7b9ubFJwfA1vdn
=gC14
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
