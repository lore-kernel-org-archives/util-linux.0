Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:41738 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755339AbbLDWBj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 17:01:39 -0500
Received: from vapier.lan (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with SMTP id 1C460340B2B
	for <util-linux@vger.kernel.org>; Fri,  4 Dec 2015 22:01:39 +0000 (UTC)
Date: Fri, 4 Dec 2015 17:01:38 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: Re: fsck memory leak
Message-ID: <20151204220138.GS23754@vapier.lan>
References: <n3rei3$8l3$1@ger.gmane.org>
 <20151204151927.GA3548@thunk.org>
 <n3sjvh$ib8$1@ger.gmane.org>
 <20151204195848.GA18359@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x/TyKPcLwmKZr+b7"
In-Reply-To: <20151204195848.GA18359@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--x/TyKPcLwmKZr+b7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 04 Dec 2015 14:58, Theodore Ts'o wrote:
> So doing something like "echo 3 > /proc/sys/vm/drop_caches" is
> actually a _bad_ thing, since it means you are throwing away data that
> could be used to avoid blocking waiting for disk I/O to complete.

just to clarify for other readers: "bad" here means "bad for performance",
not "bad" as in "data loss".
-mike

--x/TyKPcLwmKZr+b7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWYg1CAAoJEEFjO5/oN/WB1TkQALChyisOnpqHKkMqS1Nv8Bls
XPQBTjN2YFm3y+j7OEUrpGw5gVlHS9ztrVvMrJRiNjOjQ6qjWzhb8PgVJUtNBuQ+
8vKa/EqIuYYx6vSIoohV1PoOZScGLdYmxpgPiBVNN0GROC0AwNPdLVE+2RDU2CVG
HSHl+DUHaDXFgYee3tKH49KHg9FENdxPdDD/fEaaC2xJ+YErpfcbhS9WfarmLnIW
dkV/OL5MyGGqoJI6U+CB/zC2QWN9O9fZk0h1qtAebnmo9biF1SXdBmAUwnA5gquQ
e0lWcIi4TS2KHWXSJ69i+4NXf5ywSYIU5az0Ciasyyj4EfLiG0vTgnwt/7ITFjf3
56BPYJtl526MH0vY4wAz0+dd7XL88Q5s/QdZslCMFo6yinxPwVeHgx2RCs6WiVxI
iym9zF3QRvcA+I0DF91VbosnFsFSpfxw4CQtms3PB2I3vkfa+CRhKrW3AQ9nZjtk
vybCZUp6FvEEwG2Y23rRMst2r7XgJPER3pTl5px6TWkhaUykKj0/UyD7QRq7oa0N
4X01w+IpLGLU8sZ+sN5YcFClhC+TbginP6KgVy5JhqTQjCwVgFTGItYrYKsGZqyj
HQsynoy9WTmFVF+qMR9PG3g/8O6wrshJFDkj3ibZEO2/EATN3QLwMUvnUosrPojQ
gK3XN4rhip2JI4A1jFUl
=u+pC
-----END PGP SIGNATURE-----

--x/TyKPcLwmKZr+b7--
