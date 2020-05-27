Return-Path: <SRS0=vWqr=7J=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F339C433DF
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 15:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF5120873
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 15:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPiLDWlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390694AbgE0Pzh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 May 2020 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390280AbgE0PzE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 May 2020 11:55:04 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D4C05BD1E
        for <util-linux@vger.kernel.org>; Wed, 27 May 2020 08:55:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l6so22129450oic.9
        for <util-linux@vger.kernel.org>; Wed, 27 May 2020 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=67wAXadtqytnCFISdYGSKq/EPSIP7OxrxGht7eS4mgU=;
        b=KPiLDWlGf0oEtwXuhpRZoFK9FAOe7HtAVVd/v9ujm0DdYGJRVWnhIaP/kKLY9w+aET
         PExEg1qQiLtc4hCjOILpcLVccDJb9Cs7xM7qKo3+VmohqNb2E35nBGPb/Oxcl6E/Bvbw
         70XrPdp3w+KzsaclLTtwOlNl5Mw8S2raD1TTyZ5+5wMuh3F/x/6G799xWoxqq48ur4YP
         3VTpuxVlojRqEUqZzOiRLHSazzVv15ntv8VW04g54hm6thmpSQyLVfwXKXaxwq9UYM16
         psl5g0Guug5c/fAvmUWjY5eaL4AJ4TQ16eN5dtWl0rugOyE+Gp4XSAx03MO4gA+oDbUg
         c5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=67wAXadtqytnCFISdYGSKq/EPSIP7OxrxGht7eS4mgU=;
        b=ubgKNDTbp+UoLs5zzNX5dMK4Q+gSM48To6vWiDJWXl5o30nF60z6HBDapvr64+yK3w
         EIsVSmrmdp3VGxVtapOYcbA2CWdVbZaKrNiPmMJmsq9zeeHoEN5AMBeJKr6eMtNBWxEU
         KfW1iyg8QCB7dvpkwDq+fCqKkpI0GmZNKC4DeJeFSw+aXG06BAzw4ycS+qpJ9a3uExXS
         kthPWI6lQ3FJ5zhaYJ+48VJVqdE3QrnrojWzPkCeUT6Eq1T9S7mXK5kL+IX1+ZBNEXcz
         Vnqs9kz/X1+UAhHvRBpXMs+vn10b3lB/Xn1eMUqDKOSExTFWKA4/sKRsDSPJ5iztbRIi
         xWlw==
X-Gm-Message-State: AOAM533mMmmhvaNCyRsyxiEI0krNPR2CuYzYocq9Ko9i/5IWrJs38Dar
        zv0Jgh+U1KHe7B+gwXjDB1dZ8VSh
X-Google-Smtp-Source: ABdhPJwLgAO9OqNFzpDEQHJ+4jx196eA+ZGijNPJym1DnpUntgBIfY1SGUGk7ixWAQAxoO4OxJ2TgQ==
X-Received: by 2002:aca:1110:: with SMTP id 16mr3272482oir.98.1590594903506;
        Wed, 27 May 2020 08:55:03 -0700 (PDT)
Received: from [192.168.0.91] (cpe-70-123-227-116.satx.res.rr.com. [70.123.227.116])
        by smtp.gmail.com with ESMTPSA id 35sm848506otb.68.2020.05.27.08.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 08:55:02 -0700 (PDT)
Subject: Re: util-linux-2.35.2 test failures
To:     Karel Zak <kzak@redhat.com>
Cc:     Util-Linux <util-linux@vger.kernel.org>
References: <6b88784c-b130-27d4-2ec5-0d25320dd6fb@gmail.com>
 <20200527131154.p2rqxhcz6d56ik7m@ws.net.home>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <d8616084-1e16-abc2-d0d6-834073d96fca@gmail.com>
Date:   Wed, 27 May 2020 10:55:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200527131154.p2rqxhcz6d56ik7m@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 5/27/20 8:11 AM, Karel Zak wrote:
> On Tue, May 26, 2020 at 05:34:13PM -0500, Bruce Dubbs wrote:
>> I'm getting three test failures and hope I can get someone to help.
>>
>> The test failures are  ipcs/mk-rm-msg, ipcs/mk-rm-sem, and ipcs/mk-rm-shm.
>>
>> Concentrating on mk-rm-msg, I found on the system:
>>
>> ./tests/output/ipcs/mk-rm-msg
>> ./tests/ts/ipcs/mk-rm-msg
>> ./tests/expected/ipcs/mk-rm-msg
>>
>> The contents of the output and the expected files are identical:
>>
>> Message queue id: <was_number>
>> 1
>> Message queue id: <was_number>
>>
>> I am running the tests as a non-privileged user.
>>
>> If I run the commands:
>>
>> $ ipcmk -Q  (returns 24)
>> $ ipcs -q -i 24
>> $ ipcrm -q 24
>> $ echo $?
>> 0
>>
>> Everything looks OK.  Does anyone have an idea why this test (these tests)
>> are failing?
> 
> I had no time to play with it yet, but according to feedback from
> https://github.com/karelzak/util-linux/issues/1042 there is some kernel
> regression:
> 
>   The ipcs tests are failing due to a regression in kernels 5.6.8
>   through 5.6.13. Or mainline commits between
>   89163f93c6f969da5811af5377cc10173583123b and
>   5e698222c70257d13ae0816720dde57c56f81e15 (apparently including your
>   5.7.0-rc0).

Thanks.  I'll try 5.6.14 and report back.

   -- Bruce

