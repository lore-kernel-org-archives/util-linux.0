Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:50864 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbaKLSwK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Nov 2014 13:52:10 -0500
Date: Wed, 12 Nov 2014 14:51:31 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: kerolasa@gmail.com
Cc: Karel Zak <kzak@redhat.com>, Boris Egorov <egorov@linux.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/6] pull: almost working AddressSanitizer support
Message-ID: <20141112195131.GA3902@vapier.wh0rd.info>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
 <5461B803.4050707@linux.com>
 <CAG27Bk1cDZUtAm26VpY5bugUWchzY7cjqfEDQYxdDJMYZo-q1w@mail.gmail.com>
 <alpine.LNX.2.03.1411112236560.23899@iki.fi>
 <20141112142500.GB5530@x2.net.home>
 <CAG27Bk2-c4_AsqCsBd+uBkkcvX0CSJPW+Q2+JndyGts=ZE1rmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
In-Reply-To: <CAG27Bk2-c4_AsqCsBd+uBkkcvX0CSJPW+Q2+JndyGts=ZE1rmw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12 Nov 2014 15:02, Sami Kerola wrote:
> On 12 November 2014 14:25, Karel Zak <kzak@redhat.com> wrote:
> > On Tue, Nov 11, 2014 at 10:49:02PM +0000, Sami Kerola wrote:
> >>       printf(_("Setting up swapspace version %d, size =3D %s (%ju byte=
s)\n"),
> >>               version, strsz, sz);
> >> +     free(strsz);
> >
> >  free-before-exit, you know what I think about it, right? :)
>=20
> Normally I would agree, but this case is bizarre. The mkswap will
> return 1 when compiled with clang -fsanitize=3Daddress without any
> message what is wrong. That's probably clang bug, which is a different
> topic all together. Adding the free() calls seems to make the
> immediate tests failure issue to go away, that is needed to automate
> sanitize. In case travis && address sanitation is not needed at all
> then these changes does not make sense.

i don't think adding a free to avoid a bug in clang is justified

at least gcc defines __SANITIZE_ADDRESS__ ... so you might be able to gate =
on=20
that with a comment pointing to an open bug report on the clang side
-mike

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUY7pCAAoJEEFjO5/oN/WBho4P/2WmRzEUp5om91jBJYW1a/9X
+xboapgrqxTs0nUHY+MgDyVpPU8sb06Luun+Jrtx/08Id7hfgYYMx0LNbCadzguC
pdmmyl8/DXqqcodFzTcggx8A1PU46M8/xa4ZXSJd/T+RwY8I3zAc8S9+QSTDLL1s
5IlFCGPBgncA631C8d8nsXP1djp99XwUP5Mx5N0OYKjSbYYjzK+ES8Is1VwTdUSm
3VKOtRaR0+LxGlFXGbwtE2v8bXfz/9PnrjTdUONgxi1Qe9zwRPd2GRfE8BvS5V+1
ngqKU6tRbmJwGzoKDhmPKYm2kiJBplgTD0LPPDz29HYabarfqHvlYC81HfwaRF+Q
+Nh36/PGuLumieRcporjOuts7G0RiPkuqyQ9I9EjKuhgihohj2XaWS1J6W0MjpgT
FcJx1jZTdkehLL0gi9QgPK+Fihrm6bLmQC7gfJOyo0IcGkWiLwihshQ9nZJhNlS3
7gb2b3KrKIITy6KHSdV/vAmCBLEZCiN/KB+HKLknFeYsEnbuSvTdWmTtE5CTIv0X
TAdycbtfV9pn6S3vKJxXphl+3v2mKVDvjbLLwN3qkK0un50BUs+zyPF5H8G+mcVQ
9ut4JlgSJum/pgOSRY2VCVRBzNLnfjQyPskZhMGvbq6h/3rr2a04+hToBwnkyXEB
9glaliQuBqvsgFsWQtPC
=NXyr
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
