Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423582Ab2KOIsg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 15 Nov 2012 03:48:36 -0500
Date: Thu, 15 Nov 2012 09:48:21 +0100
From: Petr Pisar <ppisar@redhat.com>
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: util-linux@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Karel Zak <kzak@redhat.com>
Subject: Re: vlock command
Message-ID: <20121115084821.GB1877@dhcp-0-146.brq.redhat.com>
References: <20121114103509.GD1835@x2.net.home>
 <50A37AD8.6060601@gmail.com>
 <20121114122610.GF1835@x2.net.home>
 <20121114233117.GD20303@altlinux.org>
 <50A48F5F.3090404@gmail.com>
 <20121115075253.GA26255@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
In-Reply-To: <20121115075253.GA26255@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 08:52:53AM +0100, Karel Zak wrote:
> On Thu, Nov 15, 2012 at 10:44:47AM +0400, Alexey Gladkov wrote:
> > 15.11.2012 03:31, Dmitry V. Levin wrote:
> > > On Wed, Nov 14, 2012 at 01:26:10PM +0100, Karel Zak wrote:
> > >
> > >>  Alexey, just today I added --erase option to Fedora version. Maybe
> > >>  you can apply the patch below to your repository too. Author of the
> > >>  patch is Petr Pisar <ppisar@redhat.com>.
> > >=20
> > > The first vlock RFE for ages!  Alexey, please apply.
> >=20
> > Dmitry, I mistakenly did not add you in the Cc. I wrote Karel that
> > similar functionality you have already implemented.
> > Here is my answer:
> >=20
> > > On closer look I found out that the my version of vlock already erases
> > > display if we are on the virtual console:
> > >=20
> > > http://git.altlinux.org/people/legion/packages/kbd.git?p=3Dkbd.git;a=
=3Dblob;f=3Dsrc/vlock/screen.c;h=3D720d880080f9030553a32d625756b5e30c6d4266=
;hb=3D768b8c314e1d3c465d895b206da4aa4543914d1d#l37
> > >=20
> > > http://git.altlinux.org/people/legion/packages/kbd.git?p=3Dkbd.git;a=
=3Dblob;f=3Dsrc/vlock/vt.c;h=3D50746de238f5acc231d2ffef8a5604dfbef3cfad;hb=
=3D768b8c314e1d3c465d895b206da4aa4543914d1d#l194
> > >=20
> > > As I understand you want a similar functionality. Is this enough for
> > > you,
It's similar but insufficient. The difference between your clear_str[]
=3D "\33[H\33[J" and my string is my way clears scroll-back buffer of Linux
virtual terminal too. This prevents from reading history using Shift-PgUp
while the terminal is locked. Read current console_codes(4) page, especially
search for word "buffer".

So what I ask is to prepend "\33[3J" to your clear_str[]. This even users w=
ith
older kernel not implementing this code get console cleared.

> or you want to be able to clear the display regardless of conditions?

If I understand the code correctly, you clear screen only if it's a virtual
terminal. I have no idea how usefull is vlock on other terminals (I use
"screen" there), so I do not request any change in this matter.

-- Petr

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iF4EABEIAAYFAlCkrFUACgkQEsnFx2fG+qKgpQD+Ogg+DZPKkvm2VMBmcdmxOoRs
r5WxnmJS08WVks0Kv8oA+QFo2srk7E/9ha2XRBq03ksTz1KdgrTUynfAAO/NGyiQ
=6z2a
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
