Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39407 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751946AbdF0QAf (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Jun 2017 12:00:35 -0400
Date: Tue, 27 Jun 2017 18:00:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, luto@kernel.org
Subject: Re: [PATCH 0/5] Ambient capabilities for setpriv
Message-ID: <20170627160033.GA1012@pks-pc>
References: <cover.1498312509.git.ps@pks.im>
 <20170627131401.esuakjnceifwpwn4@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
In-Reply-To: <20170627131401.esuakjnceifwpwn4@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 03:14:01PM +0200, Karel Zak wrote:
> On Sat, Jun 24, 2017 at 04:04:29PM +0200, Patrick Steinhardt wrote:
> > Patrick Steinhardt (5):
> >   setpriv: introduce indirection for `capng_type` enum
> >   setpriv: proxy function checking whether a capability is set
> >   setpriv: proxy function to update capabilities
> >   setpriv: support dumping ambient capabilities
> >   setpriv: support modifying the set of ambient capabilities
> >=20
> >  sys-utils/setpriv.1 |   8 ++--
> >  sys-utils/setpriv.c | 109 ++++++++++++++++++++++++++++++++++++++++++++=
++------
> >  2 files changed, 103 insertions(+), 14 deletions(-)
>=20
> Applied. (You've forgot to add --ambient-caps to usage(), fixed by
> additional commit.)
>=20
> Thanks!

Thanks for applying and the fixup!

Regards
Patrick

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAllSgSEACgkQEXxntp6r
8Sw6FA/7BWNBG/LJEvsR+sBcd3cTk1W/uj5FjHRZNOhOEJN015WugckZbUFyG/KC
Q1cIvwJTaptbCw7TDetncHTRW+MpegzjRFog37VZeOCoKWf42L2EdWi5c2+ahTHH
JsYwT51D/IG5oZotvZiyYOWV9N3w4CC8iON08WuNFBwaZ1BRI2H97lqgnC+RYw9t
7WPOP1QQy6563dxQyctVNAq+SWLoA+nUXQuV7wIAlZTXKV+QL5350Bn7UcJP5iLi
CSzvCkxjbFuyz7WLj/qaHDkqrUR/RCB+BzhVre2kseuo5Xm3LtzLXc8w8cjWt6GR
DdWhXheMduE3m4Ork1vmNSSvt69kN1bnhqQn6NivjaoYHYvCwKY2dszgziWqSA83
+MkPCbbXyFZE5XtxJdVqLlAT9rcxuaVQ6ft91n0O1aDPyOhNHEvh7SPWYUVCUXD1
ekCulfnBd4gR+UDsDaxTZvrGiEVtU/cQ6U6eJrXNFvc9cQdYT1gmkp+KyTInWmnf
e+15HY/RrUdsgePnKXOnZNXT7aOqyTE6r9qfgg2dk5c0C2ZPt+kn5E6RQcpyG5oL
46/qmfXB2Cly8hqnDhzaCjC8zHZty/hjssAdPsgpUGkZ8pAthOMP5ZoSDThkywPm
hzSyCtc09p09QlomHqVsyCHO7Ji+R6NHV7lGBJGS6kyDG8ALa10=
=GbYm
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
