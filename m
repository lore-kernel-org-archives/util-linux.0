Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:45946 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753849AbdFWWH6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 18:07:58 -0400
Date: Fri, 23 Jun 2017 15:08:04 -0700
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 8/8] sys-utils/mount.8: Document libmount defaults
Message-ID: <20170623220804.GA17923@valgrind.tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
 <17bff7efa55b6ff4f04cf795de8b5d771cf43441.1498252231.git.wking@tremily.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <17bff7efa55b6ff4f04cf795de8b5d771cf43441.1498252231.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 02:30:26PM -0700, W. Trevor King wrote:
> to mount(2).  But these libmount options dare only defined in

Typo: s/dare/are/.  I'll fix this in v3, but if you end up picing up
the v2 version of this patch, feel free to fix my commit message
locally.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpgNNa8H/zemHkt2gprXBz9Wld7YFAllNkUMACgkQprXBz9Wl
d7ZMJxAAnaA9CTE3arcoPnTwFJeDQQi6+cjKPfN79taqWd8YmKqn775dGom5lCbT
ecRMQeVIoL38/0A0YxWmLb4bwBy06o4Zz3wxOkdrWyfXUDLfESPEqmXIzmRzmK+b
Lxe6HIdJptgLntPrjZHjcsanX513XPRQUM69nC09ZdzbBIhKVlGpOPRwi79QsEdc
xWdSy5beFs4ZvrumZA51lb87o6X4G9uLdsenh55JWCIrs4SoB2N6ddlg/zYI4+s9
382wrUVeIGgwK9FSNL8UKG5euXIYqmTUnIeovvGU+SEsb3AFRWXhzJPfi67A2kHU
ioeLmAW39yFBRHI9clYwVznmvyWg+3eP776v4aud7o4juNgXrAn3IRhdWIYgKUhv
0is7+MRzzHra/sqnx27YNTIdGOptdWbEdEcjqXy6nXWm2y7ZGWsCM5n9MyblGNZ1
fxaKkwJUOnQd5iNq/S/2SqRayZnjXAnxHpdWmrjNIKTCb7MM42AjbZ1yPKXlWWtK
igSEacokVvdMqZ79UrzyefNnnTsuQELsUP1Z49IO1Fc7j0+iyiHQe8PQnzyxLr2b
p8s6E+cVoZFDg4ivKfznt0JEUxDaHBVoai6SAeJjLTtiat6d9W5bFg7zCipMnVuW
aXOc/0u2brVIonO9PoOPWy0tPhWXXbHrWtUTohCo18PlwAJ+Lfw=
=7Sw2
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
