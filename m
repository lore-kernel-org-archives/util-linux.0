Return-Path: petr.uzel@suse.cz
Date: Mon, 14 May 2012 11:53:15 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid,uuidd: move read_all to include/readall.h
Message-ID: <20120514095315.GB4335@foxbat.suse.cz>
References: <1336894676-25586-1-git-send-email-petr.uzel@suse.cz>
 <20120514094601.GC16926@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
In-Reply-To: <20120514094601.GC16926@x2.net.home>
List-ID: <util-linux.vger.kernel.org>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2012 at 11:46:01AM +0200, Karel Zak wrote:
> On Sun, May 13, 2012 at 09:37:56AM +0200, Petr Uzel wrote:
> >  include/Makefile.am    |    1 +
> >  include/readall.h      |   33 +++++++++++++++++++++++++++++++++
> >  libuuid/src/gen_uuid.c |   26 +-------------------------
> >  misc-utils/uuidd.c     |   25 +------------------------
> >  4 files changed, 36 insertions(+), 49 deletions(-)
> >  create mode 100644 include/readall.h
>=20
>  Good idea, but do we really need writeall.h and readall.h ? ;-) What
>  about to merge both files? (all-io.h ?)

Sounds good, I'll merge them.

Thanks,

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+w1gsACgkQnZxG0T6qDD3FuwCeKGlAp3dU0HsTWCmXG6T6lEOK
QmoAnjQm86F1O6WpTj0fMdXPRuEHA2Hz
=GH1v
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
