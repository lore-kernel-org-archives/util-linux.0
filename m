Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC0CC433DB
	for <util-linux@archiver.kernel.org>; Tue, 23 Mar 2021 20:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16F7619CE
	for <util-linux@archiver.kernel.org>; Tue, 23 Mar 2021 20:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCWUHi (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhCWUH1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 Mar 2021 16:07:27 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CF3C061574
        for <util-linux@vger.kernel.org>; Tue, 23 Mar 2021 13:07:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id f12so15941181qtq.4
        for <util-linux@vger.kernel.org>; Tue, 23 Mar 2021 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ykYuyDBSWDyuU0SbIgPE3ka9aCFEW22q3LO8siUKOw8=;
        b=aMDoaZ/DIjhgpLUYjK4j9HUckCIoZTeDh4MHyPcqEjOW8cqo0GC3slp3YPG09Add76
         yocrJNjEr8L1kwHTfdJgJsPsVtVZkbnSsX/wzTHFYPSqs3RQAZTn+Hnkews3qkYARdVu
         8QMzOVPjCoK8DR1Ul79ypeY/PxAYIHiZK2N79mS46lMLKS/su0N4fH0g0Lg4iepzQFk4
         YgWp2DgFJuftgVHaQPmms8IL+dT6QhAaydWWtkg5vmiYJ6BjtZSjtsmGcgeXDnBC9UFv
         uSndX0HAiD65ZH82sKx0YWDUeMETyoMwKckHZZc5o7VTj7kmXe3LVV9/3wiqjZcRiJAA
         BZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ykYuyDBSWDyuU0SbIgPE3ka9aCFEW22q3LO8siUKOw8=;
        b=jkMsybKuJN2fRpaK+ti7m5/mCAB2+euZtpYqxabKLqH/ntevBq4Q7AtGWvYiJRHhBm
         opky4QLjncYgcnUTThWK3Q/hnRHDLHcnEjYVWh2EoxYsROHyIdnu9N83E7P8fCbDxRd7
         9bolf7H/VyT/a8mmKDSp3xl4rSJuH/GAdU6F1D/o0pL6u49urwz1lkQOsJTVFRjz7IZL
         tEL7yURHmjP+441B63AxkfPdQ+F+Pf1Cy1HqUjgAu+SYSya9up8hzTDnyVRxiq84T9A7
         YAPGaxQTOPtT0b3gaZA6bAXP5kzsjq7/oa4zn5IIsAUMtgivRFIoC3/9W+BkXJURoILg
         z/9g==
X-Gm-Message-State: AOAM530qUyzmY+gVhmorid1t+1gccgzYd7bLyWq31rAWLw7dAu1pHkbE
        rAneVnuJPVvdwMBq75prlS2lF2gwdFAfHGoYjt95p8cLKx4esw==
X-Google-Smtp-Source: ABdhPJwrn1BJAhDmmSkY2DvxvYtj+4MxokUCjrISW6z8fFN0Q8LOEERnZicnjaQ4BMbw4nsfynnw5/Ce054IeDpsyUE=
X-Received: by 2002:ac8:6888:: with SMTP id m8mr23729qtq.71.1616530046170;
 Tue, 23 Mar 2021 13:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <karelzak/util-linux/issues/1257@github.com> <karelzak/util-linux/issues/1257/792670506@github.com>
 <CAHi0vA-d7EQostbdDMZGmKeNfLYvjUWkuvF01nw-CM9wOkWMow@mail.gmail.com>
 <20210309084908.izmuxsrqujiml6ph@ws.net.home> <CAHi0vA-SAQYJraWb6ZH5bTWcoGdXMKnHj7fVARRzJN_LpPGc9A@mail.gmail.com>
 <CAHi0vA_Nk4GqS=gYCzwqqRoNPQLH2n9BtLozWgwaQ78MsBvVNg@mail.gmail.com> <20210323092705.uaa2oas3ux5s3er7@ws.net.home>
In-Reply-To: <20210323092705.uaa2oas3ux5s3er7@ws.net.home>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Tue, 23 Mar 2021 21:07:15 +0100
Message-ID: <CAHi0vA_FL744Lap_GqkrhPPf_wK0BW2Ed_R2FVwQ+L_A4AJdHg@mail.gmail.com>
Subject: Re: Help needed with man page conversions to asciidoc?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel,

Am Di., 23. M=C3=A4rz 2021 um 10:27 Uhr schrieb Karel Zak <kzak@redhat.com>=
:
>
> On Sat, Mar 20, 2021 at 06:46:24PM +0100, Mario Bl=C3=A4ttermann wrote:
> > Just found another problem: After applying the Makefile patches [1]
> > and running "autogen.sh" and "configure", the command =C2=BBmake gen-ma=
n=C2=AB
> > fails:
> >
> > [mariob@t450 util-linux-mariobl]$ make gen-man
> > Makefile:15938: warning: overriding recipe for target 'misc-utils/uuidd=
.8'
> > Makefile:15927: warning: ignoring old recipe for target 'misc-utils/uui=
dd.8'
> > Makefile:15938: warning: overriding recipe for target 'misc-utils/getop=
t.1'
> > Makefile:15927: warning: ignoring old recipe for target 'misc-utils/get=
opt.1'
> >  GEN      lib/terminal-colors.d.5
> > /bin/sh: line 3: lib/terminal-colors.d.5.adoc: Permission denied
> > make: *** [Makefile:15940: lib/terminal-colors.d.5] Error 126
>
> It sounds like $asciidoc_man_cmd is empty. This is my mistake.
>
> > [1] https://github.com/mariobl/util-linux/commit/34455501de74c405b56daa=
438ee3e839e92fbc17
>
> You also need to define $ASCIIDOCTOR variable in ./configure.ac.
> Please add the patch below. I have probably forgot it in my
> suggestion.
>
>  Karel
>
>
> diff --git a/configure.ac b/configure.ac
> index 7f59604bd..946222676 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -232,6 +232,7 @@ PKG_INSTALLDIR(['${usrlib_execdir}/pkgconfig'])
>
>  GTK_DOC_CHECK([1.10])
>  AC_PATH_PROG([XSLTPROC], [xsltproc])
> +AC_PATH_PROG([ASCIIDOCTOR], [asciidoctor])
>
>  linux_os=3Dno
>  bsd_os=3Dno
>
It works until it reaches the first man page link:

  GEN      lib/terminal-colors.d.5
 GEN      libuuid/man/uuid.3
 GEN      libuuid/man/uuid_clear.3
 GEN      libuuid/man/uuid_compare.3
 GEN      libuuid/man/uuid_copy.3
 GEN      libuuid/man/uuid_generate.3
 GEN      libuuid/man/uuid_is_null.3
 GEN      libuuid/man/uuid_parse.3
 GEN      libuuid/man/uuid_time.3
 GEN      libuuid/man/uuid_unparse.3
 GEN      libuuid/man/uuid_generate_random.3
asciidoctor: FAILED: input file ./libuuid/man/uuid_generate_random.3.adoc i=
s mis
sing

BTW, it also produces HTML versions of the man pages, which are not in
.gitignore. Is it intended to also install HTML versions?

Best Regards,
Mario
