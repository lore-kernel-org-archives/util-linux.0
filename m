Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:46802 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbcEWW6c (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 May 2016 18:58:32 -0400
Date: Mon, 23 May 2016 18:58:31 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] cal: drop trailing blank line
Message-ID: <20160523225831.GQ26300@vapier.lan>
References: <1464037332-21996-1-git-send-email-vapier@gentoo.org>
 <5743767D.3010904@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T80Vh+tMmiZ5iF95"
In-Reply-To: <5743767D.3010904@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--T80Vh+tMmiZ5iF95
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23 May 2016 16:30, Bruce Dubbs wrote:
> Mike Frysinger wrote:
> > There's no history to be found behind this, and the comment in the
> > code indicates no one else knows, and it makes me angry :).
> >
> > --- a/misc-utils/cal.c
> > +++ b/misc-utils/cal.c
> > @@ -767,9 +767,6 @@ static void yearly(const struct cal_control *ctl)
> >   		my_putstring("\n\n");
> >   	}
> >   	monthly(ctl);
> > -
> > -	/* Is empty line at the end year output really needed? */
> > -	my_putstring("\n");
> >   }
> >
> >   /*
>=20
> Personally I like the blank line. It sets off the cal output from the=20
> shell prompt making it easier to read.  It is basically adding the=20
> equivalent of the css property padding-bottom=3D"1em".

why should cal care ?  you could make this same exact argument for any
other cli tool that displays things.  if you like that behavior, then
update your PS1 to include a leading \n.

> I note that if doing a 'cal -y' that there is also a blank line between=
=20
> the year and February.  That should stay also.

that's a different issue.  cal always writes exactly 6 lines for a month
regardless of how many weeks a month actually uses.  it makes the code
simpler (no need to scan/remember sibling months) and the output more
consistent -- every row is 7 lines.  pick a non-leap year like 2015 and
see Feb take up only 4 lines but still leave 2 blank below it.  or pick
2019 and see Mar use all 6 lines.
-mike

--T80Vh+tMmiZ5iF95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXQ4sWAAoJEEFjO5/oN/WB9rAP/R/teABMxtv5DjOvKpd6LjNP
jftnti/enFLcLSM0qY03c4Ti8dTz0s9sAHSdPn3I5iCMuQT9mP2Yz1ngLAG8ZD7J
KXkofMN70yc5+pKrJmmBzmRKwErrY+YmOkMhry6XqojPuDU9V7TF7sQvrHC+j8et
2MCvgvVsC0IV8oMziTGfNTEue8AaPaNtElrd0qEO/D3WOrUkPwijg3qHb4CjpyZL
LZmxfZMBpaGS0ENjrEnTSJ0WOazS2eEsLAbFLN4RwBnZ+yQAWOBmoa9/8ugPD81z
gzElEJtLAhe7mrYEvQOFbwPtPsNA5i52eGpJ01I5Mh35JPE8EmblSxSVaPQafnw/
jXzjxkVHhXw3eHUJYIYxxY2Av3LkOHOOm5oyOSkB6y2m3zAvy8AT+RyVvAQWoO7M
iZkA9rhDTGmizGLndG3Gsolcj6hjUbUQ5XTbfSD7BSeEt6lrdJ3cHlaDhsXkz7NU
ExASbHaBsfWEADF5bRMDKCkTlZGyj0u00tz49WDqFqtCaxrovnwysMGvkOBonj2M
P/yAKaEZFUyMG4hGunsXqcuiiZpJV8AN4i4BFLDvsH0k9WKSb9Jd0K4SHZ8A5eaT
ykQZkPDNTH1vVG7Z1cwRFNrbZ140PyoSifogToM5UMLNpGoRYZLFXqJ5T4o7aoxf
KViRICtxUn14YgS5Xz3s
=xjrm
-----END PGP SIGNATURE-----

--T80Vh+tMmiZ5iF95--
