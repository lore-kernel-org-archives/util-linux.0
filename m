Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:33288 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab3ALF0j (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 12 Jan 2013 00:26:39 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Phillip Susi <psusi@ubuntu.com>
Subject: Re: losetup -d --force for zombie loop devices?
Date: Sat, 12 Jan 2013 00:29:28 -0500
Cc: Thomas Orgis <thomas-forum@orgis.org>, util-linux@vger.kernel.org
References: <20120417100346.2a0b8301@orgis.org> <201301112352.55112.vapier@gentoo.org> <50F0F0E8.2020909@ubuntu.com>
In-Reply-To: <50F0F0E8.2020909@ubuntu.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3144418.MGiOScF93X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201301120029.29896.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart3144418.MGiOScF93X
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 12 January 2013 00:13:12 Phillip Susi wrote:
> On 01/11/2013 11:52 PM, Mike Frysinger wrote:
> >> but my point was that what you are looking for is umount -f, not
> >> umount -l.
> >=20
> > and my point is that `umount -f` doesn't always work which means
> > `umount -l` is sometimes the only way to remove a mount point.  an
> > unresponsive remote or something is holding open a reference (which
> > doesn't show up in `lsof -n`).
>=20
> Right.  Forced unmounts aren't really implemented.  They need to be.
> It isn't losetup that needs to be forcibly detached, but the filesystem.

would be nice if userland had visibility into all these handles that the=20
kernel has opened.  for example, with losetup, i think the only way is to=20
query the loop devices directly or sysfs ?  might be handy to at least teac=
h=20
lsof to peek in there, but still sucks we have to do it subsystem by=20
subsystem.
=2Dmike

--nextPart3144418.MGiOScF93X
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQ8PS5AAoJEEFjO5/oN/WBVCEP/0ca/v8WEyyRw++e6yM9ck3E
L0S0DiWGeRrRbGxz4j8uzZIPm1no+E6VBe1L3+zHtyzVKIQIjWhKgTJvCtwkCrM/
4D40gPBBFgOky9AcQ+VU678kW7f8plbpMGO5vR2T+GC/9/J4Ir6rEwui/KyHBa44
G7eUu/UOec+c+uYB/pz64dF+ukUU55Jbve6De2CHn6HZS7SwqGFqUpZww7omHbsm
8BKAMfTVH7QRq7byqLSxB9WwjQjfeEWemc/N2gmMsym/dCG1LDAWDe8kDVIYOo7d
ONj4i5QpULghHBItaMDUxaIsHI0hEmS5vgpJbU/odpDkb3lN5lom7/8OuHt29cGL
utPmtGJz/4rvm7rm0IJYwmpaSRG3pS4JCQ19BUIO45IAa5MdoaCH///fp5ddr7Vl
VvKv8D2OLiNRaMeuQPHx9T3dN2KPAPfwhAXPrlUvhfP6E6FoQluPYDcJwQMMMo7g
kXCkfNzyjTYglJ0xPrPgivIEwHco3kpO/oCc0pq9O7HlcPCzevQ995XHBs2ChPok
yy9weW1Lho7DbnvkRPNaC5Q1xjgwoIxgfY6RxRB1ve9zjFGZYc36CAk5b6K8Bcby
KjS//Y9MSEIWeq9z4BVs4E+C5EZZb18PJY4pOQPL9oU20sLXukl8FHxa0DKHqnIH
XhXgQ+JoEULoS/EhEtkg
=wq6G
-----END PGP SIGNATURE-----

--nextPart3144418.MGiOScF93X--
