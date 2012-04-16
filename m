Return-Path: bernhard.voelker@siemens-enterprise.com
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: "dave@gnu.org" <dave@gnu.org>, Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Date: Mon, 16 Apr 2012 11:53:19 +0200
Subject: RE: [PATCH 5/8] sfdisk: fix silly mbyte typo
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0F0FCE9C0D@MCHP058A.global-ad.net>
References: <1334569484.2552.14.camel@offbook>
In-Reply-To: <1334569484.2552.14.camel@offbook>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Davidlohr Bueso wrote:

> Subject: [PATCH 5/8] sfdisk: fix silly mbyte typo
>=20
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
>=20
> ---
>  fdisk/sfdisk.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
> index 8bd27da..f81a7fa 100644
> --- a/fdisk/sfdisk.c
> +++ b/fdisk/sfdisk.c
> @@ -930,7 +930,7 @@ out_partition_header(char *dev, int format, struct ge=
ometry G) {
>  	printf(_("   Device Boot   Start       End    #blocks   Id  System\n"))=
;
>  	break;
>      case F_MEGABYTE:
> -	printf(_("Units =3D mebibytes of 1048576 bytes, blocks of 1024 bytes"
> +	printf(_("Units =3D megabytes of 1048576 bytes, blocks of 1024 bytes"
>  		 ", counting from %d\n\n"), increment);
>  	printf(_("   Device Boot Start   End    MiB    #blocks   Id  System\n")=
);
>  	break;
> --=20
> 1.7.4.1

not silly:
http://en.wikipedia.org/wiki/Mebibyte

Have a nice day,
Berny
