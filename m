Return-Path: util-linux-owner@vger.kernel.org
Received: from jespernyerup.dk ([109.74.204.79]:41229 "EHLO jespernyerup.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbaDYI3E (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Apr 2014 04:29:04 -0400
Date: Fri, 25 Apr 2014 10:21:34 +0200
From: Jesper Dahl Nyerup <nyerup@one.com>
To: util-linux@vger.kernel.org
Cc: Vedpal Rajera <vedpalr@one.com>, Martin Topholm <mph@one.com>
Subject: Using script(1) to log all user sessions
Message-ID: <20140425082133.GA3790@one.com>
Reply-To: nyerup@one.com
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi list,

We're toying with the idea of using script(1) to log all user sessions
towards a collection of systems, as one in a number of metheds to aid
debugging, education and auditing.

In order to do so, I have a couple of questions regarding a few
extensions we're considering to implement.

Firstly, script(1) is clearly and sanely designed to be invoked from the
command line to record a limited portion of a user's session. In order
for the user to have the logging started without manual invocation, it
may come in handy to support config files, to supply configurable
default values for some of the concepts normally passed in the
environment or as command line arguments.

Secondly, we're considering to add functionality for script(1) to
transmit the session transcript over the network to a collection daemon,
to be able to store transcripts from multiple machines on one or more
central systems.

This could involve:

1. Adding a daemon next to script(1) and scriptreplay(1), eg.
scriptcollect(1), to be in the receiving end of the traffic, optionally
handling the timing functionality, and finally storing data in the same
manner script(1) would.

2. Optionally linking against some crypto library to avoid putting
users' console data on the wire in clear text.

Ideally we'd like to upstream any changes we make, and this post serves
as an attempt to gauge the mood and ask for guidance as to which
direction you guys think we should take our efforts.

Yours,
--=20
Jesper Dahl Nyerup
Systems Engineer
One.com, nyerup@one.com

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlNaGw0ACgkQtzA4yjN/Kb3LTQCeJzZKki2gg+svjF5Rh+EXKXsB
ULIAnjk0yU9pr1garz/E4gcNpEzHsbGs
=Dryp
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
