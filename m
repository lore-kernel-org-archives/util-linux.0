Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB15EC48BE6
	for <util-linux@archiver.kernel.org>; Wed, 16 Jun 2021 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B018C6128C
	for <util-linux@archiver.kernel.org>; Wed, 16 Jun 2021 20:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhFPUoN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 16 Jun 2021 16:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhFPUoN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 16 Jun 2021 16:44:13 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17DEC061574
        for <util-linux@vger.kernel.org>; Wed, 16 Jun 2021 13:42:06 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id d19so3917380oic.7
        for <util-linux@vger.kernel.org>; Wed, 16 Jun 2021 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mPWy7jnzKVja56TsTd2K7ginmgXdWlSPmLdQ5LqiKJE=;
        b=HiSQ9hOZ/f43SUxC5u9+f6Grbv6MHywRcR2t6TdcwNYnDDolx9cTAAyNLjNbhEDwvx
         8W8XLPXsWqdzb1Px5vbh0R+qpQoEtqLuyPN7UMwsbDcJ92gnf+CCq0G3hnFJM5Vzx6SD
         O58OZWw+PXYB9lDv4RiV28bOgryxbSOci9JPk9GJ3OX9Vf/7viGLFZoQHRD5/SbxTD5i
         gw051CwXFQVWp8egOvhpfy2EgLFZ0AKdIw6MuvzHHnO5uSiC1hFPYHwyXeEYgNnynVgh
         5YSmM+RxVwr44X2yhuBX+8fO3S6F6hSXpllf0Ga76BOKSoZhn7yS5uC4mxjy0QDhVmNK
         4Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mPWy7jnzKVja56TsTd2K7ginmgXdWlSPmLdQ5LqiKJE=;
        b=aGm/ho/pjNPj/XyVIWHTauNqFs//BMB+Tnlayz6mjLbrsP9Xn7tpp2sZMeHwRNKtwn
         YNMUjSVQmEJu2P8XnqwIJ+3jDFnOYQKEm4S8T1fm0QTzFfZNy/wV1mflTBCLLYS6/2DU
         yETzLjglOFISTIgy9uo5l7FlUxHZqUyTbCZ8WwYZSGMy6+tpqfZhSckevdN4yoP8Bukj
         g3oVmP18ujPzY5BGrgoGgs1XvqjGzlhzzf1XuctsUVX1uqU1Xkn+cqcOSv9aZ5HWMrx5
         wfmxVIpwyS4Vj3p9n2c0fE5+Gf3SrlcG+Wkgd+UhQr6fPBGKUwbRycIZup85liefgD89
         L63Q==
X-Gm-Message-State: AOAM5335HIGv4KNYtnilKW7kutQp2G/s28iBhBBFgUAsrB5q/swEFZTA
        neqJu9icLOKapRW1ybukrDx4gtZO9VA=
X-Google-Smtp-Source: ABdhPJy1r5ExaYXlYXMXR9M5pB52P2lpVJyBlbRkJG7Haks3Y7U5buRZ9uvcekfd1edTUBcETydMzA==
X-Received: by 2002:a05:6808:10a:: with SMTP id b10mr8006999oie.65.1623876126080;
        Wed, 16 Jun 2021 13:42:06 -0700 (PDT)
Received: from [192.168.0.92] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id t39sm697881ooi.42.2021.06.16.13.42.05
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 13:42:05 -0700 (PDT)
To:     util-linux@vger.kernel.org
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: An obscure problem with v2.37 make check
Message-ID: <cdfa712c-c918-c5bd-e320-b3dbe8599bbd@gmail.com>
Date:   Wed, 16 Jun 2021 15:42:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

When I built version v2.37, make check hung on me.  The problem was in 
my kernel configuration, but I thought I would pass this on.

First of all, my biggest problem was finding out what had failed.  A 
simple 'make check' ran the tests and when it got to the end, hung.

I could not find any documentation about running the tests, but diving 
into the Makefile led me to tests/run.sh.  By default this runs tests 
using all cores, but it is unclear if this is meant to be run directly.

In any case running run.sh --parallel=1 (instead of the default 24) 
allowed me to find the problem test, tests/ts/lsns/ioctl_ns.  In this 
test, it is doing:

my_userns=$(stat -c %i -L /proc/self/ns/user)

My problem was that /proc/self/ns/user did not exist on my system.  This 
was due to a missing CONFIG option in my kernel configuration.  Adding 
that and rebuilding the kernel allowed all tests to pass.

One solution to this problem may be to test for the existence of the 
file before running 'stat' similar to the tests for programs like 
'touch' and 'uniq'.  Since this is such an unusual situation, I can 
understand if you just ignore the issue, however I thought you should 
know about it.

   -- Bruce
