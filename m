Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:40886 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbaKKCKj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Nov 2014 21:10:39 -0500
Date: Mon, 10 Nov 2014 21:10:33 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/6] build-sys: make scanf_cv_alloc_modifier to work
 [AddressSanitizer]
Message-ID: <20141111021033.GF3652@vapier.wh0rd.info>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
 <1415656195-20458-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
In-Reply-To: <1415656195-20458-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10 Nov 2014 21:49, Sami Kerola wrote:
> The tests failed with following message in config.log
>=20
> ERROR: LeakSanitizer: detected memory leaks

nit: the subject says ASAN but this is fixing an LSAN bug ;)
-mike

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUYXAZAAoJEEFjO5/oN/WBWqoP/0vfCMprXFCz51xWoWs3XK5P
NwNJczbMn0gHfbzZJEAJTkE1pViGPQGJ9xujUZOuv/ibU9sh/sIWYM9bsk5UvEcM
8gSFMky9mI7JAFHSi0ZdXCfn4efEXfbDIDymlkCt8jy2bpkk5lYvel27AesduSwb
Tz3dimdLulgzYNY/PNW/DvEZkDjO5XaFzA9pkP0Jd0J630QpMBWJ82IeYOxb3Q7x
RfSqiBkVVkXk636R1xQjUsUBJ9lseNOdRUrEU4bVyPjP3nw/x+TMn0+9GIFUQBO4
Loj3IDiDTSM4iBobFTSDngvPG3tONiuWb50bzqbGhOy1MWQvBchJ+is/oUfFyJiO
7cdtkWiBlqPVe0/puvjhjlD70lS+69sMr7VQPESYg6E9we3WoOTDa9MwmrwLejLC
ZrNjEZ/09ZKQDBakskrpSfrBifXeYaNvlPAJfG/7EocblmmQ+yVDPZuEhI9hHPSn
rvonSenpo4PlAAfxlqOC6kBbmvk7vAN57mOCiCXqVjfzXJer5EyZpVAjiW25sUSJ
PSnj9KhllvZ57jjKG6SBxY87cGwkPq8FGKiTMCIBMBdWTUBhQWg1cLpNLGYOY3BT
72xQqg3TFgCzDrnwpWztoTAQDQ7VPZLDSe5eVMD9vHoPbHkSZiRD50L6GVfJAkaA
tdilCfvAL7QMCFuTr8bv
=8Xiw
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
