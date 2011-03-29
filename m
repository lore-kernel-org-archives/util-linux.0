Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor.suse.de ([195.135.220.2]:38043 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928Ab1C2I4D (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Mar 2011 04:56:03 -0400
Date: Tue, 29 Mar 2011 10:56:01 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Miklos Szeredi <mszeredi@suse.cz>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] umount: allow non-root umount of FUSE even if not in
 fstab
Message-ID: <20110329085601.GD26819@foxbat.suse.cz>
References: <20110328140454.GA4790@foxbat.suse.cz>
 <20110328220344.GQ21093@nb.net.home>
 <20110329084623.GC26819@foxbat.suse.cz>
 <1301388690.22846.88.camel@tucsk.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
In-Reply-To: <1301388690.22846.88.camel@tucsk.pomaz.szeredi.hu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2011 at 10:51:30AM +0200, Miklos Szeredi wrote:
> On Tue, 2011-03-29 at 10:46 +0200, Petr Uzel wrote:
> > > Wouldn't be better to always call /sbin/umount.fuse for non-roots (ex=
cept
> > > umount -i)?=20
> >=20
> > Yes, that's what I meant by umount helpers. The problem is that AFAICS
> > fuse does not provide this helper.
> >=20
> > @Miklos: what do you think? Would it make sense to have umount.fuse
> > (most likely as symlink to /sbin/mount.fuse)? I could look into it.
>=20
> Could umount.fuse allow umount of fuse filesystem even if not in fstab?

Yes, as far as I understand.

> If so, then I don't see any problem with providing /sbin/umount.fuse.

OK, I'll try to look into it.

>=20
> Thanks,
> Miklos

Thanks,

        Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk2RnqEACgkQnZxG0T6qDD1DcQCffRz3eeeRRp80sSqr2CPNHj1a
7oMAoIABAWE3xyCqqgTDADYq9ooS2i7Q
=Qth3
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
