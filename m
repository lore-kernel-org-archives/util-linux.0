Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5A6C432BE
	for <util-linux@archiver.kernel.org>; Wed, 28 Jul 2021 12:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1200B60FA0
	for <util-linux@archiver.kernel.org>; Wed, 28 Jul 2021 12:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhG1M5E (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 28 Jul 2021 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhG1M5E (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 28 Jul 2021 08:57:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD04C061757;
        Wed, 28 Jul 2021 05:57:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jg2so4529973ejc.0;
        Wed, 28 Jul 2021 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Vouenykjxz8Zfu34+Mskh/eN5cURwPsT1oXHL6ep3V8=;
        b=cK1Gmgnuuw+nCYVW5Q13zVB3UJH26y520BJmLBSjJch2u7mVCKg7iAUUIzOH6vo45W
         jl1mvzzJopmYSuYrMpoP7KDZQCgXPRIGYTVrf+FdDHBFE31zzB0m4ld/9/ic/KdgkUDN
         W26ZXaxldpUiBqJGBILkh0CY6riJbxAt+9UVgnwITqRmsuKEo5b29hZ5Eqx0lpbnpI5z
         HyxQD3mtqN9KCp3nGcfPydMszaVDneoDugclGjoje3N+9pK8IKCNQf4kN/gGwwp/6btT
         d+swF+pJsThSEWg4aZK0aMG+d5KVfv+RGYt24ye7kTRrqt33VMEL+d/9IG+DGgFAPPDs
         mRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Vouenykjxz8Zfu34+Mskh/eN5cURwPsT1oXHL6ep3V8=;
        b=N4ZwjgWCxB3Sripvheo9DBocOy1zTg2xXBi1bwDTGihJaPRmqj/keouFOZhaS8wDBh
         lpD71sc2Go+hK0lPKFD8kb2mWbaD7yB1zyB2x84hFIABiHW4b8XRESkRboeiRPFdyGo5
         vLU5TdGr0L2VuIL1VDDwI+7BWneMVOA58TDGk5iF+cWOSkq2jaGAteczdJH5NoB/oHuq
         OaYh4EhlgnDWR5hn1qZfkzbFW8vwAFrGEEGnm72PndwcI/nP1YQvWmMqlbX/X4VyPcue
         MyaW3y9alf6r6XnR7h0GaclchTBkrY1wk2PD2VMlGPYS9iwqXNh7yCEplQd05qPkWwZK
         wqfQ==
X-Gm-Message-State: AOAM533BfuQxuMzo3xn9B99qfNjkprDXSoC88im1GIy3oiuQvbUdRbAE
        8hN329tbGRLGypVHCn/yg7uUeJKswjHh93rjNhxCTkHrQ83FS7rc
X-Google-Smtp-Source: ABdhPJz3FrSZmkzpnRE0eweT0CjV0FaXvot2P16xijB/LDqXaEAxrMDD1HeHE6NiCthFMxQc9mp1lLA3nf9VYoXYTY0=
X-Received: by 2002:a17:906:6011:: with SMTP id o17mr26316325ejj.157.1627477021019;
 Wed, 28 Jul 2021 05:57:01 -0700 (PDT)
MIME-Version: 1.0
From:   Shivank Garg <shivankgarg98@gmail.com>
Date:   Wed, 28 Jul 2021 18:26:44 +0530
Message-ID: <CAOVCmzEJqg6=FW3Vu1MScyj8GS-KXb2s_ztxBxwDmcbN5sbQuA@mail.gmail.com>
Subject: /proc/pid/sched units
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Everyone,

I'm analyzing the cpu time taken ("se.sum_exec_runtime" in
/proc/$pid/sched) by process in different configurations for my
project work. But I was not able to get the time units for the values
displayed in the file. I tried searching it in source code -
kernel/sched/cputime.c,include/linux/sched.h etc. but it left me more
confused.

Can you please answer me about the measurement units (is it
microseconds, nanoseconds, jiffles ...) ?

Also, I was not able to find proper documentation for /proc/pid/sched.
Please point to me if it's already there. If not, I would love to
contribute toward documenting these variables. It would be very
helpful for newbies (like me) in future.

Thanks,
Best Regards,
Shivank Garg
