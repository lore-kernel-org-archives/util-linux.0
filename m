Return-Path: <SRS0=rU+A=32=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A9EC35247
	for <util-linux@archiver.kernel.org>; Thu,  6 Feb 2020 01:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1E420661
	for <util-linux@archiver.kernel.org>; Thu,  6 Feb 2020 01:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="TIh15src"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBFBXO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 5 Feb 2020 20:23:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42844 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBFBXO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 5 Feb 2020 20:23:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id e8so1612607plt.9
        for <util-linux@vger.kernel.org>; Wed, 05 Feb 2020 17:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ly7QMrJD1wFpzo1mwRrQopyY7s3GQDqh4mhC1DED/Eg=;
        b=TIh15srcO0BqciG+GcXhW40QmOZmQtMCXkxdH5QM9U1I26kFIC4uH8Txl6EcIQyDgh
         I4rSyPyPcbHr/DrwqjzdImc/LmM6/nVFQM56fJAILFxLNtka8fqk13RwpTkhSjKZwk1g
         U2+GZLVsvuPc7QQSdSVh1iW3vFlJ6IOU3Vei7bUCqSTYtrPXYRlx0GaU7osmcnSxgmIN
         q24HZjQVuvrFj9qvMclZYxvmXpbYlq5FNlJ8ypgX9StCbAKFCmFAYhLC2mvqPPifirS8
         lGj6EgSwCoAOVLuAfV82lTXY9vCgeHjZOXpvInS0nNxd5JgbrI+Jawe5GfyTAidzxSyJ
         OWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ly7QMrJD1wFpzo1mwRrQopyY7s3GQDqh4mhC1DED/Eg=;
        b=oW96OlbnIrpYkPi1pXl/DeCX1n4qXXZGhlHSaqjWLHhERLS29fYgu4uOb7+CyCKGjX
         Z2mvHi64P7SEJBXd8DLgJsuEkWmjd8jHZt61ZdjDdqE8cbC4FBGLmtgMW9uZl4Cui9iA
         dORy80eXRtEWHE8KGcZhMtRKfF5gFweLiHgYxF64as54da7ZfEP/rexPgCNJsGNwwosz
         tzlJWnDsY2V5ht8rOObTnvUgHKRq3nYYNYpYXV6oV0lbnWXqzF7/j1IBvBQiooifR7EX
         jfPVrfnzo5waEpKIuIGB0Dt7oRcDtZftodJt23vzNfl6OWLfW2igclV91l4/t9tdT5H0
         555w==
X-Gm-Message-State: APjAAAWMhTHTGiwGWw8hTQlB5HaiZpF3IaNnPAS65rmyJC021fCmidDH
        Ch6IohLj8yGguyTYMnbWM18XdIgAJ3Q=
X-Google-Smtp-Source: APXvYqyTb/votVOJkCJD/XsM3+UHJ07iLEehKYaxEg7ykn0jmSBBsnrc3EFX3noQKw1xoDNfO6WekQ==
X-Received: by 2002:a17:90b:11cd:: with SMTP id gv13mr1208556pjb.94.1580952191308;
        Wed, 05 Feb 2020 17:23:11 -0800 (PST)
Received: from [10.200.194.201] ([103.136.220.69])
        by smtp.gmail.com with ESMTPSA id y64sm985149pgb.25.2020.02.05.17.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 17:23:10 -0800 (PST)
Subject: Re: [Phishing Risk] [External] irqtop todo note
To:     Karel Zak <kzak@redhat.com>, kerolasa@gmail.com
Cc:     util-linux <util-linux@vger.kernel.org>
References: <CAG27Bk0x4LZJSb-0PXKR8VLTmoPiZdKBPtfB4N2HPnPjxbrSKQ@mail.gmail.com>
 <3e1bf9df-b530-738b-fc7f-00e4cf144420@bytedance.com>
 <20200106105256.3phh5bdgs4qgqzpp@10.255.255.10>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <69b8ca4c-aa39-0c8f-1c48-e9ef514f55d8@bytedance.com>
Date:   Thu, 6 Feb 2020 09:20:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200106105256.3phh5bdgs4qgqzpp@10.255.255.10>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 1/6/20 6:52 PM, Karel Zak wrote:
> On Sun, Jan 05, 2020 at 11:36:26AM +0800, zhenwei pi wrote:
>> On 1/4/20 6:20 PM, Sami Kerola wrote:
>>
>>> Hello,
>>>
>>> I notice irqtop to todo file, so I decided to look into that. Changes
>>> in my branch are nowhere near ready to be considered to upstream
>>> ready, so no pull request yet maybe sometime later January or early
>>> February. Meanwhile if someone else is working with the same I'm sure
>>> efforts can be combined.
>>>
>>> https://github.com/kerolasa/util-linux/commits/irqtop
>>>
>>> Things to fix with my work.
>>>
>>> * Save git history from https://github.com/pacepi/irqtop
>>> * Write proper commit messages
>>> * Use smartcolums
>>> * Change output header to include hostname and iso timestamp
>>> * Use signalfd to catch signals
>>> * Use timerfd  for periodic execution
>>> * Make main() shorter / simpler by moving bits and bobs to functions
>>> * And the things I don't know yet, but without doubt there will be some
>>>
>> Thanks for these works. Maybe it's ready to be merged into upstream.
>> Hey, Karel, how do you think about this?
> 
> Later, for v2.35 is too late ;-)
> 
>      Karel
> 

Hey, I notice that v2.35 has been released. How about continuing this work?

-- 
zhenwei pi
