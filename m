Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34780 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab2JJMJy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Oct 2012 08:09:54 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A8A79A3D8B
	for <util-linux@vger.kernel.org>; Wed, 10 Oct 2012 14:09:53 +0200 (CEST)
Date: Wed, 10 Oct 2012 14:09:10 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg colorized output
Message-ID: <20121010120910.GC11072@foxbat.suse.cz>
References: <50752745.4020607@redhat.com>
 <20121010091926.GE28457@x2.net.home>
 <1349861169.2576.4.camel@offbook>
 <20121010093334.GH28457@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
In-Reply-To: <20121010093334.GH28457@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2012 at 11:33:34AM +0200, Karel Zak wrote:
> On Wed, Oct 10, 2012 at 11:26:09AM +0200, Davidlohr Bueso wrote:
> > On Wed, 2012-10-10 at 11:19 +0200, Karel Zak wrote:
> > > On Wed, Oct 10, 2012 at 09:44:05AM +0200, Ondrej Oprala wrote:
> > > > new file mode 100644
> >=20
> > Hehe I actually started doing this last night.
> >=20
> > I'm wondering if we actually need a new lib file for colors. I mean
> > AFAICT, dmesg is the only place we want to use it and I don't see that
>=20
> What about fdisk where we have many dialogs, warnings, hints? :-) It's
> not about colors only, but also about bold, etc.
>=20
> The another possibility is namei(1) where we can provide output
> compatible with ls(1), or cal(1), etc.
>=20
> > changing any time soon - Unix hackers don't like colors, we live oh so
> > boring lives :)
>=20
> All this should be optional. I guess than many people use aliases with
> colors
>=20
> $ alias | grep color
> alias egrep=3D'egrep --color=3Dtty'
> alias fgrep=3D'fgrep --color=3Dtty'
> alias grep=3D'grep --color=3Dtty'
> alias l.=3D'ls -d .* --color=3Dauto'
> alias ll=3D'ls -l --color=3Dauto'
> alias ls=3D'ls --color=3Dauto'

I totally agree. Colored output from various tools could make it
easier to work with, but it has to be optional.

My 2c.


Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlB1ZWYACgkQnZxG0T6qDD2YkACfW0ZUWt9yn4r/XuqYErCr+5dp
kh0AnROYqe7w1SjjEcdlh/bBUnK7PYcR
=ep8V
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
