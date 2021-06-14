Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEDEC2B9F4
	for <util-linux@archiver.kernel.org>; Mon, 14 Jun 2021 21:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B5A611C0
	for <util-linux@archiver.kernel.org>; Mon, 14 Jun 2021 21:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhFNVGj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:06:39 -0400
Received: from wforward2-smtp.messagingengine.com ([64.147.123.31]:54513 "EHLO
        wforward2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhFNVGj (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Jun 2021 17:06:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailforward.west.internal (Postfix) with ESMTP id BAF50F96
        for <util-linux@vger.kernel.org>; Mon, 14 Jun 2021 17:04:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 14 Jun 2021 17:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=EvxBHr
        ouymSup32ANsXFlpgGXFQEx1Gh4i6HW6vjmno=; b=JeWR7oZ0/SV0cqIHndtJVh
        QyfM7Ll97gqan02ujL7rvKUrYHgAxhPsJQZ4SyCi5NE8C5lFlKhBsif4F1GcjqXI
        scFkAKRQ1yfPjayd41bMtRtMLz1IQF3QxNyfpVwKQH7PWI36/iQds0rguPo7wtyC
        eOjTjjH7y2s0t5wYaufOCik4YqYobZJe9eb9Z6bU8g/ZBI+VyfdfXUFCKe9pbVGB
        R7i4pjJj9fW1rlKpGwpykI7o13XjD+aM19ArGldRGrmN+QiVSVIh43Se3knmUrsQ
        u0ZWDN/XYM0fpO6eDLcfm6Jso8gU+fMCAtR4rfVkR0TBndKij1Ui7Mha1ORMHuTQ
        ==
X-ME-Sender: <xms:Y8THYLXoEIx1tXkKA1gcV_3mrDdaQliBctRzD_qWbkKL2DpwBAGLZg>
    <xme:Y8THYDnPF5m9-LP_bwKmsDuxMT9-MTpaphgF1BglDo5EseW2jiX5SQ7kHyRR5E_Zl
    Wj4ReE9hCrmI7UnfA>
X-ME-Received: <xmr:Y8THYHbJPAH17ZUpanFc7HS-iwkgN1oa23jtwaT8B4cVZIwk6TvK4sskvcUd5bscaTQa-rC6xevhqKa2n5KqTseCC0RKhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvhedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    dtredttddvnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdr
    ihhsqeenucggtffrrghtthgvrhhnpeeuffegffdtvdffiedttefggfehtdfgudfhfffgte
    efgfdugeegveffieffudduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehqhihlihhsshesvghvvgdrqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:Y8THYGU3jXUVXI_ipDVzn_xbqW5BsUcN04yJoiZTTDZQpl8DzuV8PA>
    <xmx:Y8THYFkYRdB-7AdI8QrlzoNtcMgg3BubytfimmI2QJU3JaRIx1ikCA>
    <xmx:Y8THYDfwPeK0bonxQJdRHvYyaFP9-UEhp7hkowkrZ1f7e1nVcfXjXw>
    <xmx:Y8THYDRQx0_air-vmyvJYMP1cp3nSfGniy-2mbEPEEc-YCkZ-sN9B70rakI>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <util-linux@vger.kernel.org>; Mon, 14 Jun 2021 17:04:35 -0400 (EDT)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id CB8D4EF0; Mon, 14 Jun 2021 21:04:33 +0000 (UTC)
Date:   Mon, 14 Jun 2021 21:04:33 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: match uppercase UUIDs
Message-ID: <20210614210433.p62vxkx3cm7ynwbk@eve.qyliss.net>
References: <20210614204017.49499-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qwdfjr5ziegmrstt"
Content-Disposition: inline
In-Reply-To: <20210614204017.49499-1-hi@alyssa.is>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--qwdfjr5ziegmrstt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 14, 2021 at 08:40:17PM +0000, Alyssa Ross wrote:
> In a script, I wanted to look up the device node for the booted EFI
> partition.  systemd-boot exposes this in an EFI variable but it's
> uppercase, so when I tried to do this, it didn't work:
>
>     findfs "(< /sys/firmware/efi/vars/LoaderDevicePartUUID-4a67b082-0a4c-41cf-b6c7-440)"

Bogus command here, sorry.  It should have been:

    findfs PARTUUID="$(cat /sys/firmware/efi/vars/LoaderDevicePartUUID-4a67b082-0a4c-41cf-b6c7-440b29bb8c4f/data)"

But my point stands. :)

> This was very confusing to me, and I lost some time trying to figure
> out what was wrong before I realised that case of UUIDs was
> significant to findfs.
>
> Here, I've made comparisons of UUID and PARTUUID case-insensitive in
> libblkid, which fixes the command above.
>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

--qwdfjr5ziegmrstt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmDHxF4ACgkQ+dvtSFmy
ccAmqw//bwlZHric1QebteQZ9/7jjqT5sTsuHPy3T2E0H5TrjogwmCeFUvahN5M8
T+lfibGiDk0xuaWjGf/cgH1XAjMXvtlf/CaqPBogFNHKXPPZKFxz1F3RykKpfcCu
r40jaQa24NVH2kgXHjWWJ5obc41bEo7QgE88x35rzKZKtwGFnH1zzui46HXbkgkS
QZpMIeY2qNqQVZtpyV69SfMa5YPOKFkru9XWYxK/LXk3njYRvhLl3vCEEAnORcf1
m4EzhQlBV8lkQcZ+yo2Q9AOJc4BQATPWoia85biSfYm2hEMVbGGX2e1nNdIUXavI
jXnh1b3Wh9SC3kcWhCFg7ihe3Hfp94NRXFveda8ts6qr0nu9PtsngOmRFkvzvfGC
UvosnbTsycY1urwZgkuFVTEKOXhSZdSqOysednGHggybcZgca89RPuQq1kMSk3yA
7efwUCO9pMoE7+X5BwW8HbvbEfJrgF/KbdIAxets40rikhVN5POOm7ueSU+2hLSe
/tyDtlF7hjAecaPmbrLlv4dWkVCeKnTXtXYoD2bQY1X2zd2lhipk6wvYjXEgihfV
J/o0o1h3GtrKP4kNF5bR9yBGVYGOfyjyXncrZ+EEWfK/7FAnoo1lJKdcXr4+LCq9
ZvL/El1n0AQATr0DRE9UXIpU1XWNRGjHtqJSNOjppewG+AawoLs=
=oxwu
-----END PGP SIGNATURE-----

--qwdfjr5ziegmrstt--
