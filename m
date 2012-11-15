Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23433 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992967Ab2KOKXu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 15 Nov 2012 05:23:50 -0500
Date: Thu, 15 Nov 2012 11:23:42 +0100
From: Petr Pisar <ppisar@redhat.com>
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: util-linux@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Karel Zak <kzak@redhat.com>
Subject: Re: vlock command
Message-ID: <20121115102342.GC1877@dhcp-0-146.brq.redhat.com>
References: <20121114103509.GD1835@x2.net.home>
 <50A37AD8.6060601@gmail.com>
 <20121114122610.GF1835@x2.net.home>
 <20121114233117.GD20303@altlinux.org>
 <50A48F5F.3090404@gmail.com>
 <20121115075253.GA26255@x2.net.home>
 <20121115084821.GB1877@dhcp-0-146.brq.redhat.com>
 <50A4B774.4010005@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
In-Reply-To: <50A4B774.4010005@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 01:35:48PM +0400, Alexey Gladkov wrote:
> Guys, I want to release the new version of kbd next month. This will
> be the first kbd release with the vlock. Do you have any more
> suggestions on vlock?
>=20
Yes. Could you please internationalize vlock code (adding the setlocate(),
bindtextdomain(), textdomain(), and _() around all messages)? I'll be happy=
 to
translate it then.

-- Petr

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iF4EABEIAAYFAlCkwq4ACgkQEsnFx2fG+qKHEgD9GWgdi6P69huPAjBzUVpM5QLT
Ohi7xY1JbpDXaE/7i5kBAKRLC3KQluN0GdfaULbTcVVGnlI1tD3ruxGBFvY+Ligj
=s9VE
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
