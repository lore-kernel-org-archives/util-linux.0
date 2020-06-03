Return-Path: <SRS0=KLef=7Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09843C433DF
	for <util-linux@archiver.kernel.org>; Wed,  3 Jun 2020 10:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86C720679
	for <util-linux@archiver.kernel.org>; Wed,  3 Jun 2020 10:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBFs9DBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgFCKW7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFCKW7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 3 Jun 2020 06:22:59 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4FBC08C5C0
        for <util-linux@vger.kernel.org>; Wed,  3 Jun 2020 03:22:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so1589531ejb.4
        for <util-linux@vger.kernel.org>; Wed, 03 Jun 2020 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=whGJS7sO/rt4VDwBdVqLQe32TmeTqjyolswR54JLuMY=;
        b=uBFs9DBRoUSop56U6J6wySdEwPemNvX9Hdufl98oMvOKXXFszCtqvEsd/ofIJDDwBE
         VHyG9nGGzjLVSUxpMJTA0TvfYSfQ6Mkb53UZByl3fQqgnfRoRjQqjOGyPaRmziTK2di+
         MqcUqK5MZ7Z6u6y6mo+jfyvnKRL2RTkY1g3VX0V7Jm/02ZOVeMQ30Z1RnkaZbJHBlpkY
         iZYeLZYKJ5YrqnEkcfYzrKyQ9PJ7BlPuUTYcMNtZoI3DpQ/NVUXDqtrL1c/1sBPzvov4
         k2yYI8x97ChenBGayobUNDRYQsCDTKLVaZPYXD6IEKJJGqg6/eTENpKya+VS7pyHvEbj
         PMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=whGJS7sO/rt4VDwBdVqLQe32TmeTqjyolswR54JLuMY=;
        b=jCaMDo81VGXYiJkIa+rPnBDzwhuJkR/ezh41efiX5w5mfJX+wXcoHLFR+5tm3hN/3F
         CBSfN3H1LBbk0M9GyUT0m6khkMsg2h00zM0IkNlwpaPTNYpH0UeVoTZyynrofDlVM3U3
         MgcE7IvGqiinMSqrar/hKhz+O5OwuxHReu2bJHv3SmaFE2lu8wSPGKQr9koaoxhoFF+d
         Ij0RDF6AtcISEutoqe1ArRzzOUFLH1WE3jBHSZtJjNypMyotg5FFGOGDZSIVo/6cBlu8
         HRUcONc3FlHh2mBf207SKFLZtd+t7dTRdY/HqLIsVb4+tzYuh5buHd70u5+W00othhOy
         wVxw==
X-Gm-Message-State: AOAM532ZsdXvHT36BxZc42cpt++BxbcKrS8dcggk3uHP9D/TqsJ/ke1N
        T99F2AySHNu42VaUhZZ+eSqTjN+R+b7dNOJU/A+/dy4w
X-Google-Smtp-Source: ABdhPJy7nnZprSWG3rEj+TeJeKSKEzyiPl3QESRFJuKsLoCE8QLMn2rhB8C3yGy82jff9RGnT6z1BS4U8gHn+5vTc7g=
X-Received: by 2002:a17:906:4b18:: with SMTP id y24mr14773255eju.366.1591179777287;
 Wed, 03 Jun 2020 03:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200603074057.540157-1-mtk.manpages@gmail.com> <20200603074057.540157-2-mtk.manpages@gmail.com>
In-Reply-To: <20200603074057.540157-2-mtk.manpages@gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 3 Jun 2020 12:22:46 +0200
Message-ID: <CAKgNAkgLZp=t21vrcfuf9iPmHxk_tG74-_jbtOftQKpGge1dpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Manual pages: unshare.1: clarify that --pid=<file>
 requires --fork
To:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

> +(Creation of a persistent PID namespace will fail if the
> +.B \-\-fork
> +is not also specified.)

Small wording problem there... s/is/option is/

Should I send a new patch, or will you hand edit?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
