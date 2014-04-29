Return-Path: util-linux-owner@vger.kernel.org
Received: from jespernyerup.dk ([109.74.204.79]:52368 "EHLO jespernyerup.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933516AbaD2KAb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Apr 2014 06:00:31 -0400
Date: Tue, 29 Apr 2014 12:00:28 +0200
From: Jesper Dahl Nyerup <nyerup@one.com>
To: =?iso-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
Cc: util-linux@vger.kernel.org, Vedpal Rajera <vedpalr@one.com>,
        Martin Topholm <mph@one.com>
Subject: Re: Using script(1) to log all user sessions
Message-ID: <20140429100028.GA31241@one.com>
Reply-To: nyerup@one.com
References: <20140425082133.GA3790@one.com>
 <535D6026.1000709@zoho.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
In-Reply-To: <535D6026.1000709@zoho.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 27  21:53, =C1ngel Gonz=E1lez wrote:
> On 25/04/14 10:21, Jesper Dahl Nyerup wrote:
> >[...] support config files, to supply configurable
> >default values for some of the concepts normally passed in the
> >environment or as command line arguments.
>=20
> You can start it from a script acting as the user shell, through
> sshd config or one of the shell init scripts. As you already need to
> start script somehow, those defaults could be passed there, too
> (although I don't see a problem with supporting config files
> either).

Yes, this is how we have it working in our current test deployments, but
for simplicity we'd like to leave out these steps, and ideally have
users' shell to be /usr/bin/script.

> >1. Adding a daemon next to script(1) and scriptreplay(1), eg.
> >scriptcollect(1), to be in the receiving end of the traffic, [...]
>=20
> I'm unsure about this bit. It may be needed. Perhaps a transfer
> after the session finishes also works.

We also considered that, but we keep running in to theoretical corner
cases where this could end up being a problem - logging in on systems
with filled up mountpoints, securing the transcript even if the system
crashes, and so on.

> >2. Optionally linking against some crypto library to avoid putting
> >users' console data on the wire in clear text.
>=20
> Following unix philosophy, I would try to avoid reinventing crypto
> into the program, attempting instead to solve the issue by eg. using
> sftp to transfer the files and/or gpg to encrypt the data.

I fully agree with this concern. This is just a necessary follow up, if
we want to natively enable network support in script(1).

However as both you and others have suggested us to reconsider this, and
as we also were pretty doubtful about this ourselves, we will probably
find an alternative transport method, one way or the other.

> PS: I expect you are properly warning your users about the
> fascist-level logging done on your systems.

I appreciate your concern for our users.

These users are myself as well as my colleagues, and we all have a
shared interest in maintaining audit trails and tracebacks of who did
what, when and where.

I can assure you that everyone are aware of these measures.

Yours,
--=20
Jesper Dahl Nyerup
Systems Engineer
One.com, nyerup@one.com

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlNfeDwACgkQtzA4yjN/Kb10iwCfTZqy0m8DrkxKuwQ0ysnAz9mF
A7UAn0N3LV6C7k1ys+bDn1Qx8YmOB1nE
=OZ2Q
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
