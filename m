Return-Path: util-linux-owner@vger.kernel.org
Received: from [82.195.75.110] ([82.195.75.110]:59731 "EHLO master.debian.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751237AbbEZEu3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 May 2015 00:50:29 -0400
Message-ID: <1432614096.2154.33.camel@debian.org>
Subject: Re: when would blkid success but not filesystem type?
From: Paul Wise <pabs@debian.org>
Reply-To: 784709@bugs.debian.org, util-linux <util-linux@vger.kernel.org>
To: 784709@bugs.debian.org, util-linux <util-linux@vger.kernel.org>
Date: Tue, 26 May 2015 12:21:36 +0800
References: <20150520145904.3e4645dd@patagonia>
 <1432196678.28686.58.camel@debian.org>
 <20150521110735.GA4730@ws.net.home>
In-Reply-To: <20150521110735.GA4730@ws.net.home>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-U+guNthIX2Ud7JjZJUzt"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--=-U+guNthIX2Ud7JjZJUzt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 May 2015 13:07:35 +0200 Karel Zak wrote:

> The option '-s' does not affect return code ...  we have information
> about all (including empty) partitions!

Ok, I see. Sounds like the proposed patch is appropriate then.

https://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D12;filename=3D0001-Fix-=
by-forcing-fs-type-to-not-detected-if-not-named.patch;att=3D1;bug=3D784709

>  Note that my recommendation is to use lsblk, for example:

That has the same issue:

$ sudo lsblk --noheading --output FSTYPE /dev/sda2 ; echo $?

0

I think for our purposes we would need --nodeps too.

--=20
bye,
pabs

https://wiki.debian.org/PaulWise


--=-U+guNthIX2Ud7JjZJUzt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVY/TUAAoJEDEWul6f+mmjXCYP/Rm4VNnylqGiIC0nch8JiJUP
nIPk47KmM8XtGauFucPFMJZ9umVBQG0uJOSrpLorVvBm29HnSeOnh5HgZ+zFOI97
o0uhrE242AWL41i1imcJ/5f+mT92AfVXtdVQ9+8Fs9PAJHO7yOc4qhE/VVeJTZ5s
uF6GWik4s3ZH5pTspV1MQVb6/IjxsgueDIafcySNrblWk531DKvb7x73Xy+1d9p1
7ASytjD0pk59gfxfiEbLd5uTF88fGtnyjq7kqxBN6d23FYhUL6Y49U0ufjGVopx1
37R6KL1fu4QcVJZbV5g1wpEFpygMpdSDykb09CPUWcZ/PChmUbaiVKKlOvAWgCnf
NlDO45MxA9GQLbazkfJ03Jakg85doo2Zks2K2QJLk/4ANYH3sD+x9LNDK1B320hq
ZKHMA+QeRnrhishj/eC8BdY4KT+Zs159KPkdoBezpjCkLltMRRC9BPBAeB1spJFA
UWs+BXLtMRHRBAyLoaktnedqW3kgMFmXMhAx48XLdUcgFZxEgnt+ZcS8nmReUwlf
XvjeZVXqHzZgrja3374kP/rAtNMagaIQZ63NzLy+MfttDgJ2aoUm7tS2XmvUc0O0
UsfBgGibCZcc6A2Y/4+9qs2QChPoEe5fICxoZPEeKmh67dmTVCPWcG6H7YLzx9n4
U3tpUezNpY9ZA1Y8+7Sm
=QdCh
-----END PGP SIGNATURE-----

--=-U+guNthIX2Ud7JjZJUzt--

