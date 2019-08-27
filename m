Return-Path: <SRS0=xJlx=WX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC4FC3A5A3
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 11:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0064C2173E
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 11:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xSdJQzLX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dwXE1kAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfH0Lta (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:49:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57963 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbfH0Lta (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Aug 2019 07:49:30 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 85E4621F83;
        Tue, 27 Aug 2019 07:49:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 27 Aug 2019 07:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=aoPvMaL1vhBzrNgHNnpXRCSjlGT
        X+A82qxOv7yH9nMg=; b=xSdJQzLXkMiF/6ssfBunkKXJhdkdkbCydX+cw80TOJL
        YO34oRzrxXSGnU8AUcjPm++r0I4gA9FrM4Vr4dllH5VSmbn2BSjOAqjAjlcZdG18
        kJmodDEWeHPecu731hzV+h+Y4NgGc6zXV1HTn2BUgV/zEWZIQ8ToR02HuEnWx+VH
        nW+E7wunXqhRVlxDBw6Xx6I3avGYanEinAURx3Zp/fnlCsy9tKKnX+HcPA7jSy+5
        oOubmN6NweMFYOGnYuM0KVsx+A29mK8wQy/65z1EOLvW9mrtmczy6MfD/eAASNny
        srvk5VZ4ozujEkLBQdgmluublOsGs7s2CeXdk8Md9zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=aoPvMa
        L1vhBzrNgHNnpXRCSjlGTX+A82qxOv7yH9nMg=; b=dwXE1kAjVci21PwxRtdxX7
        zj7xeF7fzpssd+TvryTkbFjtqzk8ZGXYcrLO9eF4BoMdZVdqdmbVwkT+VMoTUKlw
        EQIBduAR3bu0mrlyysjhJizHShyJ3ePIaNB+DjcW/7uP6G0cOu5Fz/6c6b/PtMkS
        Ew5ZldVhtcuGwr4yhQv9dTJXHqtyVa/CC+x5olMdTLce5z5U4vqH0cENDA4LBh9h
        qdTfnQOy2z+KwCdtSKoMcrJFM3v4wIk67uDevkl9Wx//T4qIG6Y3VY5Arh91wNOv
        bZAKAbF0p7Bib4SgNcpEcfEDc8IWgAFC9DT5wpxHN94n/Vl9Zdwczvf7Jb4/8aHQ
        ==
X-ME-Sender: <xms:yBhlXTxLCtaBZtMXM7UrApxV3_hATx-JxtwrElULnHUVMs57AW0PmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehjecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuffhomhgrihhnpehgihhthh
    husgdrtghomhenucfkphepjeejrdduuddrvdegvddruddvleenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:yBhlXSxIQX3dFlwiqPOiRqGUnoQN-fFlFn1_EuvFppfJlWqJ5q3oZQ>
    <xmx:yBhlXTZZ1zW7kH3lccogbI3Yh6f6QmxaKTY4gebHssYtvnz65n5e1w>
    <xmx:yBhlXbmJUMg1A6S8k5ETPxQ2FQm2otR5IEH7iC9H6jSMukUfixbjzA>
    <xmx:yBhlXcHt0gMlWbLbSbzV5PiqXhqZcjpYCPZ-l2hz6eLLLv_0EcUHUg>
Received: from NSJAIL (x4d0bf281.dyn.telefonica.de [77.11.242.129])
        by mail.messagingengine.com (Postfix) with ESMTPA id 77806D6005F;
        Tue, 27 Aug 2019 07:49:27 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 347684d6 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 27 Aug 2019 11:49:25 +0000 (UTC)
Date:   Tue, 27 Aug 2019 13:49:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/6] tests: remove reliance on buffer behaviour of
 stderr/stdout streams
Message-ID: <20190827114924.GA131601@ncase>
References: <cover.1566555078.git.ps@pks.im>
 <cover.1566566906.git.ps@pks.im>
 <d503b30d13c847040a8343f0e7299ae1bf7cb120.1566566906.git.ps@pks.im>
 <20190827111748.g4o375ya2shfrivs@10.255.255.10>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20190827111748.g4o375ya2shfrivs@10.255.255.10>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 01:17:48PM +0200, Karel Zak wrote:
> On Fri, Aug 23, 2019 at 03:32:53PM +0200, Patrick Steinhardt wrote:
> > +	if [ "$TS_ENABLE_ASAN" =3D=3D "yes" ]; then
> > +		args+=3D(ASAN_OPTIONS=3D'detect_leaks=3D1')
> > +	fi
> > +
> >  	#
> > -	# ASAN mode
> > +	# Disable buffering of stdout
> >  	#
> > -	elif [ "$TS_ENABLE_ASAN" =3D=3D "yes" ]; then
> > -		ASAN_OPTIONS=3D'detect_leaks=3D1' "$@"
> > +	if [ -n "$UNBUFFERED" ]; then
> > +		if type stdbuf >/dev/null 2>&1; then
> > +			args+=3D(stdbuf --output=3D0)
> > +		fi
> > +	fi
> > =20
> >  	#
> > -	# Default mode
> > +	# valgrind mode
> >  	#
> > -	else
> > -		"$@"
> > +	if [ -n "$TS_VALGRIND_CMD" ]; then
> > +		args+=3D(libtool --mode=3Dexecute "$TS_VALGRIND_CMD" --tool=3Dmemche=
ck --leak-check=3Dfull)
> > +		args+=3D(--leak-resolution=3Dhigh --num-callers=3D20 --log-file=3D"$=
TS_VGDUMP")
> >  	fi
> > +
> > +	"${args[@]}" "$@"
> >  }
>=20
> Unfortunately, it seems "${args[@]}" does not work when environment
> variable used:

Huh. If I remember correctly then I did actually test that this
works, but oh, well...

>   ASAN_OPTIONS=3Ddetect_leaks=3D1 stdbuf --output=3D0 /home/projects/util=
-linux/util-linux/mkswap --label 1234567890abcdef --uuid 12345678-abcd-abcd=
-abcd-1234567890ab /dev/sdc
>=20
> ends with
>=20
>   ./tests/ts/misc/../../functions.sh: line 465: ASAN_OPTIONS=3Ddetect_lea=
ks=3D1: command not found
>=20
> And it's more tricky, it seems ASAN binary cannot be executed by stdbuf
>=20
>   # stdbuf --output=3D0 /home/projects/util-linux/util-linux/mkswap --lab=
el 1234567890abcdef --uuid 12345678-abcd-abcd-abcd-1234567890ab /dev/sdc
>   =3D=3D28469=3D=3DASan runtime does not come first in initial library li=
st; you should either link runtime to your application or manually preload =
it with LD_PRELOAD.
>=20
> it's because stdbuf is hack based on LD_PRELOAD which makes it
> difficult to use with ASAN...
>=20
> I have tried to fix it by
> https://github.com/karelzak/util-linux/commit/f612c4c674e8e07fc40644432d8=
147a05c62058e
>=20
> ... but it's really not perfect. I have used "unbuffer" (from expect)
> rather than stdbuf. The question is how usable it will be... (but all
> tests passed).
>=20
> Note that you can try to use ASAN by ./configure --enable-asan, the
> script tests/run.sh should be smart enough to detect it and then
> individual tests are executed with --memcheck-asan.

Thanks a lot for fixing this up for ASAN then. I've tried to get
ASAN running on musl libc multiple times, but didn't yet have any
luck in doing so as it will always crash immediately. I'll
probably have to invest some more time here at some point to get
this working.

> So, merged -- please, test it with musl libc.=20

In fact there's one more test failure in fdisk/oddinput. Seems
like patch 6/6 (fdisk: avoid hardcoding of errno string,
2019-08-23) wasn't applied yet?

Patrick

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAl1lGMQACgkQEXxntp6r
8Sys3w/8CcZHWhuSrpzm829HXE9ZlkQa3ctjw2Xgy47fn0RPLApKXRynIO0y9NhG
+zrRxoVerCt9UY+D6a7qSzzROeKq+IFWo+FCjeLWa9i6rFVC18nAOhmx6xWtn942
7h0wi0OWeJVO2I7d7gOjM+SQRQcQEyGUbzri6aXmEivdluJxN6aXLKXGNYhfl563
jIxIjDjvYQoxUSG7ysBx8tJwdaYn2vgqABEnV8r8gvWZ1y/xDRb5RD9GT+oufCSC
IBOke5u5v7DAoaUwkn2ecKX0hRhELBcsijZS8loO7aXpSpa2z6aPlMAk24nl5i1S
aePpbp5+pzNRJDGta9AgCgpWKNoVUS8JSpMPAsS6E2PnkalZftTkzsihiTLUhI/2
i4AnR3kerc9tM2UGd+XHQUPuuuEjOHocao2HB2jPV5Ml0m+TKvBokVYPOVtXWUfD
u4ChpfAZcrePCLuM0wT5sEpA9OWYv2UnAFduWbZfjbzNl/nlT7n9+r5xue73FztU
iWiHNQsEgyZDEbzwwHb7Y0X/7apPW+ri6nGfGgj5jORGkUWgbrCIjdYZkR1HMVDZ
NUwA25deUv/C5BFQf1toxUpiKHh+3sWLQuqgCTUg7iRFtFHRxSw0EbvD1YWWxfkI
A05L4v99fytfqT1oDNFiTSuMTuvVBZ9PzhIHFIj1D3prUj58Hs8=
=O15K
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
