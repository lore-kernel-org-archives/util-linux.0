Return-Path: vapier@gentoo.org
Date: Sun, 15 Feb 2015 06:12:38 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, "Dale R. Worley" <worley@alum.mit.edu>,
        =?utf-8?Q?P=C3=A1draig?= Brady <P@draigbrady.com>,
        mrmazda@earthlink.net, util-linux <util-linux@vger.kernel.org>
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
Message-ID: <20150215111238.GG32251@vapier>
References: <54DC88BF.5040702@draigBrady.com>
 <87h9uqv6lv.fsf@hobgoblin.ariadne.com>
 <20150213092131.GM32318@ws.net.home>
 <CAG27Bk0JrVSbKEBqeEr63O4cz3B5zyDmGw_MFVzXYTbWjZ2URQ@mail.gmail.com>
 <20150213112523.GP32318@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
In-Reply-To: <20150213112523.GP32318@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13 Feb 2015 12:25, Karel Zak wrote:
> On Fri, Feb 13, 2015 at 10:33:23AM +0000, Sami Kerola wrote:
> > On 13 February 2015 at 09:21, Karel Zak <kzak@redhat.com> wrote:
> > > On Thu, Feb 12, 2015 at 10:21:48PM -0500, Dale R. Worley wrote:
> > >> I don't particularly like colorization.  But technically, it seems t=
o me
> > >> that what is needed is a systematic way for the user to indicate his
> > >> colorization preferences to *all* utilities.  And a corresponding way
> > >> for the system to provide defaults for those user preferences.
> > >>
> > >>
> > >> Only when there is a systematic framework for colorization will all =
the
> > >> programs allow colorizing to be configured.
> > >
> > > It would be possible to create a shared library from our lib/colors.c
> > > to support terminal-colors.d/... :-)
> >=20
> > Or add the needed to ncurses. Isn't that better than adding a new
> > library?
>=20
> you want to link programs like dmesg, gcc or ls with ncurses monster?
>=20
> The another story is that ncurses provides completely abstract layer
> for colors and I didn't found a way how to use it together with color=20
> escape sequences. This is reason why for example cfdisk supports only
> enable/disable terminal-colors.d feature, but no schemes to specify
> colors.

this is why ncurses has the ability to split its lib into a smaller libtinf=
o. =20
you get all the logic for detecting terminal capabilities without all the r=
est=20
of the ncurses layers.  for people who do want to kill colors across the bo=
ard,=20
they can use a different TERM that does not support them.  forcing people t=
o=20
duplicate that in a new database seems wrong to me.
-mike

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU4H8mAAoJEEFjO5/oN/WBJaQQAMItqwIVanb6eDwW7nhjUqWP
rlkJa9d7ufjr+V01Zu6m15P2WM2fFhlfoqVXbbZyugwXbSqSd3RzK9xZqzrLdP/k
f31dauzCkqSwsvkfcD+EognsZzPS3TUDcFUHMqcrttVD9b8GLik6UHNXWu5ytGtf
fMmIM7LM9MUA263AWaRaBWrpN5MmLd9yvQ/PVbDrEF3q6o7Ye0ltOOK5JW2pcQK/
YDfz8JFgqNjLFk9wlp0ex1xOyOR1ZiaXIvmsqrJqW/eMqgmTBeIGJVHHmdkaHeGY
KgP7aOFtycT29K7nvlDCz+uPd8/Bayx60OxN/tSAsIgexRu7GDoEpKHGNtgPh+fM
bCWHY6LolxtERoB+zSF4GguUdSqEqHYNQDaMz14fTbRs00cneDgW1p2DLje03Utb
wtRgcrTXMYrTNnPdaqV9W8T6MlnYz8QIQlzn3ngjlzj6RCB5MmLsvn57/Xr8we5e
IRyViqAphgkLz0AGpIwwAs/U6XExhf4F0oOjX6A7yuWOKVJAjjtJpDcIvze5jId1
5x0Wq7V26KJWBwvyGliAeqOFxQ+whiJC3rq00P2go8Q/BhZCH5pFiqFBoyYy3mhZ
v+82djhSpEBh146eW6y+CGLzIUjtyqUIuy3fYwENU5tVrutgw2TqAKsLvICxNFzD
Kj8zmQkW+Hrfp9CNrysK
=m9M9
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--
