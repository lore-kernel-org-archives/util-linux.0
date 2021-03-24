Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A31C433C1
	for <util-linux@archiver.kernel.org>; Wed, 24 Mar 2021 19:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1495B619B6
	for <util-linux@archiver.kernel.org>; Wed, 24 Mar 2021 19:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhCXTiH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbhCXThr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 24 Mar 2021 15:37:47 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADE3C061763
        for <util-linux@vger.kernel.org>; Wed, 24 Mar 2021 12:37:46 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id x8so8225833ual.6
        for <util-linux@vger.kernel.org>; Wed, 24 Mar 2021 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=a+TuaT2IQyIb2iL1GEHo+vo5YINZgdTN+fw3jhgpZA8=;
        b=Caw+ip4bTSSxrXI5TohZHOd8ynzmhAiGpVNgJ9DaWutzdSEw7aSKvGbwoJtFcs59Ra
         g53qhpNJAdfdOkEMmgBQh0Z3lVIMl2fpuWXLBQi88W+3sqG76r9VT08ZqLI+4h/FYQc2
         JlNpx47tR8ib9No2NJ9AMJnfuB0hf4Cfn6n0JZ7oQypjKjkCXtS+wcKVeV5/+Ml5XBdO
         LFpyHe5EteR0BgUo/3PD49DTB1ZcK3aifrxgngxThsdTjvU5knPFZMejQ5/F24hEUdxm
         VKDohfmX0HRDu5Ut4o/jiOPq4AwJAbT+AJuj4lDVMQLUvZnOxU++MqEnA/uktLgQNvZF
         IX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=a+TuaT2IQyIb2iL1GEHo+vo5YINZgdTN+fw3jhgpZA8=;
        b=lZGQew+N6ZERPP2+B2/cMEcXsA5Qh/77kNndPoZL3RYbVEM1MWXkYLKl7zpaDsTC6O
         Ip6T368UOUQ2VsXLl1SOC7Ifoy/gxR9PtiRlDO0vzro/Pd6ybJrCf8JNvdullnnCNjTM
         rZx7Zxka0H8JxyCXVb8/87bselGm9o9i1MExWZiRt8+QSk7dqqcnKtMaoBsDHrEPYZvz
         m1yRbKK/PdxGWbXIQ5TyOkLGob33KhgM8uJZ1qB6Z+wax3IDCgDl9nWOMTxEvTvCChxM
         HXiUZ+BvIN5zUbUB0ER1gaLNmC8EyP5yuRt3ob/XG3hnPB36oQIfEzpZ7oL7ie4fms+p
         1Uvw==
X-Gm-Message-State: AOAM530Q7cbyI7IALmWwDbGYU3VLxQ9ZMFwGMVt2c1dDxpVM0BWtSomh
        kEXWYc+VNi3K1Jr2UGv4VKu32DL9Ohc6cmjZXiz774sV/2c1ZA==
X-Google-Smtp-Source: ABdhPJwP3gtjrf8GsubqpMrIZ1KaeE1GxCESlII6tZ/vMWA6w4WA6hdq8yNwylofBN0WCQ7AgcU6AJWUHXn7UzRZXks=
X-Received: by 2002:ab0:6f0e:: with SMTP id r14mr2876958uah.15.1616614665954;
 Wed, 24 Mar 2021 12:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <karelzak/util-linux/issues/1257@github.com> <karelzak/util-linux/issues/1257/792670506@github.com>
 <CAHi0vA-d7EQostbdDMZGmKeNfLYvjUWkuvF01nw-CM9wOkWMow@mail.gmail.com>
 <20210309084908.izmuxsrqujiml6ph@ws.net.home> <CAHi0vA-SAQYJraWb6ZH5bTWcoGdXMKnHj7fVARRzJN_LpPGc9A@mail.gmail.com>
 <CAHi0vA_Nk4GqS=gYCzwqqRoNPQLH2n9BtLozWgwaQ78MsBvVNg@mail.gmail.com>
 <20210323092705.uaa2oas3ux5s3er7@ws.net.home> <CAHi0vA_FL744Lap_GqkrhPPf_wK0BW2Ed_R2FVwQ+L_A4AJdHg@mail.gmail.com>
In-Reply-To: <CAHi0vA_FL744Lap_GqkrhPPf_wK0BW2Ed_R2FVwQ+L_A4AJdHg@mail.gmail.com>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Wed, 24 Mar 2021 20:37:35 +0100
Message-ID: <CAHi0vA-OcifUioLiUXSg9UmaMNUzfLhwg+tfm0hFnXYipOq0DQ@mail.gmail.com>
Subject: Re: Help needed with man page conversions to asciidoc?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel,

Am Di., 23. M=C3=A4rz 2021 um 21:07 Uhr schrieb Mario Bl=C3=A4ttermann
<mario.blaettermann@gmail.com>:
>
> [...]
> It works until it reaches the first man page link:
>
>   GEN      lib/terminal-colors.d.5
>  GEN      libuuid/man/uuid.3
>  GEN      libuuid/man/uuid_clear.3
>  GEN      libuuid/man/uuid_compare.3
>  GEN      libuuid/man/uuid_copy.3
>  GEN      libuuid/man/uuid_generate.3
>  GEN      libuuid/man/uuid_is_null.3
>  GEN      libuuid/man/uuid_parse.3
>  GEN      libuuid/man/uuid_time.3
>  GEN      libuuid/man/uuid_unparse.3
>  GEN      libuuid/man/uuid_generate_random.3
> asciidoctor: FAILED: input file ./libuuid/man/uuid_generate_random.3.adoc=
 is mis
> sing
>
> BTW, it also produces HTML versions of the man pages, which are not in
> .gitignore. Is it intended to also install HTML versions?
>
I found the problem, at least partially. A backslash was missing in
Makefile.am, and now "make gen-man" creates *roff man pages, as
expected. However, it stops here:

  GEN      sys-utils/swapoff.8
asciidoctor: FAILED: input file ./sys-utils/swapoff.8.adoc is missing
make: *** [Makefile:15942: sys-utils/swapoff.8] Fehler 1

But I'm wondering why it doesn't complain about the other symlinks in
libuuid etc, and it didn't stop until the sys-utils directory has been
reached.

Best Regards,
Mario
