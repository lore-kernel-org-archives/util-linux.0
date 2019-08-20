Return-Path: <SRS0=LZ/s=WQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1931C3A589
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 13:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A44D22DA7
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 13:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sIhe9YW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wu7SF1sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfHTNRa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:17:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43919 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfHTNR3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Aug 2019 09:17:29 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A50C21B84;
        Tue, 20 Aug 2019 09:17:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 20 Aug 2019 09:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Thx21A6fG8MoGJiZCNh9m7VoZAr
        mD7HW4mVikHuLREI=; b=sIhe9YW3ifpU5/M5PZ23d8uzN1LbzyXa0tifvvY298O
        qtPa1hDIRryJ66ewnF8WLztrF3eElLAxO7lrItdAJqm3lQYjOWe9wo88IO1TdtjD
        oMS31jLg8HF4OOOqtDTMJQEnm/9vGcdjDYtn8snW4E6qtKP4YEga7fTWZenJkCO+
        axYL0+noYT9Gyu8wQQdcnkCuMad1nSs85RmHJQI1kb+rhTnirN5wXE8Ru75lW0M0
        IQtAYHt/Hxz8YePwoWyHR8JnMB5TKtXHgAMsFeSE3VeHGw+ZfB5Jq6l9K+KFv0D8
        z3sE0h/yj5ixXNu4Y1V8MEslvWerLSYPQf3J5wsaspw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Thx21A
        6fG8MoGJiZCNh9m7VoZArmD7HW4mVikHuLREI=; b=wu7SF1szpblGTU6WLTB5eb
        J76kOP1F5ua92zEeDJ2OLT+AIsneY/0BYhaS0oShw8Lxs+aP64YIF+kPhqsagajU
        S0snYjTiY8mEyLc74YkZFzM842l0OzfjX6aBbpqAmsdaXkA7G/t+udLLiF6F1wSR
        GmT5YfKIRxboHmjq1gYm8+ET06WNQ5QLWSTd0UFsRc50kEz8MyODlkoZpvKlQUIg
        kmvLI50zKdAJNQxDb8LVAJPetD/PqH829WeniDAzpqtKZctgOnsuYHwvVWloRrku
        AlsX4ClAdAycGKsPU6kgtD07e5FkrZcujNt9ND5zO8rGCI6IakhZXyCQqXKTUnpA
        ==
X-ME-Sender: <xms:6PJbXUImy-eCVyEXkTUj3Uy7CDKfkjdpyVUr1QVZpNT2dM7Pg2NL9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeguddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucffohhmrghinheprh
    gvughhrghtrdgtohhmpdhgnhhurdhorhhgnecukfhppeejjedrudeluddruddtuddruddu
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmnecuvehluhhsthgvrh
    fuihiivgeptd
X-ME-Proxy: <xmx:6PJbXf8dCMtgmFCY0N7aREg7WZJ49Ymrc_I4e904MEOMz-Nl-PQncQ>
    <xmx:6PJbXaMdAmbHFkymgsLLIgTdIlAfHsJsgaOWDOMPthLWe8l5eY_AZA>
    <xmx:6PJbXT0sx3fgVB7JkmR443iH7ScYMQZmYyn8F1-JlBhjjU-Wytux4g>
    <xmx:6PJbXedDrVHofq1DMIGEDnOQCZodMfn_5RezyifU91Kw2rL1j5aT2A>
Received: from NSJAIL (x4dbf650b.dyn.telefonica.de [77.191.101.11])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3CB668005A;
        Tue, 20 Aug 2019 09:17:27 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 312244ff (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 20 Aug 2019 13:17:25 +0000 (UTC)
Date:   Tue, 20 Aug 2019 15:17:42 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 0/4] Fix closing of standard text streams for non-glibc
 system
Message-ID: <20190820131742.GB50493@ncase>
References: <cover.1565800625.git.ps@pks.im>
 <20190819133619.dtn5ch2sdbme5zir@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20190819133619.dtn5ch2sdbme5zir@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2019 at 03:36:19PM +0200, Karel Zak wrote:
> On Wed, Aug 14, 2019 at 06:45:03PM +0200, Patrick Steinhardt wrote:
> > since commit 52aa1a661 (include/closestream: avoid close more
> > than once, 2019-06-13), util-linux fails to build on musl libc
> > based systems. The culprit here is that it introduced assignments
> > to stderr and stdout, while the C89 standard explicitly notes
> > that treating stderr and stdout as valid lvalues is not a
> > requirement for any conforming C implementation. musl libc
> > implemented these streams as `extern FILE *const`, and as a
> > result assigning to these variables causes compiler errors.
>=20
> The question is if close() for stdout and stderr is the right way to
> go.=20
>=20
> In an ideal world it would be enough to use ferror()+fflush(),
> unfortunately for example NFS has never reached an ideal world and it
> requires fclose()... See
>=20
>  https://lists.gnu.org/r/bug-gnulib/2019-04/msg00061.html
>=20
> Florian (added to CC), also suggested to use dup3() for the
> descriptors and then fclose() for the new handle. It sounds like a
> pretty elegant solution how to avoid all the issues with NULL and it's
> also robust enough if you accidentally call close_stream() more than
> once.
>=20
> See
>=20
>  https://bugzilla.redhat.com/show_bug.cgi?id=3D1732450#c4
>=20
> Maybe we can improve include/closestream.h to use dup3(), than it would
> be possible keep all in the header file as inline functions.=20
>=20
> Comments?

I honestly don't get why we'd need to use dup3(2), though.
Couldn't the same be achieved by using dup2(3P) followed by
close(3P), instead? Especially considering that the former one
isn't specified by POSIX, either, but the latter one is.

That being said, if we agree on a proper fix here then I'd be
happy to post a v2.

Regards
Patrick

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAl1b8vYACgkQEXxntp6r
8SzSNQ/8DX3dIPDauM2+Y/+1GeGeZAKS9PJkZ4KyedOkn7gVcahWiaKZa+3LlsUX
jzThdJ4zZgnquHboBPesOxumhUkG75L9vX1HiZCCQQDUQ59znBfjdC6iT1u06hsy
nJrtIaCn5YtAVfzOWNUOQJruLamSg0nky0zSy0EYn6SiftJnPbuJnX+pZTLqOgKp
HM+32Qy3Q71XCVXaePz9cUW3KFne+fUwCUa2ikSnjZGowCEHpKW4O85wfVBItSMa
IBl00iV2Y+dkI/54CnhJVrhsJeF1nTRlMe8/wUnKG7sDDovuczkSl6PF/Tr/9geX
srD6AujXKmtfwIjHxWWdfXm89yPZhvNJqstl57zagsr/kdQYxwlXCXmcHike8wmM
iUJ89FEFdX7VOXefxGa9jUIWEF28YJSnzwOXEL5w78kc5JS12OJv5xZvLkHJWn/7
4Tt4ch2CjIifE55LSfGlAdutXjrleqnCPfj0lVkGh+y0jtToE7x42WtdgtHvUEDp
9qV1q9ST5RzgyqUAtekPgJDmqc0xrdE1IGuzDQSYXuWnfaxekDI6hHcN+e/9f3sm
cABud9Rp8DTAUA6giT9lxe1uqyHN5YOM/0hpapqcci+4yjp9vJ0j5o5wpm8yzeCY
8/rsKIZOrx2sr6eNM1EXTcbuACx2GKVwNWk5cdcarx8tXzxaQJc=
=KlvC
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
