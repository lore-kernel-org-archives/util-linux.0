Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:35612 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835AbbDAUKw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Apr 2015 16:10:52 -0400
Date: Wed, 1 Apr 2015 16:10:51 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Message-ID: <20150401201051.GP25224@vapier>
References: <201504011342.56546.sweet_f_a@gmx.de>
 <20150401133842.GA1800@newbook>
 <201504011817.48428.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nSQp8DZZn7gZbDHt"
In-Reply-To: <201504011817.48428.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nSQp8DZZn7gZbDHt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01 Apr 2015 18:17, Ruediger Meier wrote:
> On Wednesday 01 April 2015, Isaac Dunham wrote:
> > On Wed, Apr 01, 2015 at 01:42:56PM +0200, Ruediger Meier wrote:
> > > I wonder about some hardcoded binary paths.
> > >
> > > Example swapon.c:
> > >
> > > #define PATH_MKSWAP    "/sbin/mkswap"
> > >
> > > There are a two problems.
> > > 1. It's wrong. We should use $sbindir from configure.
> > > 2. When called from our test-suite it will use a wrong (or
> > >    non-existend, broken) binary. This happens in test
> > > swapon/fixpgsz.
> > >
> > > The question is how to fix this.
> > >
> > > I would prefer to use "mkwsap" from the same directory like swapon
> > > or to simply execvp "mkswap" from PATH. But don't know if we want
> > > this. If we really want to keep a hardcoded sbindir then we would
> > > need "#ifdef TEST_PROGRAM".
> > >
> > > Any comments?
> >
> > The approach that seems obvious to me (assuming you want to keep the
> > hardcoded path) is:
> > -add -DSBINDIR=3D"$sbindir" to CFLAGS
>=20
> Yes, this would be easy. But my preferred logic would be like this
>=20
> If "swapon" was called from PATH then just take mkswap from PATH too.
> If "/whatever/path/swapon" was called then look for mkswap in the same=20
> path.
>=20
> Maybe both cases also with or without fallback $sbindir, /sbin or $PATH.
>=20
> I guess we should agree how somthing like this should be handeled in=20
> general. "eject" is also using hardcoded "/bin/umount".=20

seems like $PATH should always be used.  if you broke $PATH, well that's yo=
ur=20
fualt ... tools shouldn't generally be expected to work in the fact of host=
ile=20
environments like this.
-mike

--nSQp8DZZn7gZbDHt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVHFDLAAoJEEFjO5/oN/WBFSkQAIOy4YyU2UFozwR5PNpvcEz/
nJMrdGLD246vSIl434RknQ0LpphiSY8cZFYq4xUaivrkQbmxlxAkcj8XrWAjaRs9
E5XBpiO1KvGtCrQFj4ZCymR6jT8UVbxB6HF9HWeVAJGGXn293Le0PfjYKA6vSmJN
SBtBhAIL2DNtSKFVMqFnLQh6I/JIo8V6/ZeLaZgOQQYTUvy/Wr8WB3x8r6oF3x7A
95229i2GLLHnw5li1PNcQrk4FrrJ+RsCr6VTERhh2GTkTM5GSLTcXThpbJ//JNjj
1Y2VO22XyqEt/UKcLGMnslSRhE13D05qlRl8SmQjhRzNX4GsRCaP54HGIyF6+Am2
7gRtSFPFG1zIKAxY/IZ4Voi+/IdM2A/rvPCxYraycuPY+5W9OL6JRpHClziZ8fvd
CiUVbwwrkpakgzgqSfcIb3+XaHhojPrXDUaoXDGideQoYQHk7UDu4e0o8sVSCDRI
LB6Gy6XV8gc/eyEGYvSTHkoocdakn4Fh2d9hDiWEb+C14DZv0wPP97RV/kSH78eG
Q5LyLvw7dBKSgWQldn1nTXQzSqghwG9qHuTMOFGV6pwlqX07WzANcxPTd+tAspdf
MSHH77+pJSCN58+ahhjKFGm99PAYEu/p/1pKWbSYumamdTxuMohxryCNhivR1Q9M
pgU+7eUhOgvJ2sLduWK0
=Ebmt
-----END PGP SIGNATURE-----

--nSQp8DZZn7gZbDHt--
