Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:44142 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbbDCBPX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Apr 2015 21:15:23 -0400
Date: Thu, 2 Apr 2015 21:15:22 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Message-ID: <20150403011522.GH22171@vapier>
References: <201504011342.56546.sweet_f_a@gmx.de>
 <201504011817.48428.sweet_f_a@gmx.de>
 <20150401201051.GP25224@vapier>
 <201504012306.52737.sweet_f_a@gmx.de>
 <20150401213800.GB2097@ws.net.home>
 <20150402011230.GA22171@vapier>
 <20150402082000.GC2097@ws.net.home>
 <20150402161952.GB22171@vapier>
 <20150402191530.GG2097@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
In-Reply-To: <20150402191530.GG2097@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02 Apr 2015 21:15, Karel Zak wrote:
> On Thu, Apr 02, 2015 at 12:19:52PM -0400, Mike Frysinger wrote:
> > On 02 Apr 2015 10:20, Karel Zak wrote:
> > > If I good remember then the reason is that the helpers does not have
> > > to be installed in standard PATH. Well, you're author of this thing
> > > :-)
> >=20
> > i wrote the code to make it a configure option, but the actual behavior=
 predates=20
> > me.  i'm interested more in the behavior, not the exact configure optio=
n.
>=20
>  So, the basis question is if we really need to support non-standard
>  paths for the helpers. IMHO it's unnecessary legacy and I don't see a
>  problem to drop this feature and require $PATH, and for critical
>  things like fsck fallback to /sbin if $PATH is undefined.

the reason for adding that configure option was to support packages that in=
stall=20
both into /bin and /usr/bin.  i understand some distros will override those=
=20
settings of upstream packages, but Gentoo has opted not to since there's no=
=20
reason at all to force them all into /sbin (and even existing tools in /sbi=
n are=20
pretty pointless).  although it mattered more when the code was only search=
ing=20
that list and not $PATH at all.

my preference would be just to do execvp() and be done so we can stop these=
=20
distro bikesheddings (/bin & /usr-merge and such).
-mike

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVHemqAAoJEEFjO5/oN/WBDKYP/AhIQBsAhcid21zLL2U6w7TS
wYh5CGub7YhG7Xa3wqu05Fng1+TT5ETydUIomfoc5ZRgb8oJBQlIJbiO57xwP9Bg
OWUpwXQhjeU3YccCLlN58cMGR51d3ULtwCkrWqNDeQH5UsjlsOEZXrRmvEC+UpKj
4DogczjMXPeKD9XFxwlAHQt/ICHylnAX02bEtTSmXdzkUTe+PGHn2j/XMBSRjHXm
Kiq8Y8BMS7bsJuxDubrT0y+/DbOLY0V/o4wpDd0NVsxvHJaA/X3XB0w3fvwz6oU3
gaKvKHQ2iYMPRStPBjMkamx3RhvySy7Y/Qksj89TUsz5LlCQYylJ8eXKb7Bfok+O
3jPcyRizs+ogh7M+eEpy8Mc8lxkDt2ttUEXqlNlcCXKXYfYH5feKBdDeKFBjKW9T
g7l8dnvT0i3w0GpmlK0rQxbWpK6wk0Z2O4JsUDxyIMc7J7Lci2yivMgp+Mc7dQwb
mEuyzOtHKH1Lh3A6qt0i+bKkhrBPpiVsVlI8Bvb1bY0RdbYue+WrZBheu6XAqbuc
iQ7ZrKbSnPqxACXjtfcuEMspnKpsdqr68YE6rCEmj8o8jIY3wk3YY31nLlRTqjOj
hQRgdozCZEu3bvm5Nn3Ejq3l2t6yzfaqdBn1FMpzND59HgNVJjqI6wMDZMODlSW9
0HtO2vT1XtefOLV3lyll
=o4gh
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--
