Return-Path: <SRS0=6iEs=3O=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E1CC2D0DB
	for <util-linux@archiver.kernel.org>; Sat, 25 Jan 2020 11:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987E62070A
	for <util-linux@archiver.kernel.org>; Sat, 25 Jan 2020 11:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAG0hm81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAYLT4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 25 Jan 2020 06:19:56 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:34723 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgAYLT4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 25 Jan 2020 06:19:56 -0500
Received: by mail-wm1-f45.google.com with SMTP id s144so5741210wme.1
        for <util-linux@vger.kernel.org>; Sat, 25 Jan 2020 03:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ro5CgTIB/ZoKUbJXgwiG9TV8K75iKprDqUEkv8fMX3M=;
        b=XAG0hm81yBNrzIVJ+2fJ8AhTSduHHTFtOVUOnG0aMKSmWeEFfTOUsr2Pig1aKcKd2Z
         6eMhi0A84uy/R0GQpYoGGwfBNugBgdSAxoqdL9xKenNGnjhMQCOUH+0jkvlP/KmMcswb
         9K9inLmw/ggPADtbe+lhF0DyKqJ1tc4Le+G8Ha8WfpbHlOxDfr9fuoNWc9VHA0LZX4Ny
         2BkWi6TxrtHZqzKkK9kfxegvmeAB9c1RBk8aoCu5TBNm05PaZXk/UFWXPye3OaUTbvjl
         gGYcHST3nJe38HnxNOdSWtYRaZk1uIkKf8VkSZqtwAkOrwS9N4+MvHMzHgBK0EsVb79C
         1DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ro5CgTIB/ZoKUbJXgwiG9TV8K75iKprDqUEkv8fMX3M=;
        b=kIT73TwDHydIu6GeRSKQMLRLrbcA0wdjTj/aKcYAowC9ARGu7VBWGbA1DW+Pi6OEFq
         AQgYzgDVeovXP2uc2920kZXcQiZ+Or9v790DY/G0ns3055ru73FU0T1Hj7fvSGttTaRn
         8saoSCcvbKg568f6dz34wlb56I/izJLOUj6xzrTnFIzqULc6IOJKXvcJXCaZPJtBg9bw
         Yg6NV9D1ypd/fQWyPzOcnDpa3EFBqmIUahc01MkaWQcQVLeTx43kRU8bp15I41sAMv0f
         jri5RVd+EKxF8C6btRUm9erp1j9IIEMv1r542cFIU8AE6Rj9SXjKrGeYQxlKBYpanm8r
         o5Vg==
X-Gm-Message-State: APjAAAV1tmlegtQzUoiZPftK4npSVklF5ZOk/SgWiubMAxXCZm4k6iCQ
        O2sLleHWhYmnZYX1qz4iaM2a6pqCdGZSATu0j1k=
X-Google-Smtp-Source: APXvYqzxkvZ8A1wtmzOK4lUm4Rf3gN4hNaVz1jUURNxhlE0tN9M5wTgJPHo89cFm5/Q68NI7s4WHRl69bNax8e3zIrQ=
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr4247107wmj.156.1579951193986;
 Sat, 25 Jan 2020 03:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20200121105711.zzeeolydlivqnik7@ws.net.home> <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
 <20200125105126.xaopgydc7dlrpztt@x2.net.home>
In-Reply-To: <20200125105126.xaopgydc7dlrpztt@x2.net.home>
From:   Carlos Santos <unixmania@gmail.com>
Date:   Sat, 25 Jan 2020 08:19:42 -0300
Message-ID: <CAJ4jsae1JinJWT7BAhWUK6Tjs00fMkk=HjEVrqB79gOGhXq+3g@mail.gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.35
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jan 25, 2020 at 7:51 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Fri, Jan 24, 2020 at 04:16:47PM -0300, Carlos Santos wrote:
>
> > That's a problem. It makes hwclock hard to include in embedded systems
> > due to the GPLv3 restrictions.
> >
> > I noticed that it comes due to sys-utils/hwclock-parse-date.y, which
> > was taken from gnulib. Would it be possible to take the file from an
> > previous version of gnulib that was still under GPLv2?
> >
> > An alternative approach would be porting a similar code using a more
> > liberal license, e.g. BSD.
> >
> > What do you think?
>
>  I have tried to export it from gnulib with v2, but it was impossible
>  by official gnulib tools.  Maybe do it manually from some old
>  tarball. I'll accept a patch for this if you have time do it.

I'm  looking for alternatives but they don't seem to be easy to
implement. I will explore them over the weekend and even during work
time next week, if necessary. That's fine, since the evil corporation
we both  work for pay us to write free software. :-)

>  I'll like to release 2.35.1 ASAP (due to bug in sfdisk --move-data),
>  so we can add this license change too.

Don't hold 2.35.1 because of this.

-- 
Carlos Santos <unixmania@gmail.com>
