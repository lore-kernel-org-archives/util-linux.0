Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:49378 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084Ab2IUL0K (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Sep 2012 07:26:10 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 6960699430
	for <util-linux@vger.kernel.org>; Fri, 21 Sep 2012 13:26:09 +0200 (CEST)
Date: Fri, 21 Sep 2012 13:25:57 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] fdisk: add guid
Message-ID: <20120921112557.GM10748@foxbat.suse.cz>
References: <1345550594.2664.5.camel@offbook>
 <20120921111253.GA18699@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nb8zVy0QMK3AA1xu"
In-Reply-To: <20120921111253.GA18699@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2012 at 01:12:53PM +0200, Karel Zak wrote:
> On Tue, Aug 21, 2012 at 02:03:14PM +0200, Davidlohr Bueso wrote:
> >  fdisks/cfdisk.c         |    2 +-
> >  fdisks/common.h         |   16 ++++-
> >  fdisks/fdiskbsdlabel.h  |   38 +++++-----
> >  fdisks/fdisksgilabel.c  |   38 +++++-----
> >  fdisks/fdisksunlabel.c  |   34 ++++----
> >  fdisks/i386_sys_types.c |  198 +++++++++++++++++++++++----------------=
-------
> >  6 files changed, 169 insertions(+), 157 deletions(-)
> [....]
> > +
> > +/* Globally unique identifier */
> > +struct fdisk_guid {
> > +	uint32_t   time_low;
> > +	uint16_t   time_mid;
> > +	uint16_t   time_hi_and_version;
> > +	uint8_t    clock_seq_hi;
> > +	uint8_t    clock_seq_low;
> > +	uint8_t    node[6];
> > +};
> > =20
> >  struct systypes {
> > -	unsigned char type;
> > -	char *name;
> > +	uint16_t          type;
> > +	struct fdisk_guid guid;
> > +	const char        *name;
> >  };
>=20
> I don't like this hack. On all places in fdisk where we need systypes
> is available fdisk_context struct where is ideal place to store label
> specific stuff (ideally by any label specific function in fdisk_label).

I'd say that creating label specific info in fdisk_context and moving
such stuff there would be the next step. Doing it the other way round
(which I agree would be nicer) would mean quite a lot of work given
what we have now. Would it help if we extended this patchset with
requested label specific stuff (and related cleanup) ?


Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--nb8zVy0QMK3AA1xu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlBcTsUACgkQnZxG0T6qDD3IAwCePu5D/Yzkjp57+eAISBAAZbYp
gGgAn3uQKwBarjg0KVELT+7VlBvscDv5
=YbB7
-----END PGP SIGNATURE-----

--nb8zVy0QMK3AA1xu--
