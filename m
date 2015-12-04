Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:42443 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755150AbbLDWDb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 17:03:31 -0500
Date: Fri, 4 Dec 2015 17:03:29 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fsck memory leak
Message-ID: <20151204220329.GT23754@vapier.lan>
References: <n3rei3$8l3$1@ger.gmane.org>
 <20151204151927.GA3548@thunk.org>
 <n3sjvh$ib8$1@ger.gmane.org>
 <20151204195848.GA18359@thunk.org>
 <n3st78$77b$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GviraxgP0A7vmYdC"
In-Reply-To: <n3st78$77b$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--GviraxgP0A7vmYdC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 04 Dec 2015 21:31, U.Mutlu wrote:
> I think it's a double-edged sword: if user has less memory then
> the integrated caching will IMO degrade the performance.

it is not.  the user doesn't have less memory -- if the user requests pages
and there aren't enough free, then the caches will automatically be trimmed
to satisfy the request.  (obviously i'm glossing over details, but i think
this is sufficient based on the quested generalization.)
-mike

--GviraxgP0A7vmYdC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWYg2xAAoJEEFjO5/oN/WB6ccP/iF7+yKyYIE8lhtmN1oIOhMu
Bsz7wjZ2pKVwm0kQwHiGPgMRALzk1ge+Y0k+9QKb18ID0AVOTT+Cyz1dsQyRE4Xr
vf32MDpKdgD4WkmCTYN7CxyhzVfyaPKsgsiGt0oHJUZKhwCtAZEjTkMEXVO6AFei
BPiRLiaigXKdPJhvAL8QGdSIp86dKNc2SgUATIqz9OOfruQXlV6IRC6uc0oS12AF
1aJ1S5MC60gQb1oWB7EGgSuy5PHL8j0ysvMqSDk5I6ykXrC0uxZjyD2FRqpey3P+
woAwKo2LpXpV5ir0WcpdpG/CZfOgIqzgYLrJ/GndRsF8jrcNq+7PuoIVcwjML1rh
76rQRbyMuNqYw8YiOvKPS1e0E0rTj5OGK6r22rEF0CjAIDtKq0uCbcY8yInVsfMI
FPthN0b8+K1B7ZWK1izbvs3zvRVkAtVazLywA1Ttz2yX2sNe03zrK6+ZPjHjXgZF
rS47N4Sqx1JZU8LPy15dXKf/zCnl9ib6GvFfkbwGS/gjB2fVXNfAXyE0ghS4JWKg
fPu9jZgoSBP/gESZWHnpVabWnl3DbzyOQiCSMX6VaNw3tnsJJ6MnmD81/21Odt6S
dPvxVEREMUequzSqsJxPlkamCTpKFE/YCzt4fGE3XjdsRNTLCvWfzJvF+NYUwbNs
O2+PS1K0nopbL+Vq+xBo
=9MhH
-----END PGP SIGNATURE-----

--GviraxgP0A7vmYdC--
