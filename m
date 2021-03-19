Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DD6C433C1
	for <util-linux@archiver.kernel.org>; Fri, 19 Mar 2021 22:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7AE961974
	for <util-linux@archiver.kernel.org>; Fri, 19 Mar 2021 22:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCSWvP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSWux (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 19 Mar 2021 18:50:53 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78D7C061760
        for <util-linux@vger.kernel.org>; Fri, 19 Mar 2021 15:50:41 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id a15so4336170vsi.0
        for <util-linux@vger.kernel.org>; Fri, 19 Mar 2021 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2DFyCCQguxgwHXdVQUoAV7aiuDVJ3llHy5jzYhZn8zc=;
        b=tXNWGY3+4cWHvCA2utWFjHAYfOC6cCaGeFtISksC+zrEPQmFUXuycsxR4DsG9lv2Sg
         2+lzC9x4NocgVVUEKiJVJ8vg710PtWS9HuljA3sbxUqKt/Gv6Xo1wi/9b7XQf1d6kkKb
         U7gONFmBcZe5JukIFSG1q4s42aZCIRw3dQsxKAH6X4TCx/UIWC9DldS0ssgvLsp+fxFC
         GNZNH1xDgmU4SQipnk6NWxEPGsPovL3nS8AbZfVm+2fGiFJ2c5FxZaTJtvytEEziuOAX
         LEvc12gLdGTgm9TfPc32siAHy1CU+0bxKVcv40C1++QrQ7ufYxZqz/+F8Kxk/n4R9Gw7
         7aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2DFyCCQguxgwHXdVQUoAV7aiuDVJ3llHy5jzYhZn8zc=;
        b=UywkQC1f+x5iVaTLRdoKZZt8n32xX3qyENOBr19u0Y53LufGn4BTmyOU1uWXt306AO
         0bJc8y5+pIij/HvB2maxCuxwkPy5TVCSyJ6nmzC/fDh3J9QyAX5l53I3syhFzoTIjYrT
         FtJhVWwOwqhhvg+JXD+r8Ri0apsyWkQcSlwmxD7KtkvI/Wyz8W/KBbwRl+vRc/mTGTQ0
         EzMJdsN8VuVyFY3J/beWnahF+SvwnVWqLtP/9ts8GbNhouNq+XcXlcLi5nTfYezqkQk6
         IR7ia0bkLW/kfOFIByjCuJiZHInkfYE+F1jqGKdcKt7rgBIeiSJi/mjWWJ1hvnlQeeuc
         gkSg==
X-Gm-Message-State: AOAM5303WqFXn4Gr2RVwWIBp/lUcCpMbj5K4s0PATwnOJJlIizgfwsqF
        b9T/GKw/QOerWShBifmIsOnXa8YIqxG2Gpqp0Ab6IJCzgbBdVA==
X-Google-Smtp-Source: ABdhPJzSBoLduoKGHDf+RN+q3zR+QmlfvBakG4HTGgoxoYbm8v3BiGIZ/0SMxI7dv58kcZiPWVcrJXIoEbGEnuptN4s=
X-Received: by 2002:a05:6102:74a:: with SMTP id v10mr4369397vsg.20.1616194240765;
 Fri, 19 Mar 2021 15:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <karelzak/util-linux/issues/1257@github.com> <karelzak/util-linux/issues/1257/792670506@github.com>
 <CAHi0vA-d7EQostbdDMZGmKeNfLYvjUWkuvF01nw-CM9wOkWMow@mail.gmail.com> <20210309084908.izmuxsrqujiml6ph@ws.net.home>
In-Reply-To: <20210309084908.izmuxsrqujiml6ph@ws.net.home>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Fri, 19 Mar 2021 23:50:29 +0100
Message-ID: <CAHi0vA-SAQYJraWb6ZH5bTWcoGdXMKnHj7fVARRzJN_LpPGc9A@mail.gmail.com>
Subject: Re: Help needed with man page conversions to asciidoc?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

Am Di., 9. M=C3=A4rz 2021 um 09:49 Uhr schrieb Karel Zak <kzak@redhat.com>:
>
> On Mon, Mar 08, 2021 at 09:10:34PM +0100, Mario Bl=C3=A4ttermann wrote:
> > >
> > > I like the idea with translated man pages maintained in the
> > > upstream tree, keep it all in one place is the only way how to
> > > keep it up to date. If I good understand then the result will be
> > > another template on translationproject.org to maintain man pages
> > > strings in po, right? What about in-tree .po files? I guess it
> > > should be separate from normal po files, po-docs/ directory?
> > >
> > Yes, it needs a separate .po file. It's not OK to mix UI and doc
> > translations. Well, it's theoretically possible to merge both .pot
> > files in one to force translators to work on both UI and man pages.
> > But I think the UI .pot file with more than 4000 gettext messages is
> > big enough, especially for newbies. So don't let's blow it up to more
> > than 10000.
>
>  I agree.
>
> > I propose the following structure:
> >
> > The asciidoc man pages will be stored where the *roff man pages reside
> > for ages: in their respective subdirectories (sys-utils, schedutils,
> > whatever). For the special asciidoc files footer.adoc,
> > translation.adoc and asciidoc.conf we need an extra directory, let's
> > name it "man-common".
>
>  OK.
>
> > For the man page translations, we can also use man-common. It's a good
> > place for files like po4a.conf or the TP sync script (if desired), and
> > the subdirectory "po".
>
>  OK. For scripts, see also tools/ directory where we have some
>  checkers, simple script to commit po/ changes to git (git-tp-sync)
>  etc.
>
> ...
> > > Is there any possibility to use some "style" template for
> > > conversion to the man pages (for example the same header/footer
> > > for all pages, generic sections like AVAILABILITY, etc.)?
> > >
> > Yes, see the attached tarball for an example footer.adoc. I could
> > extend it with a "Reporting bugs" section.
>
>  I see, it looks pretty cool and readable.
>
> > > Don't worry about Autotools, I'll do this task. All I need is some
> > > command-line examples of how to do the conversion.
> >
> > Oh, very nice... Although I also use Autotools in manpages-l10n (but
> > haven't written all the Makefile* and related stuff), my knowledge is
> > poor, and I'm happy after each release without problems;)
> >
> > Karel, I've already forked the util-linux project at Github; maybe it
> > is useful to create a branch for the Asciidoc stuff in your main repo,
> > which I can check out into the forked repo? This would be probably the
> > most painless way for a merge request.
>
>  OK, I have created a new branch "topic/asciidoc" on github.
>

Just FYI: I'm finished with the import, but I stumbled upon some
peculiarity in Asciidoc. Many of the current util-linux man pages use
"mailto:" links as follows:

.MT johndoe@example.com
John Doe
.ME

This leads to properly clickable links in the online man page
collections of certain Linux distributions, such as Archlinux [1] or
Debian [2]. But the *roff conversion engine of Asciidoctor produces a
slightly different code:

.MTO "johndoe\(atexample.com" "John Doe" ""

Which renders to ...

John Doe <johndoe@example.com>

... in the HTML output generated by man2html which is used by the
mentioned online collections. The link is not clickable. Because I
consider the online collections as the second most important way to
view man pages, a non-clickable "mailto:" link would be a step back,
which I don't want. I've posted this issue in the Asciidoctor forum
[3]. Maybe it is possible to create the desired custom code using a
macro... I hope so. Or the Asciidoctor developers change it upstream -
which would be the better solution.

BTW, the same applies to weblinks, but first let's find out how to get
proper mail links.

[1] https://man.archlinux.org/
[2] https://manpages.debian.org/
[3] https://discuss.asciidoctor.org/How-to-change-rendering-of-links-in-man=
-pages-tt8575.html

Best Regards,
Mario
