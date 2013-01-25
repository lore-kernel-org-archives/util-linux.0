Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:50506 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756011Ab3AYRCE (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 25 Jan 2013 12:02:04 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Subject: Re: fsck files w/relative paths
Date: Fri, 25 Jan 2013 12:02:01 -0500
Cc: util-linux-ng@vger.kernel.org
References: <201301201827.23141.vapier@gentoo.org> <20130125151736.GP27413@x2.net.home>
In-Reply-To: <20130125151736.GP27413@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5267545.yz1E1c24QN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201301251202.02511.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart5267545.yz1E1c24QN
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 25 January 2013 10:17:36 Karel Zak wrote:
> On Sun, Jan 20, 2013 at 06:27:22PM -0500, Mike Frysinger wrote:
> > we could tweak parse_argv() so that it checks for argv[0] =3D=3D '.' in
> > addition to argv[0] =3D=3D '/'.  but that wouldn't fix other relative p=
aths
> > like: $ fsck images/foo
> > $ fsck foo
>=20
> Hmm... maybe add a hint to the fsck man page is the best solution :-)
>=20
> > should we treat all non-options as devices ?  would that break anything=
 ?
>=20
> I don't think it's a good idea.
>=20
> All unknown stuff is by default interpreted as filesystem specific options
> (options for fsck.<type>) and it's pretty common that people don't use
> "--" separator between fsck and fsck.<type> options.

well, i didn't mean non-fsck options, but non-options.  i.e. things that do=
n't=20
start with dashes.  are there fscks which use non-options as something othe=
r=20
than "file/device to check" ?

really, the fsck checking here is simply to determine whether it has to=20
automatically look up the root device and append that to the command line. =
 if=20
the user specified a file/device, then that shouldn't happen.  we could eve=
n=20
resort to doing a stat() on the non-options to see if it exists.
=2Dmike

--nextPart5267545.yz1E1c24QN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRArqKAAoJEEFjO5/oN/WBoU8QAJNuXURfAjpG0wJFo4huqffY
nsis1QBW3NzLIi2Eta5PS4+qSZaEhbNXmseiW7nOqFi7bto5b3Jmy2BqFI4vCygM
xuLguGp+93boo2yf5UV+MfpiEbOJWNV1kYNmRQaZ9Tq/DYfRbzMQzhC5O4YFJNJn
nJGsA8IwlgAOfoHLgSNweb18Rky0LGrz9jJk1zxMeF4M8KKwo9HEy7OU8WrOuEU9
9ACQVfq2hetyALssT4RlWmfFn6RLY3umuqyypRGlTVHKfPrtSFFFTJVuChhr5XyM
i3sUoy91FUyMy3bPilrlLjg8zLjmW6MZudIboOQod6WLQ4BSm5x8yG/sagYMR9HE
Ap8vo0s8prQYjgwexiyakmiCqgBVM3hfmQ3n+AY6O+PGxy/aeeX4VzrT3V6xEPgX
IyPRwkn0Blcz7Esc8eWONtr3WTs/8sT50cM+rRehuHc5rY4kPxlAee8zgz/ApXC4
t2e5YP4oXabM6fSXFr9o7mxq+odXMcyfKRICGZgQ72hjcVzeCmhHqgIlzG33kD6v
OJW5vh8C56FCpUwa+2h2SeCu0zARaNEs4Qyj1n2R+w3nfY8nGEbbxQ9SQnTNIEql
lRLCs7/jcVVsemYXBH/tFZnzUHGQjgh3WZgE/qE7wu2pNprjEd4kq2HmX/SSLufh
AoMvI3RRts9iwRlSVyGA
=4xVl
-----END PGP SIGNATURE-----

--nextPart5267545.yz1E1c24QN--
