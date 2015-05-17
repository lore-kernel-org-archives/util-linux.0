Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:38382 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbbEQFxD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 17 May 2015 01:53:03 -0400
Date: Sun, 17 May 2015 01:53:02 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Peter Cordes <peter@cordes.ca>
Cc: Karel Zak <kzak@redhat.com>, Isaac Dunham <ibid.ag@gmail.com>,
        =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: fix parallel builds w/setarch links
Message-ID: <20150517055302.GC12010@vapier>
References: <1430711464-4943-1-git-send-email-vapier@gentoo.org>
 <55489D6D.9010303@draigBrady.com>
 <20150510203807.GA1832@newbook>
 <20150511080528.GK27969@ws.net.home>
 <20150516175038.GG3933@cordes.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
In-Reply-To: <20150516175038.GG3933@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16 May 2015 14:50, Peter Cordes wrote:
> On Mon, May 11, 2015 at 10:05:28AM +0200, Karel Zak wrote:
> > On Sun, May 10, 2015 at 01:38:08PM -0700, Isaac Dunham wrote:
> > > On Tue, May 05, 2015 at 11:37:33AM +0100, P=C3=A1draig Brady wrote:
> > > > On 04/05/15 04:51, Mike Frysinger wrote:
> > > > > From: Mike Frysinger <vapier@chromium.org>
> > > > >=20
> > > > > The symlink generation tries to write to the sys-utils/ subdir bu=
t does
> > > > > not make sure that dir exists.  This can sometimes lead to parall=
el build
> > > > > failures when building out-of-tree
> > > >=20
> > > > >  $(SETARCH_MAN_LINKS):
> > > > > +	$(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)
> > > > >  	$(AM_V_GEN)echo ".so man8/setarch.8" > $@
> > > > > =20
> > > > >  install-exec-hook-setarch:
> > > >=20
> > > > The `test -d ... ||` bit is racy and redundant I think
> > >=20
> > > Racy, yes, but no more so than "mkdir -p $DIR && install $FILE $DIR":
> > > it's an inherent limitation of shell scripts.
>=20
>  You mean racy as in multiple mkdir -p invocations could happen?  A C
> implementation could shorten the window for the race (because mkdir(2)
> would directly follow stat(2), rather than delayed by
> fork/exec/dynamic linker startup).  Or handle EEXISTS specially and
> test again for existance.  You could do most of that in shell, but it
> would make the code a mess.

shortening the window isn't interesting.  it's either race-free, or racy.  =
the=20
incident rate is irrelevant.
-mike

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVWCy+AAoJEEFjO5/oN/WBWCIQAIQI+R+vsWS/dKRp/K0nsuDl
fGVLM9a3uE3BZpbmGgilar00pcx1uBoL7TGjrxNT2Q/uvi/YydFAY2XcKR+03cy1
H8rsnOWiMuNapf3LqDYW+ukj6NTDE98fIoqJ6OvBNw/mHLCvXUPs5UG3Q8nHbAVv
/fgb07xzL/otmp6QMTFwhzkhxBZaU1lgPKwPEpHBfgMe/7uGPC52Q/+ca+EhHwhM
OmWWmLOY7+XB0fcF/JUq/IGj1RJN735JBeTRVG63cxz13JsWyT8v1viRN9jvfLAm
3tFZbqK9cgBOk3maOK7At3XsR9PvFL4tEqyMA/0j2PBjenO3bK4UlgC7mmVPDWwm
8eQD5BuU9q4L3pqFvAk76vgLnkNUrgk6Q2tje+W5ZTMJSGAp9DaBce4FtG663Gih
CjQjBAGHGnkW3ZatQlttZHReMPlfF5SkYtf7odgODQ/Ozay0M5qOfSo7ktyX9cxo
X4UyfcfbqXvoeJAkWjDUT/AKj7jWW5KcOUnE+E+PYDvfFzBIT2i4pmIdc76Y8+aL
Gq+YPvOv+25ts+WmVueQt8/eJPsIUrlaljvBz2X3maRDTYkZ9mQFeD2ByaCiVNaS
bcpQI36M2hKe0wjJvOFdP2rBB4mR7nDzKoAH65CqxrXatIG8W104jNs7PAo4vbMz
TskBQYRIjaF8fgJvEM8y
=0aah
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
