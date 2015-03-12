Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:57808 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbbCLMAH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Mar 2015 08:00:07 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 18E68AC70
	for <util-linux@vger.kernel.org>; Thu, 12 Mar 2015 12:00:06 +0000 (UTC)
Date: Thu, 12 Mar 2015 13:00:05 +0100
From: Petr Gajdos <pgajdos@suse.cz>
To: util-linux@vger.kernel.org
Subject: Re: prevent cal segfault
Message-ID: <20150312120005.GA10879@laura.suse.cz>
References: <20150312084639.GC9756@laura.suse.cz>
 <20150312110528.GA4637@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
In-Reply-To: <20150312110528.GA4637@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 12:05:28PM +0100, Karel Zak wrote:
> On Thu, Mar 12, 2015 at 09:46:39AM +0100, Petr Gajdos wrote:
> > cal utility segfaults in putp() when setupterm() fails as cal
> > insufficiently checks for setupterm() failure.
> >=20
> > $ TERM=3D cal
> > Segmentation fault
>=20
> I'm not able to reproduce this problem. Anyway you're right that the
> current code is pretty fragile and ignore setupterm() return code is
> bad idea.
>=20
> I have applied a little bit different patch, please test it in your
> environment. The patch is also in stable/v2.26 (for v2.26.1).
>=20
> https://github.com/karelzak/util-linux/commit/2a4b073e8b2d34dfadd8306f7d7=
1957687923bdd

Yes, that works with my original testcase. has_term is better then
*term misuse.

> > --- misc-utils/cal.c.orig	2014-08-26 16:48:45.132654654 +0200
> > +++ misc-utils/cal.c	2015-03-11 14:16:06.075064939 +0100
> > @@ -81,14 +81,22 @@
> >  # endif
> >  # include <term.h>
> > =20
> > -static void my_setupterm(const char *term, int fildes, int *errret)
> > +#if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW) || defined(H=
AVE_LIBTERMCAP)
> > +static const char	*term=3D"";
> > +#endif
>=20
> This seems incorrect, you have moved "#if defined" into another "#if".

Ugh, sure. I have sent you older version of the patch, not the one
=66rom comment 6 of referenced bug.

Thanks!
Petr


--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlUBf8IACgkQGevYtT2kPwNf2ACgmOukQUROYhEt5ZLbAaUdlqNE
LkEAnRAymplnuU97Pts12++yUY/Rg7uM
=wgDu
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
