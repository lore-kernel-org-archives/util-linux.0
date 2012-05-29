Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:50978 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab2E2Iku (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 29 May 2012 04:40:50 -0400
From: Thomas Schwinge <thomas@codesourcery.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/7] last, login, write: Provide a fallback for MAXHOSTNAMELEN, as elsewhere.
In-Reply-To: <20120529081025.GJ3757@x2.net.home>
References: <1337969621-3052-1-git-send-email-thomas@codesourcery.com> <1337969778-3154-1-git-send-email-thomas@codesourcery.com> <1337969778-3154-3-git-send-email-thomas@codesourcery.com> <20120529081025.GJ3757@x2.net.home>
Date: Tue, 29 May 2012 10:40:26 +0200
Message-ID: <8762bfbcsl.fsf@schwinge.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue, 29 May 2012 10:10:25 +0200, Karel Zak <kzak@redhat.com> wrote:
> On Fri, May 25, 2012 at 08:16:14PM +0200, Thomas Schwinge wrote:
> > Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
> > ---
> >  login-utils/last.c  |    8 ++++++++
> >  login-utils/login.c |    8 ++++++++
> >  term-utils/write.c  |    8 ++++++++
> >  3 files changed, 24 insertions(+), 0 deletions(-)
>=20
>  I have moved the fallback for MAXHOSTNAMELEN to c.h, it seems better
>  than duplicate the code.  Thanks.

Yes, of course that makes even more sense.  Thanks also for applying the
others.


Gr=C3=BC=C3=9Fe,
 Thomas

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPxIt7AAoJENuKOtuXzphJbqgIALObF5AnFh2OOSuuDM8f62MW
Z6Nes9y96mroNPjDBLcRQVmFC66MHWGC4J7v2Ypk8gdT5tq6+Srs2N4Y0+/rhZqq
y85dB8ESNzh3nHjyRUFoN0B+t3wzdinWJJVbrtdi388PhIrhCWly2EEQjHJt/6DA
Y3yeTajSysZg7R3qCKOf/lTXsmpMnU+Tmn3PoJXbWIzPujBQBlXH/OP7lJkCpYr6
lzxe0yYYS9bndrxa93MjP9Ro0b4vkC1zrC0kMvTl3XB05dLjUCPJOAMzcLSgCVPt
04X1H8pP6CmxhSe1t6m3Cfjr1AKt44XhHtX0i90P+hoYrZsZoQZlTalAv+2fnN4=
=aPuv
-----END PGP SIGNATURE-----
--=-=-=--
