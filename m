Return-Path: <SRS0=Ohmc=7A=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D1EC433DF
	for <util-linux@archiver.kernel.org>; Mon, 18 May 2020 10:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E195020787
	for <util-linux@archiver.kernel.org>; Mon, 18 May 2020 10:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Endt0lhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgERKgO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 May 2020 06:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgERKgO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 May 2020 06:36:14 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED78CC05BD09
        for <util-linux@vger.kernel.org>; Mon, 18 May 2020 03:36:13 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s21so8427489ejd.2
        for <util-linux@vger.kernel.org>; Mon, 18 May 2020 03:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=qZTMAdTv0Tp3VylX7vE0ylpdWlExkiNN4FzbJyYQ64Q=;
        b=Endt0lhn6+C63vHWmiJ3Fwl6q3yrauIHkhHQw61eAd3Vy9CqRjjcabOGv9zkBs0o/2
         WzK2dKPGszLuDt5x2JsfnD9J7e0aP9Ulzb8/3P3nzYoWjYoUBAe8oz8kAJFv4Efe/FmW
         cUaDG1kRp4yL8z5v3jw9c70LAgWDPbVQOOXgatFdnjUXpvlXV+hGCRCyTg5BhZJLz4C9
         rvmrJQQNCyLOAGDG/8vIViKgEu/lgIcIajQixlr7TPP5rDAvt86KyWjciTl4vWnOspdu
         ypgZAS/thgnnRY8Ss8z7vMwG9KrS99yrxNAlAu9FYbTgqYCVn4taaAmE63sSSsTPyK8+
         HiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=qZTMAdTv0Tp3VylX7vE0ylpdWlExkiNN4FzbJyYQ64Q=;
        b=pyQaf5iaJueczQYyvrGpRxS3lq8EaZkHbqOGVFs5pYKFim4gaYICFlljHZw5t61Hhu
         DIFeUrn+nf3iOg1qtjiJeDtJeuSSer8g/bcPcU2YLnJ5aCYWVmOPT8qRStoESa8kvToE
         XgmeKI0sy4KtSCrJfRA7C/74hKWQu0aBgviil6FB42je1ObSbx3EkttrCF1tjBodkghQ
         tPFh7Vi52ZAzGpIOX0ydbOWTVeJs+wP0YQ71CQgfnhbNdluEixDpwyAAYgDFQlXINKb9
         p0uD2ieMUPVK2Us28qfn0PhuXks+A00JxRIvvk1Kys26FZi4jtiOhdl8NCZHkoFmOm/h
         rOzQ==
X-Gm-Message-State: AOAM532sab+AfAFH6t891yyM8Nx2TR7YVsxz724LiUSo4lAP7njJokNz
        MogRQdHUiG2LdTRmBT1BCukrshipGOYFXSyIs+Q=
X-Google-Smtp-Source: ABdhPJyZSqn4rwa1QHpsjGRR9MS99Hc3iSlGTcR2AddB1bkPF4h1Hz1OVMbSq2KgpT2fqoys3ORTplwNtyLxCp61Lvc=
X-Received: by 2002:a17:906:f212:: with SMTP id gt18mr12193007ejb.150.1589798172413;
 Mon, 18 May 2020 03:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <4cb60e3f-0226-e7f0-0052-08a48ea9f425@gmail.com> <20200518082814.pq22ph732eiebacz@ws.net.home>
In-Reply-To: <20200518082814.pq22ph732eiebacz@ws.net.home>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 18 May 2020 12:36:01 +0200
Message-ID: <CAKgNAkihsF1tGurfHbnFPYZ4qJV9-2f=Sbj5qdLxmuuuAJ+GGA@mail.gmail.com>
Subject: Re: Consistency fixes in util-linux man pages
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Helge Kreutzmann <debian@helgefjell.de>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel,

On Mon, 18 May 2020 at 10:28, Karel Zak <kzak@redhat.com> wrote:
>
> On Sat, May 16, 2020 at 10:24:59AM +0200, Michael Kerrisk (man-pages) wrote:
> > Hello Karel,
> >
> > Perhaps a little inspired by Helge's recent reports, I wonder about
> > submitting some wide-ranging patches to improve consistency across
> > the util-linux manual pages.
> >
> > As an example, there's quite a bit of variation in the order of
> > .SH sections in the manual pages (e.g., in the placement of the SEE
> > ALSO section). The pages would be more readable if the ordering was
> > more consistent.
> >
> > Would you entertain patches that made wide-ranging changes
> > that fixed that sort of thing (without changing page content?
>
> No problem,

Ok.

> but it would be nice to somehow document that is expected
> to avoid future changes in an opposite way. For example add some info
> to Documentation/howto-man-page.txt.

Agreed. For man-pages, I created man-pags(7) to document those
expectations. At least some of that should be applicable in othe
pojects, if they want.

> BTW, I'm not sure about man pages as ideal format to maintain
> documentation (because it's mostly about formatting than about
> content). I think about AsciiDoc or so in future. What do you think
> about this idea?

I'm not too knowledgeable in AsciiDc, but my impression is that it's
too limited in terms of its formatting opinions.

If I did move man-pages, the most likely candidate would probably be
Sphinx, as is nowadays used in the kernel docs. But, that would
require converting a thousand pages or so, and  I have not so far had
the stomach for that. Of course, you have a rather smaller set of
pages to deal with, so a conversion step sould be more easily
entertained.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
