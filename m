Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:57565 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334Ab2KAItS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 1 Nov 2012 04:49:18 -0400
Date: Thu, 1 Nov 2012 09:49:07 +0100
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] fdisk: gpt: write entire first sector
Message-ID: <20121101084906.GG3979@foxbat.suse.cz>
References: <1351358616.2842.2.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
In-Reply-To: <1351358616.2842.2.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 27, 2012 at 07:23:36PM +0200, Davidlohr Bueso wrote:
> We were writing only 1 byte in LBA0, and GPT requires dealing with an ent=
ire
> sector. This bug wasn't affecting when dealing with already existing devi=
ces
> with GPT as we weren't writing an important part of the first sector, thus
> leaving it unchanged. Also use write_all() wrapper from all-io.h
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>

Acked-by: Petr Uzel <petr.uzel@suse.cz>

> ---
>  fdisks/gpt.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/fdisks/gpt.c b/fdisks/gpt.c
> index 40cadb1..48397f3 100644
> --- a/fdisks/gpt.c
> +++ b/fdisks/gpt.c
> @@ -44,6 +44,7 @@
>  #include "blkdev.h"
>  #include "bitops.h"
>  #include "strutils.h"
> +#include "all-io.h"
> =20
>  #define GPT_HEADER_SIGNATURE 0x5452415020494645LL /* EFI PART */
>  #define GPT_HEADER_REVISION_V1_02 0x00010200
> @@ -1057,8 +1058,10 @@ static int gpt_write_pmbr(struct fdisk_context *cx=
t)
>  	if (offset !=3D lseek(cxt->dev_fd, offset, SEEK_SET))
>  		goto fail;
> =20
> -	if (1 =3D=3D write(cxt->dev_fd, pmbr, 1))
> -		return 0;
> +	/* pMBR covers the first sector (LBA) of the disk */
> +	if (write_all(cxt->dev_fd, pmbr, cxt->sector_size))
> +		goto fail;
> +	return 0;
>  fail:
>  	return -errno;
>  }
> --=20
> 1.7.9.5
>=20
>=20
>=20
>=20

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlCSN4IACgkQnZxG0T6qDD2IEQCcC/KAbkIhY4DgK+hIgPcJ0a3o
o4YAnj/cesFsHV9C0kPKCwRQC93mY0go
=NTkm
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
