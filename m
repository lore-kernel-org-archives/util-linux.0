Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:32892 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754347Ab2EFSAC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 6 May 2012 14:00:02 -0400
Date: Sun, 6 May 2012 19:58:46 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/5] fdisk: move DOS new/add partition code
Message-ID: <20120506175846.GA6429@skipper.site>
References: <1336306218.2685.11.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
In-Reply-To: <1336306218.2685.11.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2012 at 02:10:18PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
> =20
> Since this is DOS specific logic, it belongs in its own label file. Addit=
ionally, a dos_new_partition() function is created
> that asks the user for partition type and then calls the actual dos_add_p=
artition().
>=20
> This patch passed fdisk regression tests, builds without problems and it =
was locally tested against adding and removing DOS partitions.
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>

Reviewed-and-acked-by: Petr Uzel <petr.uzel@suse.cz>

> ---
>  fdisk/fdisk.c         |  354 ++-----------------------------------------=
------
>  fdisk/fdisk.h         |   22 +++-
>  fdisk/fdiskdoslabel.c |  332 +++++++++++++++++++++++++++++++++++++++++++=
+++
>  fdisk/fdiskdoslabel.h |    5 +-
>  4 files changed, 365 insertions(+), 348 deletions(-)
[SNIP]

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+mu9YACgkQnZxG0T6qDD0dXACfaTSbqMMnhQLlHzKwElx1vstV
u/kAn3RhDrxuDxL/hWWYs3G57BTJg4Ed
=hMgP
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
