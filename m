Return-Path: util-linux-owner@vger.kernel.org
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38820 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753391AbcD2PjD (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Apr 2016 11:39:03 -0400
Message-ID: <1461944328.2311.10.camel@HansenPartnership.com>
Subject: Re: Unprivileged containers and co-ordinating user namespaces
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "W. Trevor King" <wking@tremily.us>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        util-linux@vger.kernel.org, systemd-devel@lists.freedesktop.org
Date: Fri, 29 Apr 2016 08:38:48 -0700
In-Reply-To: <20160428230045.GS22888@odin.tremily.us>
References: <1461880928.2307.48.camel@HansenPartnership.com>
	 <20160428230045.GS22888@odin.tremily.us>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-yBfO5sB/Vk/TzoqZ4KsO"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--=-yBfO5sB/Vk/TzoqZ4KsO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2016-04-28 at 16:00 -0700, W. Trevor King wrote:
> On Thu, Apr 28, 2016 at 03:02:08PM -0700, James Bottomley wrote:
> > /etc/usernamespaces
> >=20
> > and the format be :::
> >=20
> > =E2=80=A6
> >=20
> > If this sounds OK to people, I can code up a utility that does this,
> > which should probably belong in util-linux.
>=20
> This sounds a lot like shadow's newuidmap and newgidmap [1,2,3].
>=20
> Cheers,
> Trevor
>=20
> [1]: https://github.com/shadow-maint/shadow/commit/673c2a6f9aa6c69588f4c1=
be08589b8d3475a520
> [2]: http://man7.org/linux/man-pages/man1/newuidmap.1.html
> [3]: http://man7.org/linux/man-pages/man5/subuid.5.html

I think that mostly works.  No-one's packaging it yet, which is why I
didn't notice.  It also looks like the build dependencies have vastly
expanded, so I can't get it to build in the build service yet.

It looks like the only addition it needs is the setgroups flag for
newgidmap, which the security people will need, so I can patch that.=20
 Plus it's trying to install newgidmap/newuidmap as setuid root rather
than cap_setuid/cap_setgid, but that's fixable in the spec file.

James

--=-yBfO5sB/Vk/TzoqZ4KsO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXI4ATAAoJEDeqqVYsXL0MHpUH/3K2v2wf1jZFN81sfFV2qADF
Nho6BbShZG/HyfYEjeukaxiq1IVQIyfCPGsArNO03Ld0ouAILvLzGKFkI2yIGM5C
i0/kwNyfFv1jHuj8MoW18lpypXmzQJNIcSi90yokJazSdDDsVZ9dsGDuW9+Q/FSh
8XZpY2oXtlkJT4FOYNr96YHS3fHo2iZY/R5CATDCmzmHS4UWcFbE4y0ko77vvIwf
aOaZ7vZLQ6FhehuT8sA2XAARTUccdqkw2XRlHOh28vbGWsWAwkPymqPkZ6R1mY19
aQWRZG0iegI5JT1jVfb37ADapDdlzv+jGpfA5cuXr/7B37F14q4I1LUHYwVvJns=
=YK2/
-----END PGP SIGNATURE-----

--=-yBfO5sB/Vk/TzoqZ4KsO--

