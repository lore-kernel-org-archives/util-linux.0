Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:57912 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbbKOBYT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 14 Nov 2015 20:24:19 -0500
Date: Sat, 14 Nov 2015 20:24:18 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unshare -m for non-root user
Message-ID: <20151115012418.GC31395@vapier.lan>
References: <n0ujgc$tll$1@ger.gmane.org>
 <20151030102247.GF19508@ws.net.home>
 <n2674p$ulm$1@ger.gmane.org>
 <87si49p771.fsf@x220.int.ebiederm.org>
 <n26nkm$13l$1@ger.gmane.org>
 <20151114181716.GA3839@newbook>
 <n287q4$efd$1@ger.gmane.org>
 <n28krj$8i0$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
In-Reply-To: <n28krj$8i0$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 15 Nov 2015 01:49, U.Mutlu wrote:
> So, then the question remains: how to give non-root user a secure mount

no, it doesn't.  at least two people have already told you how to do it:
use the usernamespace (-U) option that unshare already supports.
-mike

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWR97CAAoJEEFjO5/oN/WBOsMQAJcUzbLN7ZMo5qkoArsx3xxn
V+RH6aA1rhE0jYc54NeQm6X/jnBaCUNk8W+Dr31hqFmpl7CvLuLRKvhSX+/+xGiq
dIWjY7dCZeB8mv8+7eceUsx3P+KFl3Sv+k8ebu/YFBr2BRWe5Ypui0kyDEBFqtCd
pMbaASf6ODOKCaDzZ5HbM/r4cglyuyOVKQhn2ZMMUeG8jwOWhwbYzwLU4C9TKqzf
ZLO0BoDZrxeRx9ZD/2bfNnUPUD1CLOC/NsdyGx+15a9eTaaXr1NILHwxYjaDntE9
ISymsK9awB1dMFQH2wlzcaFApVHhuBjcLj3ZNvfSWa0SDdvw+oYNby31o5v7la05
WAE2GNe20CSnj0hDq+bOdG1Gcp1VJX/FasAd4ReSN5WmKlfpBk0dczBKdPVZ1h/q
GxIlq6zU4oopltEz06ko+gZPeXOZuzajWwUkBgSuGPhU2QN0eTRw4hDUpkexDSNP
aQ+XCQFmjA2pfLbWCeG/eRX7m+JHy8lggH4UNiUOProlto2bxO8x9NnuFSdZaWKw
qwix6Vpolew3ixPH7+/tiuLatxW9SiDUfzkNbVeW+giFC4o28oTcyKpj5d5WlUy/
SiKMMza1IBmindWFitNOhb0cf2Nk57kVLaw1TSWx+1buXPqyEAShNbrKll9AIIAK
jnnTRQpHI4851/SR8EaX
=LoTl
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
