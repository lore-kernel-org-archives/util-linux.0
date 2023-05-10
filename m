Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE0EC7EE22
	for <util-linux@archiver.kernel.org>; Wed, 10 May 2023 18:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbjEJSnC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 May 2023 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJSnC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 May 2023 14:43:02 -0400
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 11:43:00 PDT
Received: from tuna.sandelman.ca (tuna.sandelman.ca [IPv6:2607:f0b0:f:3:216:3eff:fe7c:d1f3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939C1114
        for <util-linux@vger.kernel.org>; Wed, 10 May 2023 11:43:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by tuna.sandelman.ca (Postfix) with ESMTP id D8C4F3898E;
        Wed, 10 May 2023 14:52:31 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id izgPzHSsubOJ; Wed, 10 May 2023 14:52:31 -0400 (EDT)
Received: from sandelman.ca (unknown [IPv6:2607:f0b0:f:2:40a:34ff:fe10:f571])
        by tuna.sandelman.ca (Postfix) with ESMTP id 0EEFC3898D;
        Wed, 10 May 2023 14:52:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
        s=mail; t=1683744751;
        bh=XeNaWW3VGLqqC3NIauL/Oz2S8i0lRKWklggKO4ohIpk=;
        h=From:to:Subject:In-Reply-To:References:Date:From;
        b=Gcc8s59wL+05Se9yx0I66c1KvvyjKO87a/iqOfwbCRUncjOhpm8lkxEfa772ptjVt
         11YiLXjJP5r5Btf97yrtyiPucpCUczK20ae8XsvF5mroGpbErPbWENuIpCt1UBPNse
         6R/eRx1CP5DXeKzqGoGbF0bzr3cfAjc//hz6edy3A1n4y7arTRqlGzoMBDbr5GegqJ
         jb0lFGwtJWbPT9Yh7tp/y5L8mdeelWhddSDcy7t2dPVrz/R428tU4vahS5Cq2QhwqV
         a3GQy3YcYIfqUNHI3KJLvy8sBP8Fu7rt50O0JCAxxd/zjWWva4r12dfYvEk02A9SQE
         NDMEh0rTVefUg==
Received: from localhost (localhost [IPv6:::1])
        by sandelman.ca (Postfix) with ESMTP id BFE2BEF;
        Wed, 10 May 2023 14:33:43 -0400 (EDT)
From:   Michael Richardson <mcr@sandelman.ca>
to:     "Theodore Ts'o" <tytso@mit.edu>,
        Chris Hofstaedtler <zeha@debian.org>,
        util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: uuid and RFC4122
In-Reply-To: <23699.1676924882@localhost>
References: <14266.1676658860@localhost> <20230219170116.q453di5cmknxn665@zeha.at> <Y/LPN7pf6x75Xm9H@mit.edu> <23699.1676924882@localhost>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 27.1
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Date:   Wed, 10 May 2023 14:33:43 -0400
Message-ID: <5866.1683743623@localhost>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

--=-=-=
Content-Type: text/plain


Hello again!

Michael Richardson <mcr@sandelman.ca> wrote:
    > Hi, thanks for your work on debian packages.  I'm contacting you
    > wearing my IETF uuidrev WG co-chair on.

    > The https://datatracker.ietf.org/wg/uuidrev/documents/ WG was chartered
    > to update RFC4122 last summer, and we expect to start a WGLC on
    > RFC4122bis in the next few weeks.  This is just a heads up for now.

We have started the WGLC today.
It goes until June 9th.  The document is still open for comments,
particularly of an editorial nature.
Did something confuse you? our fault, let us know.

We included a way to do SHA-2 based uuids into the v8 namespace based uuids,
which we think is future proof, and won't burn version numbers the way that
MD5 and SHA1 derived uuids did.

You may find this diff to be useful:

https://author-tools.ietf.org/iddiff?url1=draft-ietf-uuidrev-rfc4122bis-01&url2=draft-ietf-uuidrev-rfc4122bis-03&difftype=--html

Your comments to uuidrev@ietf.org, or to https://github.com/ietf-wg-uuidrev/rfc4122bis/issues
(or even send a PR)





--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCgAvFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmRb44cRHG1jckBzYW5k
ZWxtYW4uY2EACgkQgItw+93Q3WXlYgf7B7HxcYWe46EmfPq1GwUTHaHngHnq7nj/
TeTxUjKbgGZnKzrxyXyKNVmD4UcrVvEQAWwFg/nkI4aLChcIgxRqLlB2eoOO38Li
HXyRMJ7TtXmVNKObuIfSI0neo/4G8rPNP4aua4qtz8MInYbCmTT7gfI9xIObx2/h
F9ljf17RjXUUiQo42vdazfFHfvUUtG18CpY6YT/7jSfw2eML1MImiKaZpmvHAqrD
ksqWd6w4pgQO3evbd4tSUb15wzLpLieP1WTas9xNX0TD6cNCxxalQRllsbtpZ12R
HRo1SmFeHDCDv+Ccl4Nqd1efwhHmaZ5CCKC5eOjios8fkVADZE3Oig==
=00iD
-----END PGP SIGNATURE-----
--=-=-=--
