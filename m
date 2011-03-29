Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor.suse.de ([195.135.220.2]:37566 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab1C2IqZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Mar 2011 04:46:25 -0400
Date: Tue, 29 Mar 2011 10:46:23 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>, Miklos Szeredi <mszeredi@suse.cz>
Subject: Re: [PATCH] umount: allow non-root umount of FUSE even if not in
 fstab
Message-ID: <20110329084623.GC26819@foxbat.suse.cz>
References: <20110328140454.GA4790@foxbat.suse.cz>
 <20110328220344.GQ21093@nb.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
In-Reply-To: <20110328220344.GQ21093@nb.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2011 at 12:03:44AM +0200, Karel Zak wrote:
> On Mon, Mar 28, 2011 at 04:04:56PM +0200, Petr Uzel wrote:
> > I have to admit that I don't like it very much, because:
>=20
> I don't like it too :-)

I'm not surprised :)

>=20
> > - it complicates umount
> > - duplicates code from fusermount
> > - should (???) be implemented using umount helpers
>=20
> [...]
>=20
> > +		/* If this is fuse-based filesystem, allow user unmount even
> > +		 * if the FS is not in fstab.
> > +		 *
> > +		 * Based on fusermount code. */
> > +		if (strcmp(mc->m.mnt_type, "fuse") =3D=3D 0 ||
> > +		    strcmp(mc->m.mnt_type, "fuseblk") =3D=3D 0 ||
> > +		    strncmp(mc->m.mnt_type, "fuse.", 5) =3D=3D 0 ||
> > +		    strncmp(mc->m.mnt_type, "fuseblk.", 8) =3D=3D 0) {
>=20
> Wouldn't be better to always call /sbin/umount.fuse for non-roots (except
> umount -i)?=20

Yes, that's what I meant by umount helpers. The problem is that AFAICS
fuse does not provide this helper.

@Miklos: what do you think? Would it make sense to have umount.fuse
(most likely as symlink to /sbin/mount.fuse)? I could look into it.

>=20
> I believe more and more that we need something like
>=20
>     /etc/mount.d/{fuse,foo,...}.conf
>=20
> where we can define such behavior for some filesystems.

Hm, I fail to understand what (regarding to this 'issue') would
you configure there. I can imagine e.g. per-fs-type default mount
options or enable/disable 'user mounts' (-i) per fs-type.

Is this what you think that should be configured via /etc/mount.d/*,
or something else?

Thanks,

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk2RnF8ACgkQnZxG0T6qDD31PgCeOGNKw3Df59wRbBsjQZsE3kTL
GzUAoIaRHci8tBpy+NBTDYA+faYpjWoc
=+TAd
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
