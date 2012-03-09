Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:38039 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753760Ab2CIOWR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Mar 2012 09:22:17 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BF75B8FFDD
	for <util-linux@vger.kernel.org>; Fri,  9 Mar 2012 15:22:16 +0100 (CET)
Date: Fri, 9 Mar 2012 15:22:16 +0100
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: mount -f regression in v2.21's new-mount
Message-ID: <20120309142216.GA7991@foxbat.suse.cz>
References: <20120309105304.GF17711@x2.net.home>
 <5fde29ffbccb41cf5eb3a286c2f7e954@quantum.linuxfromscratch.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <5fde29ffbccb41cf5eb3a286c2f7e954@quantum.linuxfromscratch.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 04:30:02AM -0700, Matthew Burgess wrote:
>=20
> Thanks!  Is there a consensus opinion on whether users should be
> using a regular mtab or a symlink to /proc/self/mountinfo?

I've seen a couple of quite nasty bugs with regular mtab (caused by
the fact that /etc/mtab got out of sync with /proc/self/mounts) so
I'd recommend to avoid regular /etc/mtab wherever possible.

My 2c,

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9aEhgACgkQnZxG0T6qDD3xcwCdGzjcZxpFcJeIZ+UNqxOxRbU4
c/YAn3911QfzIrK07XNf6hFI6e6rGRsO
=jFxw
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
