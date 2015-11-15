Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:45321 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbbKOMmS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Nov 2015 07:42:18 -0500
Date: Sun, 15 Nov 2015 07:42:11 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unshare -m for non-root user
Message-ID: <20151115124211.GA5949@vapier.lan>
References: <n2674p$ulm$1@ger.gmane.org>
 <87si49p771.fsf@x220.int.ebiederm.org>
 <n26nkm$13l$1@ger.gmane.org>
 <20151114181716.GA3839@newbook>
 <n287q4$efd$1@ger.gmane.org>
 <n28krj$8i0$1@ger.gmane.org>
 <20151115012418.GC31395@vapier.lan>
 <n28pis$6uv$1@ger.gmane.org>
 <20151115062819.GD31395@vapier.lan>
 <n29sg5$15j$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
In-Reply-To: <n29sg5$15j$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15 Nov 2015 13:06, U.Mutlu wrote:
> Mike Frysinger wrote on 11/15/2015 07:28 AM:
> > On 15 Nov 2015 03:10, U.Mutlu wrote:
> >> Mike Frysinger wrote on 11/15/2015 02:24 AM:
> >>> On 15 Nov 2015 01:49, U.Mutlu wrote:
> >>>> So, then the question remains: how to give non-root user a secure mo=
unt
> >>>
> >>> no, it doesn't.  at least two people have already told you how to do =
it:
> >>> use the usernamespace (-U) option that unshare already supports.
> >>
> >> It's not yet clear for me how to use that. Can you give an example?
> >> unshare -U /bin/bash
> >
> > the unshare(1) man page already includes an example:
> > $ unshare --map-root-user --user sh -c whoami
> > root
>=20
> No, firstly there is no such example in man unshare, secondly it doesn't =
do here:
> $ unshare --map-root-user --user sh -c whoami
> unshare: unshare failed: Operation not permitted
>=20
> Is there maybe a bug in the Debian version?

complain to Debian.  iirc, they break their kernels on purpose by adding
non-standard caps which disallow userns usage.

> And thirdly: is that not even more dangerous to give a user root permissi=
on=20
> then? I don't understand this philosophy. Or, where is the trick in this?

you aren't actually root.  you'll probably want to read:
	https://lwn.net/Articles/532593/
	man user_namespaces
-mike

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWSH2jAAoJEEFjO5/oN/WBm4gP/AxcFcZAa/3uifsANnyNREUr
fq0Q2oYwIlcclrvLEImbca1kapQEpUDPzh1JowoIu7yA1ZTUrV7xEAmV3lKXOAVo
bTQzvHPIP583JwbcD/Osr6GGXeVQNKb463M6kgkwt+fu/MnldsAUQQO1g8ER7Xvu
xzljilKppX4xyD0tlaOs+Fpm5eLrqmVlnrn/0+p/4CeC5Cy/gtUq7Zc8Z+mpjzYG
dfyLz+WUf72FtkMqSdcPQKAKBsrvJZsaSfrfTjbHBg9xmyFnEiyyk5Aazc+I25AY
ya64cojjVMBuhN+Yig0Qs0+89y7xoFi4TnkmxxNcE7vd4ydbyGadvnu8phvYzkbG
SvNsDr7XF8Qg/GOEDj6AkDgIsMQ1Z2NAlfyPwIMrdqANOnDoZCXT8LizeKN5zTUq
hm1CUkglgZKEKreXPmkUhpJJ8k2oITquLRSlyTgnHvatmE2nwgeHnw7oji7C7mj5
a/KVXosi80RZyNl8rnO0WPV2VE4LTHbPFK2bvMcBa5eaf3ZwQXvzG83bfXExUcBc
xHIjEQt5IdaAvL5uZRxXr2D+bCJA034uex24lGW8C31cnN8Jlq3T9NtrXtHDLmon
4UtrbhGv5nbQkl96eaLTYaDI7i/c8TagZt+FpG3zGn+fT9UDiQAg6STt8KTSMtIt
5tMc0QNWA56+wDW0Xgkj
=fVKF
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
