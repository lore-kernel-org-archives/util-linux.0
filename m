Return-Path: util-linux-owner@vger.kernel.org
Received: from vint.altlinux.org ([194.107.17.35]:55141 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab2KNXy2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 14 Nov 2012 18:54:28 -0500
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id A2C9B226C099
	for <util-linux@vger.kernel.org>; Wed, 14 Nov 2012 23:54:27 +0000 (UTC)
Date: Thu, 15 Nov 2012 03:54:27 +0400
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: util-linux@vger.kernel.org
Subject: Re: vlock command
Message-ID: <20121114235426.GE20303@altlinux.org>
References: <20121114103509.GD1835@x2.net.home> <50A37AD8.6060601@gmail.com> <20121114122207.GE1835@x2.net.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
In-Reply-To: <20121114122207.GE1835@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2012 at 01:22:07PM +0100, Karel Zak wrote:
> On Wed, Nov 14, 2012 at 03:04:56PM +0400, Alexey Gladkov wrote:
> > http://git.altlinux.org/people/ldv/packages/vlock.git
>=20
>  it seems the same code as the original vlock-1.3

It was surely based on the same vlock-1.3 code, and it has essentially the
same features list, but it's hardly the same code. :)

> > Some time ago, I have merged this version in kbd project:
> >=20
> > http://git.altlinux.org/people/legion/packages/kbd.git?p=3Dkbd.git;a=3D=
tree;f=3Dsrc/vlock;h=3D92419b98175d215a71f83bfb06b409daa97b13c4;hb=3D768b8c=
314e1d3c465d895b206da4aa4543914d1d
> >=20
> > I have a collection of utilities for manipulation in console (openvt,
> > chvt, deallocvt ...) I consider logical to have the utility for
> > terminal blocking.
> >=20
> > What do you think?
>=20
>  Well, vlock is mostly about authentication,

About authentication?  Well, could you then explain why do you keep that
7 year old vlock-1.3-morepam.patch from Nalin in Fedora vlock package?
It does something unnatural for vlock, e.g. pam_acct_mgmt and even
pam_setcred!  At the same time, the only module in its account stack is
pam_permit.so.  Weird.


--=20
ldv

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlCkLzIACgkQfKvmrJ41Nh5G3gCcDM8limz5XO/fdG0Z5pU2igHj
a54AnRIwbsFJ0AB9EFpUwb1mBDMzNaxm
=IPdA
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
