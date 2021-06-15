Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01DAC48BE5
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 09:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07C061245
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 09:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFOJWJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhFOJWI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 15 Jun 2021 05:22:08 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5847AC061574
        for <util-linux@vger.kernel.org>; Tue, 15 Jun 2021 02:20:03 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i4so19545192ybe.2
        for <util-linux@vger.kernel.org>; Tue, 15 Jun 2021 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHEZ4PLPOV2Ky6axJvpptPL/juJoUK73eGKRLZjXeVw=;
        b=jd2lm2WzPM0ePXgNo1fOQ0cjgm4LCCriCf2I94i+XE4kzAgd0wcO4EKAqg7m8qvG9Y
         Fqic2AuHxcs7z0uPKUy3Ojqh3JWlZdRxv+2yBMmrUuVvgtV/uhc3C8cjk/w8e4YhaV2j
         2OB9FyuW+zdhRRjH3jFsjB3WKZkkhs+2PxoMsOymKb6okI8Bcxo+yJIKpNm/QkNEOfX9
         N6FZxVSvmqgnbrNCCQ1QikXKYrHPTQzOZ3b9Qpz2BV7UCRnnspdKwQZ6Foob78Y/jzEJ
         RrZHh3VhFNb10wjpwCQAyMSzAVW905W3Gd4FXX+xt4AW3GEzf7U5Ip5nLtuZyuNsFIZB
         H3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHEZ4PLPOV2Ky6axJvpptPL/juJoUK73eGKRLZjXeVw=;
        b=eVGhTIo1V6CNcOwOfLJ709RLGlM00Yu2gdRZzYMkAiYLMqWwGjXbND4osZZ1ZoB+E3
         mnuTGwL10LT1OCWjknB4c9aW++LTL/uRwdpSQ2HOVTqvWuX5cH55ynD1aJ5KyTBSs2PK
         G/MwOw2KlFyHI7gg/WXPYutbMnU8o2rExSTOIqqUZAl5/fQcM/4sPmVZDtdWz3rvnwsJ
         reWswivF3P3XM1uvne5FpYogRs89wQsOrS8296+qJ31ybIHfAcn3OTJIvOr4YZrFFESm
         cDtG76SVnW5jUiqlCVA5TpITvDlqRrrcOKrhYT2D346tD/0iebFx26ax2xHKmmuztEzX
         Sl0g==
X-Gm-Message-State: AOAM530qFNyRE7+1dgtInc0FRw5YXC29RhRFVbpAhhsrtk3uCwVZdr6M
        ueZSCwIs1DNb/rnsSSKDWUQFu0b1yulRhMid0Zs=
X-Google-Smtp-Source: ABdhPJxQjZdQrL9EDWkUrObsbz+COMAy9XjBgwt2lpj/StUGGC3oSK57+biNBcshPZpjQqtopnEIBRVmcsjwFhkRuwI=
X-Received: by 2002:a25:3d8:: with SMTP id 207mr30519935ybd.81.1623748802599;
 Tue, 15 Jun 2021 02:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210614204017.49499-1-hi@alyssa.is> <20210614210433.p62vxkx3cm7ynwbk@eve.qyliss.net>
In-Reply-To: <20210614210433.p62vxkx3cm7ynwbk@eve.qyliss.net>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 15 Jun 2021 12:19:51 +0300
Message-ID: <CADxRZqyyy2U1czTggBmSFz19BX5Jeg+hQk9ac+91ovkgsAc6RQ@mail.gmail.com>
Subject: Re: [PATCH] libblkid: match uppercase UUIDs
To:     Alyssa Ross <hi@alyssa.is>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 15, 2021 at 12:07 AM Alyssa Ross <hi@alyssa.is> wrote:
>
> On Mon, Jun 14, 2021 at 08:40:17PM +0000, Alyssa Ross wrote:
> > In a script, I wanted to look up the device node for the booted EFI
> > partition.  systemd-boot exposes this in an EFI variable but it's
> > uppercase, so when I tried to do this, it didn't work:
> >
> >     findfs "(< /sys/firmware/efi/vars/LoaderDevicePartUUID-4a67b082-0a4c-41cf-b6c7-440)"
>
> Bogus command here, sorry.  It should have been:
>
>     findfs PARTUUID="$(cat /sys/firmware/efi/vars/LoaderDevicePartUUID-4a67b082-0a4c-41cf-b6c7-440b29bb8c4f/data)"
>
> But my point stands. :)

probably could use a pipe after cat, like:

cat ... | tr [:lower:] [:upper:]

or patch util-linux docs, to implicitly state that comparison is done
with upper case letters (UUID)... Not sure which way is better
(including your patch).

Thanks.
