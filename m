Return-Path: util-linux-owner@vger.kernel.org
Received: from jespernyerup.dk ([109.74.204.79]:52529 "EHLO jespernyerup.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933706AbaD2LFN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Apr 2014 07:05:13 -0400
Date: Tue, 29 Apr 2014 13:05:12 +0200
From: Jesper Dahl Nyerup <nyerup@one.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Vedpal Rajera <vedpalr@one.com>,
        Martin Topholm <mph@one.com>
Subject: Re: Using script(1) to log all user sessions
Message-ID: <20140429110511.GB31241@one.com>
Reply-To: nyerup@one.com
References: <20140425082133.GA3790@one.com>
 <20140428071320.GK2405@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
In-Reply-To: <20140428071320.GK2405@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 28  09:13, Karel Zak wrote:
> On Fri, Apr 25, 2014 at 10:21:34AM +0200, Jesper Dahl Nyerup wrote:
> > [...] support config files, to supply configurable
> > default values for some of the concepts normally passed in the
> > environment or as command line arguments.
>=20
>  OK.

We will produce a patch for this, and submit it fow review.

> > Secondly, we're considering to add functionality for script(1) to
> > transmit the session transcript over the network to a collection daemon,
> > to be able to store transcripts from multiple machines on one or more
> > central systems.
>=20
>  Hmm.. "Every program attempts to expand until it can read mail. Those
>  programs which cannot so expand are replaced by ones which can."
>=20
>  I like git concept: here are files and it's your problem to transfer the
>  staff over the network. You can use rsync, http, ssh, ...
>=20
>  Maybe all you need is to store timing and typescript data to the one
>  place (e.g. /var/log/typescripts/user/<timestamp>.{session,timing})
>  and use ssh or so to transfer the data to another place.

I see your point.

Storing the files locally before transferring them away has a number of
drawbacks, for instance logging in on systems with filled up
mountpoints, data loss during crashes on systems without persistent
storage, tampering, and so on.

We'll probably end up piping the transcript data to ssh(1), and have
something collecting the data remotely. One of the challenges is to
ensure this transport mechanism doesn't end up blocking the user's
terminal session, in case of network problems or other offload
difficulties.

Thank you all for you input.

Yours,
--=20
Jesper Dahl Nyerup
Systems Engineer
One.com, nyerup@one.com

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlNfh2cACgkQtzA4yjN/Kb0CCQCeK2F891HoE0RLvS6KcyL+Ldpn
l48An2BYu2lwX9Maqc7GZ/At74flTxpG
=jWYL
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
