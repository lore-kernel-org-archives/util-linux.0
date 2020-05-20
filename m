Return-Path: <SRS0=xh3B=7C=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38FC433DF
	for <util-linux@archiver.kernel.org>; Wed, 20 May 2020 12:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E64120758
	for <util-linux@archiver.kernel.org>; Wed, 20 May 2020 12:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="halv4JhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETMtk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 20 May 2020 08:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETMtj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 20 May 2020 08:49:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F64C061A0E
        for <util-linux@vger.kernel.org>; Wed, 20 May 2020 05:49:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e2so3572283eje.13
        for <util-linux@vger.kernel.org>; Wed, 20 May 2020 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=lIJFlXTFUKWVTIAD07jYxjXQm7bB71JvKQxX1S5aphM=;
        b=halv4JhFysZOMmGfENfo7SyviYUrw6H4qo49l+PWAF3l303mfXePvvpSYiau+okhWZ
         Qa5/cpp4ZYbksejoX8weuusIhkBcqgTwsYhDOk++eyrU20mdCyBz55gbLa5Pqixlob8Q
         XcSWA2CjnVJkQYKPlI+Kms1qfpNel8As5k8DYQvWEXCtnzxZNUV12mWNYYWs5uiawYHq
         hmnwpWUlyWNJcUDdyQtma1ddleV/Lkkz5U+eDpZSwgoNLphvMz3b3YAr/Ih+Zq3ryNzL
         UAwofEZ7Pb0BTEAMclYeli07jMvr8DSC13DKQr3VgErSaZRBIEPivMFbMzAZxia+zttk
         M+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=lIJFlXTFUKWVTIAD07jYxjXQm7bB71JvKQxX1S5aphM=;
        b=pxbtlB4Tek/7Npq6ztdtuvurBwXm5eyT3QtoQ4JiEyL2xeox1PCMkC8tqektqPprYe
         AQ1liRggTMiDtM9qiI6q9egrLcQ0oYPxYkltn+nYSN4NUSvvjMT4luPrKKx26tmvNYab
         zsL5GBFhKqOn5OrXcKEze+oNlCNtXoMmgUx5MWowQplJGMZQ/Ft7b/hJshHyccooe1xL
         q4YJOFGqcbbi7phcG/N4BBN9r3XUU1iA5kYLotmLaNCjUmX2FtcnSvpZEDDrJhbw8bD/
         RXv4AiRCgP2nXzk0stc54ZwD9NjBoC66Qs9eQw0E8HJ354UXjQF37MvQXV1PkrCRo5mZ
         6M4Q==
X-Gm-Message-State: AOAM532xlCHfvqTbVR/3GaINv/p9ByN8bxe+2b9NWdyK6kbqpx8+MsDz
        ySg9IdKTUNTtO+RyrYuuobsVC4Diga7KLGiKG3TR5agO
X-Google-Smtp-Source: ABdhPJxlxh/tFNgbKvDKqC2064i3nUGFDEukKbzbH1HwS3H6/u42mJ+XtcU4fG9DMYZmC0v8JJgiGD1sMLOx5SuMMpo=
X-Received: by 2002:a17:906:1d4c:: with SMTP id o12mr3436882ejh.357.1589978977885;
 Wed, 20 May 2020 05:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <4bfbe76e-4bde-289c-2a8f-b29e1d3aaae1@gmail.com> <20200520105942.b4f7kf7e32jva7nu@ws.net.home>
In-Reply-To: <20200520105942.b4f7kf7e32jva7nu@ws.net.home>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 20 May 2020 14:49:26 +0200
Message-ID: <CAKgNAkjgcRGh29zfdswPqn85bzOOaMjj0hZYGJd1Qs_9aWyKYA@mail.gmail.com>
Subject: Re: [PATCH 1/7] Manual pages: Standardize on AUTHORS as section title
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel,

On Wed, 20 May 2020 at 12:59, Karel Zak <kzak@redhat.com> wrote:
>
> On Tue, May 19, 2020 at 02:51:28PM +0200, Michael Kerrisk (man-pages) wrote:
> >  47 files changed, 47 insertions(+), 47 deletions(-)
>
> All 7 patches applied. Thanks!

Thanks!

> Please, use the same prefix for all patches subject line -- for example
> "Manual pages:" is nice. We use the prefix to generate release notes.

Got it. (I do something similar for my changelog/release notes.)

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
