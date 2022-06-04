Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED50C433EF
	for <util-linux@archiver.kernel.org>; Sat,  4 Jun 2022 08:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiFDIQt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 4 Jun 2022 04:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiFDIQs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 4 Jun 2022 04:16:48 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFECB7EF
        for <util-linux@vger.kernel.org>; Sat,  4 Jun 2022 01:16:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id m82so13202192oif.13
        for <util-linux@vger.kernel.org>; Sat, 04 Jun 2022 01:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEb58moKsZYZ0FPf7KyRNo3e8C+OCi2iBzFqpgIQFOw=;
        b=pr/49LsXBTDPGcc9wEWnGdHuwe01aPIu7Y08dUU5n4JU1pM7sB/fKbYUFwLGwHTW1x
         EVzSumxPGypgUkAQUkjJnRRdBlv6KfbH0T9c9N75wZEZZtl96pRG2RkTSkd3X135+ntx
         xYKaqs/Oy402hzPC6LRXWuaCp92uwu723Qryj9PA3QkQUDqbsw67zE6dyN+OTmnlqQKk
         fRpRj6bEsi52Pjx/BgoieUhRGl152e9vvNQaCjopNjKUv2yT0/9W/DDsoXQvLGC+B4jS
         PBofN+nyeOXo1z5p72XoztMIWWAjgHJRaIu6FE3kOaKD9brCPlrM4huwZReNJZ/Unb90
         2RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEb58moKsZYZ0FPf7KyRNo3e8C+OCi2iBzFqpgIQFOw=;
        b=5wsAhjPv5qDL+W1Wf67/f1T2iDzVUUax9ifSxmvq2drj0vtZ84DZTSCy3022RBpaiU
         tQ0W6NPI3+/kRR/NtPUE3476XuTyENBSa9nIlHFJPxAiSJIMQyzmkpHofpmNuG9kz/gJ
         F2gtz5lpnWxMRTLLYW76wQorCBkNj5NdPJQT/3YlVhoN8sAtHt4O2d9QxUugWAT5iBOu
         BVUwWdnusM8r2Is2rm8L15foFyF0fvBBBucykWlBZoKc0+6lcUx1TwzGT/5+q3cU56oe
         Uk7Az6m1zLToiYnVTMEEeGrSRnybG7+c3w2tZ+R9tVcVktA8Sfl6+4HGYP11krLdN7Kp
         zNXQ==
X-Gm-Message-State: AOAM5300FUK8/ey5itb2IxD0VDAXsERoJ1PZH4rfPQoouEm3Pwtqt1tY
        S/6jMr3dd0OTyXoBEpTduThsDTN/w+YYKPgANIA=
X-Google-Smtp-Source: ABdhPJwEUR49DfEja7oAiIk4VI/+bbkrXtNue2OWWYWsTkrN+lbj6Q8X48MyiN9TXwQHJbfvSbhDXw+kTKxsDCfymqs=
X-Received: by 2002:a05:6808:2002:b0:32b:50ab:431f with SMTP id
 q2-20020a056808200200b0032b50ab431fmr8056252oiw.120.1654330607278; Sat, 04
 Jun 2022 01:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqzipCFaFFAs-o=FDA_g=9NmrqzieXaYtWwbGCCXDeiM5g@mail.gmail.com>
 <SN6PR04MB39834AB02ACBCA91B949F821C2A09@SN6PR04MB3983.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB39834AB02ACBCA91B949F821C2A09@SN6PR04MB3983.namprd04.prod.outlook.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sat, 4 Jun 2022 11:16:41 +0300
Message-ID: <CADxRZqwX5xvsh4Se_fJuA72NEt-Ou_N-aevPTFQc41y_bxs32g@mail.gmail.com>
Subject: Re: [PATCH] pipesz: use native PAGE_SIZE in tests
To:     Nathan Sharp <nwsharp@live.com>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jun 4, 2022 at 5:00 AM Nathan Sharp <nwsharp@live.com> wrote:
>
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Nathan Sharp <nwsharp@live.com>
> ---
>  tests/expected/misc/pipesz-get-fd   |  2 +-
>  tests/expected/misc/pipesz-get-file |  2 +-
>  tests/ts/misc/pipesz                | 10 ++++++++--
>  3 files changed, 10 insertions(+), 4 deletions(-)


Thanks. This one fixes the issue.
(tested on both sparc64 and powerpc64)
