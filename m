Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60845 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750731AbdBNWko (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Feb 2017 17:40:44 -0500
Subject: Re: [PATCH] Fix word repetitions
To: Yuri Chornoivan <yurchor@gmail.com>, util-linux@vger.kernel.org
References: <1486724704-8127-1-git-send-email-yurchor@gmail.com>
From: Tilman Schmidt <tilman@imap.cc>
Message-ID: <4628c807-c74f-fe57-2cab-6690fa94d4d7@imap.cc>
Date: Tue, 14 Feb 2017 23:40:34 +0100
MIME-Version: 1.0
In-Reply-To: <1486724704-8127-1-git-send-email-yurchor@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="30Knt6TBUcSnQHpaJoi6HCJ14o2uTj9RB"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--30Knt6TBUcSnQHpaJoi6HCJ14o2uTj9RB
Content-Type: multipart/mixed; boundary="h5QNkMvPxx3L2bM75kPnHPHQ0qrVvin6v";
 protected-headers="v1"
From: Tilman Schmidt <tilman@imap.cc>
To: Yuri Chornoivan <yurchor@gmail.com>, util-linux@vger.kernel.org
Message-ID: <4628c807-c74f-fe57-2cab-6690fa94d4d7@imap.cc>
Subject: Re: [PATCH] Fix word repetitions
References: <1486724704-8127-1-git-send-email-yurchor@gmail.com>
In-Reply-To: <1486724704-8127-1-git-send-email-yurchor@gmail.com>

--h5QNkMvPxx3L2bM75kPnHPHQ0qrVvin6v
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Am 10.02.2017 um 12:05 schrieb Yuri Chornoivan:

> diff --git a/misc-utils/look.c b/misc-utils/look.c
> index 93c388e..bb0d965 100644
> --- a/misc-utils/look.c
> +++ b/misc-utils/look.c
> @@ -171,7 +171,7 @@ look(char *front, char *back)
>  	int ch;
>  	char *readp, *writep;
> =20
> -	/* Reformat string string to avoid doing it multiple times later. */
> +	/* Reformat string to avoid doing it multiple times later. */
>  	if (dflag) {
>  		for (readp =3D writep =3D string; (ch =3D *readp++) !=3D 0;) {
>  			if (isalnum(ch) || isblank(ch))

Actually I don't think this is a word repetition. It looks to me like
it's really talking about "string string" - the string held in the
variable named "string".

> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 21caeb2..e561859 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -712,7 +712,7 @@ display_time(const bool hclock_valid, struct timeva=
l hwctime)
>   * runnable by issuing the command "date" to the /bin/sh shell. That m=
eans
>   * in must be in the current PATH.
>   *
> - * If anything goes wrong (and many things can), we return return code=
 10
> + * If anything goes wrong (and many things can), we return code 10
>   * and arbitrary *time_p. Otherwise, return code is 0 and *time_p is v=
alid.
>   */
>  static int interpret_date_string(const char *date_opt, time_t * const =
time_p)

Nor is this, as it talks about the return code that will be returned.

Regards,
Tilman

--=20
Tilman Schmidt                              E-Mail: tilman@imap.cc
Bonn, Germany
Nous, on a des fleurs et des bougies pour nous prot=E9ger.


--h5QNkMvPxx3L2bM75kPnHPHQ0qrVvin6v--

--30Knt6TBUcSnQHpaJoi6HCJ14o2uTj9RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYo4dsAAoJEFPuqx0v+F+qy6IH/0Gp85rCAjwssUv0qazX4XFA
4mRxqDKA29gTsJGVt1ZlnjUzJ/OTiGljGzg/7TUYGCI4S0xbjYJQ8EyBfUJVvsZ+
Y2UjbVwBJI+FEZFf2ut6wqy119AyYA9ryQvkiIYe2iLgj7DROGnTpB9EPMtSMF/b
qXbc7OhcoaTswiSG2ZsrJZ2yZTyCGqxdDGwrtzKiCfgdQLWAl6bUMu6Hok/k5DTD
25IOwBl4srnmwHnd6QiBQdF0NLkqeJQe1P0H4IkU3xU0vISEn9BQveq0z+Ter6T1
cSDfgHDJPfu/SlguVwUOSgRV5MZbS9RXzqwjf/B32euQeHbv+U2L063i/H0kkcI=
=rDly
-----END PGP SIGNATURE-----

--30Knt6TBUcSnQHpaJoi6HCJ14o2uTj9RB--
