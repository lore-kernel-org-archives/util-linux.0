Received: from router.bayer.uni.cx (ip-89-103-181-52.bb.vodafone.cz [89.103.181.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFE15EA6
	for <util-linux@vger.kernel.org>; Tue, 26 Mar 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.103.181.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470948; cv=none; b=qrnDODgNnL+rQGyq36qKmT+BQoipnQCYl2+8IitQpEd0IKF42hMJNL5yexRZCH70r6pDOtRENEat4Nu9oBMA7m89pWNaUeui0X2DWKDvy01flnepBUaYbn58Y4HAPKPABJBuJvBOcECpzXMIxvo55NfsDTSGITTc3LHP5rGm9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470948; c=relaxed/simple;
	bh=Va6CP9HGvYi3/ugmDievsZ+q49C3ZMlN8ch6jwywnnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iefLMc2ypvCznV9yyAr9H7HOqFiRip/gL8Fg0Nd16o9DHO6aIP2aRTuXMqkWOdAmK97vIhvpykNYDiUj1DdimutszKU9WLbSlBS2LDDQQ0iRbvtrovd8C7CchsRc4mbimqIilVhRyXv+TYhNbVGB6Pcm3cmrc2eEdzUCqpSw0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=atlas.cz; spf=fail smtp.mailfrom=atlas.cz; arc=none smtp.client-ip=89.103.181.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atlas.cz
Received: from album.bayer.uni.cx (album.bayer.uni.cx [IPv6:2001:470:993c:1:5246:5dff:fe8e:a186])
	by router.bayer.uni.cx (Postfix) with SMTP id 10E87B5BE4;
	Tue, 26 Mar 2024 17:35:35 +0100 (CET)
Received: by album.bayer.uni.cx (sSMTP sendmail emulation); Tue, 26 Mar 2024 17:35:35 +0100
Date: Tue, 26 Mar 2024 17:35:35 +0100
From: Petr Pisar <petr.pisar@atlas.cz>
To: util-linux@vger.kernel.org
Cc: util-linux@vger.kernel.org
Subject: Re: Mistakes in messages of util-linux-2.40-rc2
Message-ID: <ZgL5V-tgHJKon6Oe@album.bayer.uni.cx>
References: <ZgKxUSbGN-R8Rn-w@album.bayer.uni.cx>
 <257b46c7-dbe9-414e-a707-fc543d1e7849@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LOvgeitBJqD/yG8P"
Content-Disposition: inline
In-Reply-To: <257b46c7-dbe9-414e-a707-fc543d1e7849@telfort.nl>


--LOvgeitBJqD/yG8P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

V=C2=A0Tue, Mar 26, 2024 at 04:48:09PM +0100,=C2=A0Benno Schulenberg napsal=
(a):
> >> #: misc-utils/lsblk.c:236
> >> msgid "write same max bytes, use <number> if --bytes is given"
> >=20
> > There are multiple messages ending with "use <number> if --bytes is giv=
en".
> >=20
> > I found the ", use" clause clumsy. Especially the reference to "<number=
>".
> > I know it refers to an argument of the --bytes option, but it can be di=
fficult
> > for users to realize it. [...]
>=20
> If I read things correctly, the --bytes option takes no argument.
> So to me the msgid makes zero sense.  :/
>=20
You are right.

> > I propose rephrasing it as "write-same max bytes, respect --bytes forma=
t".
> > Or "write same max bytes, respects --bytes format".
>=20
> What does "same" refer to?

Same bytes.

The column simply prints a content of "write_same_max_bytes" file from sysf=
s.
That file is documented in Linux as:

    Some devices support a write same operation in which a
    single data block can be written to a range of several
    contiguous blocks on storage. This can be used to wipe areas on
    disk or to initialize drives in a RAID configuration.
    write_same_max_bytes indicates how many bytes can be written in
    a single write same command. If write_same_max_bytes is 0, write
    same is not supported by the device.

So write-same is a name of the operation.

-- Petr

--LOvgeitBJqD/yG8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE4/QvzhVoMKgDWObpT9GuwzZa978FAmYC+VEACgkQT9GuwzZa
97+LBRAAsu++Ox16DgBbKkJQ0rj9+ekYBzg5nGRjEK/Th5UjR7UCj058QcWc/nGK
piWadmbJim4xyrxPt89LYn6nhKFwO43gRy9ClCeieCHByehFDoM7bFr3K3ueKNL7
ohypza1FGETrr+nUCvYucGPwa0V22xjSmKqkgekTURtp7gXtN28w9w8gMAXxrAfa
R+vCrYDmdye7nHgOldyijDOh0lppeTDKxIIwRuiOvTbtg9t0V17XFgm+ZqPLneVe
4eUZpsirYkjLjBWwora5ittsO5JA6sau9UJa1A6uf2a9/DXUmoS3GYhiN9B7uKGU
e4Sgg1uOJmZdDlVl/z7rHT6cOnLOVjng1vSUlDIoAS4wW7NYF1TEfSpZvx3A93sK
oRXKXFK8elFjlOCRMr3xAkcmV1coaLPEFmp3tChnB5NPdYF/VSZmtxE5Hrzm863W
LraoE3yBE3GJOJm+jzXfaVtyTr518Pf1bx6XBPskHFsl6ZDgRAubR00S5psSFw/3
H/C7u6JGkqOIw5gXRWWcq6TiSZaXxucUoZczQtQ/UP1/KsATpKT1hayaNc1U+0uC
z3CcztNsP0MEFEacMFUFHb3UILHnwQSRbwZYDX7oVqsVWcbK96RO9rOZ6h2lkSwc
+bIHjU/YEdXtcGfAszF+clecar+Wgy+dktEvYZRFaU96msFm2v0=
=FC05
-----END PGP SIGNATURE-----

--LOvgeitBJqD/yG8P--
