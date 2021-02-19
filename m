Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CB0C433E0
	for <util-linux@archiver.kernel.org>; Fri, 19 Feb 2021 17:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE8464E60
	for <util-linux@archiver.kernel.org>; Fri, 19 Feb 2021 17:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBSRM5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBSRM4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 19 Feb 2021 12:12:56 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DDCC061786
        for <util-linux@vger.kernel.org>; Fri, 19 Feb 2021 09:12:16 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q186so6485397oig.12
        for <util-linux@vger.kernel.org>; Fri, 19 Feb 2021 09:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VQw6kge8atAoQdKkiEv9Iva57R8ohqJS6e+lKCWChAQ=;
        b=jO8/eOiMuwILOA0yJWBtoxc2oDaNtMQGOErAKdwEocbqTzYkNsKNVL/g8htUMj3efd
         FyNChcqxWKP8NOp2hHDjmaARlnu1X4Hvnce0ASmwjFnplrzmBGdnE9xZ4z1cCFtHHdcd
         Qi9DjGZ4rU6BXrs8unXg37bRVm0Wb/8Yzrzibg9JlP+wFNtLpwjkOZP78Pf/pwGSyVcv
         7nPOTMZXM6PnvtjowW1P4iYWDO4Q5Gn65U0WBsKc/odGU2Ym35gdR3LBASCU+dcAUlw/
         YRHabR1sqId9Kr2lmAjin9rtm5z0qQZEaEMbnjOACB39pP2K5A2MwJPeFOpCEkYoVWrY
         krNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VQw6kge8atAoQdKkiEv9Iva57R8ohqJS6e+lKCWChAQ=;
        b=SuZmZ/ZxFxVFQsuv6nS759eAYXGxxMVSU3uFpITii2by0ItiNgXrTbQohr7c5jxtlk
         SZ81n8mPyGHdKXmCj98ANNp5zqZHEQqBY6RlXXzvkBX6gIyPPrGsiODFtqvoqxYlmXis
         AyjdrRer1Wn7JdYEVkMEQeEWGvojuVgzx69vKv7NdvGF4kLL1cxxQrfP9As4Zeh+KgXL
         tDSVfhY1ExnjIJ1PMNnkboE0FtXFyvvKbr7qzfyV6d6XZ6ZC59MuF2d/O4ppWtAfy4L+
         M8AM/ZJNVCoSjQ+eFun9kTy+Z1LzyMh5KHoLbNkEx0hKyu3H5JDe9lVOLM6dBu8hvgnS
         rnfQ==
X-Gm-Message-State: AOAM531gB91KNJwa8QjXF2w1MOETpbWY1tGpTjB4JNDYu0Z6ypPlla/0
        888O9T5X+IqMz0oDFpVy04fp6rvalyo=
X-Google-Smtp-Source: ABdhPJx0nXL2X+92A1z0FjbBD0Wp9VreiKmh/hHAF/rnqxlU9B9JLEopxfnvk8Lvieru+P3eb+Cysg==
X-Received: by 2002:aca:1003:: with SMTP id 3mr7068826oiq.22.1613754735656;
        Fri, 19 Feb 2021 09:12:15 -0800 (PST)
Received: from [192.168.0.91] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id a25sm333636oos.6.2021.02.19.09.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 09:12:14 -0800 (PST)
Subject: Re: Suggested changes to util-linux for FHS compliance.
To:     Karel Zak <kzak@redhat.com>
Cc:     Util-Linux <util-linux@vger.kernel.org>
References: <cc08c08e-81d9-f3c7-ce8b-43a27bfe1c72@gmail.com>
 <20210215091625.jzaf6ephntdwmi5w@ws.net.home>
 <f8d10b77-79d9-6a62-50a4-5fb2d1d45655@gmail.com>
 <20210219111427.35z43zib4jn5irkr@ws.net.home>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <b936be7a-15e8-575d-fb9b-8f57ad82803d@gmail.com>
Date:   Fri, 19 Feb 2021 11:12:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210219111427.35z43zib4jn5irkr@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2/19/21 5:14 AM, Karel Zak wrote:
> On Thu, Feb 18, 2021 at 09:37:21AM -0600, Bruce Dubbs wrote:
>> Perhaps another solution would be to make the default for localstatedir be
>> /var instead of PREFIX/var.
> 
> Ah, I see what do you mean.
> 
> We do not alter $localstatedir in the configure script at all. This is is
> probably the problem you see. For the other directories we default to /bin,
> /lib, ... when the default prefix (NONE or /usr) detected.
> 
> It seems $localstatedir and $sysconfdir need our care too.
> 
> I have committed:
>   
>    https://github.com/karelzak/util-linux/commit/3d2899651791bcb4ee8fe4e605acc83f3ae3471b
> 
> Please, try it. The final summary from ./configure should be also
> more verbose about the paths now.

Thanks Karel.  Works for us.

   -- Bruce

