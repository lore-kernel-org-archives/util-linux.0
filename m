Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:35480 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756Ab1JLIzo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Oct 2011 04:55:44 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id D876F8B2F9
	for <util-linux@vger.kernel.org>; Wed, 12 Oct 2011 10:55:43 +0200 (CEST)
Date: Wed, 12 Oct 2011 10:55:43 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] fdisk: don't shorten long path to disk device
Message-ID: <20111012085543.GC11839@foxbat.suse.cz>
References: <1318252338-11200-1-git-send-email-petr.uzel@suse.cz>
 <20111012082550.GA9667@nb.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
In-Reply-To: <20111012082550.GA9667@nb.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2011 at 10:25:50AM +0200, Karel Zak wrote:
> On Mon, Oct 10, 2011 at 03:12:17PM +0200, Petr Uzel wrote:
> > fdisk/partname.c:partname() uses fixed 80 char static buffer for partit=
ion
> > name. This might be not enough if the used path to the disk device is l=
ong
> > enough, e.g.
> [...]
> > -	static char bufp[80];
> > +	char *bufp;
>=20
> Hmm, after review... your idea to increase the static buffer
> size to PATH_MAX seems less invasive ;-)
>=20
>  -       static char bufp[80];
>  +       static char bufp[PATH_MAX];

I agree.

Thanks,

    P.


--
Petr Uzel
IRC: ptr_uzl @ freenode

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk6VVg8ACgkQnZxG0T6qDD2v7QCeKgJj1l+Vh7u8x/KXi+Dn2W2k
jAgAn0nHO9orbwuNJ4R1+RCDuywiogfa
=HXYB
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
