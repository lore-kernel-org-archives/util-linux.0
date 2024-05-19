Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478784C8E
	for <util-linux@vger.kernel.org>; Sun, 19 May 2024 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716106434; cv=none; b=hTdE+cQn20xW0w+BwBMadvRTMKw2e59bJec//Bp5T/NGTuCkw1Xqd/y44UAnNnAMdJf09Us1WEtjOPdszjkMKdbA2U9Vp259kjVTZRDt0P4CDVjvVQA+S5BvnGYFQyUdEkhPCmORyM8QrY8ZTiLbu8Hb1AoN5l70nLxNbB+yV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716106434; c=relaxed/simple;
	bh=AhtcmroSZ0eKLM1aPxu3QcLEhOBXVNkgsSGp5FCxxwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDKC07rERE5SR8mjQl+05IRZ7ADRb7WHCReGFwJACTyImSg3+WVFe9BjjVkAwCCOQWmEzaXH6gDG+2xgWt8AYInXBLkhJY51iWVeb8vXBARgIIWMpoxBDQcVx+YA6Is43Shs9QQyzcbuL32zV+sjXDM8jR2VcaCupW4APwxEY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=TwOkPA8q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PdtvpO8K; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="TwOkPA8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PdtvpO8K"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3E7E313814B2;
	Sun, 19 May 2024 04:13:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 19 May 2024 04:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716106430; x=1716192830; bh=AhtcmroSZ0
	eKLM1aPxu3QcLEhOBXVNkgsSGp5FCxxwo=; b=TwOkPA8qM/d97Itixbnf/DN758
	B4GblUt3uWoJieRQ92bPvxdGT9PixDDViGaxZMJ2PSIWxEu5UwxjGizmr+szc0X6
	2HubUkZniMk9VEEAcycoCAWhmeT72O0ejsME02XvwE4jd1fztM86BkFjDPouMTrg
	0oXyzRSWcthGrvBGZVtsTOxzHeKWHw6q9OHEHBu2eTvrpadiJF3Rjwpn/iyY2o7Z
	1qBU24NMGneqVMdnvqOGOh9kcQcA12CnywBD+DzHKSg9GhMQZkbqjRjn0ZEgtm3G
	l7xF5di67Bgz/ZUMLUQMc2v/BEQN7LMUGlnvFgdDOS82BDRvwWWxsULtX4tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716106430; x=1716192830; bh=AhtcmroSZ0eKLM1aPxu3QcLEhOBX
	VNkgsSGp5FCxxwo=; b=PdtvpO8Ky85ysknWE4cXmh/uFwQE7rktckNZOyI+yhSf
	u9wV4yQilJpff7NJi+6CXmMpmG0g52Fpunr1lMfH17ej+0xF7qo5LVKhCrYTxx9l
	X3vEujdhMPfp7bhsCVhO7hWC1ZDsJCoF0NwcwlJFB9RxraIAq0IZi3g/QLmGAC7Z
	FHkEP6R3LyeLtGK3TTxB5cez3QjLZEla7+LK3HZMc0LmCfap735MqPEqchMCqZmB
	aUJ/r6ICzjECl9HpktTfkpSI9fm+cbiORZ2UhVoljvCZbdUegkBI81awY9jMpsg0
	7Pyz2KZW1gzFCbIc3r/nUxXIvDT+aPeXVcguw5b1sA==
X-ME-Sender: <xms:vbRJZlMLJLe5uGq1AmOuMoP5VKRw1tnRu8BX7xsO61R9IzuypsHWKg>
    <xme:vbRJZn-A_w41U_kcAtRK8RhYu6j3cBvlZJL7htm1P2wVVPUsRSydLPzGeT-aqu4EP
    6Ba-I9DdtSl-aWQiA>
X-ME-Received: <xmr:vbRJZkQosH4p8RfjVqHmhRrr15v_8TwfkSxNtWM_J50hE5V2zfi4So8d_ZsDRhalbtVNS_aIDREtMs8IApSS9KSVJjeq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuh
    hsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvfevufgjfhffkfggtgesghdt
    reertddttdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrd
    hisheqnecuggftrfgrthhtvghrnhepiedvtddvudeiudevvefhgfdtgeethefgjeekueel
    heekvdeuuddvffetvdfhkeeknecuffhomhgrihhnpehgihhthhhusgdrihhonecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhs
    rgdrihhs
