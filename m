Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:59454 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbaHDHk5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Aug 2014 03:40:57 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Andreas Henriksson <andreas@fatal.se>
Cc: YunQiang Su <wzssyqa@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount/buildsys: move SELINUX_LIBS to LDFLAGS
Date: Mon, 04 Aug 2014 03:40:56 -0400
Message-ID: <7003188.HrNgjPCK9Z@vapier>
In-Reply-To: <20140803202309.GA26295@fatal.se>
References: <1407010261-17305-1-git-send-email-andreas@fatal.se> <2625005.WTIbfJcupg@vapier> <20140803202309.GA26295@fatal.se>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2253922.ImZytYm0Gb"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart2253922.ImZytYm0Gb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Sun 03 Aug 2014 22:23:09 Andreas Henriksson wrote:
> Hello Mike Frysinger!
>=20
> On Sun, Aug 03, 2014 at 09:34:25AM -0400, Mike Frysinger wrote:
> [...]
>=20
> > please post the full details here.
>=20
> I have no more details then those found in
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D721431

well, that thing has barely 6 lines (and even then requires some esoter=
ic=20
knowledge from the reader), so you could have just pasted it here :p
=2D-----
In libmount/src/Makefile.am

libmount_la_LIBADD =3D $(ul_libblkid_la) $(SELINUX_LIBS)

libmount_la_DEPENDENCIES =3D $(libmount_la_LIBADD) libmount.sym libmoun=
t.h.in

While $(SELINUX_LIBS) is '-lselinux -lsepol'

They are not files or makefile tag, so cannot build-depends on.
=2D-----

the problem is that libmount_la_DEPENDENCIES shows up in the Makefile l=
ike:
libmount.la: ... $(libmount_la_DEPENDENCIES) ...

which means make evaluates it like so:
libmount.la: ... -lselinux -lsepol ...

which triggers the builtin library path searching of make itself:
https://www.gnu.org/software/make/manual/make.html#Libraries_002fSearch=


which means it'll rewrite -lselinux into /usr/lib/libselinux.so (if it =
can=20
find it) which is bad for multilib and cross-compiling.

the easy answer is to not add LIBADD to DEPENDENCIES.  which has been d=
one=20
already -- see dbf7043ea1d090d283cfd36280bb14189d8e35b1.

> > linkage (like -lselinux) are not ldflags.
>=20
> Works for me, but likely I got LIBADD/LDFLAGS/LDADD wrong (again).

it often works in the common case, but the edges break down.  we know p=
utting=20
=2Dlflags into LDFLAGS is such a scenario :).
=2Dmike
--nextPart2253922.ImZytYm0Gb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJT3zkIAAoJEEFjO5/oN/WBOU4P/j+EKnez16QJ1/y1dcmMXeA0
YKsQTYIcINhv+NUBgYgm4liRMVJE+8vUWzKYoxJQfl9bD32ux4g797zDclApoQs8
ouaM8zg9PJUFHQmWEAIx2HNH+XmlOJx8muQzE8uxn6/E5Jd8Rj9szS3R3BMId8ZX
AjoCvU1DIbK1ZvGJ+MShpdtVDfXZMZ2dQcVphDJFunUn+YG0/xIrbZQxfoNAcOL9
W4xFt2K0kF9yQTbDupSFDJeXL9E/fRfZwmXLfZskQzEjf4H52uFipB5dDWcaYUsl
4WrUj8Z3QZ7LWZOrocOvS2wo3y6aIaIT1DjiRZbSryEmCBdX2LFA/MBlso/rR+sK
udCs+nvdFaASbS8rsY5J7POEWLGB3RvpV1yh6eDuIH5HffjDGxDZaBB0a7ZouFd4
jXlqS+Rk31LE2N927zq4zFtCtsHaywRJKpGnFpbs7f2awQtxB/Ntq19zx4O61zPj
JV8iiTtNKtDOVQgHE3ApLPo3s6FFbIf2iAf3J4uhmRvvpWW6KT5zE3gF9Z/QVlVd
5BuIBWifStKE9Y0OOuDzRTNjpWn4yjusM4FszWm5uLAYTMMiEkmqUhoZ5RlC6EDV
vkbxtiGYGqEZcPk/K3HTnyJnSclVB/8oW8e7LLFzMy9jZK3kb5Au92CmEhT9iGxX
0TMwTefJ3w1sx4cl09EP
=HZwH
-----END PGP SIGNATURE-----

--nextPart2253922.ImZytYm0Gb--

