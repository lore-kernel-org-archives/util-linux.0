Return-Path: <SRS0=ViFG=64=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D417C433E0
	for <util-linux@archiver.kernel.org>; Thu, 14 May 2020 20:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1D62065F
	for <util-linux@archiver.kernel.org>; Thu, 14 May 2020 20:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1COIJ/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgENUJX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 14 May 2020 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbgENUJW (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 14 May 2020 16:09:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826A3C061A0C
        for <util-linux@vger.kernel.org>; Thu, 14 May 2020 13:09:21 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l21so18036eji.4
        for <util-linux@vger.kernel.org>; Thu, 14 May 2020 13:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpz89FVu6IhhF7AgkXuFEFjkyQG5tksSMBCF8bbMXhs=;
        b=E1COIJ/wvEh/KnF2oGswlUMMZSZXtLbPeqZLlsnCCUCANa/U30w7+zLYTduMjB2M6N
         0UvCqpgV8N6sfqzfS/J4npfagZl8BA3Jb7OZag0UCd4Uvval2Owz2H+eK3VE1Xuilprr
         ZvQiZsuZkKkVynPR0FGYCq0Zu4TnUMr+3Mjebu0cF+JC/8OcJ8jbN9fLxMZ7/70Fu3qZ
         ziwusW2Tw81rMXwHZLl0opbBWyWLs+PikUztqb7suoFpTd/cRgDAAOj6CzJJszOvhiwT
         jcDAkwltiJL/bzluC1G1aElHN2XUqIHyKdNuCCdiP/T1NU4qJenb+tM5J1feCfwfTU5x
         iBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpz89FVu6IhhF7AgkXuFEFjkyQG5tksSMBCF8bbMXhs=;
        b=Z9Y5UMs4lDTA+3dJM7tBrznkuFTm8mRSIZ19A6x/qWwthXV2JrUeyovC0VsAdWANT5
         JblaieL7a5E238pEtpdNCpZ4Ly8oIydHHXE8G/FOLGw3sscc3WnooUeAeovQt1fmPEl1
         3847d3cdoam96x9OnwhrZLMB/XtDUZy5LqCRTqdJkjZS2+0HLgYidVIjStlbFFlWjeIn
         LiopNy4AUrT87a2oYZst23B2QNzkAoTxFz+srcCs42r0GYpR/jty/5pvO6ISaZ0l5Fio
         PmF1vAQEbT5RcgqSvTWwMv6UMA/nsiayCa2sr9zUEvXpBfleejk2Nf3tuuNmzvxJ/wRp
         CPjA==
X-Gm-Message-State: AOAM5330f4Xzs5DUD48dqpJuNgNLESoPofx9pXfMGEQMQ+Y2qu3llZkE
        cTAzuHV7ErgwlWPR+SAehJqL+UrgcfiKk3d+6LtCJlhf
X-Google-Smtp-Source: ABdhPJxv3qxHqdtM5IKxb5Am7+SwQmiwC/guUM3hit4SYwvz6Buc4XrMmCPHQdk1d9N2VHjNNwVxa6Sz76eppfDGvuE=
X-Received: by 2002:a17:906:da1e:: with SMTP id fi30mr1386525ejb.80.1589486960302;
 Thu, 14 May 2020 13:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200514185116.GA25596@Debian-50-lenny-64-minimal> <5372295b-b74b-2bf9-a8d1-bf1b38edcb30@physik.fu-berlin.de>
In-Reply-To: <5372295b-b74b-2bf9-a8d1-bf1b38edcb30@physik.fu-berlin.de>
From:   Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Thu, 14 May 2020 22:09:09 +0200
Message-ID: <CALxWeYqwYyOAMHaoWnoKKL2O4BvYu8-m-DyBap5eYn=2stzXyQ@mail.gmail.com>
Subject: Re: Errors in util-linux man pages, here: adjtime_config.5: Wording
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Helge Kreutzmann <debian@helgefjell.de>,
        util-linux@vger.kernel.org,
        =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello John,

On Thu, May 14, 2020 at 9:20 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hello Helge!
>
> On 5/14/20 8:51 PM, Helge Kreutzmann wrote:
> > I'm now reporting the errors for your project. If future reports should
> > use another channel, please let me know.
>
> I think you should send your changes as patches, preferably with a git pull
> request as the current form of submitting these changes requires a lot of
> manual editing due to the large number of changes involved.

Well, yes, but see
https://lore.kernel.org/util-linux/CAKgNAkgqKs=Q4qvPHirHa6KjW3qOqyyNG7sCxHX2RfWiOBqRbg@mail.gmail.com/

Cheers,

Michael
