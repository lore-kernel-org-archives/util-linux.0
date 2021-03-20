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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61115C433C1
	for <util-linux@archiver.kernel.org>; Sat, 20 Mar 2021 17:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240296192D
	for <util-linux@archiver.kernel.org>; Sat, 20 Mar 2021 17:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCTRqt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 20 Mar 2021 13:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTRqh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 20 Mar 2021 13:46:37 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EF2C061574
        for <util-linux@vger.kernel.org>; Sat, 20 Mar 2021 10:46:36 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id l13so5267714vst.8
        for <util-linux@vger.kernel.org>; Sat, 20 Mar 2021 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Q4ngqPN+iDiOOpXbn40B+6ZtZKoJbo5Zd8xLUvkeW+c=;
        b=vAATfrxkWm1shNdQw1xTGTIhzA9UQ7SYojijhb7ajQ+Zo+m4UyrJmFegW4c0L5gqFK
         wezkMwY6jxeYa2F/RRzlWriONBHtK7li+tQAzFsqJ2RzgtVT2+mD2+N5GEJchU8776PZ
         nwCW+tNDqZik4TwIueHGhwOshMFR8FgGzpQg2cTZMn/e38jF54xAb2C2ztb62Ph+/LtZ
         Hm2pLNVon7C+yEqmyUOxj1m8To05zEOwfBjmehkY4+C9P1OVHJea0FqogIOIng0ehA6h
         ESmKipcRlCS2c0wUGp8NfYmYGeZmkP2nArk1laK7MHWCq3DLAt+eHQrH3b1ZwKcRe3Em
         59Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Q4ngqPN+iDiOOpXbn40B+6ZtZKoJbo5Zd8xLUvkeW+c=;
        b=ADBmHfSkAwX4G5sxmfaGtN5GNYwZViprpyG6WQolAMJ5ZIeSqjGdp5+RhJXcBOJU8k
         U2oiMc642Ym4EsfD7dXm1NKOizBU7SjEbIgZqKu2wZxUfXn7xN55KFMJhx4iKG3hr7UH
         Qzcs+bObI8dCx3lmng4KJy4uf0qQ2TN8KAzhHWzGwpoJMvuhZgMAba1RaKM5ukQRcwOy
         ewSOxYIOXAmclj9wAcl6Hq6xPcHTUUWzVf3oenFI4P8x4DN+MBm1oUcMWZkxwSkY7g8I
         gPX6Jahji5r1jn+y2TWD8xmDjJesipxBuk7gblnug1Q5IRNZLC5QIwwpysz+UcYUfqG2
         q6qQ==
X-Gm-Message-State: AOAM532vSE0sBEhxUOJ2ksdATabe+zZSKT19J+rIDQKfneCI/WpHEpB3
        1Av4lVcGKiLcQO6NCx1T8t7gJu/meIZvNjO46Hlf+YowjUmNFw==
X-Google-Smtp-Source: ABdhPJyDD6lD6FLMuLMp6ZgsUU+OSJA5f77YLpSINO/I0NVU1HAAQHYog8aKhZN9Q7aM+kvqh/BkSrsG2o8Un5wuclo=
X-Received: by 2002:a67:bc11:: with SMTP id t17mr5576766vsn.51.1616262395365;
 Sat, 20 Mar 2021 10:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <karelzak/util-linux/issues/1257@github.com> <karelzak/util-linux/issues/1257/792670506@github.com>
 <CAHi0vA-d7EQostbdDMZGmKeNfLYvjUWkuvF01nw-CM9wOkWMow@mail.gmail.com>
 <20210309084908.izmuxsrqujiml6ph@ws.net.home> <CAHi0vA-SAQYJraWb6ZH5bTWcoGdXMKnHj7fVARRzJN_LpPGc9A@mail.gmail.com>
In-Reply-To: <CAHi0vA-SAQYJraWb6ZH5bTWcoGdXMKnHj7fVARRzJN_LpPGc9A@mail.gmail.com>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Sat, 20 Mar 2021 18:46:24 +0100
Message-ID: <CAHi0vA_Nk4GqS=gYCzwqqRoNPQLH2n9BtLozWgwaQ78MsBvVNg@mail.gmail.com>
Subject: Re: Help needed with man page conversions to asciidoc?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

