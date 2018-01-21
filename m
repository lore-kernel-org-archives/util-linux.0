Return-Path: vapier@gentoo.org
Date: Sat, 20 Jan 2018 21:49:12 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: =?utf-8?Q?R=C3=BCdiger?= Meier <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, Carlos Santos <casantos@datacom.ind.br>,
	util-linux@vger.kernel.org
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
Message-ID: <20180121024912.GG15022@vapier>
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
 <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
 <20170801072017.yl7mgv64pq7ccj5e@ws.net.home>
 <20180119024717.GJ7217@vapier>
 <20180119094051.g3qztrrqf5guife5@ws.net.home>
 <20180119182123.GK28967@vapier>
 <9f4f0155-fd38-e8d7-1340-b128b6ac447f@gmx.de>
 <20180120181405.GH14915@vapier>
 <8f64924f-f89f-bc10-1be5-c8e64d2cdd12@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
In-Reply-To: <8f64924f-f89f-bc10-1be5-c8e64d2cdd12@gmx.de>
List-ID: <util-linux.vger.kernel.org>


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20 Jan 2018 20:31, R=C3=BCdiger Meier wrote:
> On 01/20/2018 07:14 PM, Mike Frysinger wrote:
> > On 20 Jan 2018 18:50, R=C3=BCdiger Meier wrote:
> >> On 01/19/2018 07:21 PM, Mike Frysinger wrote:
> >>> On 19 Jan 2018 10:40, Karel Zak wrote:
> >>>> On Thu, Jan 18, 2018 at 09:47:17PM -0500, Mike Frysinger wrote:
> >>>>> why don't we just support ncurses's pkg-config files as the default=
 ?
> >>>>> $ pkg-config --cflags ncurses
> >>>>> -D_GNU_SOURCE
> >>>>> $ pkg-config --cflags ncursesw
> >>>>> -D_GNU_SOURCE -I/usr/include/ncursesw
> >>>>
> >>>> because pkg-config is not supported by ncurses upstream by default a=
nd
> >>>> it's not always the best solution.
> >>>
> >>> you mean upstream's configure script doesn't default it to on.  distr=
os
> >>> can (and many do) simply pass --enable-pc-files to get them.  but i d=
on't
> >>> see how that's relevant to preference when it comes to detection.
> >>>
> >>>> See commit 4c12a334dc4104d16dc06edf51904b08b08fcdfa.
> >>>
> >>> seems like that's trivial to resolve with a compile test rather than
> >>> throwing it all out.  xxx-config scripts provide bad defaults when you
> >>> cross-compile because now the user has to make sure the build's copy
> >>> of ncurses-config don't get used.
> >>>
> >>>> The ncurses detection and variability in distros is horrible. We
> >>>> already tried all possible combinations and always someone complains
> >>>> about the way how we detect ncurses. See mailing list archive for mo=
re
> >>>> information.
> >>>
> >>> that's the point of pkg-config.  if someone is having problems because
> >>> they're doing something weird/non-standard, tell them to sort out the=
ir
> >>> pkg-config installs.
> >>
> >> non-standard is to have ncurses.pc installed.
> >=20
> > that's a silly position to try to take.  you're claiming anything that =
isn't
> > turned on by default in `./configure` is non-standard ?
>=20
> No, as you could have read I'm talking only about --enable-pc-files being=
 non
> standard. Many distros and users are not using it

most distros are enabling it.  Debian & Fedora & openSUSE & Gentoo & ArchLi=
nux
& OpenEmbedded OE and everything based on it are enabling them.  so it's the
common case now, and if that's what it requires for you define something
"standard", then it is standard now.

> and you can't just call them all stupid.

i didn't call anyone stupid.  don't put words in my mouth.

> We have to support this case first.

i didn't say to drop xxx-config usage.  i said it shouldn't come first.
-mike

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAlpj/6gACgkQQWM7n+g3
9YF5iA/9G8gNstqpaR9c+Q/I3n4RWIkQOHVqxhLP4A0zBWGlye28sFVlBQgAKR44
YDKPzSqNr/RMuaY9YLEObE9kDcnyCjkLltWvNESI55l9m4D7lXj01CiiFU11oYOU
T0ncxwEuteBUQn90DcNb9Owobp32wHqouhhRVu0j2piZvXmTStZm3YUTsnAs3l+3
uK89LzAhck/IRla4FNMP7ejM20mNoZvrb4PZITstMD6IxpRa/CBsaS1bGS9qBeXA
MF8jqwsAAgtcbQwhYu+JwR0Alqd1YIcC5ZToz4T+qDDZF47LUSLxAS3gJdXjWp9Y
8zNkRFs/ckZPNBL3+XncaMLsfhbuKOh03oL51/3cLDQrBfH3dpLADlQvOdDOEIQN
x2jfBLOFRXQ3uYbMzZny+QcF0giVbP/6eIUFYHRnSm1Gmbm/YWqggapGunKbukM0
ZlREtbiNTaY1ZwFLmfgEibw3PbWgGynMVd3IYk1tr2zxAtrFK7O+uCDZpX2SrF08
ZjDJ5iCFnyScEwYnm7lH6HNAUKDukDf8MMlaKcki55tYqj2/Xz+v6vlTscgLd3T3
ZxWLUNvp7JeX3dnHPXV/vJ9rLhG5evLkNSa85BeTcTsnKk/7xlTWPdhkXSs8NnRd
76vybNK6dVSaslApJUI8dfKNbYQzJJAmeZKbEVtnzGj2WRu59/Y=
=qaSE
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
