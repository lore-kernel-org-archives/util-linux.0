Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:43736 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756382AbeATSOG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Jan 2018 13:14:06 -0500
Date: Sat, 20 Jan 2018 13:14:05 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: =?utf-8?Q?R=C3=BCdiger?= Meier <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>,
        Carlos Santos <casantos@datacom.ind.br>,
        util-linux@vger.kernel.org
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
Message-ID: <20180120181405.GH14915@vapier>
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
 <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
 <20170801072017.yl7mgv64pq7ccj5e@ws.net.home>
 <20180119024717.GJ7217@vapier>
 <20180119094051.g3qztrrqf5guife5@ws.net.home>
 <20180119182123.GK28967@vapier>
 <9f4f0155-fd38-e8d7-1340-b128b6ac447f@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
In-Reply-To: <9f4f0155-fd38-e8d7-1340-b128b6ac447f@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20 Jan 2018 18:50, R=C3=BCdiger Meier wrote:
> On 01/19/2018 07:21 PM, Mike Frysinger wrote:
> > On 19 Jan 2018 10:40, Karel Zak wrote:
> >> On Thu, Jan 18, 2018 at 09:47:17PM -0500, Mike Frysinger wrote:
> >>> On 01 Aug 2017 09:20, Karel Zak wrote:
> >>>> On Mon, Jul 31, 2017 at 09:46:39PM -0300, Carlos Santos wrote:
> >>>>>> From: "Carlos Santos" <casantos@datacom.ind.br>
> >>>>>> To: util-linux@vger.kernel.org
> >>>>>> Sent: Monday, July 31, 2017 9:12:03 PM
> >>>>>> Subject: Problem building util-linux without a separate ncursesw i=
nclude dir
> >>>>>
> >>>>>> of util-linux. Would it be possible to make the location of ncurse=
sw4c12a334dc4104d16dc06edf51904b08b08fcdfa
> >>>>>> headers configurable, instead?
> >>>>
> >>>> We test for alone ncurses.h and term.h in the for non-wide ncurses.
> >>>> Can you send output from your configure from the current master
> >>>> branch (or v2.30.1)?
> >>>>
> >>>>> I was thinking on something simple, like https://pastebin.com/VqM9G=
9yu
> >>>>
> >>>> Hmm, but you don't distinguish between wide and non-wide ncurses.
> >>>
> >>> why don't we just support ncurses's pkg-config files as the default ?
> >>> $ pkg-config --cflags ncurses
> >>> -D_GNU_SOURCE
> >>> $ pkg-config --cflags ncursesw
> >>> -D_GNU_SOURCE -I/usr/include/ncursesw
> >>
> >> because pkg-config is not supported by ncurses upstream by default and
> >> it's not always the best solution.
> >=20
> > you mean upstream's configure script doesn't default it to on.  distros
> > can (and many do) simply pass --enable-pc-files to get them.  but i don=
't
> > see how that's relevant to preference when it comes to detection.
> >=20
> >> See commit 4c12a334dc4104d16dc06edf51904b08b08fcdfa.
> >=20
> > seems like that's trivial to resolve with a compile test rather than
> > throwing it all out.  xxx-config scripts provide bad defaults when you
> > cross-compile because now the user has to make sure the build's copy
> > of ncurses-config don't get used.
> >=20
> >> The ncurses detection and variability in distros is horrible. We
> >> already tried all possible combinations and always someone complains
> >> about the way how we detect ncurses. See mailing list archive for more
> >> information.
> >=20
> > that's the point of pkg-config.  if someone is having problems because
> > they're doing something weird/non-standard, tell them to sort out their
> > pkg-config installs.
>=20
> non-standard is to have ncurses.pc installed.

that's a silly position to try to take.  you're claiming anything that isn't
turned on by default in `./configure` is non-standard ?  have you ever actu=
ally
tried building ncurses before and see what its defaults are ?  ncursesw isn=
't
the default, neither is installing into a subdir like /usr/include/ncursesw.
neither is libtinfo nor libtinfow.

> Also cross-compiling is certainly more "weird" than not cross-compiling.

you are aware that multilib is cross-compiling right ?  so people are doing
it every day on all the mainstream distros.

> Regarding "tell them",
> Have you tried yet to ask ncurses upstream about installing *.pc files
> by default?

i can send them an e-mail, but Thomas often leans towards not changing thin=
gs
=66rom how they've always been done, so i'm not exactly hopeful.

> > that's a lot easier than trying to cater to all
> > the stupid ways people try to set up their build environments.
>=20
> Installing ncurses via './configure && make install' is not the most
> stupid thing IMO ... Maybe just remove your ncurses-config system wide
> if you don't like it or use it correctly. Could be easier than telling
> all other people on the planet that they have to install ncurses in a way
> you like ...

telling people to mess with their build system (actively breaking it),=20
especially when they might be on a shared system or where they don't have
admin access, doesn't sound like a great idea to me.  especially when it's
trivial for them to resolve with --enable-pc-files.  then again, the number
of people who are building & installing ncurses by hand seems significantly
lower than those who get it from distros, so catering to their choices (that
then break things) doesn't seem worth it when they can simply adjust to do
what everyone else is doing.
-mike

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAlpjhu0ACgkQQWM7n+g3
9YEa8g/9HFFqUYxxrywHflU56MYIgN+iKsYwp02d2GdUg1e5txbKWWXtLlAEyBFy
Kj+6ILQ7wOT09Z9yBmYIyScLtnMQ3CrAu89Qot+OxAvjqZF2pwN/Bs8itk84dBGg
b1rIJRhP5gwF/JD9lMYieWgseDhlv2lET+ZGXt2Nh6CdRobAG96SrnBj59dk+XDX
K3AZjsV4p+K/1HpdMrzbb1xRz7h0jv8sXoab/n5iEdSWRUAqdaBfkrxbSul6hZGh
XxoQu+op/haN4irNIEdCpNS0eMvTCqX5KFrSq9c1dKo7CiM/SpTG+UnY4G4cYvyo
nvNEk320vPmG+ABKi7AbNudzOmif3DsZyuFRIM/D5UCiXOiqC3R1uOoxj0EKbK6g
0Re6IYvFS7H6GhqcuY2HglrnliXYlrIvpIs2VOyW1IenANko2XslmQVgGmnxm7Og
NX54gXtl2nDs5UpwGSetR0jgsm2RfwlzAqcyzDSYhnyOz8BQUx1JcOhtYnuIz626
NBn4amAIMgl97du22dYovbD5ZkS2df1HEBZQi/Ow+onfEZtHmAbuVG8N/b07i6XI
DXJb4B55irnzuvvMb1iB6TVOCIM5ILRArHok+p0W3uavqX4HNJZF94IvwWEBRRR3
3Tx/nSc2eMg59tud6bpoDwtFSZQ+JWwi7MuwHDMzJxX12mIbvBA=
=LLgO
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--
