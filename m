Return-Path: <SRS0=JR0f=W3=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2396C3A59F
	for <util-linux@archiver.kernel.org>; Sat, 31 Aug 2019 07:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FB12342E
	for <util-linux@archiver.kernel.org>; Sat, 31 Aug 2019 07:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oYNLGwM/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jXYCxHOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfHaHla (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 31 Aug 2019 03:41:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55613 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfHaHla (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 31 Aug 2019 03:41:30 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C18321B7C;
        Sat, 31 Aug 2019 03:41:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 31 Aug 2019 03:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=aTRB/4F9SoxuHm49fgQRUsQ+yWj
        gHKbsKYYBk1AReek=; b=oYNLGwM/7MhZe/NWmjv2J8/ZmEgoB/iVDSSv+2ALeub
        FDxzbbHPrXXDrjEE86ypu/cQF3jocqRv4Xq47ylLLSOvH/c+9ZmZDkrNr8DuQEJV
        oXvts/baq5ktXahPXWMXsy1EU4oJxKMjPi/UAbLAZMEiva23xS5araoydehlDQlU
        4VFADcLNVzLQ337sFdLe8+jjGHOm8ZrpDnQSC/ICwQWIiJAsbSqCP6mQ5B+TVFhg
        Z0wU4V9crang3OOJZY5THk0x5kFePon5ehLCy1qGwbhKjWLatqp82F1pCMSAobCP
        qUvsME3ol08dnw1hCNoy+Ju8lFGucW5Qt8NTydafvLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=aTRB/4
        F9SoxuHm49fgQRUsQ+yWjgHKbsKYYBk1AReek=; b=jXYCxHOhNa+MigF4ROy5rw
        FWsaUfBlU4YFpQrqRvUmtFBSHP5dhAsdRHT+VuPfOvmesNiBimLQDUD5CudZvjFs
        ssKUJgDWWS9+LfNKy5fGYWNBSEcI1/K05XodA9ckjE9QlUHzjh84f1ty3umXZdk2
        Gp8ZMeuJ6Xl6X/8sFLE/op2PcoVrv+gMU5o+7WuNdmXxP+lwu5GTtTWP7ZHoK6fD
        G1Go0MOYB7QstaA0sjZN5vBA0SBUy5NRDXteUn8fXemBj3d/ajUiwTY0kOB0oWRD
        nzZSVLzaKNIu4UH56iFtXmInKLjFoDbf6FfI2HW/ex0udNJoFb+8cIZWFUAREttA
        ==
X-ME-Sender: <xms:qCRqXUFPLXGe3PfRdjpf1Y0k0ieMn5pN8CXZ3E5IzTavMCLLpahSWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeihedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuffhomhgrihhnpe
    htrhgrvhhishdqtghirdhorhhgnecukfhppeejjedrudefrdekkedrudejjeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpe
    dt
X-ME-Proxy: <xmx:qCRqXac64F2b39LNObbyLv6zebs8nP7mhoBNYpiyyIDpQ34iJzdrMA>
    <xmx:qCRqXenqj-_wDa6qJkiGuKlWBgpzAvZ4ZrA2KH6lP_K9xRxYjfkVAA>
    <xmx:qCRqXXHc-YXHaS6J1AUxUAOOr9Bs1VdoprQk4bD42Joe1ujNcGRYoA>
    <xmx:qCRqXf9Vi_Qg0gsPSHsO-fCe9FAExdjZfTq0OuztmhsEdBo9gE3Spg>
Received: from NSJAIL (x4d0d58b1.dyn.telefonica.de [77.13.88.177])
        by mail.messagingengine.com (Postfix) with ESMTPA id 73FB6D60057;
        Sat, 31 Aug 2019 03:41:27 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 9310db02 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sat, 31 Aug 2019 07:41:25 +0000 (UTC)
Date:   Sat, 31 Aug 2019 09:41:26 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: use env and support both unbuffer/stdbuf
Message-ID: <20190831074126.GA12599@ncase>
References: <20190827111748.g4o375ya2shfrivs@10.255.255.10>
 <219cbcaeb173a07e97dbac8e1b653904369d91e0.1566907983.git.ps@pks.im>
 <20190828105107.tkhwqh3limxjo5yc@10.255.255.10>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20190828105107.tkhwqh3limxjo5yc@10.255.255.10>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 12:51:07PM +0200, Karel Zak wrote:
> On Tue, Aug 27, 2019 at 02:26:08PM +0200, Patrick Steinhardt wrote:
> > Triggered by commit f612c4c67 (tests: fix --unbuffered mode with
> > ASAN, 2019-08-27), which says:
> >=20
> >     Well, this patch sucks. It would be nice to have things in
> >     the way how it has been original expected by Patrick's patch,
> >     but ...
> >=20
> > So this commit here effectively reverts it and instead tries to
> > improve the shortcomings of the original patch. First, it uses
> > env(1) to set ASAN_OPTIONS instead of directly adding it to the
> > args array to fix execution of "${args[@]}" "$@".
> >=20
> > Second, it now supports both unbuffer(1) and stdbuf(1). The
> > latter uses LD_PRELOAD tricks, which doesn't play nicely with
> > ASAN, so it will not be used if ASAN has been requested. It's
> > still valuable to have support for both, as many more systems
> > will have stdbuf(1) from coreutils installed but not unbuffer(1)
> > from expect.
>=20
> Applied, thanks.
>=20
> Unfortunately, it seems result is fragile. It fails on travis
> https://travis-ci.org/karelzak/util-linux/jobs/577767328
>=20
> The problem is the order of some output lines, for example:
> tests/output/rename/exit_codes
>=20
> Maybe the best and most robust solution would be split stdout and
> stderr into two files for each test. Now we have $TS_OUTPUT, what about
> to replace it with $TS_STDOUT and $TS_STDERR? Something like:
>=20
>  - $TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
>  + $TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT >> $TS_STDOUT 2>> $TS_STDERR
>=20
> And also create tests/expected/<foo>/<bar>{.err} for tests where any
> output on stderr is expected, otherwise assume $TS_STDERR is empty.
>=20
> This change will be pretty invasive, but than we can easily compare=20
> outputs and keep track about what is where printed.=20
>=20
>     Karel

Sorry, I somehow didn't see this mail. I thought about splitting
it up too, but shied away as I expected it to be rather involved.
Anyway, I think in the long run it's definitely the best way to
tackle the issue at hand, so thanks for your effort!

I've just done a test run on musl libc, and everything except for
the known issue with POSIXLY_CORRECT getopt passes.

Patrick

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAl1qJKQACgkQEXxntp6r
8Sz4zRAAkElPYAJZ8CBDkWWvoPoYnaTsaS30n0zKfB0yPEmM3dFOJLd/EIaJ7cNS
FOY6FBaux33U9yB8Akddi+0bBfVuAaH1v+CNzAoFGBBFr1Kt+OgIvuDiOvKcHHXw
WFdDg/wR7o2eUVvVFh4CeZ2dtSbp78QnSH6YhBiML1LhFNecxIesfaguW8y3UT4U
JRLHmViuty/ftnYTi6fqHJPU65Ayhbymx5zpLGNErM/fu9n9AqkyXwl0q2dALkV8
Bs4MrdQJqSt3gE3aDn/SstGuAPe8sb65bftqw7CPXVN6RHF1RQecr47KZEHJMo0Q
H9Qritstk3fcTqN/raDUqzqNSWQlGm2QA/ZNuPxSl8w1PjUHHQNM0lkjOPt18tGT
NRT0fmtTNDzfctxufO4aUULtz5jMmJhiZ9l9URIgvvfjARqTPZv8kipZwgLvzb6q
oERbpGI5BFfD0GAlodNUDXu1GqE5tkyWrOPiilJ4QFXxokJiZkmxxaSzkl/05Add
t0ORGMnmB7POb7cK7vP8gF2Ix3ZIhnomc1N7XaWi3tolqoJii3EMKLOsnAF/ruqQ
o3sjQd6GIZJwBNFqpb5jO4ZoFwJ1ct7kYonILQpmfF1E1C/AOUjBJ352IzTgamIa
uKl38eEFWf00P6rpIuy9WpabUFHlAVyOhEhM9phNy76nsV31lyE=
=9Kf3
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