X-ME-Proxy: <xmx:vbRJZhupwZAM_ZtO0fbbPQDDnYkAPF5dsrYCDLDuEw34nRUtqu-4TQ>
    <xmx:vbRJZtcGiyvXzZxSy8sElXfWNcie7JLU7aXPRO2NqSFUQ59rM3CaWQ>
    <xmx:vbRJZt2vcbPfUpk7uon1paECnlECydDt1FTjM1z9-f8k4jDXSxObjw>
    <xmx:vbRJZp8AwsNIwrlO3jWauyBrghWg5FoKKW_3-pzdnUTXGrEObXwyqA>
    <xmx:vrRJZh5Ue1H63QXDA8mGSNHlCDZX7HG7509ZP3-17RULmU3KElFC1k7X>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 04:13:49 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 245014F4209; Sun, 19 May 2024 10:13:47 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Santiago Vila <sanvila@debian.org>, util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: Re: Parallel build failures with util-linux 2.40
In-Reply-To: <3dfa7d03-f2bf-4d6f-8387-98ec999243bf@debian.org>
References: <87le4c1zm4.fsf@alyssa.is>
 <20240515142226.oyp37o3fkajvpoal@ws.net.home> <87eda31219.fsf@alyssa.is>
 <87v83auc95.fsf@alyssa.is>
 <3dfa7d03-f2bf-4d6f-8387-98ec999243bf@debian.org>
Date: Sun, 19 May 2024 10:13:39 +0200
Message-ID: <87cypigqx8.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Santiago Vila <sanvila@debian.org> writes:

> Hello.
>
> In some cases, make --shuffle option (available in GNU make 4.4)
> "amplifies" the probability that a Makefile bug shows up.
> I suggest that you people give it a try.
>
> There is a blog entry from the author explaining --shuffle option:
>
> https://trofi.github.io/posts/238-new-make-shuffle-mode.html
>
> [ I'm just a long-time lurker in this list, but maybe this could help ]

Thanks for the suggestion, but I tried running with --shuffle for hours
before submitting my report, but wasn't able to reproduce that way. :(

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmZJtLMACgkQ+dvtSFmy
ccC4PA/8Do5nHjdc91KMjBVXEPO/RB87SK2hdv8zYOXBRxRea5SVVtd4f9Fp3k+p
daZ8ERc4bf4a7DjLjlE+omBuPWXzajFoQ+P8u2fpAqyWnL/VfnW970LUIweYp49m
ZbhP56Hb3bK1lxsn+rBDRk6cuolULiesmR+U2jpDiawgqhrNHNA5NFzbFiZJvoE8
endmpPmOfsfxv5mYlEyR1AC/HgfvCZJj1Tp1x6UhWKonDI16D/CgW/sjrtQghbnx
LRbzhsGXSvYdubWg1l6/g5PduDPABV1l6T5U6tBY/CngJM8bRnwRfYnHRhnBeA9h
fGIPCU+/4K8PF8tDZWZ/Z2vYp9E751Kzk9heiIGQ7PErklc2DoMijrsKN+SjsmdL
gJl7lJVgel0sUj/rTUeb/ekme/9Uyhw8x7niXLPddi1+B03vCQUXef+lnhScezuV
JK2o6R1eBKxcyzaifqwyxroZjbra2qeXFyDVO85NQRPIgekD2dy3PkdESjdKOjYh
K9N9nHUt/09+2eotv0KR4H3G4ZcqFXlS+fakbGVmieOGj4kItR4xjMx3FI/pT9CC
obwK5GuAt/nWlqESQUKSd12yfVqathPrNd6yNC0O/pykYD++6U9B/ArH0A8458uv
ZkmbtIowcUmxGW07BoEcgUBgSyc7ORQDzqGb5WELiSs2wVngw/w=
=WbED
-----END PGP SIGNATURE-----
--=-=-=--
