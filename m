Return-Path: util-linux-owner@vger.kernel.org
Received: from jespernyerup.dk ([109.74.204.79]:42261 "EHLO jespernyerup.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbaDYRjO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Apr 2014 13:39:14 -0400
Date: Fri, 25 Apr 2014 19:39:12 +0200
From: Jesper Dahl Nyerup <nyerup@one.com>
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: util-linux@vger.kernel.org, Martin Topholm <mph@one.com>,
        Vedpal Rajera <vedpalr@one.com>
Subject: Re: Using script(1) to log all user sessions
Message-ID: <20140425173912.GB6197@one.com>
Reply-To: nyerup@one.com
References: <20140425082133.GA3790@one.com>
 <201404251427.s3PERiaV008964@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
In-Reply-To: <201404251427.s3PERiaV008964@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 25  10:27, Dale R. Worley wrote:
> > From: Jesper Dahl Nyerup <nyerup@one.com>
> >
> > 1. Adding a daemon next to script(1) and scriptreplay(1), eg.
> > scriptcollect(1), to be in the receiving end of the traffic, optionally
> > handling the timing functionality, and finally storing data in the same
> > manner script(1) would.
>=20
> You might want to consider using syslog(3) for this.  Or conversely,
> if syslog won't work in your environment, that might indicate
> improvements that are needed in syslog.

We considered that, but kind of gave up on the idea.

Syslog is inherently newline delimited, where as the per-update payloads
=66rom script(1) are pretty much the opposite - one payload will often
contain multiple newlines, others will consist of a single character.

Thus, (de)serializing to and from syslog will probably be more of a
hassle than using it will be a benifit.

J.
--=20
Jesper Dahl Nyerup
Systems Engineer
One.com, nyerup@one.com

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlNanb8ACgkQtzA4yjN/Kb0uYgCffQdz++/6sWdLYyalZXTgmj8q
Y24AoLj2o+AwL2LcYWx/j5ZUBxjdsUUT
=5HjY
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
