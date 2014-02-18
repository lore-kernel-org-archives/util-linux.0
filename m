Return-Path: util-linux-owner@vger.kernel.org
Received: from jespernyerup.dk ([109.74.204.79]:43347 "EHLO jespernyerup.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074AbaBRKVo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Feb 2014 05:21:44 -0500
Date: Tue, 18 Feb 2014 11:21:42 +0100
From: Jesper Dahl Nyerup <nyerup@one.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] script: Also flush writes to timing file.
Message-ID: <20140218102142.GA10373@one.com>
Reply-To: nyerup@one.com
References: <1392673386-42128-1-git-send-email-nyerup@one.com>
 <CAG27Bk2pvdG_Gewxqo8Q=q_2qExCf=u2vvFjmrgvLnYSmvQe+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
In-Reply-To: <CAG27Bk2pvdG_Gewxqo8Q=q_2qExCf=u2vvFjmrgvLnYSmvQe+Q@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 18  10:08, Sami Kerola wrote:
> On 17 February 2014 21:43, Jesper Dahl Nyerup <nyerup@one.com> wrote:
> > If both -f and -t are given, flush the timing fd on each write, similar
> > to the behavior on the script fd. This allows playback of still-running
> > sessions, and reduces the risk of ending up with empty timing files when
> > script(1) exits abnormally.
>=20
> Instead of flushing all the time how about checking write status at
> the end? See attached patch how that could work.

That's a good idea, and should take care of the scenario where an
abnormal exit leads to empty timings The other use case however,
scriptreplay(1)'ing transcripts while script(1) is still running, would
not be improved upon.

Besides, the man page describes the -f option behavior as `Flush output
after each write`. I would expect this to apply to the timing fd as
well, and honoring this description was the main purpose of my patch.

I think it'd be great if both patches were applied.

J.
--=20
Jesper Dahl Nyerup
Systems Engineer
One.com, nyerup@one.com

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlMDNDYACgkQtzA4yjN/Kb224wCgiH7ZI7onUWaavqlZOoJ4GtZH
BEIAnAynUKf1OlbHRtct/Q/EqJZdvhv6
=Pwj1
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
