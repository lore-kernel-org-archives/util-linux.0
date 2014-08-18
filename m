Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:34962 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbaHRMFe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Aug 2014 08:05:34 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Steven Stewart-Gallus <sstewartgallus00@mylangara.bc.ca>
Cc: util-linux@vger.kernel.org
Subject: Re: Utilities don't take into account capabilities
Date: Mon, 18 Aug 2014 08:05:29 -0400
Message-ID: <3715739.62j44Bg1Aj@vapier>
In-Reply-To: <fbcec6cf5352.53efd3e4@langara.bc.ca>
References: <fbcec6cf5352.53efd3e4@langara.bc.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15843556.ejVeOxGk17"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart15843556.ejVeOxGk17
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Sat 16 Aug 2014 21:57:56 Steven Stewart-Gallus wrote:
> The utilities such as mount don't take into account capabilities and =
always
> fail for non root users which is wrong.
>=20
> This is really, really, really annoying when working in a sandboxed n=
on root
> shell with pseudo capabilities.
>=20
> One possible solution to my problem is do some complicated checking f=
or
> capabilities that I don't even know how would work. I believe a bette=
r and
> simpler approach that would work for possible future extensions as we=
ll
> would be to simply drop privileges whenever one is unprivileged and a=
ttempt
> to do the task as normally. If you felt like it, a warning along the =
lines
> of "warning: user is unprivileged, attempting mount without privilege=
s"
> could be made. As a bonus, failed system calls can sometimes leave
> important diagnostic information in the dmesg.

guessing the sandbox isn't really meant for security purposes since=20
CAP_SYS_ADMIN can easily be used to recover just about every other capa=
bility.
=09http://lwn.net/Articles/486306/

especially considering access to mount means you're allowed to mount ar=
bitrary=20
filesystems w/arbitrary content including set*id progs.

so what exactly is the point of trying to support CAP_SYS_ADMIN ?

note: i'm not arguing about whether the current UID checks in `mount` a=
re even=20
useful ... it'd make the code simpler to just assume the privs exist, e=
lse=20
it'll get errors from the respective syscalls and the user of a misconf=
igured=20
system can deal with it themselves.
=2Dmike
--nextPart15843556.ejVeOxGk17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJT8ewJAAoJEEFjO5/oN/WBZ9AQAIlQTAXSH+Vj9kNe1BPLuX9l
HqTxb+4wJ8FtOTqa9WBTiMS381sTwMnXMpvyq/9/3kqvRRh2/mVX5hm16LsbsUJ8
SzYuKue+Clmb37ojHzWrsngxPF/TuaMvH2E4ZNj6zvASryXKkw+Q8gHet0Uly2aI
cXW90yF+reKfb7f3+Mb60mUZTgqmM4/18MfG1JO1fp6NKSvrjP7F7vx6GvTvoOze
wDjQGikbzmlgKQZ6/F6HRqUZex7N78mqkX5A1zLcp5YQ34EwqqSo4u1P1ErzTdKD
IO/3+2EvECUysWKMRsI3cuEAD+uOOLwCRJZGYMnAOhBKsOaK+g86NBhbdwK1L/GQ
TPGmtYuy12UvqrDXn1MYAGjFAccaQQwH/MxIutF/T5X5pQLK16D7hhiS5xSNDiCY
oHTqUjXxJQVzjY1fI2veR1kh3QWODnfceATpu7gEIfmN7yNh1PBVQMCLuZWNMTmW
t+jzgtV898Aps8ZX8ZMA6C98qpFy+FxJRnEri5uNN/p9m8yBidYl2rM+Fdulb2dl
uLcbY3AEQJ5EeayDLYJm6boTw23nF7KHQdBSyQaK3wHTXiqk5G51y0Re8bGgqb7M
VLLT/t5F+adFt+TRUK4f/IAUY86xlVrqR3xCuo7wetkA3Ko1j0Udm3fiULAfw+Wp
Ju0cuG0vFyQ1t7rdgx3g
=AJnD
-----END PGP SIGNATURE-----

--nextPart15843556.ejVeOxGk17--

