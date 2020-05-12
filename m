Return-Path: <SRS0=qlqL=62=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E64C54E4B
	for <util-linux@archiver.kernel.org>; Tue, 12 May 2020 06:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E3220714
	for <util-linux@archiver.kernel.org>; Tue, 12 May 2020 06:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgELGas (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 May 2020 02:30:48 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:39334 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgELGas (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 May 2020 02:30:48 -0400
Received: by mail-lj1-f170.google.com with SMTP id u6so12235500ljl.6
        for <util-linux@vger.kernel.org>; Mon, 11 May 2020 23:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=XaBjHz43pXxqJPV8IcwxfVJV0mxDfxDB6nGbJCngPss=;
        b=qwiKVRi7U2lHF0dIK+YWV0Kk4PUNVgAJbqmM1cz4Pn1Fb+rv+UFsTLQzmuqOwf/HFy
         TkJKOiU2rsU+7VuFBpnP54WkicRhdsE8IIlyAcwpDNDc8vHsea+gmefS8uoiyF+fXSOL
         14kv/mX9JVyHTl7DhEK0VJzlKVXf+kEzfbtuwPPMq5sXU8JCsq8OLvK5BYEYNLfTpvjA
         D7tTuR4w6tRyXA8E9ynM7pCJoqLndsc9J9ySSN0RFABRZ3tz2q1K0yBF/kyEtbcZLi3Y
         iVo+m2U8qMklVVuXrvR3q9l+KUb0L0KzM7AplOJocAVlKs5eFUB7X52hYwlneTIcnzL8
         uR9g==
X-Gm-Message-State: AOAM531WTOe4/ghF8DmVRPXOYpfkfEwVWsOm1Nu0ljThyo0s2FeTIwPL
        ILPb57+OSbsA1HNw93iZR7AV7/TAGAxBpl45gE1AybiV
X-Google-Smtp-Source: ABdhPJyM+QtLXnxcuWjamp4XBKlBmewLxOxd3R1rmREgd6lj9xHEWevROi6dtSGxnGg68tcBoVcu57pK7HbHGYk+o58=
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr2399458ljj.23.1589265046577;
 Mon, 11 May 2020 23:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <06b88d20-4753-bba5-4df6-ea992aca214e@ft-c.de>
In-Reply-To: <06b88d20-4753-bba5-4df6-ea992aca214e@ft-c.de>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Tue, 12 May 2020 07:30:35 +0100
Message-ID: <CAG27Bk0mU1AG6ysX=rbrvUBU6N2-b1QZgy4xOXOOj50NgPPTFg@mail.gmail.com>
Subject: Re: rename bug
To:     ml@ft-c.de
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, 12 May 2020 at 00:30, <ml@ft-c.de> wrote:
> here is a bug in the rename command.
> Pleae test it:
>
> The rename command doesn't work from another directory, when there is a
> "^" (beginn-line) in the regular-expression.

[snip]

> $ rename -V
> /usr/bin/rename using File::Rename version 1.10

Hi Franz

The email list you sent the bug report is maintaining different
rename(1) implementation.

$ rename -V
rename from util-linux 2.35.1

I think good place to report the issue is Debian distribution bug
tracker or straight to Perl cpan upstream.

https://bugs.debian.org/cgi-bin/pkgreport.cgi?pkg=rename;dist=unstable
https://rt.cpan.org/Public/Dist/Display.html?Name=File-Rename

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
