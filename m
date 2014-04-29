Return-Path: util-linux-owner@vger.kernel.org
Received: from jespernyerup.dk ([109.74.204.79]:52533 "EHLO jespernyerup.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933004AbaD2LKH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Apr 2014 07:10:07 -0400
Date: Tue, 29 Apr 2014 13:10:06 +0200
From: Jesper Dahl Nyerup <nyerup@one.com>
To: Karel Zak <kzak@redhat.com>
Cc: =?iso-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>,
        util-linux@vger.kernel.org, Vedpal Rajera <vedpalr@one.com>,
        Martin Topholm <mph@one.com>
Subject: Re: Using script(1) to log all user sessions
Message-ID: <20140429111005.GC31241@one.com>
Reply-To: nyerup@one.com
References: <20140425082133.GA3790@one.com>
 <535D6026.1000709@zoho.com>
 <20140429100028.GA31241@one.com>
 <20140429104240.GA12056@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
In-Reply-To: <20140429104240.GA12056@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 29  12:42, Karel Zak wrote:
> On Tue, Apr 29, 2014 at 12:00:28PM +0200, Jesper Dahl Nyerup wrote:
> > > >1. Adding a daemon next to script(1) and scriptreplay(1), eg.
> > > >scriptcollect(1), to be in the receiving end of the traffic, [...]
> > >=20
> > > I'm unsure about this bit. It may be needed. Perhaps a transfer
> > > after the session finishes also works.
> >=20
> > We also considered that, but we keep running in to theoretical corner
> > cases where this could end up being a problem - logging in on systems
> > with filled up mountpoints, securing the transcript even if the system
> > crashes, and so on.
>=20
> You don't have to transfer the logs after finished session, but in
> small segments (script(1) only add new entries to the file). The same
> idea uses large databases for on-line backups
> (http://www.postgresql.org/docs/8.1/static/backup-online.html)

Good idea. But then we might as well pipe the output directly to some
rsh, avoiding the data to touch storage in the first place.

> The another (IMHO the best) possibility is to log into systemd journal,=
=20
> it supports all necessary advantages. See
>=20
>   http://www.freedesktop.org/software/systemd/man/sd-journal.html
>=20
> for example sd_journal_stream_fd(). I'm not sure, but it's probably
> already possible to somehow mirror the journal over network or log to
> remote machine.

That's a good idea =E2=80=93 we'll look into that. Sadly some of the systems
where we'd want this won't be running systemd for the next few years.

Yours,
--=20
Jesper Dahl Nyerup
Systems Engineer
One.com, nyerup@one.com

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlNfiI0ACgkQtzA4yjN/Kb1gDwCgtHfK9yPjqpkMWbZ9jTmx1Jtm
iRMAoKKUBUyyidnYNlNeoZ7qxeEcqL0e
=ROIa
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
