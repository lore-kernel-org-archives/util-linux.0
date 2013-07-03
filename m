Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:44145 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab3GCRI3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Jul 2013 13:08:29 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH/RFC] unshare: add --fork/--mount-proc options for pid namespaces
Date: Wed, 3 Jul 2013 13:08:30 -0400
Cc: util-linux@vger.kernel.org, ebiederm@xmission.com, mtk.manpages@gmail.com
References: <1372377898-2602-1-git-send-email-vapier@gentoo.org> <201307011047.05595.vapier@gentoo.org> <20130703103635.GA722@x2.net.home>
In-Reply-To: <20130703103635.GA722@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1687781.CeJcPbUnSM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201307031308.31557.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1687781.CeJcPbUnSM
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 03 July 2013 06:36:35 Karel Zak wrote:
> On Mon, Jul 01, 2013 at 10:47:04AM -0400, Mike Frysinger wrote:
> > On Monday 01 July 2013 07:40:08 Karel Zak wrote:
> > > On Thu, Jun 27, 2013 at 08:04:58PM -0400, Mike Frysinger wrote:
> > > > When it comes to pid namespaces, it's also useful for /proc to
> > > > reflect the current namespace.  Again, this is easy to pull off, but
> > > > annoying to force everyone to do it themselves.  So let's add a
> > > > --mount-proc to do the magic for us.
> > > =20
> > >  This is not so easy. For example on Fedora 18 the default is "shared=
":
> > > =20
> > >  # grep /proc /proc/self/mountinfo
> > >  14 33 0:3 / /proc rw,nosuid,nodev,noexec,relatime shared:5 - proc pr=
oc
> > >  rw
> > > =20
> > >  it means that unshare( CLONE_NEWNS ) has no expected effect and the
> > >  following mount(/proc) has horrible impact for all system. You have
> > > =20
> > >  to use (for example):
> > >     mount --make-rprivate /proc
> > >     unshare --fork --mount-proc --pid
> >=20
> > i'm not quite following here.  are you saying that Fedora 18 by default
> > makes it hard to do pid namespaces ?
>=20
>  /proc does not have to be private. You have to call
>=20
>     mount("none", "/proc", NULL, MS_PRIVATE|MS_REC, NULL);
>=20
>  to be sure that unshare(CLONE_NEWNS) makes any effect. It's mistake
>  to blindly call
>=20
>     unshare( CLONE_NEWNS );
>     mount("proc, "/proc", "proc", 0, NULL);
>=20
>  If we want to add --mount-proc to unshare(1) than the implementation has
> to be robust. Your current patch is dangerous on systems where /proc is
> shared.

well, it usually does more:
	unshare(...);
	fork();
	mount(...);

but if just adding MS_PRIVATE makes it work w/out needing to do=20
unshare(NEWNS), that's even better.  i'm not familiar with that flag as it'=
s=20
not in the mount(2) man page (looks like it's listed as a TODO).

>  It would be also nice to support optional argument to specify the
>  mountpoint --mount-proc[=3D<mountpoint>].
>=20
>  See the patch below -- works for me.

Acked-by: Mike Frysinger <vapier@gentoo.or>
=2Dmike

--nextPart1687781.CeJcPbUnSM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJR1FqPAAoJEEFjO5/oN/WBcOYP/ix15mFNMKRTxBxwrBp6LU74
Gu3swP6J28V2cPJyfAyf8SLWm7qZ3GHDkP7QCVEvRP62whYMXau3lImetaAckZNr
y8D5dvcJVuM3aoZFLSxXV9R6SVZe0ERohIEsR9VkzBq1WtwAnefXKskcOqAMKk48
/kFH37okq0BIZd4dK6FuKC6U99j5keEMpx12V4V+3Mfl/bjCtrabUMTDn7VqIFKJ
usyDS2JFaShzI8lK3euiPJFQhn8KyfHK7FTjLDV+RLq8EI7Msz+wvjRHsBYF146s
pxdi3W0vsRyLYhnsPKxE3zkLc6AGn7EZN3/rKs3fgMH1bUAqw33VyNkPuTpWQb28
GvdElK0fM7uuCq9mhuqk+5eVbec3QKh+Qd9VFqK1VYZ0n2F8MX9k1Z4+JwzUZRJ6
QnValpA0j0AUjYnkQImdyWQcarHqiOVSNaYDCcPv2eaMUSSZ+SwywL0BV3aDmGUa
2UgJLVUPnk5OZsE5w3B6wjBxUNJZrpHOHT6I0a5+KYK38F9CwFhcPnFiMZXpzLl+
ywMe0knycLmz+meqCfgoON7kntTTC5rIzwHkECx55jr/njoC3Yp3pqPGxHhGKFoQ
u7Mir8LyvadAKpYWHI0WD+Rjm4Hls+bBmKmT3YX6ZmmadYRE+AfLTLB3H9IRMegk
HRA8kt0lb/MBhZzMX7I+
=bFuE
-----END PGP SIGNATURE-----

--nextPart1687781.CeJcPbUnSM--
