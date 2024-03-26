Received: from router.bayer.uni.cx (ip-89-103-181-52.bb.vodafone.cz [89.103.181.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D77640F
	for <util-linux@vger.kernel.org>; Tue, 26 Mar 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.103.181.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452857; cv=none; b=fmFuNQOCDPo5WnPrrXQjhtoaN2MfX24E8LMujQa/gc7NgQPLK1zA4pRJpvYwi0jfhHw+N2NrCjLje36w7sNKtyzVsyezRz4GjMVejAR35L1sTlUmzHlCi31PbrzpooZIUamypcxhnsdzKBl9vSkmjVBIB3ckPuz4ETiSXYzkzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452857; c=relaxed/simple;
	bh=WLsS9uTveTPg4Ebohrtasm64+LUvfUczq9X5y5MEqL4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MyfRpEnnVV5QjUHmVz/dKpSg+8JySaBmjqHtOYvfmVabbYcnNGTUomH2sPOcazrV+obKefSV4Yi3RAmyrX0jOiSWUx983TGPFaD7gosv6H0FahnLoPHhMGK+Ehy/YeZZBvkLg9Mbxnb+Q3DbWAzXsm1JInJa9WQrYnJ71yw8kFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=atlas.cz; spf=fail smtp.mailfrom=atlas.cz; arc=none smtp.client-ip=89.103.181.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atlas.cz
Received: from album.bayer.uni.cx (album.bayer.uni.cx [IPv6:2001:470:993c:1:5246:5dff:fe8e:a186])
	by router.bayer.uni.cx (Postfix) with SMTP id 58A0DA6DB4
	for <util-linux@vger.kernel.org>; Tue, 26 Mar 2024 12:28:17 +0100 (CET)
Received: by album.bayer.uni.cx (sSMTP sendmail emulation); Tue, 26 Mar 2024 12:28:17 +0100
Date: Tue, 26 Mar 2024 12:28:17 +0100
From: Petr Pisar <petr.pisar@atlas.cz>
To: util-linux@vger.kernel.org
Subject: Mistakes in messages of util-linux-2.40-rc2
Message-ID: <ZgKxUSbGN-R8Rn-w@album.bayer.uni.cx>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yYQ3sjov2LOSDrpz"
Content-Disposition: inline


--yYQ3sjov2LOSDrpz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

while translating util-linux-2.40-rc2 I notice a few messages which are, in my
opinion, incorrect:

> #: login-utils/lslogins.c:1461
> msgid " -p, --pwd                display information related to login by password.\n"

Other surrounding messages do end with the full stop charater. I recommend
removing it.

> #: misc-utils/lastlog2.c:117
> msgid " -S, --set               ySet lastlog record to current time (requires -u)\n"

"ySet" is a typo.

> #: misc-utils/lsblk.c:236
> msgid "write same max bytes, use <number> if --bytes is given"

There are multiple messages ending with "use <number> if --bytes is given".

I found the ", use" clause clumsy. Especillay the reference to "<number>".
I know it refers to an argument of the --bytes option, but it can be difficult
for users to realize it. Another issue I have is the same verb form of "write"
and "use". It takes time to realize "write" is a compound attribute of
"bytes", not a predicate.

I propose rephrasing it as "write-same max bytes, respect --bytes format".
Or "write same max bytes, respects --bytes format".

> #: misc-utils/lsfd.c:405
> msgid "extended version of MDOE (rwxD[Ll]m)"

"MDOE" should be "MODE".

> #: misc-utils/lslocks.c:92
> msgid "HOLDERS of the lock"

"HOLDERS" should be "holders". It's not a replacement word.

> #: misc-utils/waitpid.c:239
> #, c-format
> msgid "can't want for %zu of %zu PIDs"

"want" should be "wait".

> #: sys-utils/chcpu.c:208
> #, c-format
> msgid "CPU %u configure failed"

"configure" should be "configuration".

> #: sys-utils/irqtop.c:180
> msgid "cannot not create timerfd"

Duplicate "not".

> #: sys-utils/setpriv.c:135
> msgid " --rgid <gid|user>           set real gid\n"

"user" should be "group".

> #: term-utils/agetty.c:2466
> msgid " -J  --noclear              do not clear the screen before prompt\n"

There is missing a comma between the alternations of the option.

> #: term-utils/agetty.c:2471
> msgid " -N  --nonewline            do not print a newline before issue\n"

The same problem.

-- Petr


--yYQ3sjov2LOSDrpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE4/QvzhVoMKgDWObpT9GuwzZa978FAmYCsT0ACgkQT9GuwzZa
978Y3hAA7V0TOOnk9R7SdUN5+F+pu0zJuAoCuvRnkfk7v0P0yDQLDG0LmpTr0b7U
Xc6flnO1esVQNQfQC1gIle+bcA/zxsJUqkPCZnBsfx43UL/91lXb5uELjhJCuRhJ
Quxv8wMV1RycXdk/F5KlfRPjAyVR3DfoAc9qr2mOM1Pofqqz+bS2WRVXWPj0OgtR
Rj9R3wrQzDQIe9HkYElOWCw6uRB6uGlw7LwTnlmI1ulqCtH+vJy/a5cs6lOAjLuz
kaxZR1f+S8ovPMrjVcwA+SsUJAJlVwDjyRh/vsNWLV+J/yvrCgfCtbnBdbX6v+VY
cfGuyXDcp1l2Di3grKOvaWp9YSnPN8F+4zFTYPr02BFlpirnC96lukvOrwjppV0/
GrvwQ0Zif5ei7dr4Pq3FFuv0D6rZHFerskHRv6VWr3+Vs85pUxYyHQbo1eL1aJxM
7d9IsNBgaQwV7sXKgdjYvamUkNbhk+ys0DT+AiUtBYITkfZXSwWxksxu7LVtVspP
Z2oa46DtC34nFQZaFJG+V9BWGHabUcp6Ct8bFScLTQ8wvQyb8teKI9gEC0yUDTxV
gKsSgYwR0hmn0Mw3mWcD6p1nMQMKIS2Gifv9lK6x9iMkG2GX/O2ZxLfqcl3Jw/Bo
Ql4zvS5zG2eqyPurRC/sjfkuSfvHxcKX9N3lr+g2LuDxk9lpxcY=
=Z5jy
-----END PGP SIGNATURE-----

--yYQ3sjov2LOSDrpz--
