Return-Path: vapier@gentoo.org
Date: Fri, 19 Jan 2018 13:21:23 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: Carlos Santos <casantos@datacom.ind.br>, util-linux@vger.kernel.org
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
Message-ID: <20180119182123.GK28967@vapier>
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
 <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
 <20170801072017.yl7mgv64pq7ccj5e@ws.net.home>
 <20180119024717.GJ7217@vapier>
 <20180119094051.g3qztrrqf5guife5@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fjEAjMKpll6GDq3U"
In-Reply-To: <20180119094051.g3qztrrqf5guife5@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--fjEAjMKpll6GDq3U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19 Jan 2018 10:40, Karel Zak wrote:
> On Thu, Jan 18, 2018 at 09:47:17PM -0500, Mike Frysinger wrote:
> > On 01 Aug 2017 09:20, Karel Zak wrote:
> > > On Mon, Jul 31, 2017 at 09:46:39PM -0300, Carlos Santos wrote:
> > > > > From: "Carlos Santos" <casantos@datacom.ind.br>
> > > > > To: util-linux@vger.kernel.org
> > > > > Sent: Monday, July 31, 2017 9:12:03 PM
> > > > > Subject: Problem building util-linux without a separate ncursesw =
include dir
> > > >=20
> > > > > of util-linux. Would it be possible to make the location of ncurs=
esw
> > > > > headers configurable, instead?
> > >=20
> > > We test for alone ncurses.h and term.h in the for non-wide ncurses.
> > > Can you send output from your configure from the current master
> > > branch (or v2.30.1)?
> > >=20
> > > > I was thinking on something simple, like https://pastebin.com/VqM9G=
9yu
> > >=20
> > > Hmm, but you don't distinguish between wide and non-wide ncurses.
> >=20
> > why don't we just support ncurses's pkg-config files as the default ?
> > $ pkg-config --cflags ncurses
> > -D_GNU_SOURCE
> > $ pkg-config --cflags ncursesw
> > -D_GNU_SOURCE -I/usr/include/ncursesw
>=20
> because pkg-config is not supported by ncurses upstream by default and
> it's not always the best solution.

you mean upstream's configure script doesn't default it to on.  distros
can (and many do) simply pass --enable-pc-files to get them.  but i don't
see how that's relevant to preference when it comes to detection.

> See commit 4c12a334dc4104d16dc06edf51904b08b08fcdfa.

seems like that's trivial to resolve with a compile test rather than
throwing it all out.  xxx-config scripts provide bad defaults when you
cross-compile because now the user has to make sure the build's copy
of ncurses-config don't get used.

> The ncurses detection and variability in distros is horrible. We
> already tried all possible combinations and always someone complains
> about the way how we detect ncurses. See mailing list archive for more
> information.

that's the point of pkg-config.  if someone is having problems because
they're doing something weird/non-standard, tell them to sort out their
pkg-config installs.  that's a lot easier than trying to cater to all
the stupid ways people try to set up their build environments.
-mike

--fjEAjMKpll6GDq3U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAlpiNyMACgkQQWM7n+g3
9YHfYw/+LO30+h4YbNSRuH9wZ/O4rsGnSrS4BhJUpyWpLpNjOQFtVG5NNUtfWR27
0LGo2mkGoOgD5NvwZ0WJ8+XmYrjQFF7Cr7d11XycnAvH+8AzDJ4Ka3UExGc7X88r
IzM0heyu2A00Pb4cQrwO2TC41R9X7qS56g+cZvWJuL8OgDHQHNFN0XIS7V4Nu0MT
vH0O+K/IWm/5ONuh/2qokaMvfR92wRqIviWS1l95mWjjl8CVGg9ZJkxGTB1qKlVy
cipAhtWUh3wIreSySTrqh5zM0wSgrudTazsAYvaq8crr6CK4lPsy1b3HqLPxkqwD
Z0Is3h7WLJ0nKSTw1WD1Vp9FUtbIwa1Ul8Xvr7lpK0luBCqNOQJcNAmaFRjoLAzo
LcBZk7n4YYGgnNB7C2xOiHjCPcU2qZAE0OL7kSlE2O/jQAqqtT96A/12dHd/wAhv
6vHZYhEfPbrmcKPXdiVqI+NMLA/GomfmWusiHF3lQMoi8YGovmpYbo970y4g4ocD
unQDn1BfTfk6owcQ0L9AdS8oYKXNTHiCoHu/9pr9be+5gWFXLuBK4iC4UKa45r3u
0dECN9zqQTjQ9xTgBT/PgXsHm7lKUE5QrlKre2x+m2kkUGmcyP3Miun1YIMr1efE
6hvCiEnmz6It/dnmPUQEKbzphCbySeRMt+r9pbfP+qXn7tEcd00=
=rOTw
-----END PGP SIGNATURE-----

--fjEAjMKpll6GDq3U--
