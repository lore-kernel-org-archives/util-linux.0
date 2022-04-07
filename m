Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164E6C433EF
	for <util-linux@archiver.kernel.org>; Thu,  7 Apr 2022 03:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiDGD5I (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Apr 2022 23:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiDGD5H (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2022 23:57:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16535F5C
        for <util-linux@vger.kernel.org>; Wed,  6 Apr 2022 20:55:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q12so711254pla.9
        for <util-linux@vger.kernel.org>; Wed, 06 Apr 2022 20:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zkTlQM3IZZ3dNYHRqE1/KR72nqR7wkHt0l+mIqj1e30=;
        b=R1XkPtwoCE48WuIbsWLucIYfpXIw0ItVYK8IRYHpY7eyLssDuI9zmVo78/wS1pGiPe
         xm1MHWooNHw6qrdKe8dSfYkaiUJaLyr803A28ogrB9rZs20RZL+0jQk2A49Oak8cDQyl
         vcPAhAI3NCdjvNCPs7tE0vtRprVWV2yvSd/tih9ZA1dU7OCJmfZ4Vx4kVcogbGGUuK0o
         X0OeB3NsvBBN5wtzrh4YEkU+XAZYxYi/GwsmKTjofP5npL+Ffy9yts36CPCtJKRXvNV/
         Lb2B5QPHBW9UkqCPD1ldhFrzcEMTvN7OmSVdzh9SkpsfrSV38toBeA7VOjSUkex7JA/q
         d2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zkTlQM3IZZ3dNYHRqE1/KR72nqR7wkHt0l+mIqj1e30=;
        b=2wf2qtK7mGfcN0xmp0iiyfzJ6Dv7ud5UXYm2XHfPvSOb7u4nVySN/E5uT2iQyB+fBO
         wDeNyhExzLenvhnEiB7ndWvCUvtjV3ULmaKUdYrJXfGfqEFXQ4bAuleAtNcYC++lEhUw
         Js/2wZMlIzCnccDsibr8YB3RT5AWpYP5NkSg3LhZfVsn8v/uOq99y8yTV/ja+nAq2fYt
         rGwIFTCllZnSqwHvDq05tXlH+JRT2AMZ5TXqOi97ZuJR2Rbw0PjH1pINXO9vQ/eTXbR2
         1BQSj2XwG0o9DVmbhRAJ0DAVUo+Ho5Ej1YN8NV2QPl6FbwBRA2PNO9itSeSRNtCnA0Ws
         wx1w==
X-Gm-Message-State: AOAM533dC3Dcm6R9eFsCTorkD67d/R9prtPUlIzoCh07z9u/si+Kzoxz
        AZ+DWZBbW+7fmQvxQwCG4oPRgyx1AyX4bw==
X-Google-Smtp-Source: ABdhPJw6beqE8BaW/H/g2B9/tFgGaLwtHke0WK5iEVpGUkZ2hlpHxdFcJROGhpbYBK9tWAgFNnhT3g==
X-Received: by 2002:a17:90b:87:b0:1ca:a84b:37e with SMTP id bb7-20020a17090b008700b001caa84b037emr13616040pjb.168.1649303707595;
        Wed, 06 Apr 2022 20:55:07 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78503000000b00504e93ef182sm895157pfn.31.2022.04.06.20.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 20:55:06 -0700 (PDT)
Message-ID: <241683e8-90bd-50c4-0010-07b887ba20dc@bytedance.com>
Date:   Thu, 7 Apr 2022 11:51:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Re: [PATCH] blkpr: add block persistent reservations command
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, util-linux@vger.kernel.org
References: <20210916032901.2189336-1-pizhenwei@bytedance.com>
 <YkvsUl9ZZOC7j70X@infradead.org>
 <f9e3fb29-a4ee-06a8-238f-ef1caade0234@bytedance.com>
 <20220406085521.nbytfauspc6kgofd@ws.net.home>
 <20220406102707.vzwcndfueoo64aza@ws.net.home>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220406102707.vzwcndfueoo64aza@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 4/6/22 18:27, Karel Zak wrote:
> On Wed, Apr 06, 2022 at 10:55:24AM +0200, Karel Zak wrote:
>> At first glance it seems like something I can merge.
> 
> Merged. I did some minor changes to the code and man-page.
> 
> It would be nice to have some short description for the operations and
> the types. Something what we can use in --help output.
> 
>    register, reserve, release, preempt, preempt-abort, and clear
> 
>    write-exclusive, exclusive-access, write-exclusive-reg-only, exclusive-access-reg-only, write-exclusive-all-regs, and exclusive-access-all-regs
> 
> I'm not sure if for example "preempt" or "write-exclusive-reg-only" is
> obvious enough for end-users.
> 
> The next question, what about to rename --operation to --command?  The
> man-page describes blkpr as "run persistent reservations command on a
> device".
> 
>   Karel
> 
Thanks! Rename 'operation' to 'command', also add description for 
arguments in another two patches.

-- 
zhenwei pi
