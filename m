Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60736 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754259Ab2EFRpE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 6 May 2012 13:45:04 -0400
Date: Sun, 6 May 2012 19:34:08 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/5] fdisk: remove unused hsc2sector macro
Message-ID: <20120506173408.GA14007@skipper.site>
References: <1336306216.2685.10.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
In-Reply-To: <1336306216.2685.10.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2012 at 02:10:16PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
> fdisk/fdisk.c |    2 --
> 1 files changed, 0 insertions(+), 2 deletions(-)
>=20
> diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
> index dccaf27..3543745 100644
> --- a/fdisk/fdisk.c
> +++ b/fdisk/fdisk.c
> @@ -68,8 +68,6 @@ int MBRbuffer_changed;
> #define sector(s) ((s) & 0x3f)
> #define cylinder(s, c) ((c) | (((s) & 0xc0) << 2))
>=20
> -#define hsc2sector(h,s,c) (sector(s) - 1 + sectors * \
> - ((h) + heads * cylinder(s,c)))
> #define set_hsc(h,s,c,sector) { \
> s =3D sector % sectors + 1; \
> sector /=3D sectors; \

This patch seems to be malformed. Could you please check what's wrong?

Thanks,

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+mthAACgkQnZxG0T6qDD1hAwCeJdWkNlwdh1ZJWrbAMtTpZPJZ
hW4AoI/oNpDfNgZjMJkv7C+v9GHT3lqt
=c6IE
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
