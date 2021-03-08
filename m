Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D9C433E0
	for <util-linux@archiver.kernel.org>; Mon,  8 Mar 2021 20:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D19365272
	for <util-linux@archiver.kernel.org>; Mon,  8 Mar 2021 20:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhCHULE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhCHUKr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 8 Mar 2021 15:10:47 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB20C06174A
        for <util-linux@vger.kernel.org>; Mon,  8 Mar 2021 12:10:46 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id s8so5542011vsc.8
        for <util-linux@vger.kernel.org>; Mon, 08 Mar 2021 12:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4W8Xb8HNa4cX63noP6QDa2q5gZyQO+rMhL49jeKH7QI=;
        b=TYjMDiLmMoy4cK0fR17JWGp+gPnPVju46UolFyn4p5hGxxe4T/zu3NW3BLB1e6us/V
         4Gx6vFMAevnn0/SPia/sbttSckJfOQRU+EFjY9iYcO/pewpyuFvY4sz0sdvJlobtgiYa
         GWb0M6e1EH6c2646zFv+IC8Jmd4k1ZFzVR9bEcRp0voucc/abv2Bya3z3zSV9LwRBRFc
         E64EYD8OjQVzWYn6j9bh8qA8AdrMhGoUYTN9KxzJKqF5+09Lc4EJ7ESpJLDUU384eS77
         NUU4AYVbzv9RjCTumzocu4n2SFw24tJkVdlZCU+ETHeaFZlWy7xK+JP20JXU7H88HJwT
         hKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4W8Xb8HNa4cX63noP6QDa2q5gZyQO+rMhL49jeKH7QI=;
        b=mMVweELml30OL1ECuheH1Ee+mUDPgEF/ulhjo9p0i3x2zmyIi1OKjpW2ipbZTBw6CC
         RWBKAQ4KscGYMdvwvprEBmsBIeUb0r8eQRwIR8DfsXpcw9hyPcQ7584iKtfKHO/JYbPt
         1bt1l796pTccSMvhyDyXNQ13TciqHN0pQmXAx5v8X1x37M8c5g+5UpEb4qfvtwHLrMHP
         WTxlb3aNvlG4jxT0rgcHpI5JmpQCxQppgbPTFnXp0lcr1C/d4dcivpOvCqFEEYyJaXzr
         ddGZBE7/LGbOBZNTlm8BJGhzJgxPTGw4cSlJa7LRgft9QsDN3jXsKUD15aRd/n8ssqgq
         RXGA==
X-Gm-Message-State: AOAM531jW8jVtucY2owfGud7++Z+mBhue/ZlbbAwJdU+5T6PUBjqoAZE
        aB3KK4aL2YFxtqdSOrJjwLVRwuvRj9+SiDdKqG06hyLRB+++IA==
X-Google-Smtp-Source: ABdhPJygml8RUcOUFWMQeffsF2b+EPgZycRi7VYfwOkQ6spayByGugbDTETzb7ryNJHcCtTJk8pMv43NaQgTHYf02JU=
X-Received: by 2002:a67:eed4:: with SMTP id o20mr4032163vsp.25.1615234245935;
 Mon, 08 Mar 2021 12:10:45 -0800 (PST)
MIME-Version: 1.0
References: <karelzak/util-linux/issues/1257@github.com> <karelzak/util-linux/issues/1257/792670506@github.com>
In-Reply-To: <karelzak/util-linux/issues/1257/792670506@github.com>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Mon, 8 Mar 2021 21:10:34 +0100
Message-ID: <CAHi0vA-d7EQostbdDMZGmKeNfLYvjUWkuvF01nw-CM9wOkWMow@mail.gmail.com>
Subject: Re: Help needed with man page conversions to asciidoc?
To:     util-linux@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007559ad05bd0c073d"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

--0000000000007559ad05bd0c073d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Karel,

Am Mo., 8. M=C3=A4rz 2021 um 11:53 Uhr schrieb Karel Zak <notifications@git=
hub.com>:
>
> Oh, it's like reading a dream -- sure, go ahead :-)
>
OK. Sometimes dreams become true ;) I know about the peculiarities of
the ~50 years old *roff formats, and I'm happy to help a project to
get rid of this odd stuff...

> It would be probably good to move this discussion to util-linux@vger.kern=
el.org upstream mailing list to make it possible to others to contribute wi=
th ideas and objections.
>
> I like the idea with translated man pages maintained in the upstream tree=
, keep it all in one place is the only way how to keep it up to date. If I =
good understand then the result will be another template on translationproj=
ect.org to maintain man pages strings in po, right? What about in-tree .po =
files? I guess it should be separate from normal po files, po-docs/ directo=
ry?
>
Yes, it needs a separate .po file. It's not OK to mix UI and doc
translations. Well, it's theoretically possible to merge both .pot
files in one to force translators to work on both UI and man pages.
But I think the UI .pot file with more than 4000 gettext messages is
big enough, especially for newbies. So don't let's blow it up to more
than 10000.

I propose the following structure:

The asciidoc man pages will be stored where the *roff man pages reside
for ages: in their respective subdirectories (sys-utils, schedutils,
whatever). For the special asciidoc files footer.adoc,
translation.adoc and asciidoc.conf we need an extra directory, let's
name it "man-common".

For the man page translations, we can also use man-common. It's a good
place for files like po4a.conf or the TP sync script (if desired), and
the subdirectory "po".

> For now (as the first step) for me more important is ASCII to man pages c=
onversion with some usable result. The translations should be the next logi=
cal step.
Yes, although I'm sure I need to always have a look at the
localizabililty while converting the man pages. Once all is OK, I need
some more time anyway to import existing .po files and provide some
help to the TP folks. As far as I can see, we have translations of
util-linux man pages in German, French, Spanish and Polish in
manpages-l10n. Some other teams, like Japanese, or even the abandoned
Hungarian and Turkish projects, also have such files. Sadly there are
no Czech translations known to me :(

> Is there any possibility to use some "style" template for conversion to t=
he man pages (for example the same header/footer for all pages, generic sec=
tions like AVAILABILITY, etc.)?
>
Yes, see the attached tarball for an example footer.adoc. I could
extend it with a "Reporting bugs" section.

> Don't worry about Autotools, I'll do this task. All I need is some comman=
d-line examples of how to do the conversion.

Oh, very nice... Although I also use Autotools in manpages-l10n (but
haven't written all the Makefile* and related stuff), my knowledge is
poor, and I'm happy after each release without problems;)

Karel, I've already forked the util-linux project at Github; maybe it
is useful to create a branch for the Asciidoc stuff in your main repo,
which I can check out into the forked repo? This would be probably the
most painless way for a merge request.

Best Regards,
Mario

--0000000000007559ad05bd0c073d
Content-Type: application/x-xz; name="chrt-adoc-test.tar.xz"
Content-Disposition: attachment; filename="chrt-adoc-test.tar.xz"
Content-Transfer-Encoding: base64
Content-ID: <f_km10ffht0>
X-Attachment-Id: f_km10ffht0

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
EYBEAAAm6AMdscRn+wIAAAAABFla
--0000000000007559ad05bd0c073d--
