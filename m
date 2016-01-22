Return-Path: tilman@imap.cc
Subject: Re: [PATCH] mkswap: Add warnings for insecure device
 permissions/owners
To: Sarah Newman <srn@prgmr.com>
References: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
 <20160120103042.clphjleuiesjrl52@ws.net.home> <56A1596C.3060507@prgmr.com>
Cc: Karel Zak <kzak@redhat.com>, "Wayne R. Roth" <wayneroth42@gmail.com>,
        util-linux@vger.kernel.org
From: Tilman Schmidt <tilman@imap.cc>
Message-ID: <56A25241.8050000@imap.cc>
Date: Fri, 22 Jan 2016 17:01:05 +0100
MIME-Version: 1.0
In-Reply-To: <56A1596C.3060507@prgmr.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ENOfwWqAwJvKJJ6VvTjppmdN0e2L9KPTx"
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ENOfwWqAwJvKJJ6VvTjppmdN0e2L9KPTx
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Am 21.01.2016 um 23:19 schrieb Sarah Newman:
> This patch does not break any existing behavior. The worst case possibi=
lity from accepting this patch is it will annoy some people, and best cas=
e it
> will save millions of devices from being shipped with insecure permissi=
ons.

The worst case is it will train millions of administrators to ignore
warning messages.

--=20
Tilman Schmidt                              E-Mail: tilman@imap.cc
Bonn, Germany
Nous, on a des fleurs et des bougies pour nous prot=E9ger.


--ENOfwWqAwJvKJJ6VvTjppmdN0e2L9KPTx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWolJLAAoJEFPuqx0v+F+q+BcH/A8W9LcJWWLKwzDYo5/ZYPHY
KNIgQ65OHtFcDobffBFZlh5ZdcPb5wUQvDKvoKuiEo4CBfY7crWJ0Fh5nqO2/Q6+
RFEfd/klwqBWXCqBLJrcKwuzOeajyCRX1Rzoo/9wfYcGmKLSYX8PE1r3egxCaXtv
TVWryAOrXjRAT9bFkYTHTmMy+OH5i4hgISarQNRLPxxcxtphhDPT3D+zXsmpXNcn
pvav8Z/3WxRRdJwaMQZFa/C5Jt0w/U4c6+vSoUQ2V0QD677BUplGLggdtAcxdeb7
xellrVdpc1GHpdPQzyisADeqFkAL+NcfoLy3yZPZbl+LLeDg8l9ydaXR6hs4e98=
=KmUb
-----END PGP SIGNATURE-----

--ENOfwWqAwJvKJJ6VvTjppmdN0e2L9KPTx--
