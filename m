Received: from evolvis.org (evolvis.org [217.144.135.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45A215189
	for <util-linux@vger.kernel.org>; Wed, 26 Feb 2025 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.135.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562127; cv=none; b=DZKbijnYu3Im6Id/9kfzzidfwc+xXWhDiZeuFmwXj1SUd9R8ZIJx+NAKclbvc5peHzMs8RytA7yLRVhbLazUtsgTOznbp2dW/WEn1fyq72UpvkziLurd6VOY1/2jQL+GSSBLZvlN3cwDSe2zPkK1TGGu8me0cbAVbbI0hW6PgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562127; c=relaxed/simple;
	bh=ILoUCtlXq/nqH0Nf5eJwKjmaC+7zPs0k9/MAEU0w/xA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V0sFTFnT3E6VMHjoBHqFodjNZI5jyurP/6Tx87T/ZXVTONs3yx7AzQ+6Y1qNw52YenM6SpxvlxeonxyrlMJAxL6lCglgFk4/TcZosC6bGFOEL20ls50Qlb4neim1diBb2v70rz1PZhT5YnUBzyw8ESQT6Y8Iim1tKaJAYCI+bv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirbsd.de; spf=pass smtp.mailfrom=mirbsd.de; arc=none smtp.client-ip=217.144.135.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirbsd.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mirbsd.de
Received: from x61p.mirbsd.org (unknown [IPv6:2001:470:1f15:10c:21d:e0ff:fe77:c17b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: x61p@relay.evolvis.org)
	by evolvis.org (Postfix) with ESMTPSA id BC89A100104;
	Wed, 26 Feb 2025 09:22:44 +0000 (UTC)
Received: by x61p.mirbsd.org (Postfix, from userid 1000)
	id 27A65143236; Wed, 26 Feb 2025 10:22:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by x61p.mirbsd.org (Postfix) with ESMTP id 227B9143235;
	Wed, 26 Feb 2025 10:22:44 +0100 (CET)
Date: Wed, 26 Feb 2025 10:22:43 +0100 (CET)
From: Thorsten Glaser <tg@mirbsd.de>
To: Karel Zak <kzak@redhat.com>
cc: Chris Hofstaedtler <zeha@debian.org>, 1098638-quiet@bugs.debian.org, 
    util-linux@vger.kernel.org
Subject: Re: Bug#1098638: fdisk: creates partitions one sector too large
In-Reply-To: <7tyxu3bufdztsdkt4svgvz5ul4bzsnvbstndcopht36lklthbj@3kmnuyuwhtwp>
Message-ID: <69387f65-c992-04f6-2774-a1d0417ded94@mirbsd.de>
References: <5c513969-5e9f-cb0d-c62c-e153ca259915@mirbsd.de> <Z7shDWfLwHPMxT2C@per.namespace.at> <7tyxu3bufdztsdkt4svgvz5ul4bzsnvbstndcopht36lklthbj@3kmnuyuwhtwp>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 25 Feb 2025, Karel Zak wrote:

>The convention of +<sectors> is strictly evaluated as <first> + <size>,
>without subtracting 1.

I guess someone made the maths mistake here: the last sector
is always <first> + <size> - 1, compare C arrays.

>This is how fdisk has functioned since its inception. I noticed this
>in the v2.13 code and was able to replicate it with v2.14 (year 2008).

Ouch. Then I agree changing this is not prudent at this point,
but please *do* clarify this in the question text. Let me
propose new text=E2=80=A6 hmm, let me see the old=E2=80=A6

>> > Command (m for help): n
>> > Partition number (1-128, default 1):
>> > First sector (2048-7814037134, default 2048):
>> > Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-7814037134, defaul=
t 7814035455): +2097152

=E2=80=A6 let=E2=80=99s go multiline for this:

| Last sector (2048-7814037134, default 7814035455),
| +/-sectors from first sector, or +/-size{K,M,G,T,P}:

>This is different from +<size>{M,G,T,..} where the final
>size is reduced by 1 and aligned to the disk I/O limits.

I expected the -1 (fencepost) but not the alignment, but
that makes sense.

>Additionally, it should be noted that people use 'echo
>"something" | fdisk' in scripts ...

Indeed, I do so myself, though in scripts I have so far
always calculated the last sector manually, it was only
that day interactively when I wanted to enter a manual
size in sectors: specifically, a split-mode dm-integrity
<https://evolvis.org/plugins/scmgit/cgi-bin/gitweb.cgi?p=3Duseful-scripts/u=
seful-scripts.git;a=3Dblob;f=3Dintegritysetup/README.txt;h=3D76a7a67cb35d34=
c08eeeb916ce26f1832febf922;hb=3DHEAD#l113>
partition (where I manually aligned the result from the
isize-p script in the aforementioned documentation to a
multiple of 2048).

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80

So, would you please consider changing the wording, at
least, upstream? (And, perhaps, throw in another sentence
or two into the manpage, stating that the +sectors syntax
isn=E2=80=99t meant to express size, unlike the others.)

Thanks,
//mirabilos
--=20
[16:04:33] bkix: "veni vidi violini"
[16:04:45] bkix: "ich kam, sah und vergeigte"...
