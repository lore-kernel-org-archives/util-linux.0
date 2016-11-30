Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49661 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751414AbcK3VzZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Nov 2016 16:55:25 -0500
Subject: Re: [PATCH 1/2] misc: spelling, always use "cannot" instead of "can
 not"
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <1480515830-1408-1-git-send-email-sweet_f_a@gmx.de>
From: Tilman Schmidt <tilman@imap.cc>
Message-ID: <69f6d109-9399-5b36-73cb-a27c82a30110@imap.cc>
Date: Wed, 30 Nov 2016 22:55:22 +0100
MIME-Version: 1.0
In-Reply-To: <1480515830-1408-1-git-send-email-sweet_f_a@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OlK0sUcR3EHqHQO4B59UUpUEHVILE3pP3"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OlK0sUcR3EHqHQO4B59UUpUEHVILE3pP3
Content-Type: multipart/mixed; boundary="BE1WmCrh3qRL3ivFROlm4PVeK3h3TLx3j";
 protected-headers="v1"
From: Tilman Schmidt <tilman@imap.cc>
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Message-ID: <69f6d109-9399-5b36-73cb-a27c82a30110@imap.cc>
Subject: Re: [PATCH 1/2] misc: spelling, always use "cannot" instead of "can
 not"
References: <1480515830-1408-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480515830-1408-1-git-send-email-sweet_f_a@gmx.de>

--BE1WmCrh3qRL3ivFROlm4PVeK3h3TLx3j
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Am 30.11.2016 um 15:23 schrieb Ruediger Meier:
[...]
> diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
> index 1c4313a..a44216b 100644
> --- a/login-utils/sulogin.c
> +++ b/login-utils/sulogin.c
> @@ -1012,7 +1012,7 @@ int main(int argc, char **argv)
>  				mask_signal(SIGINT,  SIG_IGN, &saved_sigint);
> =20
>  				if (failed) {
> -					fprintf(stderr, _("Can not execute su shell\n\n"));
> +					fprintf(stderr, _("cannot execute su shell\n\n"));

Might be better to preserve capitalization here.

>  					break;
>  				}
>  				fprintf(stderr, _("Login incorrect\n\n"));
> @@ -1051,7 +1051,7 @@ int main(int argc, char **argv)
>  				continue;
>  		}
> =20
> -		errx(EXIT_FAILURE, _("Can not wait on su shell\n\n"));
> +		errx(EXIT_FAILURE, _("cannot wait on su shell\n\n"));

And here.

> =20
>  	} while (1);
> =20
[...]
> diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> index bd702b0..e3e6ff6 100644
> --- a/sys-utils/lscpu.c
> +++ b/sys-utils/lscpu.c
> @@ -886,12 +886,12 @@ is_vmware_platform(void)
>  	act.sa_flags =3D SA_SIGINFO;
> =20
>  	if (sigaction(SIGSEGV, &act, &oact))
> -		err(EXIT_FAILURE, _("error: can not set signal handler"));
> +		err(EXIT_FAILURE, _("cannot set signal handler"));
> =20
>  	vmware_bdoor(&eax, &ebx, &ecx, &edx);
> =20
>  	if (sigaction(SIGSEGV, &oact, NULL))
> -		err(EXIT_FAILURE, _("error: can not restore signal handler"));
> +		err(EXIT_FAILURE, _("cannot restore signal handler"));

Why drop the prefix "error: " in these two instances?

Thanks,
Tilman

--=20
Tilman Schmidt                              E-Mail: tilman@imap.cc
Bonn, Germany
Nous, on a des fleurs et des bougies pour nous prot=E9ger.


--BE1WmCrh3qRL3ivFROlm4PVeK3h3TLx3j--

--OlK0sUcR3EHqHQO4B59UUpUEHVILE3pP3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYP0rKAAoJEFPuqx0v+F+qL58H/3m1nRngx7OdvbP0LlJ8LIl0
9mpejGUYa6EAjk6/rDLk7wdLjwksMNN9spJWP0EPdBAFy3JYQOODVIHjckwUdiok
yV1Ma9en491pSyCmuVXJmmWPIV1zDDqD4ensIZxvndha/dcV6E6qxjogEeW8NE1y
qJ/OnKT222CkaC6utsOzUSG9+tGyNpiueIxPbSpoiFi9G/1GiFPzQwPbnIPcHXDX
4iYW5AviVHD5C7b2SWpppcUHRKewjl3+/EVIVqxm8BWdPg0NbEGJZO0ZIZRTvcnh
LyRDTnJaUg7zxp67IvfKp3hXAHSTqH3tGbL2KTpqs8X6WaVCAbpWhntORN3sCsc=
=Zi3/
-----END PGP SIGNATURE-----

--OlK0sUcR3EHqHQO4B59UUpUEHVILE3pP3--
