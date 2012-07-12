Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:52395 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753231Ab2GLJpw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Jul 2012 05:45:52 -0400
Date: Thu, 12 Jul 2012 11:45:02 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH] fdisk: API: add label probing functionality
Message-ID: <20120712094502.GK1886@foxbat.suse.cz>
References: <1341783627.2628.10.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
In-Reply-To: <1341783627.2628.10.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 08, 2012 at 11:40:27PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> This patch sets the initial layout for label specific operations. A new f=
disk_label structure
> is created that will hold all these ops, like new, delete, write and prob=
e, among others. For
> now only probing is implemented. Once this design is established, a copy =
of the probed label
> will be copied to the main context structure, where calling the specific =
functions will save
> 'disklabel' checks. Debugging support is added as well.
>=20
> This patch passes regression tests and manually passes bsd, sun, dos and =
sgi labels probes.
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>

Looks good to me:

Reviewed-by: Petr Uzel <petr.uzel@suse.cz>

I have two patches for you to consider taking them into your next
series (on top of this patch) - I'll send them separately.

Thanks,

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk/+nJ4ACgkQnZxG0T6qDD3b8gCfVQ4eFIRp1gtXVgDWchLCwZOy
B0cAmwfwXcC+Eg6AmRbY/t5zTM1Ex+bg
=/Fvr
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--
