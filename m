Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83558C433F5
	for <util-linux@archiver.kernel.org>; Mon,  7 Feb 2022 18:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiBGSpF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 7 Feb 2022 13:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiBGSmQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 7 Feb 2022 13:42:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DB3C0401DC
        for <util-linux@vger.kernel.org>; Mon,  7 Feb 2022 10:42:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y9so6130808pjf.1
        for <util-linux@vger.kernel.org>; Mon, 07 Feb 2022 10:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dHCX56J2GEQlyWMSsVoPTL8wwjzXfaFh0/bGnb1N1Tw=;
        b=Xjy3c1endhap6Q1I6Y6ntl5v2ALQn0ADJY410LULouLdWn59Nd1nGy8inPzVLh7voE
         Po4RpegdwRtFws/ZkGtUrRP7byRHLK4Z1hIIH8dBfJ0b2GQ8d6+MlhJe7uEgs7Urp7iT
         AVMgedJCKvl1PNZHGxI1VKXc5KUgKTOwTayYGEyBOzSECM31UY17q8oP4tza/QwfdUDx
         qL2Lr+DeaFPfMNM41PnSFMc/nlbtJG4BfG3ge5JsEnnO+mQsZmzsiGXTwRdG+nAKQHFQ
         PSg0ZGReeavR7/09X4zmg0IFVpJzrrGJMUi8j1nNPQ8AuekQ6of0uczVqhheOdO6Ww/m
         DYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=dHCX56J2GEQlyWMSsVoPTL8wwjzXfaFh0/bGnb1N1Tw=;
        b=e33jKt1Xut64EeDfa205mIXPQYD4K4APZYx+qGEJ+Qc8ZrQBmRv3dfw0kFiZ1HzopS
         W7co6sOvD5VKGuQDyPt+0VydFjUSWLH2EWOJr5gsGgB/GLzMaxoJZtvhrnHH6JCqMnT8
         3aMcdkt76XAJXjnkoguJ6Rqh0E9GCw3CecCOHWYEwDfh1YPZcLIPUZle8DiC1qZZ0I0O
         mPZZbIbq7/6GVRbBZ9p3y2gju+/BjfZ/H6k09phTy4ocFv6Y6I+Sppz6e8PtaY+Fikuc
         LdjOvJc1ZaeABqcFF3sGvKIeGQenkyAJBVMU1IGVf9pZnvXlYmKggt+GhauiSPjcUt2A
         jSiQ==
X-Gm-Message-State: AOAM531ZJGDkYj9bYBlMDCubYPkH7ODZCSve0UCwZz0n/gL5KTGVCbHQ
        P1CjZe0J+W1AiBB0vaZWWzm1tTB9SicymabL4UTkAdA6taE=
X-Google-Smtp-Source: ABdhPJzj6oy+EPqXsqqk8o6Tyj0EkBhjmtzKNwgVAcSxEv76cnpF1e90dnODxN7+kjnnnHcMFArhaaHjDY5g1GTW4T4=
X-Received: by 2002:a17:90b:1d0e:: with SMTP id on14mr279390pjb.59.1644259335770;
 Mon, 07 Feb 2022 10:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20220206061158.752262-1-aclopte@gmail.com> <20220206061158.752262-4-aclopte@gmail.com>
In-Reply-To: <20220206061158.752262-4-aclopte@gmail.com>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Mon, 7 Feb 2022 19:42:04 +0100
Message-ID: <CAHi0vA_O5A788BGtETDdDwCAbVCgXdzweZyhKjTVQ3P93xDNFQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] getopt.1.adoc: render synopsis rules on separate lines
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Johannes,

Am Mo., 7. Feb. 2022 um 16:45 Uhr schrieb Johannes Altmanninger
<aclopte@gmail.com>:
>
> AsciiDoc ignores single line breaks, so the synopsis of
>
>         *getopt* _variant1_
>         *getopt* _variant2_
>
> will render as one line in the manpage.
>
> Fix this by adding a blank line in between two rules, like we do
> elsewhere.  This means that the manpage also has blank lines.
>
>         *getopt* _variant1_
>
>         *getopt* _variant2_
>
> Alternative solution: we could avoid the blank lines like below,
> but that'd be inconsistent with our other manpages.
>
>         *getopt* _variant1_ +
>         *getopt* _variant2_ +
>

This would be possible, but we need in any case a solution which can
be parsed by Po4a to generate a translation template and write the
gettext messages properly to the translated man page. With the
appended plus sign, Po4a generates the following gettext message:

#. type: Plain text
#: ../misc-utils/getopt.1.adoc:19
#, no-wrap
msgid ""
"*getopt* _optstring_ _parameters_ +\n"
"*getopt* [options] [*--*] _optstring_ _parameters_ +\n"
"*getopt* [options] *-o*|*--options* _optstring_ [options] [*--*]
_parameters_\n"
msgstr ""

Even in case translators recognize the plus sign correctly, Po4a
writes it indeed back to the translated *.adoc file, but in a way that
Asciidoctor parses it as an arbitrary plus sign within the text =E2=80=93 a=
nd
concatenates the lines anyway, now with a few more plus signs =E2=80=A6

> or, equivalently, use the verse[*] directive
>
>         [verse]
>         *getopt* _variant1_
>         *getopt* _variant2_
>

This is IMHO the best solution. It looks good in the translation
template, and it renders properly in the translated man page. If I
find some time next days, I will create a global patch for all
affected man pages =E2=80=93 not only for the "SYNOPSIS" sections, this
"[verse]" thing seems to be also perfectly usable for multiline
"AUTHORS" sections.

Thanks for reviewing the man pages!

Best Regards,
Mario
