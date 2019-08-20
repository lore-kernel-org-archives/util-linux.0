Return-Path: <SRS0=LZ/s=WQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B753AC3A589
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 13:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8C42054F
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 13:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DTBuVsUA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2/m0Z62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfHTNJT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:09:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35033 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728595AbfHTNJT (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Aug 2019 09:09:19 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7CB882222B;
        Tue, 20 Aug 2019 09:09:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 20 Aug 2019 09:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=RlTq+3rkLQ5kqZx+qOhKbuC+oD2
        1lQpgXAIuUPAdFh8=; b=DTBuVsUAEz49b32LImUN6z6G+EOaIeRbVU86AdbDfqI
        e2M9NSyXMphfsxvGEr/rk3lzG5Iw2FcpwDY/qGyE4v9y1gr3C3E8vOeBcKQi70b5
        +js+0LzG+9q1iDsNW2SsERWwsem+0lADfIx6JjVLz6SeS+edOjt8F9UGp4r4vtZQ
        9/6RnxBBjZmnNwuUkovflXhbcaCAUxfwldtSBUw+c1j2e0goAMtYC/2wVo0Ll1Kn
        LCrLKR3Z8TIq4B8fBkbmTc++YEprRXlx/994f/jv+p1kvfaJYTaeE3taqZLdL61m
        j/rhgG6F3SGTuMxBpu4MfyteKxfQXWbBHw28YKtn++Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=RlTq+3
        rkLQ5kqZx+qOhKbuC+oD21lQpgXAIuUPAdFh8=; b=T2/m0Z62nFIw2lmLnbA+vK
        rDZirM3riuDfOYei/neoxuJoHPBZGQb2khRdPwCJgixPK4I8m/KNcHNO2tIy+dEu
        melIk8wkyKyhreToc6ZzxKpVWLMbTac0+sy0apJWMu2somJHABnr8ytJuvY4UDxW
        rMBJzeaSRE32CwVwhUmCPPGbXFj8z20B2VzGGLc9RCecEXnziNjGlO6F4IUm3qdq
        EBxn9ihC2YXPFB7d76gYn51Oj1bOPmJgZXoAVFfJCsJp2/lVu1L0DqcLiq1sY2IQ
        U0YhbmqDJQ0QlbG2CyFQXgj73/FDKGr/+slUfxOn9Ehnxxls8w+pFLzcMeHgWuqg
        ==
X-ME-Sender: <xms:_PBbXVWtfObAabMlGPXJjQhoU0K0GM4yU_9Q6MYEwiFur1kItpt1JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeguddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddule
    durddutddurdduudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:_PBbXRbL8lNAGHatQVC1Y-8GCjKjyV2UJpJITy6atuNrOy6wiVCjJQ>
    <xmx:_PBbXX1ghUiz1oTyO-yVTIzCIIr4PmS3lUDYS5UMZTfTH1FqHafRfQ>
    <xmx:_PBbXVBo4aIu11jJIJNec8FXlLsQzhi8kURLtaJNXNm19SFP310Prg>
    <xmx:_fBbXRJcvQSZ0EpwSl9vIq9dNkfM4UFvfyqY8vFDPDbASJ3cad957g>
Received: from NSJAIL (x4dbf650b.dyn.telefonica.de [77.191.101.11])
        by mail.messagingengine.com (Postfix) with ESMTPA id CBB1680060;
        Tue, 20 Aug 2019 09:09:15 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 1b12c8eb (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 20 Aug 2019 13:09:13 +0000 (UTC)
Date:   Tue, 20 Aug 2019 15:09:30 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] unshare: allow setting up filesystems in the mount
 namespace
Message-ID: <20190820130930.GA50493@ncase>
References: <3fcfc033d9d115649fee5f9ae05296c29033a7de.1565866421.git.ps@pks.im>
 <20190820125132.iq3w234ump62mnmb@10.255.255.10>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20190820125132.iq3w234ump62mnmb@10.255.255.10>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2019 at 02:51:32PM +0200, Karel Zak wrote:
> On Thu, Aug 15, 2019 at 12:54:45PM +0200, Patrick Steinhardt wrote:
> > In order to execute commands with the least-possible privileges, it may
> > be desirable to provide them with a trimmed down filesystem view.
> > unshare naturally provides the ability to create mount namespaces, but
> > it doesn't yet offer much in preparing these. For now, a combination of
> > unshare and nsenter is required to prepare culled filesystems views,
> > which is kind of unwieldy.
> >=20
> > To remedy that, this implements a new option "--mount-fs". As
> > parameters, one may specify a source filesystem, the destination where
> > this filesystem shall be mounted, the type of filesystem as well as a
> > set of options. unshare will then mount it using libmount right before
> > performing `chroot`, `chdir` and the subsequent `execve`, which allows
> > for preparing the `chroot` environment without using nsenter at all.
> >
> > The above is useful in several different cases, for example when one
> > wants to execute the process in a read-only environment or execute it
> > with a reduced view of the filesystem.
>=20
> I understand your point of view, but it's a way how unshare(1) will
> slowly grow from simple one-purpose tool to complex container/namespace
> setup tool ;-) I do not have any strong opinion about it. Maybe your=20
> --mount-fs is still so basic that we can merge it into unshare(1)
>=20
> Sounds like we need a discussion about it to gather more opinions :-)
> (CC to Eric).

