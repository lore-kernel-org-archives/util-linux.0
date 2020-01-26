Return-Path: <SRS0=EvaV=3P=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733E0C2D0DB
	for <util-linux@archiver.kernel.org>; Sun, 26 Jan 2020 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E5D206D5
	for <util-linux@archiver.kernel.org>; Sun, 26 Jan 2020 17:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO+u0B5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgAZRu3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 26 Jan 2020 12:50:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55214 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZRu3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 26 Jan 2020 12:50:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id g1so4339149wmh.4
        for <util-linux@vger.kernel.org>; Sun, 26 Jan 2020 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/jwl2HJIAgZbot9tTCASF/wwXeIJTBJ21ckANldHKk=;
        b=eO+u0B5yvFj26Wrp21O8c3CQsgeXaePj9hUvB2c1OrlC3F6DNk4JXxgxliRhoPhqmr
         YuWXDiM3+7kuUUjs46DSeQYQnEgfOEDZlqbS0/ubTaFeZb7N5JfopAVjrNGgMR2v09ec
         IWn10/uqL2dGv27btlVrHFHVssMEPjY6XHZszrQLgpmQcpTEXnGk5zV5DJW+nWquntxY
         1TnUA8gDtXccvj0/PsXAKOj6B+EgTC9MBww1AsdeC4i2eXMCy8irJQAlRq0n6S0oJ8Oh
         B2YQK9Xn/9QfsOAvVpCLA8GHC8X32Dxq1GRLLeJL6H5CEW8NfGhQGN+9jAibTgnFHYMw
         iJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/jwl2HJIAgZbot9tTCASF/wwXeIJTBJ21ckANldHKk=;
        b=oVf95QEeU8PNjLWLhGsiTSLwHw74fJLWfjXwOED4EkQPqsgB/xesghF3Q1zvoCN5nf
         n49RUmwA5AutoTR6FzM+hRHl945jwdmWGDDPrVw+JhdtG/TPUkz8HRmq2tL34D+jLSNU
         7ObxNmbXYi8QbExLj7EOptEJw74sSr5sn0mDJ2yxUMsvAO0vQ7+UmCBuFXwgBEJkjCan
         DcH7aIrpA6JOfoUezaKTfC0vjwLss/1ycy/zMSomwD/23fHQG6EsWw2jd1Kne1SY1tnc
         vHsylI6ElDQSQS/cPrmHd672GET8gToBs0LrN03C/J3jcMkvgyRP+QGR0+FiPKRpTXwt
         tq1w==
X-Gm-Message-State: APjAAAWgFIaR6J786ahZDgo3JXOJ997JxU91HqGZgKSWdDwwOOEOhW3Q
        tjUoqETk0Oyh8bNWTClfzqvzWgVSfZYDzWzwBT0=
X-Google-Smtp-Source: APXvYqwQexwJdBaOWDajfe4YVmG4BdwOmtf6TPAsvZh7jjC9PLC+X+j/uHWzsvMVWWVW/Qkd1knN0JxJjThuJqc1B3c=
X-Received: by 2002:a05:600c:30a:: with SMTP id q10mr9613388wmd.84.1580061027215;
 Sun, 26 Jan 2020 09:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20200121105711.zzeeolydlivqnik7@ws.net.home> <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
 <20200125105126.xaopgydc7dlrpztt@x2.net.home> <nycvar.YAK.7.76.2001261131130.3053@zhn.tzk.pbz>
In-Reply-To: <nycvar.YAK.7.76.2001261131130.3053@zhn.tzk.pbz>
From:   Carlos Santos <unixmania@gmail.com>
Date:   Sun, 26 Jan 2020 14:50:15 -0300
Message-ID: <CAJ4jsaeYwY3kvw23UfbuysYTeM0i0+vDykUwpcJNnQo7J6BMDw@mail.gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.35
To:     J William Piggott <elseifthen@gmx.com>
Cc:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Jan 26, 2020 at 2:00 PM J William Piggott <elseifthen@gmx.com> wrote:
>
>
>
> On Sat, 25 Jan 2020, Karel Zak wrote:
>
> > On Fri, Jan 24, 2020 at 04:16:47PM -0300, Carlos Santos wrote:
> >
> >> That's a problem. It makes hwclock hard to include in embedded systems
> >> due to the GPLv3 restrictions.
> >>
> >> I noticed that it comes due to sys-utils/hwclock-parse-date.y, which
> >> was taken from gnulib. Would it be possible to take the file from an
> >> previous version of gnulib that was still under GPLv2?
> >>
> >> An alternative approach would be porting a similar code using a more
> >> liberal license, e.g. BSD.
> >>
> >> What do you think?
> >
> > I have tried to export it from gnulib with v2, but it was impossible
> > by official gnulib tools.  Maybe do it manually from some old
> > tarball. I'll accept a patch for this if you have time do it.
>
> You do realize that I had to heavily modify that file to remove its
> gnulib dependencies (because you said no to gnulib). If I recall
> correctly I had newer and older versions to chose from and picked that
> one due to it having the most bugs fixed while still being practical to
> strip its gnulib dependence.
>
> The reasons for making the change were:
>   * remove hwclock's dependence on date(1)
>   * remove an insecure call to date(1)
>   * I thought there would be to many complaints if the accepted input
>     date formats were changed
>
> As to the last bullet point; personally I think having the --date option
> accept every date syntax know to history is nonsense. A fixed format
> would be fine with me. Since we switched hwclock's output to ISO 8601
> that seems like a good choice for its input. Or you could just use the
> existing utillinux date parser.
>
> The question is, do you want to deal with any pushback for
> changing the long established accepted --date formats?
>
> >
> > I'll like to release 2.35.1 ASAP (due to bug in sfdisk --move-data),
> > so we can add this license change too.

Can't we use getdate(3), instead? I see some advantages in this approach:

- It's a POSIX standard
- It's supported by GLIBC, uClibc-ng and musl, among others
- No need to maintain the code, since it is provided by the system libc
- It's easy to a default template to use if DATEMSK is not defined
(e.g. start with a copy of NetBSD's
/usr/share/examples/getdate/datemsk.template and expand it as
necessary).

Being non-reentrant is irelevant for hwclock and the cost of reading
an external file is negligible.

-- 
Carlos Santos <unixmania@gmail.com>
