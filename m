Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:44809 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab2BWRFS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 23 Feb 2012 12:05:18 -0500
Date: Thu, 23 Feb 2012 18:05:17 +0100
From: Petr Uzel <petr.uzel@suse.cz>
To: Keshav P R <the.ridikulus.rat@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] fdisk.8: update information about GNU Parted
Message-ID: <20120223170516.GC12306@foxbat.suse.cz>
References: <1330011815-18517-1-git-send-email-petr.uzel@suse.cz>
 <CAMPnHXzmn=cUWmLQRvfJXnGMvjoLBAXE-HqhckMOsLXZhf_WSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
In-Reply-To: <CAMPnHXzmn=cUWmLQRvfJXnGMvjoLBAXE-HqhckMOsLXZhf_WSg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2012 at 10:24:09PM +0530, Keshav P R wrote:
> On Thu, Feb 23, 2012 at 21:13, Petr Uzel <petr.uzel@suse.cz> wrote:
> > The support for resizing partitions and filesystems has been
> > removed from parted since version 3.0.
> >
>=20
> http://git.savannah.gnu.org/cgit/parted.git/commit/?id=3D42f3d8e9b9aa686a=
4849be8837b0837e19f84445

Those are changes to the libparted library. With parted(8) you can
not resize the partitions or filesystems. And while I hope that I will
be able to find some time to finish my FS-agnostic resize patch for
parted, I don't think the possibility to resize any FS from parted
will be included.

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9GccwACgkQnZxG0T6qDD2zDwCbBRccQtQI4VAbe1e+/CF6y3X5
T+QAn1+UhZwN4Y+DNGkszXPAcZKp+YYh
=/zBf
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
