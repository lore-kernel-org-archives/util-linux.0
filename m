Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3876028CF5D
	for <util-linux@vger.kernel.org>; Wed,  3 Dec 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801371; cv=none; b=Zm+1fs7uEwKq0G5BVnm4sUujuXVw2xVa9EwIOiohkF4t5cd8TR8qyUD2MjPO/10tCOzBt8YLngvwwzXI4XNkNrpLZDT8bnhOXhDCJShyhh8twIHOUdr/7Tdhks7bnAlrY++sWs9u0a7ncjE7/wP9lgPwL8hoRTgHLGDqcq9svtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801371; c=relaxed/simple;
	bh=CvWEOGlAXTm82bcRqzv5o3joqtFOW3U68nL4a0+bBc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POuahhqW6YRuCn3HCs2U1eXp1jxCJIXHlfm6P1Fui4NTKo0y8TE0SwmHx1pnNBCMTB4FEAs01QqKTevK/SxwbTLZ+LUeAKzSz0WGw3Xm6cVuMo2Sl7NmFk+889szcHkNJekfSqrY/9mawfg032orgSNcLmYz/osxfwYgBrwYngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ/3GeXN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ/3GeXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB32EC116B1;
	Wed,  3 Dec 2025 22:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764801370;
	bh=CvWEOGlAXTm82bcRqzv5o3joqtFOW3U68nL4a0+bBc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQ/3GeXNd7O8ij/gFjegv3yyollCxrjqZ/ayMUdAub5WY228UL2qbb7t9mR6Bhytd
	 o3+y64TEzlhXGdTfZWrygm5HZVBkT2AkOKrkLZ/zUGUPNj6ZbF1RazECBGUgfHL+6V
	 rSD0kUP7zjhAgLA3DF5ZegZXy2PRtumogvxgtGfy6glgApiCF44eUSNJPFs/wKVzOu
	 lMjfBaOTLGqOxpoS/grjwJ5BVcR65Y/Gwe51jYQCVMHhdwe9jBFrbBKjj+a8OPJN0+
	 Ahy4W21SN0qYeoXmd6T3Z7FJBRjQusftCeuMl2KgEK6UGLxmE9KuPXTkO7nDReCMZD
	 FelDun2BBlIoQ==
Date: Wed, 3 Dec 2025 23:36:07 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 0/1] Call prctl(2) with signed long integers, and
 avoid casts
Message-ID: <fqh6evzlyowscow44l7b2wa5amiz4b5mbhddavk2nwzcfrtil7@mkv4lsejntlt>
References: <20240601093150.16912-1-alx@kernel.org>
 <cover.1764794880.git.alx@kernel.org>
 <xfml2leih5xmokh4vhyyaarsq6ly7ehq5zfdjwwpkgnodiygwp@7tjm4lfqo6is>
 <0ed6fa4c-7098-474c-99a5-f2c02879b119@t-8ch.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3tge7p7fpk6e7vab"
Content-Disposition: inline
In-Reply-To: <0ed6fa4c-7098-474c-99a5-f2c02879b119@t-8ch.de>


--3tge7p7fpk6e7vab
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 0/1] Call prctl(2) with signed long integers, and
 avoid casts
Message-ID: <fqh6evzlyowscow44l7b2wa5amiz4b5mbhddavk2nwzcfrtil7@mkv4lsejntlt>
References: <20240601093150.16912-1-alx@kernel.org>
 <cover.1764794880.git.alx@kernel.org>
 <xfml2leih5xmokh4vhyyaarsq6ly7ehq5zfdjwwpkgnodiygwp@7tjm4lfqo6is>
 <0ed6fa4c-7098-474c-99a5-f2c02879b119@t-8ch.de>
MIME-Version: 1.0
In-Reply-To: <0ed6fa4c-7098-474c-99a5-f2c02879b119@t-8ch.de>

Hi Thomas!

On Wed, Dec 03, 2025 at 11:12:47PM +0100, Thomas Wei=C3=9Fschuh wrote:
> Hi!
>=20
> On 2025-12-03 22:01:18+0100, Alejandro Colomar wrote:
> > On Wed, Dec 03, 2025 at 09:50:27PM +0100, Alejandro Colomar wrote:
> > > Karel reminded me of this old patch.  Here's a revision of the patch.
> > > Major changes in v2:
> > >=20
> > > -  Don't specify the 5 arguments unnecessarily.
> > >=20
> > > BTW, I've developed a header file that might be useful for the general
> > > public.  See in a reply to this mail.
> >=20
> > Here it is.  I think it would be useful to provide this in some libprctl
> > library so that everyone can use these, instead of raw prctl(2).  What
> > do you think?  We could start by including this header file within
> > util-linux, and then consider providing in a separate git repository so
> > that distros can package it as a system library.
>=20
> What about fixing raw prctl(2) in libc to avoid the issues you are
> fixing in your original patch? prctl() could be a macro which counts its
> passed arguments, dispatching to a set of inline functions which then in
> turn call the underlying prctl() with the correct set of parameters.
> This would be backwards-compatible and safe.

I'm not sure how this would be implementable in a single macro.  If
possible at all, I guess such a macro would be easily over 1k lines of
hardly readable code.  I think providing these inline functions in libc
would be more reasonable.  I can ask glibc and see what they think.


Have a lovely night!
Alex

>=20
> (...)
>=20
>=20
> Thomas

--=20
<https://www.alejandro-colomar.es>

--3tge7p7fpk6e7vab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkwu1EACgkQ64mZXMKQ
wqnsFQ/5AZGAeKmZv+433mdGr/zIsoZYmPF9XTnNwCN2rUKmOxeH3B4ZvyBEMZG7
QdvLQKGzcoleHwTh5SiYKUeWH6JIu7onHmvYqY8I6mpFGX3WNj+CDQHlrI0wcSBL
ab5G/2/4ptq3kmgoR/zlswVZw5JzltjcKb4mlTPqcF4/iIqaNNjZqwWfiUvkjFbw
PBJTUB+H7rSmfvGg3T3L0uR7oPOThUzNzOFoRxzIB7+dSCwxwlZ2uBrUpYvLbt0m
El7g2b2efRgDwlI7sxUV4C99+csRYJyRDjqftxqiZXvM9fC3J9EfmWzLhTq/NM8t
h4Z2Lps/OdCoyHipN+fsFo98OZbu71av8Fn3Q1PyefAkIcGhMk1qfRVESZYiq5+y
rAo+VDf5C7vmdyNYTpE3MI2mEDAaBV5xC5ATq3haZhAxwzHGB+Xy+Y10bW0J8tuk
JOBT1rFHNgY7ymhejhSxlJQG0HspjZEQ694p0QnXPNk6RfIs1TayMPGgWmermD/K
dZWkZ83nxMeVRTO9qrIBZ7i2wB2lQzZm3Onm1z96NnnWj9ENNka2VPK+qqRDVveC
4/xUQYhxXBcjoK32sxOFzP+Udv8+M5eGxnNMt1bikHTehiA2X6sWU1ScYioDq15c
dwFC2l1tT3yj+ap1uFPaIEQQ8l0xfNk/2CnoRpESS6geyo5Dy4E=
=XN/c
-----END PGP SIGNATURE-----

--3tge7p7fpk6e7vab--
