Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:42614 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbbDAWXT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Apr 2015 18:23:19 -0400
Date: Wed, 1 Apr 2015 18:23:17 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Message-ID: <20150401222317.GS25224@vapier>
References: <201504011342.56546.sweet_f_a@gmx.de>
 <201504011817.48428.sweet_f_a@gmx.de>
 <20150401201051.GP25224@vapier>
 <201504012306.52737.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ck3np9Ek/EMsFxRu"
In-Reply-To: <201504012306.52737.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ck3np9Ek/EMsFxRu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01 Apr 2015 22:06, Ruediger Meier wrote:
> On Wednesday 01 April 2015, Mike Frysinger wrote:
> > On 01 Apr 2015 18:17, Ruediger Meier wrote:
> > > On Wednesday 01 April 2015, Isaac Dunham wrote:
> > > > On Wed, Apr 01, 2015 at 01:42:56PM +0200, Ruediger Meier wrote:
> > > > > I wonder about some hardcoded binary paths.
> > > > >
> > > > > Example swapon.c:
> > > > >
> > > > > #define PATH_MKSWAP    "/sbin/mkswap"
> > > > >
> > > > > There are a two problems.
> > > > > 1. It's wrong. We should use $sbindir from configure.
> > > > > 2. When called from our test-suite it will use a wrong (or
> > > > >    non-existend, broken) binary. This happens in test
> > > > > swapon/fixpgsz.
> > > > >
> > > > > The question is how to fix this.
> > > > >
> > > > > I would prefer to use "mkwsap" from the same directory like
> > > > > swapon or to simply execvp "mkswap" from PATH. But don't know
> > > > > if we want this. If we really want to keep a hardcoded sbindir
> > > > > then we would need "#ifdef TEST_PROGRAM".
> > > > >
> > > > > Any comments?
> > > >
> > > > The approach that seems obvious to me (assuming you want to keep
> > > > the hardcoded path) is:
> > > > -add -DSBINDIR=3D"$sbindir" to CFLAGS
> > >
> > > Yes, this would be easy. But my preferred logic would be like this
> > >
> > > If "swapon" was called from PATH then just take mkswap from PATH
> > > too. If "/whatever/path/swapon" was called then look for mkswap in
> > > the same path.
> > >
> > > Maybe both cases also with or without fallback $sbindir, /sbin or
> > > $PATH.
> > >
> > > I guess we should agree how somthing like this should be handeled
> > > in general. "eject" is also using hardcoded "/bin/umount".
> >
> > seems like $PATH should always be used.  if you broke $PATH, well
> > that's your fualt ... tools shouldn't generally be expected to work
> > in the fact of hostile environments like this.
> > -mike
>=20
> I'd also like to use PATH (at least as fallback).
>=20
> The only special thing here is IMO that mkswap and swapon belong to the=
=20
> same project. Should we try to use the right one per default?
>=20
> Example:
> UL is installed below /usr/local
> PATH=3D"/usr/local/sbin:/sbin"
>=20
> Explicitly invoking the (old) globally installed /sbin/swapon should use=
=20
> the old /sbin/mkswap too or the new /usr/local/sbin/mkswap from PATH?=20
>=20
> Another point:
> If "/sbin" is not in PATH should "sudo /sbin/swapon" find /sbin/mkswap=20
> or not?

imo it should just use the $PATH and be done.  sudo will set up a sane path=
 for=20
you which includes /sbin.
-mike

--ck3np9Ek/EMsFxRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVHG/VAAoJEEFjO5/oN/WBpIUP/14dA0vi0kfgZCKNsBztpWGF
BptrixRKDtSMS+OLa0mM/SsSyoe2Zcf9aCwOXtVjvr3quHfEoS15DIozPS7p2WXg
7X/o8sCH5x+GakAh0NSN5rnCDRG1fN1rmKyrpmTBhWMpCoFBlKrlOgRZXTF3phNA
dIBbbVIEmwerLmTNVyS4Hy2Cs9tpUviYA9e7ewqs8Lntn0aIRT1KUSoQhrRcA5ag
O7RBexFymHy282UqsU1h26JerVF2F2/pWw/7aVFz5I95Et5EzdIdNFIYEPKCK3H6
qQrivUhO0vAGCkzhVy5mFTcw7YxaDrO5W7hA7OHcoHMywgTB80YCqhjwm6++W1qE
/Ac3NSzcUPnmDNzZrQ5835r5FRvMITr+Wqzvbj4MXW5yHxF1rag3WCyMqe2Qu5tK
RM493EY0YFhSTROrY8KoNsIQPSUnf00cWT0q8SvBniLvAxBA683B4/0Q9pMpFYVC
OQYR4WD52wxPfnAIiOwHLMi7RhxzrrFxWOMM4qjASJVvIhcPGfMoZIEV63QB9vWx
Qo1gSeNl/5Y1h1F7q85EyVzd4RivlOZUjvT7xIYz0JSMVK/4oisaBr0wZmrUyHfq
BXxnoqyRImySe9diuPf00sFs4TUFgXQKwpIE3eRVVRbUD2TqrpAx4XMuF2uIiYrC
PjzG33hj36b87Bb9JerH
=xOPN
-----END PGP SIGNATURE-----

--ck3np9Ek/EMsFxRu--
