Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:44787 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbaBHL0K (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 8 Feb 2014 06:26:10 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: setarch treats all x86 variants as i686?
Date: Sat, 08 Feb 2014 06:26:10 -0500
Message-ID: <1445010.UmVgbvgH5k@vapier>
In-Reply-To: <52F3F660.8060600@ubuntu.com>
References: <52F3F660.8060600@ubuntu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart26283328.TSaDdkPDee"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart26283328.TSaDdkPDee
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thursday, February 06, 2014 15:53:52 Phillip Susi wrote:
> setarch i486
> uname -m
> i686
>=20
> Is this a bug?

no.  setarch is merely calling the kernel and the kernel is doing this.=
  see=20
`man personality` for more details.
=2Dmike
--nextPart26283328.TSaDdkPDee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJS9hRSAAoJEEFjO5/oN/WBOZcP/iwu5ADDF3YABq0wqcg/vKd9
YaQ3Ci7smxNvSo6LxbX+tsyvwz7MiJReYwE5IXfTJKX1B9HIpuYaSLRr2Mya+zDy
7PX4Ks8TzZN4rKdMdDssFXmFTjrfkCnfNSZHVfwW0xMwuxK5opkILzp41DKK3FA9
tBcQk/+pB5p8tiuNBzBa8JCJJVq9osIWnJY/l6sfb5O74jA+6HeOeDF8y7FsHiFg
psDDKHklFpKghwcM9sMI3VamPqKxwCe0iSjKTb3ICuZ44qfwLHudYAhGCkGWAqq3
BWgxnc7kQp6lJcWQyM+Ney7elmfAK7s75aP7l8NB6SwWJilN6Lo1cp2911F+ph/A
IC4TbQ3l1BoOyWUR8haEA7Ju1GIPDF582XWIB5rJnOMmjffLSQHzeyoOzjRWwDUe
bUYWRL6TwaCQzcgwpMTo9CZ2oE8Of45NVehs81R+I96GWuesAaNC5UOpA/+ZogpR
0AX46EXaAzfr/0JO9RBqExhbilP1UgDGmP4IxIKTvmqtE+9cfaxUUmsVlSwsQJZu
fl8nO7flHivUkpTka/EumABg6A28ZuiWyFjHYchAQUiE4CbQAVE4D3XHW1asoAlu
xWppJ56feEWQoUQIoxINchJMDa6UHq2GeLL01WA16EZcU6W3Gqcho0kgAyr8Yjcl
1LcVaKjMGGzLGW6FU0PZ
=UJ72
-----END PGP SIGNATURE-----

--nextPart26283328.TSaDdkPDee--

