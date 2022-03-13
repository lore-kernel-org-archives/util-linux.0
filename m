Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BFFC433F5
	for <util-linux@archiver.kernel.org>; Sun, 13 Mar 2022 11:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiCMLgR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 13 Mar 2022 07:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiCMLgQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2022 07:36:16 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E303DA5C
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2022 04:35:09 -0700 (PDT)
X-KPN-MessageId: 9923cec1-a2c1-11ec-a7c6-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 9923cec1-a2c1-11ec-a7c6-005056992ed3;
        Sun, 13 Mar 2022 12:34:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telfort.nl; s=telfort01;
        h=content-type:to:from:subject:mime-version:date:message-id;
        bh=ReYB+Krtrg727jhFexNp3QbmSPNUx3kP8WYdGVMqa5g=;
        b=xAQgnRydNYhskqMEMRoqp1Be/kezC7Rvko3hyU+32YOZXAaCrNyfwRz68bEqjQ/MiWL2/1mDMct9+
         687tG1NkHu4ivZdgoK+viNssZHXCFIk6J/zn2YCkidpspbzrAH05YD65fcvxu8/24pKpAbbvD2XnMQ
         R9CI4xxCjPJCo+hE=
X-KPN-MID: 33|XdSTmr/UQuOvRSkyTRDih6HNzQcqInTRYOMd3JytlHlQAZILnF0nQTDQdo8lO18
 Ri2OoEeD/EAdfcFoU9jpm6MHmG9K06u1cJ2sH3Sl/LJY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|RvIIbt+GBB3LtPcMAKxm0cp1VS9ztxD0MHFv6KDTiwsotoZkxKI5y9LSVOmKafA
 WBCS0nkDHHnaupqKdHsL5rw==
X-Originating-IP: 82.168.50.91
Received: from [192.168.2.25] (82-168-50-91.fixed.kpn.net [82.168.50.91])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id a1c65a5a-a2c1-11ec-b2a4-005056998788;
        Sun, 13 Mar 2022 12:35:07 +0100 (CET)
Message-ID: <e9a4d530-d5bb-214c-ecf8-134a89b8e428@telfort.nl>
Date:   Sun, 13 Mar 2022 12:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: the localized output of 'hardlink' is misaligned for some
 languages
Content-Language: en-US
From:   Benno Schulenberg <bensberg@telfort.nl>
To:     util-linux@vger.kernel.org
References: <ece4e3d9-7cf7-2319-ec69-de978ab7081e@telfort.nl>
In-Reply-To: <ece4e3d9-7cf7-2319-ec69-de978ab7081e@telfort.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------h4nYUzCbEDtuUb4X8UmMZZC0"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------h4nYUzCbEDtuUb4X8UmMZZC0
Content-Type: multipart/mixed; boundary="------------i0tdoYDrmQjzOqyn1ozWRety";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Message-ID: <e9a4d530-d5bb-214c-ecf8-134a89b8e428@telfort.nl>
Subject: Re: the localized output of 'hardlink' is misaligned for some
 languages
References: <ece4e3d9-7cf7-2319-ec69-de978ab7081e@telfort.nl>
In-Reply-To: <ece4e3d9-7cf7-2319-ec69-de978ab7081e@telfort.nl>

--------------i0tdoYDrmQjzOqyn1ozWRety
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Op 13-03-2022 om 12:24 schreef Benno Schulenberg:
> Oszcz=C4=99dzono:             9,52 MiB
> Trwa=C5=82o:                  0.154945 seconds

Oh, by the way, see that dot in the number of seconds is not localized
to a comma (for a completely Dutch locale) but the one in the number of
bytes is.

Benno

--------------i0tdoYDrmQjzOqyn1ozWRety--

--------------h4nYUzCbEDtuUb4X8UmMZZC0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEv9AJBh5TUFKtDfIVDSjU0qCs6IQFAmIt1uoFAwAAAAAACgkQDSjU0qCs6IQN
lxAApeNkhcCTZnNJl4dKqFCk29mlV9Uq9NJg31lPaDxodLD2mW6yJhPhKKWOfhVr9iHcxh8bqxUk
uvj3Tmjzs1eTizGQFt53qyoxEe0GZQveagm/HPQlPftbIiHq+p4D2jgn1mXx+SOz6n56aSDmHOJi
Kv72r0cWE3xRVkpG+q5CofYOma0wCJq8/FQepqFfhNq7xi/eRH/gBZjSLGQkB5MPgM8J+5BNoLby
zaJ2dh/mOxxVhHGUYQUUezSNUVDJoCn562WdMZRyefb+EaVsh7+CYEwgtyd/14zipk5FomBBGF4p
fxGrT0Axrn1L1ySiqJS+0WFnfQM9DmMmmWbMROK9IBPll1PW+SjEuutRD3iZmNtPISKRnUiA9IeO
uoG8PGc0qKAJ7J9cXpajsI1EUmR0mB7aP/dyN1beBkhaWdTdWh3KqPE392nEOvXHyQAGlctqY3os
Xn9Baz0V5u83d9RikR7UrE9FknmIrNulOpBtTUOBq1ABrKEsKmhSryzqqOdG/blmvaVFXPgAqaPz
EspofUTgYVJSPeESrt/Ex6Zig/3EzLk00nJpaQOT5UR9zNtsHFu5FHxYK8fS28IbvABFL5VLH7rI
T0LZeYs7/odMa95ASRZzwr+V2muXh0k04CIUHd3j3/TsAeJ0S2GjTyz/KCakck4K1d9IuckldC9O
CXg=
=WKjt
-----END PGP SIGNATURE-----

--------------h4nYUzCbEDtuUb4X8UmMZZC0--
