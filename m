Return-Path: util-linux-owner@vger.kernel.org
Received: from jespernyerup.dk ([109.74.204.79]:45383 "EHLO jespernyerup.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577AbaDZV1R (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 26 Apr 2014 17:27:17 -0400
Date: Sat, 26 Apr 2014 23:27:15 +0200
From: Jesper Dahl Nyerup <nyerup@one.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Vedpal Rajera <vedpalr@one.com>,
        Martin Topholm <mph@one.com>
Subject: Re: Using script(1) to log all user sessions
Message-ID: <20140426212715.GA14316@one.com>
Reply-To: nyerup@one.com
References: <20140425082133.GA3790@one.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
In-Reply-To: <20140425082133.GA3790@one.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Karel,

On Apr 25  10:21, Jesper Dahl Nyerup wrote:
> This could involve:
>=20
> 1. Adding a daemon next to script(1) and scriptreplay(1), eg.
> scriptcollect(1), to be in the receiving end of the traffic, optionally
> handling the timing functionality, and finally storing data in the same
> manner script(1) would.
>=20
> 2. Optionally linking against some crypto library to avoid putting
> users' console data on the wire in clear text.
>=20
> Ideally we'd like to upstream any changes we make, and this post serves
> as an attempt to gauge the mood and ask for guidance as to which
> direction you guys think we should take our efforts.

Do you think functionality like this belongs in script(1) et al., and do
you think you'd accept the patches, if they look sane?

J.
--=20
Jesper Dahl Nyerup
Systems Engineer
One.com, nyerup@one.com

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlNcJLMACgkQtzA4yjN/Kb312ACePqJLupwBzL6nAS5CWdihucdw
TTwAoMlW5ngdGMr6MpctzEUHO9X8SLVD
=I+Ia
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
