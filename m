Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:34680 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbbH0AQf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Aug 2015 20:16:35 -0400
Date: Wed, 26 Aug 2015 20:16:34 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Kees Cook <keescook@chromium.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] libmount: handle arbitrary line length for mounts
Message-ID: <20150827001634.GJ3116@vapier>
References: <20150826224923.GA11884@www.outflux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
In-Reply-To: <20150826224923.GA11884@www.outflux.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 26 Aug 2015 15:49, Kees Cook wrote:
> --- a/libmount/src/mountP.h
> +++ b/libmount/src/mountP.h
> @@ -212,6 +212,8 @@ struct libmnt_table {
>  	int		comms;		/* enable/disable comment parsing */
>  	char		*comm_intro;	/* First comment in file */
>  	char		*comm_tail;	/* Last comment in file */
> +	char		*buf;		/* Memory for reading lines */
> +	size_t		buf_size;	/* Size of line-reading buffer */

just to be clear, this structure is zero-allocated right ?  getline
needs the first call to have buf==NULL in order for everything to
fall into place.
-mike

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3lbiAAoJEEFjO5/oN/WBZyEP/1nx8poPHZNd+AROW9zPzA5o
SiNH+SK3DywBahx85grh4macvfceoVTNyOEkWkoKRfLxiBdo09IWVckkdf0Iz3hJ
dXf8yogOKW6gnFTlLD/CyYkYhPPBXG5Iz3ihCdbRPw2q+ll5YKgQhFyfDj1QFUOm
SojajfnDJ/CiTxkGWDM/0A1RwPXMlEKNoUPFfcBOAHgM01eSohiy17nP+jSMwm9p
QzzihNiZMEkz4uuufzXLMKMrCBMlxIX2AvOj6gdGtPP8CFhRgrVl0VBx2OaJNcSr
RFb/vHZuyWi+qerF6YYjK5l8JOOB7VQF/U75hF6FarR89u4/iBLZLUQkU4zpdc0f
/nW1kski2DYtexLjmP/8I7xNAldf58ttx1twsfulVZS1nUVkNGBHYmsntNWAkFuA
d5RBUXOIgfKydSCGeILvh4tzkfrsbrhf1A7JDvaa42ZYvtw+5X/KUPr/aZQvwfwl
G6iFJSYWSx7v34pAxlLD9bB0Jvk5vYo+vlgawLfUPtUCQuVYWZkKdAzakJqfDjXy
AzXBXK/bkmRgmkrxrmrMnAXCXFxTMwJmTQ2jCWE3tMBAyF9MGvgWzrh7naod0uWu
uD5VFlcwBP8NlHC/eu4b8y02Z+rKIcm9AlcoyDIfJ+ddkozJZqHvSWzyc0OHHeLA
lGGvd/N22zmJ9Phk/CLC
=nDv7
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--
