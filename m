Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4340C388F7
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 16:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515BE217A0
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 16:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RylTuKV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgKMQrO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgKMQrO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 13 Nov 2020 11:47:14 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E12C0613D1
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 08:47:14 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id t5so7112377qtp.2
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 08:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dJrhw9k5uQoQey/c+ApSR9NVSjCLkrfPa/hM9/DjyO0=;
        b=RylTuKV0rt7ZxIIns9c+pKRt/tXp/d1XiiBAvn23A4DlHHlZCoZ3HQEuI2MCjeyyta
         Gp+Qxwryd0ytDA7VzZTsq9toc4YhEf2A4jnUsU8y1yZpkvp9iNYtTg78nkIhZkMEiI63
         +Ad8M6w1qQQM97wDnx2RAVUxqIbsGX0VhZid1AJA7264/mmgBawFrfjEPzvOjMkFGE8t
         P7f6g2++7QftTgPgnR2rWBzHQjlexKwN12ChBLHVqDxBNrm3dn+kG8ZAH/STfNmnEaQR
         w8sQlR0Go3zU5FEZg4FZWsOZEO8rth0DR6Lq3er1EmP9E3cbGWBdx8pxb5WX1BdT3TZc
         ByIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJrhw9k5uQoQey/c+ApSR9NVSjCLkrfPa/hM9/DjyO0=;
        b=rYPUnPDSEcxO++GKl7Ymz3orGWeEyqRrLGzJX/RyY/mCMYozYHzP/XbiPVeLCKpdHL
         KHUGRzteRaZsKXYpYwaszIYo9v/p9QqQA7ttJ/IBGTj5rUcclZ+2BZaMKi39InI+y3YJ
         ay7el4jM7mSVvw7w4iWFt7K5Vo1lkXv4IJW4HSb3LRHTYL9D5eou3Ngz7lEDm8LpaKJ4
         RC0xdPCuWSi0burvEowXN334sEEDLkebwgPMED3t3Dnb6T2sCusmbsmXg2YqvSNhAJFZ
         jnqOuNOP9W+FdO/GxjdCMrSieoWM9eC8cOYi5jvArEJpJTbF1wafiOy8cWygcmJblGhq
         gqdQ==
X-Gm-Message-State: AOAM530lSkSgJMiZsJATImF7VqNgNEk4nGDwqxtaxivLaVO5xWnW4HzO
        1y4rcP4ol2dPhpw9Qb1SUw==
X-Google-Smtp-Source: ABdhPJxhehVc3wPlZsHBkBq8uNI2m0Mv+r7kb8LuOJMSzShnkGMAlfUHH1I/yYazH7topr/zBzDyjA==
X-Received: by 2002:ac8:4e84:: with SMTP id 4mr2735217qtp.296.1605286028669;
        Fri, 13 Nov 2020 08:47:08 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id j63sm7087761qke.67.2020.11.13.08.47.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Nov 2020 08:47:07 -0800 (PST)
Date:   Fri, 13 Nov 2020 11:47:05 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, jbastian@redhat.com,
        jeremy.linton@arm.com, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH v5] lscpu-arm: Add "BIOS Vendor ID" and "BIOS Model name"
 to show the SMBIOS information.
Message-ID: <20201113164705.oyzgzeczxle3vwc5@gabell>
References: <20201111012400.23995-1-msys.mizuma@gmail.com>
 <20201113095906.tjd5iee4xb6cd72d@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113095906.tjd5iee4xb6cd72d@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Nov 13, 2020 at 10:59:06AM +0100, Karel Zak wrote:
> On Tue, Nov 10, 2020 at 08:24:00PM -0500, Masayoshi Mizuma wrote:
> >  sys-utils/lscpu-arm.c | 22 ++++++++--------------
> >  sys-utils/lscpu.c     |  4 ++++
> >  sys-utils/lscpu.h     |  2 ++
> >  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> Ported to the new lscpu and merged. Thanks (and extra thanks for
> your patience :-).

Thank you so much!

> 
> I see one issue with the stuff from BIOS. It seems it reads the
> information always from the same place. How does it work if I have two
> different CPUs? I guess it always return the same model name, but what
> if I have Cortex-A53 and Cortex-A72 on the same board?

The first entry, /sys/firmware/dmi/entries/4-0/raw, is only used,
so lscpu will show the same information of the SMBIOS type4 from
the entry even if the system has two diffrent cpu models, like
Cortex-A53 and Cortex-A72.
I'm not familiar with the heterogenous SoC, probably each
CPU model has own SMBIOS type4, right? for example, /sys/firmware/dmi/entries/4-0/raw
is for Cortex-A53 and /sys/firmware/dmi/entries/4-1/raw is for Cortex-A72.

> 
> Maybe we should disable reading from BIOS on systems with more than
> one CPU type.

I agree with you.

Thanks,
Masa
