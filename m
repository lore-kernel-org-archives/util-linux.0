Return-Path: petr.uzel@suse.cz
Date: Mon, 14 May 2012 11:47:25 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] lib/tt: make get_terminal_width available externally
Message-ID: <20120514094725.GA4335@foxbat.suse.cz>
References: <1336981918-18123-1-git-send-email-petr.uzel@suse.cz>
 <20120514094208.GB16926@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
In-Reply-To: <20120514094208.GB16926@x2.net.home>
List-ID: <util-linux.vger.kernel.org>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2012 at 11:42:08AM +0200, Karel Zak wrote:
> On Mon, May 14, 2012 at 09:51:57AM +0200, Petr Uzel wrote:
> > Also, rename get_terminal_width() to tt_get_terminal_width()
> > to match naming convention of other exported functions.
>=20
>  That's overkill to compile whole tt.c (for example for blkid) for
>  this one simple function.  What about to add get_terminal_width() to
>  include/ttyutils.h as a static function?

Hm, right, that would be much better. I'll send a new patch.

Thanks,

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+w1K0ACgkQnZxG0T6qDD37JQCgjOkyokS0DmC+uDqdvzCcGZ4v
kfkAn3iNiYakvUt/Dj4lu/+GaC2wHKmo
=KSoS
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
