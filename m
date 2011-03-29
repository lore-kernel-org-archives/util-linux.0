Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:56321 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab1C2IIC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Mar 2011 04:08:02 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id D43958730A
	for <util-linux@vger.kernel.org>; Tue, 29 Mar 2011 10:08:01 +0200 (CEST)
Date: Tue, 29 Mar 2011 10:08:01 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Miklos Szeredi <mszeredi@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] umount: allow non-root umount of FUSE even if not in
 fstab
Message-ID: <20110329080801.GB26819@foxbat.suse.cz>
References: <20110328140454.GA4790@foxbat.suse.cz>
 <1301322200.22846.68.camel@tucsk.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
In-Reply-To: <1301322200.22846.68.camel@tucsk.pomaz.szeredi.hu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 28, 2011 at 04:23:20PM +0200, Miklos Szeredi wrote:
> On Mon, 2011-03-28 at 16:04 +0200, Petr Uzel wrote:
> > Hi all,
> >=20
> > I hacked the following patch with which it is possible to use=20
> > "umount $dir" instead of "fusermount -u $dir", which IMHO is an
> > improvement in usability. It seems to work (at least for me), however,
> > I have to admit that I don't like it very much, because:
> > - it complicates umount
> > - duplicates code from fusermount
>=20
> And this is not the only one that would have to be duplicated.  The
> mount and umount races that were fixed in fusermount in recently and not
> so recently would also have to be added to util-linux, which would
> actually be a good thing, since in theory they could affect fstab based
> user mounts as well (though that is much more unlikely than with fuse,
> where the user chooses the mountpoint).

Do you mean this commit:

8b3a0c74a15e237eb4b7053774600f0ce3fff403=20
Fix race if two "fusermount -u" instances are run in parallel.=20

?

> > - should (???) be implemented using umount helpers
>=20
> The end goal is to implement permission checking for unprivileged mount
> and umount in the kernel.

OK, that sounds reasonable. Not something I'd have guts to look into,
though :)


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk2Rk2EACgkQnZxG0T6qDD1AzACcCmYG1LnLsPHksxHWAnpXKJvq
WacAn0chNVq6n8fC+nELk5CDIUR4/wVK
=TFPr
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
