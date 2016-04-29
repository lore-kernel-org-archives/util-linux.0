Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:46179 "EHLO
	resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751303AbcD2SeI (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Apr 2016 14:34:08 -0400
Date: Fri, 29 Apr 2016 11:34:05 -0700
From: "W. Trevor King" <wking@tremily.us>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        systemd-devel@lists.freedesktop.org, util-linux@vger.kernel.org
Subject: Re: Unprivileged containers and co-ordinating user namespaces
Message-ID: <20160429183404.GE22888@odin.tremily.us>
References: <1461880928.2307.48.camel@HansenPartnership.com>
 <20160428230045.GS22888@odin.tremily.us>
 <1461944328.2311.10.camel@HansenPartnership.com>
 <20160429155303.GA8900@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ayEWcOB1VvXmLrn2"
In-Reply-To: <20160429155303.GA8900@mail.hallyn.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ayEWcOB1VvXmLrn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2016 at 10:53:03AM -0500, Serge E. Hallyn wrote:
> Quoting James Bottomley:
> > I think that mostly works.  No-one's packaging it yet, which is why I
>=20
> https://packages.debian.org/jessie/uidmap
> https://launchpad.net/ubuntu/yakkety/+package/uidmap
> http://rpm.pbone.net/index.php3/stat/45/idpl/28763248/numer/1/nazwa/newui=
dmap

On the other hand, Gentoo is waiting on a clean release tarball [1].
It looks like 4.3-1 was missing a clean autoreconf [2]?  Has anything
been pushed since?

Cheers,
Trevor

[1]: https://bugs.gentoo.org/show_bug.cgi?id=3D580432#c3
[2]: https://lists.alioth.debian.org/pipermail/pkg-shadow-devel/2016-March/=
010924.html
     Subject: [Pkg-shadow-devel] new shadow release candidate
     Date: Tue Mar 22 18:58:55 UTC 2016

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--ayEWcOB1VvXmLrn2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXI6kaAAoJEAPqygegUbGszy4P/1IvQ91zflgU1SYT9qbKP2pj
XddYYpW+mqsnJY4WVsVxRzVrSxcEbns4kdGvoKiu92MEsoYtZzYIufY4uR/Ef5+L
tDwyjx3bHGBq4yDUHUsxjLF6Z7GHNrnu1X+71rL12Rh13PoNZhZq8BS9t9nVGB7F
gW80obPL401pI9WKVsaK3IAY9VrSN3WKCm6dK6ZuYVsajFEoq8S8hJETAg5LfpIQ
4jyzziSHaf5nLrV7V+D01ATDyrR2nTRJP31lLXGQNP2ox+qm1WU6jUdruLcoOvTP
XHOHzfBoUCnOMVcxYlhIAggXz+OGeCBV7dnnOurcUiqsD8A9YOBLdFWcrKPE7QPw
IommBAHsB2qHQeZRvHypnhDISQTn5gAKd7tgh/EqYoWCrwlnIVRKL0fLlcER2/XJ
mtENIHmnCYI1I97yo4QZZ06PAqm1/fjvLludCOO0dCT+3LKsrDtYegvrN1RFjnz3
+Zb61VgpaVOjNfUBIwFwKGjPgEVI03iPvtHqhckVklssXDM4jfsuwp7aP0u02IGe
XUmv0ibNZSa6xS69na9fUJlstIr1sjJv+h0Au6BoD2SVmvgc1Tlkrd42wnML1IHW
vqtE9KeMWFXBs+c1XuRqa/vpxsu5/UZsVPuWhWGwX8mQ05eiHPve7ynO79pGuKQV
NjvgyZ6CH9XA/srqqkv0
=Xr/4
-----END PGP SIGNATURE-----

--ayEWcOB1VvXmLrn2--
