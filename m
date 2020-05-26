Return-Path: <SRS0=W0VW=7I=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7831CC433DF
	for <util-linux@archiver.kernel.org>; Tue, 26 May 2020 22:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4987320899
	for <util-linux@archiver.kernel.org>; Tue, 26 May 2020 22:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMtdleh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390254AbgEZWeR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 26 May 2020 18:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389755AbgEZWeQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 26 May 2020 18:34:16 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0EFC061A0F
        for <util-linux@vger.kernel.org>; Tue, 26 May 2020 15:34:15 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id d191so20064142oib.12
        for <util-linux@vger.kernel.org>; Tue, 26 May 2020 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/FO8YT8LUXLC0MoU2dkskYq/rLf5NUiYtUTSWr4q/A8=;
        b=iMtdleh39OwbKPXyfpesms8BEvLsqsWglnNOXjTd3lGILBloUZLUvRgzsBdnb26qOh
         MLvBc9I67r98WpGWDK5sDUE+BZay6pjLDXS+xr7QWjETqaq8oaoPQ7p+Uh0e56yv3xr9
         +gyTe+V11v3MHBwcG0rXigNTkdVopFVt5eDZf6tDysjSx5eGgPhIJrsqrWKrb19ca/AW
         fGBpZMt/Gh40k4MWWLdtW2tqEwS4xp2BjC4FjV7gFOXaR3Zl0AB3544ZCEJNVPrNW7vw
         OgujoHEvvGoJw9IVR9EGvXrCF+mJcfLE7lYMqDH5VeeBliRtcRwQNS2BzvFGhQL8JAuN
         xHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/FO8YT8LUXLC0MoU2dkskYq/rLf5NUiYtUTSWr4q/A8=;
        b=ESAQoRIkdCroZYU6v8lgV6qNbA5gSMOEokl5wDJ65dTPKjX3+/7hPvRQtNQ7vx3ah1
         qeHIiAZpsbFX3859IQyk1dprgvyKW1pZOVEB47jP/mp5F6FrWSFQtBF8mGfwzSip4fAW
         lOJAzLcDtjBDBtXBynS5Y1rJN37WnK0vzlAavhQSl4/poU77hc6rkiVGxmrrWr/NIvqa
         PR3N/0tMNXXzFdXeaNFXpEFJTfl2CfQyo4ujC4JYVOavEwr/3wFUXbJbvVUg2KG/g/+b
         viuiwZ3pIg0nFn6j5u2iwR6jytAQcCPtynRlJniAQahBODrtBqJXMx5XpzN9UlGnuTuv
         nVIw==
X-Gm-Message-State: AOAM530dq+cieE6OGCB0MYctWELJ5eSSdutwlFloX3ctNgOJ5/++JAni
        6Vjo098iXgxRnEvNLw0VPeZLLWYY
X-Google-Smtp-Source: ABdhPJxQQkHb4mQw2pbpnPgmTForkYK9OUeidW7nAGYsm/bHFLliyhc//SmalqWky30dcGfnob8/aw==
X-Received: by 2002:aca:eb56:: with SMTP id j83mr823071oih.110.1590532455103;
        Tue, 26 May 2020 15:34:15 -0700 (PDT)
Received: from [192.168.0.91] (cpe-70-123-227-116.satx.res.rr.com. [70.123.227.116])
        by smtp.gmail.com with ESMTPSA id x79sm322933oia.24.2020.05.26.15.34.14
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 15:34:14 -0700 (PDT)
To:     Util-Linux <util-linux@vger.kernel.org>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: util-linux-2.35.2 test failures
Message-ID: <6b88784c-b130-27d4-2ec5-0d25320dd6fb@gmail.com>
Date:   Tue, 26 May 2020 17:34:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

I'm getting three test failures and hope I can get someone to help.

The test failures are  ipcs/mk-rm-msg, ipcs/mk-rm-sem, and ipcs/mk-rm-shm.

Concentrating on mk-rm-msg, I found on the system:

./tests/output/ipcs/mk-rm-msg
./tests/ts/ipcs/mk-rm-msg
./tests/expected/ipcs/mk-rm-msg

The contents of the output and the expected files are identical:

Message queue id: <was_number>
1
Message queue id: <was_number>

I am running the tests as a non-privileged user.

If I run the commands:

$ ipcmk -Q  (returns 24)
$ ipcs -q -i 24
$ ipcrm -q 24
$ echo $?
0

Everything looks OK.  Does anyone have an idea why this test (these 
tests) are failing?

   -- Bruce Dubbs
      LFS
