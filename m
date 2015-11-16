Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:47586 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbbKPETc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Nov 2015 23:19:32 -0500
Date: Sun, 15 Nov 2015 23:19:31 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unshare -m should not be a privileged option
Message-ID: <20151116041931.GC5949@vapier.lan>
References: <n2besp$j56$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
In-Reply-To: <n2besp$j56$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16 Nov 2015 03:26, U.Mutlu wrote:
> I'm proposing that "unshare -m" should not be a privileged option,

what you're asking for is not coming from util-linux.  unshare is merely an
interface to the unshare() syscall.  if you dislike the security semantics
there, you can post to the namespace mailing list:
https://lists.linuxfoundation.org/mailman/listinfo/containers

> Therefore the -m option (and maybe even most of the other options) of uns=
hare
> should be made to work for users, without needing root permission.

they do already -- with user namespaces.  if you give people the ability to
mount anything in the existing mount namespace, you open up attacks:
- create an ext2 fs as the user with some setuid programs
- create a new mount namespace
- mount that image
- instant root

> The other solution via user namespace is IMHO overkill and in my case=20
> impractical and irritating because user gets a root-prompt (#)
> eventhough it is only inside the user namespace.

so remap it to your own user instead of to root

> As said in previous postings of mine: "chmod u+s unshare" does what I nee=
d,

i would like shell access to your systems please.  free root is fun.
-mike

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWSVlTAAoJEEFjO5/oN/WBNGcP/j1ooJ6/TQlYZVeiUvgoK5z8
xfV+TPDViH99SzaI7GupC0eIAiRvGyILwTCkLaJ6Xy2BTKO/z09bNh7PvW8iG80J
Aj7IN3mV3eK+thr4IWSueXIptQKL8VRDqg9pZlt4K+VptkP82TcvstJrFbJeN7/H
FnIZSfm8/cnbvV4ScFpc89vUxT3Nkp+F949hLYxKxem23lVrbrdK/5rIgNVrjsmL
KQQfC0VboTEno9CWbSkG11M5MjuqcruQMKqd1pm7R/2vgw2IcR94JbtHquSrBc35
maupT0WHChpdPV4EK2TWBlXprIbe9gNXNdikVa+ChIljCY9E14WVqLeoZC4QGAXp
+ZJcWz/yGvZKUEyePVgSx6czCdjmXyy92TOde3blsXG1jbDB8d8vps1e1xEkOmRM
a0mxPsUpLuDLaZtaTsM9djYG2UD4NDHSEU9T8BxI13Hxein8ET3JJgXlO7hw21Jf
wLyWWrw0U918eGNH8iNMKcfc/rNveklQ1kjxcmYNIucjZT6pTkEdt/ilrhQJlVVd
8A2WxCisW19JYLnIrxuVnbFD8YSVPYDUok/m1w/jfoqLAyVvTpZa0N3U+9i7sYQY
hTc/SCx2X2L00NNEttxGJaWXYmpp2cH+BN2HHLvmlADIW0o766ICCUlt2hjpHpoj
aqcnA9o8oksEp8AVRzJA
=YQhU
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
