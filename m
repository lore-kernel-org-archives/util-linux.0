Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:53086 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbcEXBCq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 May 2016 21:02:46 -0400
Date: Mon, 23 May 2016 21:02:45 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] cal: drop trailing blank line
Message-ID: <20160524010245.GS26300@vapier.lan>
References: <1464037332-21996-1-git-send-email-vapier@gentoo.org>
 <5743767D.3010904@gmail.com>
 <20160523225831.GQ26300@vapier.lan>
 <57439324.90809@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SUTdwQX8hmY7TaNH"
In-Reply-To: <57439324.90809@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--SUTdwQX8hmY7TaNH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23 May 2016 18:32, Bruce Dubbs wrote:
> Mike Frysinger wrote:
> > On 23 May 2016 16:30, Bruce Dubbs wrote:
> >> Mike Frysinger wrote:
> >>> There's no history to be found behind this, and the comment in the
> >>> code indicates no one else knows, and it makes me angry :).
> >>>
> >>> --- a/misc-utils/cal.c
> >>> +++ b/misc-utils/cal.c
> >>> @@ -767,9 +767,6 @@ static void yearly(const struct cal_control *ctl)
> >>>    		my_putstring("\n\n");
> >>>    	}
> >>>    	monthly(ctl);
> >>> -
> >>> -	/* Is empty line at the end year output really needed? */
> >>> -	my_putstring("\n");
> >>>    }
> >>>
> >>>    /*
> >>
> >> Personally I like the blank line. It sets off the cal output from the
> >> shell prompt making it easier to read.  It is basically adding the
> >> equivalent of the css property padding-bottom=3D"1em".
> >
> > why should cal care ?  you could make this same exact argument for any
> > other cli tool that displays things.  if you like that behavior, then
> > update your PS1 to include a leading \n.
>=20
> I certainly do not want to double space every bash prompt.  Your solution=
=20
> causes more problems than it solves.

if you want to special case `cal` or any other util, then alias it in
your shell.  your personal preference for a util doesn't mean it should
stay that way.  the trailing newline is uncommon in the cli world.

> >> I note that if doing a 'cal -y' that there is also a blank line between
> >> the year and February.  That should stay also.
> >
> > that's a different issue.  cal always writes exactly 6 lines for a month
> > regardless of how many weeks a month actually uses.  it makes the code
> > simpler (no need to scan/remember sibling months) and the output more
> > consistent -- every row is 7 lines.  pick a non-leap year like 2015 and
> > see Feb take up only 4 lines but still leave 2 blank below it.  or pick
> > 2019 and see Mar use all 6 lines.
>=20
> Did you look at the output?

i thought you were talking about the inter-month spacing.  i don't care
about either of those, nor does my change impact them.
-mike

--SUTdwQX8hmY7TaNH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXQ6g0AAoJEEFjO5/oN/WBUAQP/R7qOdUuD6ADoyVfAjO4wtGE
9cB8GE/aPjJXSSSRd0XSaHp4cc6Lh4niBjZCxbQya2Q5m5Bfrrskvn82OCB8V1t7
tG+3jN9m11IQFuf4vzVvdTh11E2s6+DQs++3RRkkjxrUsl0lTcatQ0L8P3J+5MJQ
VcbakhRsZijxCdqYlOaq95C4/r+/933Bj3TXopPcZ+9Fc32AfhvNjEbQ4mFU+SiF
jz5fxVxbghEy5OTFz/hTNGeALHyus3jeprqXp3Eawk0TbihO9CEGxtfQnByzJp+8
sm/i208kcV/fDsDjt7ePEHpLsRa1/Ay1/IsxWgTfONaRrBm9SriDUl9bVYfM9Dyj
bGK+aipcg+7pYkMjzDVyBNQs8SomjbrJlWAjrrgOaPM0g5eahrDXarIMN+b8AzJZ
9l9g23nAEaylyFQ9F2PNtpISg0jw4Kq/Av9vw4ib6TzicoIjTu+Dl1utcyvVX6Av
P0FTv2mtLuJQzTAt7pFsh5j2WT2c4qTqnvJBhUcRhH7CypSBGcBqsAZk1kbtFks7
hNHg9ZmX7oSNVVrKJ9s986PscBlXLjEDKSekv2oCqPg26PYDgHg7KYeUJ67KJ0uU
wmmzuDg12tctKrNo937fVAR60lOytuO+tKxUYBdW/W1fRilIraXd1UEK5/ystLLf
0iu1KBl7G9YqPDgIKpLW
=79OW
-----END PGP SIGNATURE-----

--SUTdwQX8hmY7TaNH--
