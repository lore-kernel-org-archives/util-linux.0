Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D019C433EF
	for <util-linux@archiver.kernel.org>; Thu,  7 Apr 2022 14:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbiDGOZU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 7 Apr 2022 10:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241283AbiDGOZT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 7 Apr 2022 10:25:19 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C794F187BB9
        for <util-linux@vger.kernel.org>; Thu,  7 Apr 2022 07:23:06 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id A3E0C8CC;
        Thu,  7 Apr 2022 16:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1649341364;
        bh=vhJp7HC9c8fm/bsbaC7ROg3qtgstcMfXDLqjNRKg4q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZK+OCOzpalTDcRuKN03SEWxVppJPI+FdDz48R5hWdHqZ+527SeXL+8V82IIW10jm8
         LzXWdQgKzoJxJgNUnlW9p6tzLnD7weJOeZVhOvJ3mNClybRRSxzWTw/xtUbGtfVHbG
         GgSCm7y0pdDmcOV/yG5RT6K2V7UGf6ZuqlhIpczhUgk0hGLPA3ogl/jeo2yKZ2Kz0V
         Enl072wStcgQM36pdu5d5/7ATwNekm4S8i9UoDl6RCYU9ZkL6Bp7uumQzxuKKywstS
         05x6vPivMxbvV8ilhieIafcaNjKd6Tl4cfn1WYl5nZ/1428Sw7Mofn0ohgSt2Ut9DC
         sE3EE5iJWjqoA==
Date:   Thu, 7 Apr 2022 16:22:43 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Karel Zak <kzak@redhat.com>
Cc:     1003095@bugs.debian.org, util-linux@vger.kernel.org
Subject: Re: Bug#1003095: /usr/bin/script: hangs when child doesn't read
 input fast enough
Message-ID: <20220407142243.w3ehp4drloliovhw@tarta.nabijaczleweli.xyz>
Mail-Followup-To: Karel Zak <kzak@redhat.com>, 1003095@bugs.debian.org,
        util-linux@vger.kernel.org
References: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
 <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
 <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
 <20220108145406.vkiuvl6iji4oypay@tarta.nabijaczleweli.xyz>
 <20220113232811.puu3pbtzjvzgys3o@tarta.nabijaczleweli.xyz>
 <20220202144938.eypexs65ujillsrg@tarta.nabijaczleweli.xyz>
 <20220203105540.kfyn625ioaxts354@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gfamf4y6s7hopf35"
Content-Disposition: inline
In-Reply-To: <20220203105540.kfyn625ioaxts354@ws.net.home>
User-Agent: NeoMutt/20211029-557-7a7327
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--gfamf4y6s7hopf35
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu, Feb 03, 2022 at 11:55:40AM +0100, Karel Zak wrote:
> Your solution seems elegant, but it seems to late for the next release
> v2.38 (now rc1). I'll play with it next week and prepare it for v2.39.

Bumping this now that 2.38 landed;
a quick test shows that it applies cleanly to HEAD
and works as-expected.

=D0=BD=D0=B0=D0=B1

--gfamf4y6s7hopf35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJO87MACgkQvP0LAY0m
WPG+nw/9FLKpQy3rAbii7vPMMBkRsSitTSA6mMi5YAGRGrPBH7hrLVGFfH2Bq6t8
WXhI2gL3SXaNIIuP6THUpYVSyd6mmF6GIGIgeN1SoGVSZYv/mUSdT8Mn2uS9kYYp
Nq38QuxWztMMhROgq6LOjSaq1w/HPeHSm5JXCOUTc2/N+YaWiC1eEMMrafZ7sH+h
nNCOH8vJHq8Gnz56jyarltcGvw8IOAa/OdWQEl6bvUDpxc6Is2hB5Fb8y6VTls0E
XQL0sf+HoixbSEp77FaOqeSji29UrRN+qKZNmMvcMObnoXS30z0Mv9gJ4X/K30r9
gPQZC/l0uk2RWryFRc4fXzDT2oCbPZMKmtssNbHpL9ZHNYwLe02yZDOfk8Db7rId
9F6ufWeS/mElokWi3sJOExcT1C1wWxUwlK/I3POfxWO9hqbIL9HhuD/oWv10o3Oa
sMhTiHv4TbFFO57Lc+0AGcR/WJ/S4Vss84ZHdVKAHUQpWuFV/N9UiAeCSflcwDFu
6RPeVUKG824S/6UGyv11c5cL/DDeA37xPW9fcJdsZqktwR9b55iC3DPrODHyxRIw
RrsJu8uvUdIuFV6V/18HvAkqOB3YK17VOCBltyjs3i7/MfHP2iByc71S//xuZE8m
RS5BBA1RhmAmySoRTR/1dD3cY7jCuja1M26jaLEm2R+fbPbVLbk=
=EnvF
-----END PGP SIGNATURE-----

--gfamf4y6s7hopf35--
