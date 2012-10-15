Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:37005 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab2JOBqe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Oct 2012 21:46:34 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 01/19] last: stop using MAXHOSTNAMELEN
Date: Sun, 14 Oct 2012 21:46:39 -0400
Cc: util-linux@vger.kernel.org
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi> <1350246070-10544-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart75015980.aLbmKnorKF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201210142146.40677.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart75015980.aLbmKnorKF
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 14 October 2012 16:20:52 Sami Kerola wrote:
> --- a/login-utils/last.c
> +++ b/login-utils/last.c
> @@ -418,22 +418,19 @@ addtty(char *ttyname) {
>   */
>  static void
>  hostconv(char *arg) {
> -	static int	first =3D 1;
> -	static char	*hostdot,
> -			name[MAXHOSTNAMELEN];
> -	char	*argdot;
> +	static char *hostdot;
> +	static char *argdot;
> +	static char *name;
>=20
>  	if (!(argdot =3D strchr(arg, '.')))
>  		return;
> -	if (first) {
> -		first =3D 0;
> -		if (gethostname(name, sizeof(name)))
> -			err(EXIT_FAILURE, _("gethostname failed"));
> -
> -		hostdot =3D strchr(name, '.');
> -	}
> +	name =3D xmalloc(sizeof(char) * (sysconf(_SC_HOST_NAME_MAX) + 1));
> +	if (gethostname(name, sysconf(_SC_HOST_NAME_MAX)))
> +		err(EXIT_FAILURE, _("gethostname failed"));
> +	hostdot =3D strchr(name, '.');
>  	if (hostdot && !strcmp(hostdot, argdot))
>  		*argdot =3D '\0';
> +	free(name);
>  }

marking argdot static doesn't make sense

the way you're rewritten things also doesn't make sense to have "name" be=20
static.  i'd go so far as to say it's wrong.  keep the existing "first" log=
ic.
=2Dmike

--nextPart75015980.aLbmKnorKF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQe2sAAAoJEEFjO5/oN/WBnu0QAJwhzDvXg+oQ4/+G6GneuZJP
5hN7Qf2orR/sDd4PtCgUoZJYR5nfeW565iHLB9UI3cSLX/jUirsNkmhpG9eOaeSS
lsmaCWPp7RWSa5/26b4N5pZJMV1bqWYODfT9bFGm3bSsw0IBvSIW9gqgMScTyCV3
HV9d5t+li8BamatjItb63k36qGH7a/wWNCrY3FoqFyy8SHbklEKaNbEAwFo7eIAo
pPS1onfEevcR4xC13e+M5AEr1OYN1SyZHfIs376ZJyNwitrKVcwOsWo8d6SDc/r7
z9uFOzhocqemQRguxVid/amnB1fucR9usiglKrtmceQ6JiuEofR5PwuQ4eBRuwor
BuP3WHFg4GQXYwp530mTjLbC/OtNyNzK61Gr3U6twKckYaweDT5JPmY0o+xfwUye
0vSgCYrxhZTMGFLjckRC8KX3372PWoTpUsr4+W2vd/LxGJtUQRT4uLInOHwn0G37
dH7oTwcX9IzGePOdtBWqtI/jtYzIRU6RFTS+z5FK3bMFxu+CMmQ4XpVf4Cu3GtlI
xO5Xg4tfzaRJ163WDmRuPwSN5LaWG/mLYhAtuN3j+FuCGnue3ox7u4e655Gu74hh
3gw1bBBybH4UQxfg34T+x4qnRrEyH85GPiD9cNbWVPfAigF+pI/jfTCVjnhT7SEW
tea2HnIEZteKZdy+319y
=a4K9
-----END PGP SIGNATURE-----

--nextPart75015980.aLbmKnorKF--
