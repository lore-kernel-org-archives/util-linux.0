Return-Path: <SRS0=vFYQ=AZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BFCC433E5
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A814621D79
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 12:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWSzYGxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGNMd0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgGNMdZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2020 08:33:25 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ECAC061755
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 05:33:25 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 12so13777518oir.4
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ExhFgX0roa7wmBLzZDlXPuMAyNG9BQ0pQvXPz8+krJ8=;
        b=rWSzYGxLbXhvik9/YEnN6n9/uazMN7oMcUAshhslIV6Szq6osk2b8+njIOtB2Ahw8C
         KBijMGeYq2vdLYgdxJTNnyPFDUgZkU5JQy12mXqCZEF1MhhzCmdOdGasEpeCDcACSpBF
         3inShZcUh/C2ODu1LEvwdIAQF8ym7mP5gltqsC1nf7C/AU+F02/EzsO7kks1m0aVYrik
         /Xthj2ka/jFP0SOxckfoXMlqISStU6aVRu3UzE2ORU4kZNF9HRQMf4uHiKSHUlXUTn4H
         CngX41P7EPSacf5LEI7U/9EHlQgdMfCOW7Gb5mFCBFGg8qHi37XI83ePTZjRMhJS+pUj
         TGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ExhFgX0roa7wmBLzZDlXPuMAyNG9BQ0pQvXPz8+krJ8=;
        b=GvEU3tDvfBUaNIoj2mMwyif5MvRBWz1wMDon68JEEYsmlbjVq0/gtlJZ6/P1Ezml29
         mHL9xQGMvlGiDLGAfDUy83V83LH6LMIaVqH5XsmwVQSghSdv+efr9ERh448Q6IqbjK9l
         khcHsKmV2NB8k7tLX/C1FMjxV7lQrEysE+XFjdWJwUYZ4lncJHeAOnMTrTB4dlSK8BTh
         I9Ukj0NYbZ/lOAdC7su5T8ML1Nv+kOQMwCiCt628WXrcmVJ38OlA9YUPi1qtg+E232jD
         13M3X05888/qOcpKHKotHJrVS49FNoJEY06erf2BMQQS5G2vDq11tJ8DmbgDyHe6dtXs
         9Sgg==
X-Gm-Message-State: AOAM530MKOKyZPwIMIj/pKY54e3Ix6Tyua6MBCVrkTdb17RNIKWjRRYw
        kIx4hzJ3i/XZN9MOyGI4X0ssHfMUWHd4jDqK4rU=
X-Google-Smtp-Source: ABdhPJwnlR3SE34NlUt/ARpSVschnRBGv4ZX5x1oKfyuPm0AVeeVV1Lq/rlLoWy2ZLgLsxcJt1LITOZSEpexdTupmYI=
X-Received: by 2002:aca:5683:: with SMTP id k125mr3474581oib.159.1594730004651;
 Tue, 14 Jul 2020 05:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200714095741.45292-1-mtk.manpages@gmail.com>
 <20200714095741.45292-5-mtk.manpages@gmail.com> <20200714121420.fvmuuasgkq5hrtcz@ws.net.home>
In-Reply-To: <20200714121420.fvmuuasgkq5hrtcz@ws.net.home>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 14 Jul 2020 14:33:13 +0200
Message-ID: <CAKgNAkgA38ycbAJix6_b6xJXf3h7VY9AVop5QZVbKTc8kbZAiQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] Manual pages: various: reword "allow(s) to"
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel,

On Tue, 14 Jul 2020 at 14:14, Karel Zak <kzak@redhat.com> wrote:
>
> On Tue, Jul 14, 2020 at 11:57:41AM +0200, Michael Kerrisk (man-pages) wrote:
> > The wording "allow(s) to" is not grammatical English. Reword various
> > pages to use a more correct form such "can be use to" or "allows
> > the [noun] of".
> >
> > Aklong the way, fix a few nearby wording errors in some pages.
>
> Some of the "allow to" has been already fixed by Bjarni Ingi Gislason
> (well, his fix is "allows <verb>ing" -- not sure what is better ;-).

I see. Those changes also work, of course. Thanks for fixing that conflict.

> The rest has been merged without change.

Thanks.

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