Sounds fair to me. The main motivation I have is that I want to
use unshare(1) as part of runit(8) to spawn supervised processes
in their own namespaces. And using multiple steps to set up
namespaces and spawn the executable makes things a lot more error
prone.

> Note that the latest mount(8) has --namespace option, so you can mount
> filesystems in the another namespace although the namespace does not
> contain mount command and necessary libs.

That would require me to set up persistent namespaces first,
though, while unshare(1) allows me to use transient ones that
disappear as soon as the executable exits.

> And note that for systemd based distros there is systemd-nspawn which
> provides many many features (include IPC, hostname, TZ, private users,
> ...).

Yeah, I know of that one, but as I'm using runit(8) as PID1
systemd-nspawn(1) is not a viable route, at least as far as I
know. I'm definitely inspired by that tool, though, and would
love to have something similar that is completely agnostic of
what init system is running.

> > +.B # unshare
> > +.B    --mount-fs=3Dnone:/tmp:tmpfs
> > +.B    --mount-fs=3D/bin:/tmp/bin:none:bind,ro,X-mount.mkdir
> > +.B    --mount-fs=3D/lib:/tmp/lib:none:bind,ro,X-mount.mkdir
> > +.B    --mount-fs=3D/usr/lib:/tmp/usr/lib:none:bind,ro,X-mount.mkdir
> > +.B    --root=3D/tmp /bin/ls /
>=20
> The libmount also allows to mount all filesystem according to mount
> table stored in a file, so I can imagine --fstab option ;-)

I thought about exposing parsing of fstab-style lines from
libmount. But I'd definitely be happy to implement an "--fstab"
option instead, that would work perfectly fine for my own usecase
and probably simplify code by quite a bit.

Regards
Patrick

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAl1b8QgACgkQEXxntp6r
8SwVgg/7BmG4Pjh0wNxgs7iJ1umYGOa3noI1fQQn/M11vgtlNijs2V1g2aqmHo5v
LJ+AK4469QXaHT1EOlcsYXotI11NGzkPwFDdoRkp++TRj6mDDh6LzVTaCOS/fERI
IhEBBh3NH3XGCZZ2FB0tz4At7QAJOmo5V4vMYV1U9MigyZc+iRfcsN+v/NRbIxQb
RVvFhqiXldVVZUOWfrx6GRQCnU2dHTKbzeSWo47kXXqh9ZJa2ecCzdSayVB1HEUT
Kw9c8PdfnfyYz0xuB1POen2KguNfywKUGVmT4qrvEVNtALKADGq7ISA0Vwv9RqUk
queAltoXsPX2qSavGoeJWHtlaplyATK1dfHuC+wtWZ9b+kj/0DC3f2CskK+ZHvLr
7CxY97pEBd0sVojyK/U5byncwCrgqRf+CS9hcUnVSce0SumZccYg2Sw7G2aW8EXH
W5BfgNH+J2NMxPkBJOzT4niKgi3sDw/xxavoYBcP6JGCWWnBO3AK5CohbOacxZI8
kD7do5SPzBfIhBBXGeiaZRDmvqQ0GWptNxEe34N5O1U15oi0Wy42h1kily9Xze8j
ToCPRKwqwbbQBFM//r6Clymq8SvQVbZGGHWCJ0aFqWHlmCOkI8XqcOtPHLOX/mfh
WYzZmjSoFc0ewT62YuKL2qEu9NDEpDOBuXzwkvfVBTTjdK0W+q8=
=jNsO
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
