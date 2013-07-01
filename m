Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:56848 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331Ab3GAOrF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Jul 2013 10:47:05 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH/RFC] unshare: add --fork/--mount-proc options for pid namespaces
Date: Mon, 1 Jul 2013 10:47:04 -0400
Cc: util-linux@vger.kernel.org, ebiederm@xmission.com, mtk.manpages@gmail.com
References: <1372377898-2602-1-git-send-email-vapier@gentoo.org> <20130701114008.GA1946@x2.net.home>
In-Reply-To: <20130701114008.GA1946@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1485929.KjD58xY2UD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201307011047.05595.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1485929.KjD58xY2UD
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 01 July 2013 07:40:08 Karel Zak wrote:
> On Thu, Jun 27, 2013 at 08:04:58PM -0400, Mike Frysinger wrote:
> > When it comes to pid namespaces, it's also useful for /proc to reflect
> > the current namespace.  Again, this is easy to pull off, but annoying
> > to force everyone to do it themselves.  So let's add a --mount-proc to
> > do the magic for us.
>=20
>  This is not so easy. For example on Fedora 18 the default is "shared":
>=20
>  # grep /proc /proc/self/mountinfo
>  14 33 0:3 / /proc rw,nosuid,nodev,noexec,relatime shared:5 - proc proc rw
>=20
>  it means that unshare( CLONE_NEWNS ) has no expected effect and the
>  following mount(/proc) has horrible impact for all system. You have
>  to use (for example):
>=20
>     mount --make-rprivate /proc
>     unshare --fork --mount-proc --pid

i'm not quite following here.  are you saying that Fedora 18 by default mak=
es=20
it hard to do pid namespaces ? =20

>  The --fork option makes sense, but I have doubts about --mount-proc.
>=20
>  It would be better to keep unshare(1) simple and stupid rather than
>  expect that we can setup usable container by the util.
>=20
>  It's easy to call "mount proc /proc -t proc" after "unshare --pid
>  --mount --fork".

unless you're running on a system that has a shared /proc ? :)

> > -	if (optind < argc) {
> > -		execvp(argv[optind], argv + optind);
> > -		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> > +	pid =3D forkit ? fork() : 1;
> ^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
>  I guess it's bug that exec_shell() only when forkit is set and
>  waitpid() is called always.

i fixed this locally already.  guess i sent out a stale version.  change th=
e=20
"1" to "0".

>  See the patch below.

sure, that gets us half way home :)

> +		switch(pid) {

needs a space before the (
=2Dmike

--nextPart1485929.KjD58xY2UD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJR0ZZpAAoJEEFjO5/oN/WB40MQAOVYJWUbvSUkh4KYO2gx2URJ
q3JjzhOMFrwWLh58NpHHiPV5X1p25rmJh/7U67ZdzTv0IIHoGkrEZxVIyNhuj4cT
XL4Zv25SkeyLnGNMebs1gn0nY2FFYAVElUJA8iQWQdpsIT6neTqvtM1bOYBZzor2
O3uJ1QFJ/cM+2R15rQTkj1jnnn6t76eWlh6MmEBpwvuXo6lzr9riX9byypHUFB//
9WtIaNcgO5GKWFknXiHYQzfH/TaVa30tkNQM/cJzJe+KKKcpHLSCu/oAKobevn4a
PeoLmdwF4jpQg5pbszRKLsXNqVc3DJqJIZTCyHLmbJBtQm7BK2sp75qY2JklTc8T
Zg6YBc2ArFjNvfsypSpi1z//GD+CxZgUOPh0PopgBdJmAit30x8HlCMWP8W2WQoa
CDbOgNjDMtHGrF+u2xw7ckl05fftTy8KWmXPYVoZC8txmjJNOLWQUmXJ+05+YPFw
lK9wDXSPZrRaQkuDuiLpMauSNaPuftCPOwM8UgAiEh2/Z+6ecTbI8GIouvZSPFT/
Np0C90Nx3QekF6sCm486zAkrxpzqngE6XNm7/Po+aG8YaTst/YiFuf5LRFATYlqD
orn+ij905DoCf4SmudED6qJ9WcwYk8+fH36uwda4cMDegwedzFyWw1LMVp/Pvpwy
ESlXJswSV18cCc82noDe
=F4TU
-----END PGP SIGNATURE-----

--nextPart1485929.KjD58xY2UD--
