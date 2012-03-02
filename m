Return-Path: bernhard.voelker@siemens-enterprise.com
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Davidlohr Bueso <dbueso@aomail.uab.es>, Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Date: Fri, 2 Mar 2012 14:22:57 +0100
Subject: RE: [PATCH] lslocks: add personality column
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0F0B038F77@MCHP058A.global-ad.net>
References: <1330693206.23371.0.camel@offworld>
In-Reply-To: <1330693206.23371.0.camel@offworld>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Davidlohr Bueso wrote:

> @@ -248,8 +251,9 @@ static int get_local_locks(struct list_head *locks)
>  			 * separated by ' ' - check <kernel>/fs/locks.c
>  			 */
>  			switch (i) {
> -			case 0:
> -			case 1: /* not intereted! */
> +			case 0: /* not intereted! */
> +			case 1: /* posix, flock, etc */
> +				l->personality =3D xstrdup(tok);
>  				break;

Forgot a break for case 0?

btw: s/intereted/interested/

and a few lines above:
-			 * /proc/locks as *exactly* 8 "blocks" of text
+			 * /proc/locks has *exactly* 8 "blocks" of text

Have a nice day,
Berny
