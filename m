Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:59712 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750879AbdFPRYW (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 16 Jun 2017 13:24:22 -0400
Date: Fri, 16 Jun 2017 10:24:15 -0700
From: "W. Trevor King" <wking@tremily.us>
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: Identical commits?
Message-ID: <20170616172415.GA8561@valgrind.tremily.us>
References: <594546ee-275e-bce4-6578-4676009c2922@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <594546ee-275e-bce4-6578-4676009c2922@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 10:48:25AM -0400, J William Piggott wrote:
>=20
> This seems unusual, two identical commits:
>=20
> --- patch.1	2017-06-15 14:07:08.316861600 -0400
> +++ patch.2	2017-06-15 14:07:25.964305209 -0400
> @@ -1,4 +1,4 @@
> -commit b1557fe98120132e6671924af4ed69f4e21d3de4
> +commit 3a5ce6e7efe62e1f583c090f907bf8518ce2f4ba
>  Author: Sami Kerola <kerolasa@iki.fi>
>  Date:   Tue May 16 09:18:24 2017 +0100
> =20
> @@ -35,7 +35,7 @@
>   	FILE *stream =3D status ? stderr : stdout;
>  =20
>  diff --git a/login-utils/last.c b/login-utils/last.c
> -index c90b574..50451b2 100644
> +index f93ec7f..d230deb 100644

This can happen if you rebase a commit, and the files you touch have
changed in the meantime, but your original hunks still apply without
any conflicts or changes in the context.  In this case, the
surrounding history looks like:

  $ git log --graph --topo-order --oneline --decorate e228735 | head -n9
  *   e228735 Merge branch 'master' of ra.kernel.org:/pub/scm/utils/util-li=
nux/util-linux
  |\ =20
  | *   2a38433 Merge branch 'sami-fallthrough' of https://github.com/rudim=
eier/util-linux
  | |\ =20
  | | * 3a5ce6e misc: fix ggc-7 fallthrough warnings
  * | | 098a75a wall: fix OSX getgrouplist, gid_t* vs int*
  * | | bda2676 misc: POSIX usage dd, regarding unit suffixes
  * | | 5abaf5b tests: add more tests for line(1)
  * | | b1557fe misc: fix ggc-7 fallthrough warnings

So 2a38433, for whatever reason, decided to pull in the 3a5ce6e
version of that commit, while the first-parent branch decided to pull
in the b1557fe version.  It ends up being a bit redundant, but
shouldn't cause problems.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpgNNa8H/zemHkt2gprXBz9Wld7YFAllEFD4ACgkQprXBz9Wl
d7ZI4A/9FU9D21/5p9XOb9YKfQB14sfLpMijxFRQFAkU6fzpZzb2y1i2YXn19EjQ
5BT4h41cCGJMX2INzdaXa+lATUMU7zDWB5EWOrglzaEt1My7Y0TH1UcRp9Hyp33Q
wxRUIdw0n3Omxixo2tOO+Uln5NaPKR9qFJbh4aAWWBorUfIQ9g+BDQKRtkUEYO4x
HiaIwYO8kIMp+BDHd58b9KOe2WBhWECqvFSt1XSsqCz1w9bdhWnL5PzyryvSDjp0
iE9/dPEYeM8JeWcbvBm4WJrYUdyMolQpf+vkemKcXHLW8fa0320S61OtX7cuAHfg
c/RMzQZ0kYyM+U89eYpTHxIaY7pfbyKwECGdhRr3Le6rh1gG1pDLLmWExq38SY/o
R7DOxraB5wU/xEVqIydNPpLYqUixQ6y7xCK+00piMf1GabzhI+OH76TaMOPns5Rn
/ozzXCJoHIQ/Kxvc8zlI8tEimxmid8J9ETr0njqFqCHbsKrsCHWSG6iua9GNq8jT
8SbvD6/TkM6tvjPAp1yav65wrJnRw4GNzj/Zyn+zn1u2/Nx1HL5MNNVSGlImD8Xf
xf+NrerwXDF6kjQwba7uPZKd5/VWCUtRDXXkcliKvCK2TJ8sznA6iwZMsYqORm62
r15BqJrzu7QhJMygdb0we4Y8hspRLD1rZKniv9CghFf6LOBwQIY=
=61Yp
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
