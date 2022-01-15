Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F5FC433F5
	for <util-linux@archiver.kernel.org>; Sat, 15 Jan 2022 00:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiAOAxV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiAOAxV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 14 Jan 2022 19:53:21 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DF7C061574
        for <util-linux@vger.kernel.org>; Fri, 14 Jan 2022 16:53:20 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id o135so1733706qke.8
        for <util-linux@vger.kernel.org>; Fri, 14 Jan 2022 16:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fUubjDhnf2NWmFYV4t/a6GBZpxOwThvNUF2SbzJD9Zo=;
        b=pOF7TwHrUb/zHKRXimL4IHRUpZAoT+Wf/hhhZvZtrHmGJQhkgX2U4Z8yF9qLSQCa6+
         +79M8aHD/q65UDecvieUbRTnW+aT50FWRc+yon3xhbgPReLLu/I6UM7bouYA5t15HM/H
         Ffv8E+988IEBanmmpAy2L6hCkQGn3hsLTYImAcEuaqeu46BmhKOwQXVNQgEwR5KWEkc8
         o5J1tFrGZzDhr/+yreQ1othBTDj9mlZzLnJxIQ0p1hpZiPWocQ2en8+sFand/0zqUCuq
         LgxTuy0heCv59/XDNv3JJRJGeSnYY1Jw9E2Bs+s0AlgxBtJ7sQzcQ5oQbr/vpdlmHk50
         fnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fUubjDhnf2NWmFYV4t/a6GBZpxOwThvNUF2SbzJD9Zo=;
        b=EyeunKCGc8aOow51sGufkUsAzZbj+l8DBZsd67O51nC16N3bvX/SZ9j1XVEd26k8+4
         TM+c5hpOPecmIcVro6KRar6w9mBExsgu7Ka/T4+btBzEIZgNhRUDhdNQ6Ydd+plwzJ/v
         OkPisLJ38LuOodI2CE7UkJjLgy0zJmMo/vcdk50dnxUjX7Kxo4FyUTgE17421I2+BVf/
         b0iiG9bB9YPKP6uubx3k4i91/SjvS03BdP13v84UzLQcf3LUDbDWM82IvOw9CW8R4ol3
         +58s5N/cwcr7IOF3dW1b0q/FtfEuTmtdt7xxUIUw/s5/2MQRDrqS1uqwwaLhgbL0Ctg6
         Q1MQ==
X-Gm-Message-State: AOAM531ICTuOgRO+HBq8f5oYCoTlMu3tnXKCpuAuCTT2O+xThI4wGCeb
        RsocC2mQQKd7+wb3qs/cUNC8CwK24wE=
X-Google-Smtp-Source: ABdhPJzpxy4Ck9+XqQhuKo2Rgk2QsWqHTD9WByyyZDQaYcFmeiFOMy1IeV5vxRNRQ1pGgiHg20NHow==
X-Received: by 2002:a37:5305:: with SMTP id h5mr2269059qkb.117.1642207999599;
        Fri, 14 Jan 2022 16:53:19 -0800 (PST)
Received: from [192.168.1.201] (pool-108-18-137-133.washdc.fios.verizon.net. [108.18.137.133])
        by smtp.googlemail.com with ESMTPSA id x10sm4969554qtw.60.2022.01.14.16.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 16:53:19 -0800 (PST)
Subject: Re: [PATCH v2 0/6] unshare: Add support for mapping ranges of
 user/group IDs
To:     Daniel Gerber <dg@atufi.org>
Cc:     dottedmag@dottedmag.net, id@mbekkema.name, jpeach@apache.org,
        kzak@redhat.com, util-linux@vger.kernel.org
References: <874k664nlq.fsf@atufi.org>
 <73850170-db69-7d64-ca9e-6e41dfa4eab9@gmail.com> <87zgny2q8c.fsf@atufi.org>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <c72b75e6-4bee-c9c3-9087-3c6cbd48afc7@gmail.com>
Date:   Fri, 14 Jan 2022 19:53:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87zgny2q8c.fsf@atufi.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 1/14/22 12:15 PM, Daniel Gerber wrote:
> 
> 2022-01-14, Sean Anderson:
>> It's stack garbage. Try
>>
>> diff --git i/sys-utils/unshare.c w/sys-utils/unshare.c
>> index 3cdd90329..5ac7af3de 100644
>> --- i/sys-utils/unshare.c
>> +++ w/sys-utils/unshare.c
>> @@ -385,10 +385,10 @@ struct map_range {
>>    */
>>   static int uint_to_id(const char *name, size_t sz)
>>   {
>> -       char buf[UID_BUFSIZ];
>> +       char buf[UID_BUFSIZ] = {0};
>>   -       mem2strcpy(buf, name, sz, sizeof(buf));
>> -       return strtoul_or_err(name, _("could not parse ID"));
>> +       memcpy(buf, name, min(sz, sizeof(buf) - 1));
>> +       return strtoul_or_err(buf, _("could not parse ID"));
>>   }
>>     /**
> 
> That works, thanks.

OK, I will submit it.

> 
>>> Also, I would suggest adopting the same argument order as in /proc/<pid>/uid_map and newuidmap -- inner,outer,count.
> 
>> I think this is a rather silly order. Since this is a mapping, the "natural" order is
> 
>> outer -> inner
> 
>> and only from the new namespace's PoV is it
> 
>> inner -> outer
> 
>> It certainly helped me remember things once I reversed the order...
> 
> All right, this may make some sense to me now. To the user discovering these tools though (me yesterday) the worst is missing one "standard" notation...

Yeah, I'm not terribly happy about it. That's why I added an "auto" feature, so you wouldn't have to remember the order.

>>> This doc string has it reversed:
> 
>> As noted above, this is intended.
> 
>>>    * struct map_range - A range of IDs to map
>>>    * @outer: First ID inside the namespace
>>>    * @inner: First ID outside the namespace
> 
> I mean "@outer: First ID inside ..." surely is a typo, isn't it?

Yes, you're right.

--Sean
