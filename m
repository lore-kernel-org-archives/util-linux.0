Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:35827 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbbKOG2U (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Nov 2015 01:28:20 -0500
Date: Sun, 15 Nov 2015 01:28:19 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unshare -m for non-root user
Message-ID: <20151115062819.GD31395@vapier.lan>
References: <n0ujgc$tll$1@ger.gmane.org>
 <20151030102247.GF19508@ws.net.home>
 <n2674p$ulm$1@ger.gmane.org>
 <87si49p771.fsf@x220.int.ebiederm.org>
 <n26nkm$13l$1@ger.gmane.org>
 <20151114181716.GA3839@newbook>
 <n287q4$efd$1@ger.gmane.org>
 <n28krj$8i0$1@ger.gmane.org>
 <20151115012418.GC31395@vapier.lan>
 <n28pis$6uv$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
In-Reply-To: <n28pis$6uv$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15 Nov 2015 03:10, U.Mutlu wrote:
> Mike Frysinger wrote on 11/15/2015 02:24 AM:
> > On 15 Nov 2015 01:49, U.Mutlu wrote:
> >> So, then the question remains: how to give non-root user a secure mount
> >
> > no, it doesn't.  at least two people have already told you how to do it:
> > use the usernamespace (-U) option that unshare already supports.
>=20
> It's not yet clear for me how to use that. Can you give an example?
> unshare -U /bin/bash

the unshare(1) man page already includes an example:
$ unshare --map-root-user --user sh -c whoami
root
-mike

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWSCYDAAoJEEFjO5/oN/WBP70QAI1A6+B+pjE4gBfJwlZQ3A0C
S+2Z0JsoLcPcPTfIJXbPj1H18sMq679s1mq+SirkMkFgyYiM3lPiBzi4fUOaiblB
p+NZZPwpCRExMYlzvZJt23wB+DgmLSpGekALrjySTxxJlScU+c6bnAu9HF/CTtb6
qKXNkKK8+1WwsV5bdAJVwGfn3NfYczHw+Gg6iOr52LV6e3Mr51+8IViJJQHf8OFf
MewOPqzm89PqnxkJIptJdxZWhm4i7FyQjJebmBgF87XVi808w2hY8hgtvfnk+6jv
di1x911a+h8hIgc30WDuN/6a1ut96vRL5ZEgHPYYMb7adtpG6L1hn/XiH2PgbHEY
ShSSwXsa9/dc2y9gZxsqLeGVCRL+87wLa/dqI5iPKuiWTBR51i7kQWrNytgiwek7
JcuyTDNgrvOhJAvC6vX0Wj+rMvoRKEBaH1MnnvLwoE2sPk+YFrRMq0760Ntgbz/O
ZUv4iNS0eKkmLgL6YPJC98pPM3u1kCBjZe59D/57YAl2mIvunigVbxf0HyP48nXz
l8pAX3+FFl8JCHt4IpXYPCxmIeEWdHTQBkHjBGIegbny3KnAVE+8NxsQ5+EZqM1r
xKX6k0fSdvZ7hoYf9tWlbB14Ij8DDO9GEPQ6FGs6sjL3bO+MUYhoDNNxAZJGCP7T
WKPzhFWCG00OM26XDMUn
=zX3I
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
