Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:60230 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab3ALEuH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Jan 2013 23:50:07 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Phillip Susi <psusi@ubuntu.com>
Subject: Re: losetup -d --force for zombie loop devices?
Date: Fri, 11 Jan 2013 23:52:54 -0500
Cc: Thomas Orgis <thomas-forum@orgis.org>, util-linux@vger.kernel.org
References: <20120417100346.2a0b8301@orgis.org> <201301111852.03607.vapier@gentoo.org> <50F0B438.1080608@ubuntu.com>
In-Reply-To: <50F0B438.1080608@ubuntu.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14447423.dJeKArlolZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201301112352.55112.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart14447423.dJeKArlolZ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 11 January 2013 19:54:16 Phillip Susi wrote:
> On 01/11/2013 06:52 PM, Mike Frysinger wrote:
> > On Thursday 03 May 2012 10:29:07 Phillip Susi wrote:
> >> If you want to hide mounts from certain processes, that is what
> >> unshare is for.  Hiding a mount from all processes does not make
> >> sense.  If you know a mount is gone and beyond recovery ( like in
> >> this loop over nfs case, or removed media ), then it should be
> >> forcibly unmounted, not simply made invisible and doomed to
> >> remain a zombie mount until the system is rebooted.
> >=20
> > in an ideal world, maybe unshare might work.  in the real world, it
> > doesn't. you can use it only on *new* processes, not ones that are
> > already running. nor can you do `unshare shutdown` and have it work
> > since that simply signals a long running init process to initiate a
> > shutdown.
> >=20
> > an nfs server goes afk and attempts to `umount` it timeout, as well
> > as many desktop programs (like kde io daemons that like to walk
> > available mount points) or shutdown processes.  no call to
> > `unshare` will fix this, but certainly forcibly removing it with
> > `umount -l` will.
>=20
> A bit of a delayed response there

the recent unshare patches reminded me of this.  and i had actually used=20
unshare in the interim so i know how it works now.

> but my point was that what you are
> looking for is umount -f, not umount -l.

and my point is that `umount -f` doesn't always work which means `umount -l=
`=20
is sometimes the only way to remove a mount point.  an unresponsive remote =
or=20
something is holding open a reference (which doesn't show up in `lsof -n`).

> It also used to be that once
> you detached a mount with umount -l, you could not reattach it.
> Attempts to remount would fail with EBUSY and so this was a horribly
> broken state to be in.  At some point it seems this was changed and
> now you *can* reattach, so lazy unmount is no longer pure evil, but
> still it is no forced unmount.

it hasn't been that way for quite some time, and for network based mounts,=
=20
it's pretty much never been that way ?
=2Dmike

--nextPart14447423.dJeKArlolZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQ8OwnAAoJEEFjO5/oN/WBmbEQAIHGZq0bgsWY4CAc8puyU6vH
9HnAO3o0qoVVhIFEftghEPuEL19lpqVZvQ7Yo/Wpyd4ve+fD8FjjqW32q3zAVEji
KVxHllTjwgR8Ql3slfw0qdj8KtUiuE2mZIv7j5v4+XdtSbgiB1Ptsf/DoBX87Est
mC9/pbshxMI6ENfVVxQ90O7UP/PU8UEL03uSLuudhoUWLeoXwid4g8Q5gpR9xva1
sr5d0sICcAqRMKutGiSD49/vPQr4B+ml5R93oY3kcHHGF63Xlad9yJE2UudmqMpL
TXgLQ3xlfbpMaARUpZSrzFBr7LRPvFeozR7pYpjFtSC/NGQyYyPPxP2eHBKO7tuf
d3Emu9Zr2O2kl7kmX0xg4FffEgD6P7BFRa8V7TP9rgH/5YqyvEjipRTWY9IMbMN0
1yTjzHinX/lFQ0rAA4+6lWGoXnc9GyfDtrhD0Gbnym6iWK5GN6lF4+FEO8sr4A5J
hWaxDAEAN9nUps618UZc70cbZi7KiXzCxu1DQVtBBWZt/8AIgME9ZnWFZ1RAbI+q
aEVJnDTK1OBZxv7HFpCyDpsJHwVGRzW94Ekpy+Om6/9O4ypGyvCh8CBgoQhmqRk8
8u34CShaYxHfeVLodw7G0e1G/BOvEo4q2+G8VpRx30lnP+S7xJqKGtBZUWqQiCGU
hWKViLrLOoF+077/i5hk
=koyN
-----END PGP SIGNATURE-----

--nextPart14447423.dJeKArlolZ--
