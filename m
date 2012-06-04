Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:58904 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759108Ab2FDKBi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Jun 2012 06:01:38 -0400
Date: Mon, 4 Jun 2012 12:01:11 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/5] fdisk: add device topology to the API
Message-ID: <20120604100111.GA9264@foxbat.suse.cz>
References: <1338747317.2864.10.camel@offbook>
 <20120604090604.GA6290@foxbat.suse.cz>
 <1338803049.2553.5.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
In-Reply-To: <1338803049.2553.5.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2012 at 11:44:09AM +0200, Davidlohr Bueso wrote:
> On Mon, 2012-06-04 at 11:06 +0200, Petr Uzel wrote:
> > On Sun, Jun 03, 2012 at 08:15:17PM +0200, Davidlohr Bueso wrote:
>=20
> Well for now this seemed like the saner way of proceeding, but yes, I'm
> definitely up for debating as I don't like the idea of overwriting the
> discovery. Perhaps an extra parameter in the initialization context for
> flags.

Or better separate function(s) for setting and getting that flag and custom
sector_size to/from the context structure.

> IIRC there are other similar issues that we'll have to deal with
> soon - like user passed CHS.
=20

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk/Mh2cACgkQnZxG0T6qDD0U9QCdHvWqSeJQDwLExanG6p3frkev
zz4An3VbUuuQvb7G67NOZNQpDIWlF2wl
=3ZzN
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
