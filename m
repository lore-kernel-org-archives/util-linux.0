Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:58647 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032Ab2GXKnI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 06:43:08 -0400
Date: Tue, 24 Jul 2012 12:42:49 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 03/10] fdisk: API: add fdisk_label_change
Message-ID: <20120724104249.GF2086@foxbat.suse.cz>
References: <1342976704.2863.13.camel@offbook>
 <500E6F49.60406@bernhard-voelker.de>
 <20120724095617.GD2086@foxbat.suse.cz>
 <500E79B9.9030701@bernhard-voelker.de>
 <1343126347.2686.4.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
In-Reply-To: <1343126347.2686.4.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2012 at 12:39:07PM +0200, Davidlohr Bueso wrote:
> > >> Shouldn't we use something else than hardcoded "sun"|"dos"|"sgi"|...
> > >> strings here?=20
> > >=20
> > > What's the problem with these strings? I think these are well
> > > recognized with clear meaning. What alternative do you propose?
> >=20
> > Sorry, I should've proposed this already in my first mail:
> >=20
> > -	fdisk_label_change(cxt, "sun");
> > +	fdisk_label_change(cxt, sun_label.name);
=20
Ah, right. Deduplicating the strings makes sense, IMO.

> I'm planning on adding the disklabel type (numeric) to the context
> structure in a near future, so we'd then have two ways of identifying
> labels. I really do not see much difference between numbers and strings
> - this is not a performance critical program.

The concern here is not speed, but maintainability ;)

Best,

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlAOfCkACgkQnZxG0T6qDD0XygCfe50a2FBdkDr7eGzNVPfnhg2l
ATEAoIIohw7WaX7FRM7i2df1PAkejVwF
=qdm5
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
