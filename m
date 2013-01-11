Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:50568 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183Ab3AKXtO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Jan 2013 18:49:14 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Phillip Susi <psusi@ubuntu.com>
Subject: Re: losetup -d --force for zombie loop devices?
Date: Fri, 11 Jan 2013 18:52:02 -0500
Cc: Thomas Orgis <thomas-forum@orgis.org>, util-linux@vger.kernel.org
References: <20120417100346.2a0b8301@orgis.org> <201205030043.21697.vapier@gentoo.org> <4FA29633.70508@ubuntu.com>
In-Reply-To: <4FA29633.70508@ubuntu.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart24250050.YyxVERo7lV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201301111852.03607.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart24250050.YyxVERo7lV
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 03 May 2012 10:29:07 Phillip Susi wrote:
> On 5/3/2012 12:43 AM, Mike Frysinger wrote:
> > conversely, having a mount point removed from the perspective of
> > userspace can be useful.  like with tools that stubbornly enumerate all
> > mounts, or attempting to shutdown your system with known unreachable
> > network mounts. you, as the admin, know these things are gone and beyond
> > accessible, so having the ability to remove them all manually and reboot
> > cleanly (w/out ridiculous long retries/timeouts) is a good thing.
>=20
> If you want to hide mounts from certain processes, that is what unshare
> is for.  Hiding a mount from all processes does not make sense.  If you
> know a mount is gone and beyond recovery ( like in this loop over nfs
> case, or removed media ), then it should be forcibly unmounted, not
> simply made invisible and doomed to remain a zombie mount until the
> system is rebooted.

in an ideal world, maybe unshare might work.  in the real world, it doesn't=
=2E =20
you can use it only on *new* processes, not ones that are already running. =
=20
nor can you do `unshare shutdown` and have it work since that simply signal=
s a=20
long running init process to initiate a shutdown.

an nfs server goes afk and attempts to `umount` it timeout, as well as many=
=20
desktop programs (like kde io daemons that like to walk available mount=20
points) or shutdown processes.  no call to `unshare` will fix this, but=20
certainly forcibly removing it with `umount -l` will.
=2Dmike

--nextPart24250050.YyxVERo7lV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQ8KWjAAoJEEFjO5/oN/WBgBMP/RRHOcJ2tFOUNXbVEp/Od5oj
XLwhn64YdswARzW44Cer+6EmVYgmAVfefbbL0Qau3Nyo5Sts0/ZH8I1BirC1b4SG
V+Lw+cg0uSwRryvlknt80G+BbCN1J1Ci5vZ9k+GPuJjZIUhyWDWiwIaavYZyDJBV
Ie6yHNoc9H31I6DLHOC3T6hvnJ7YhRw/JbhY1aVC6154tVuDBelqcGxhl95rEtFm
EZ6x9fkEHX/my5Q93WyuOBkiBDYSsneHTKvNeZzvWgSEbE778gr9xk8NgT3P3AgC
Xv0rTcoARWwNekA4VJKdHRGysF9s6OAeClDUfcbO01NKfpv8yyaBzTca89QHRFmo
ogMYfI2XsLzD3TtZPaVAxet/7bHpmCLmWckbeLkNz+TaLOtZUnLmL2pG75CusjH6
yFfjsNd3qLFF74yedozDK1ZDEwVgMCjyG81ccfZJ5JBbUsID6zKxpt6CCwL7CKQw
dfQwm22nIkJaw/OdtGp3jPGRDEyH97WB8lYkNAP0vjwnhn72vqO4u/UtzOkY7VLR
jp0O4zl6C2EnL48rhfLUvwxI+Q2M1jPU9sxEN/JelRS1IZzm7I+wneHxKnXUCrk2
kze2Gk37h8gAmUEQgVozOJcyImSqWH1FYulO3VpAG8uIArw9h0X5FwGfknHD9LCc
gCH3VN3BXQGKhiYRIkfi
=tZ2U
-----END PGP SIGNATURE-----

--nextPart24250050.YyxVERo7lV--