Am Fr., 19. M=C3=A4rz 2021 um 23:50 Uhr schrieb Mario Bl=C3=A4ttermann
<mario.blaettermann@gmail.com>:
>
> Hello,
>
> Am Di., 9. M=C3=A4rz 2021 um 09:49 Uhr schrieb Karel Zak <kzak@redhat.com=
>:
> >
> > On Mon, Mar 08, 2021 at 09:10:34PM +0100, Mario Bl=C3=A4ttermann wrote:
> > > >
> > > > I like the idea with translated man pages maintained in the
> > > > upstream tree, keep it all in one place is the only way how to
> > > > keep it up to date. If I good understand then the result will be
> > > > another template on translationproject.org to maintain man pages
> > > > strings in po, right? What about in-tree .po files? I guess it
> > > > should be separate from normal po files, po-docs/ directory?
> > > >
> > > Yes, it needs a separate .po file. It's not OK to mix UI and doc
> > > translations. Well, it's theoretically possible to merge both .pot
> > > files in one to force translators to work on both UI and man pages.
> > > But I think the UI .pot file with more than 4000 gettext messages is
> > > big enough, especially for newbies. So don't let's blow it up to more
> > > than 10000.
> >
> >  I agree.
> >
> > > I propose the following structure:
> > >
> > > The asciidoc man pages will be stored where the *roff man pages resid=
e
> > > for ages: in their respective subdirectories (sys-utils, schedutils,
> > > whatever). For the special asciidoc files footer.adoc,
> > > translation.adoc and asciidoc.conf we need an extra directory, let's
> > > name it "man-common".
> >
> >  OK.
> >
> > > For the man page translations, we can also use man-common. It's a goo=
d
> > > place for files like po4a.conf or the TP sync script (if desired), an=
d
> > > the subdirectory "po".
> >
> >  OK. For scripts, see also tools/ directory where we have some
> >  checkers, simple script to commit po/ changes to git (git-tp-sync)
> >  etc.
> >
> > ...
> > > > Is there any possibility to use some "style" template for
> > > > conversion to the man pages (for example the same header/footer
> > > > for all pages, generic sections like AVAILABILITY, etc.)?
> > > >
> > > Yes, see the attached tarball for an example footer.adoc. I could
> > > extend it with a "Reporting bugs" section.
> >
> >  I see, it looks pretty cool and readable.
> >
> > > > Don't worry about Autotools, I'll do this task. All I need is some
> > > > command-line examples of how to do the conversion.
> > >
> > > Oh, very nice... Although I also use Autotools in manpages-l10n (but
> > > haven't written all the Makefile* and related stuff), my knowledge is
> > > poor, and I'm happy after each release without problems;)
> > >
> > > Karel, I've already forked the util-linux project at Github; maybe it
> > > is useful to create a branch for the Asciidoc stuff in your main repo=
,
> > > which I can check out into the forked repo? This would be probably th=
e
> > > most painless way for a merge request.
> >
> >  OK, I have created a new branch "topic/asciidoc" on github.
> >
>
> Just FYI: I'm finished with the import, but I stumbled upon some
> peculiarity in Asciidoc. Many of the current util-linux man pages use
> "mailto:" links as follows:
>
> .MT johndoe@example.com
> John Doe
> .ME
>
> This leads to properly clickable links in the online man page
> collections of certain Linux distributions, such as Archlinux [1] or
> Debian [2]. But the *roff conversion engine of Asciidoctor produces a
> slightly different code:
>
> .MTO "johndoe\(atexample.com" "John Doe" ""
>
> Which renders to ...
>
> John Doe <johndoe@example.com>
>
> ... in the HTML output generated by man2html which is used by the
> mentioned online collections. The link is not clickable. Because I
> consider the online collections as the second most important way to
> view man pages, a non-clickable "mailto:" link would be a step back,
> which I don't want. I've posted this issue in the Asciidoctor forum
> [3]. Maybe it is possible to create the desired custom code using a
> macro... I hope so. Or the Asciidoctor developers change it upstream -
> which would be the better solution.
>
> BTW, the same applies to weblinks, but first let's find out how to get
> proper mail links.
>
> [1] https://man.archlinux.org/
> [2] https://manpages.debian.org/
> [3] https://discuss.asciidoctor.org/How-to-change-rendering-of-links-in-m=
an-pages-tt8575.html
>

Just found another problem: After applying the Makefile patches [1]
and running "autogen.sh" and "configure", the command =C2=BBmake gen-man=C2=
=AB
fails:

[mariob@t450 util-linux-mariobl]$ make gen-man
Makefile:15938: warning: overriding recipe for target 'misc-utils/uuidd.8'
Makefile:15927: warning: ignoring old recipe for target 'misc-utils/uuidd.8=
'
Makefile:15938: warning: overriding recipe for target 'misc-utils/getopt.1'
Makefile:15927: warning: ignoring old recipe for target 'misc-utils/getopt.=
1'
 GEN      lib/terminal-colors.d.5
/bin/sh: line 3: lib/terminal-colors.d.5.adoc: Permission denied
make: *** [Makefile:15940: lib/terminal-colors.d.5] Error 126

Don't know what permissions are really needed here:

[mariob@t450 util-linux-mariobl]$ ls -l lib/terminal-colors.d.5.adoc
-rw-r--r-- 1 mariob mariob 4947 Mar 20 16:34 lib/terminal-colors.d.5.adoc

I cannot imagine that lib/terminal-colors.d.5.adoc needs to be
executable... However, after chmod +x, the error message is even
stranger than before:

[mariob@t450 util-linux-mariobl]$ make gen-man
Makefile:15938: warning: overriding recipe for target 'misc-utils/uuidd.8'
Makefile:15927: warning: ignoring old recipe for target 'misc-utils/uuidd.8=
'
Makefile:15938: warning: overriding recipe for target 'misc-utils/getopt.1'
Makefile:15927: warning: ignoring old recipe for target 'misc-utils/getopt.=
1'
 GEN      lib/terminal-colors.d.5
lib/terminal-colors.d.5.adoc: line 1: //po4a:: No such file or directory
lib/terminal-colors.d.5.adoc: line 2: ////: Is a directory
lib/terminal-colors.d.5.adoc: line 3: terminal-colors.d.5: command not foun=
d
lib/terminal-colors.d.5.adoc: line 4: syntax error near unexpected
token `newline'
lib/terminal-colors.d.5.adoc: line 4: `Copyright 2014 Ondrej Oprala <oopral=
a@red
hat.com>'
make: *** [Makefile:15940: lib/terminal-colors.d.5] Error 2

Obviously the script cannot handle the comment lines at all.

I noticed the following line in the Makefile generated by the configure scr=
ipt:

asciidoc_man_cmd =3D $(ASCIIDOCTOR)

This seems to be the pure "asciidoctor" command without any options,
as far as I can tell, given my poor knowledge about GNU Autotools.

[1] https://github.com/mariobl/util-linux/commit/34455501de74c405b56daa438e=
e3e839e92fbc17

Best Regards,
Mario
