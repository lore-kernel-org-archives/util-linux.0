Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BB0C433EF
	for <util-linux@archiver.kernel.org>; Mon,  6 Jun 2022 10:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiFFKtq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiFFKtp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2022 06:49:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199722B05
        for <util-linux@vger.kernel.org>; Mon,  6 Jun 2022 03:49:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r71so12633693pgr.0
        for <util-linux@vger.kernel.org>; Mon, 06 Jun 2022 03:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f3RufZDElZdFtpUwvub3VXkU1hKrVhZVrtnCfWj10ns=;
        b=yonJ0pBleOTMcCiIyQI6WplGq0rm3vLSsl+GdHntki///WsNi7OoxsYMwZAbTpe24O
         v5K+r8uZIk8p/YSJ6btFa8sMbtEW0MH6JZ2wjVeH1/wSpArG6GqTBPSKRKalRTWbYVr6
         gI2hqUOPsygyC3Sqy/ES6FB40It5L5OQ+I2O9+G65TrpQF5pOMW2/6UPwGnHp6zPH3dz
         22gddB3hKgiaBFnSxmcZM7PAjz/4nqBY5Fp/ZZk/EgkKoXkzO1gChXfcGUOS3JpT8leP
         vqeN8usYz/Hbq7lzxq+JTsu5h3c5Q1sOQm+0RFzSXmT6Q0wisOmrnhscWB/PCVjRQNav
         nVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f3RufZDElZdFtpUwvub3VXkU1hKrVhZVrtnCfWj10ns=;
        b=ebj+sApyqOAT5VrzL7RxYSCNY0O+U2qy3zRMPniSw1kGEThnEF2fownihda/um+v4s
         9iDOcna7SApAUrg3b7th0jKN+F966eTeYKUv8nK8GvAM5tfzjHArI1ZVnzYJ6WD60AHa
         +EyRg2QwevO3C8b1s0dgVOv1gQwm52Hg5ucfT349o47gwrd/dhT0kgy8GIZ6pMh9q8vT
         T6XCVsUWfKmusAMuUIZoKNkG3CJDpTJcvDiJuez21diDSCJSxYLS8VIU3thph0vXrNkC
         Z+IUjhRaE5fislnYzDj6Otg0LGBEosk8dCtQaTiP9incdyOCOJLK8ncFpOW+RyZukFRl
         oMbg==
X-Gm-Message-State: AOAM531w1PuohD0sIqO/SC5ZDyTp8h2HR892Fdvjp2ktLgd0g/2P+Ix/
        SxUvLtw3+qrHGhjeVVFLgekfG65TZ3BeLg==
X-Google-Smtp-Source: ABdhPJwYKLVfj2wcNRNLlThoCMCJb+GnycNqIjw6467FBXbDH9LPMYdki1QO1leaBnl71oCYZXVzIw==
X-Received: by 2002:a05:6a00:807:b0:51b:f4b5:db82 with SMTP id m7-20020a056a00080700b0051bf4b5db82mr11756599pfk.57.1654512583530;
        Mon, 06 Jun 2022 03:49:43 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id g12-20020a17090a708c00b001cd4989ff42sm9779127pjk.9.2022.06.06.03.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 03:49:42 -0700 (PDT)
Message-ID: <be42364e-5acb-d4cb-432b-66138dff7c81@bytedance.com>
Date:   Mon, 6 Jun 2022 18:45:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Re: [PATCH 4/5] lsblk: introduce 'MQ' column
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20220603122402.3274789-1-pizhenwei@bytedance.com>
 <20220603122402.3274789-5-pizhenwei@bytedance.com>
 <20220606104117.lbv4tify3qjvp2t3@ws.net.home>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220606104117.lbv4tify3qjvp2t3@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



On 6/6/22 18:41, Karel Zak wrote:
> On Fri, Jun 03, 2022 at 08:24:01PM +0800, zhenwei pi wrote:
>> +static void process_mq(struct lsblk_device *dev, char **str)
>> +{
>> +	DIR *dir;
>> +	struct dirent *d;
>> +	unsigned int queues = 0;
>> +
>> +	DBG(DEV, ul_debugobj(dev, "%s: process mq", dev->name));
>> +
>> +	dir = ul_path_opendir(dev->sysfs, "mq");
>> +	if (!dir) {
>> +		*str = xstrdup("1");
>> +		DBG(DEV, ul_debugobj(dev, "%s: no mq supported, use a single queue", dev->name));
>> +		return;
>> +	}
>> +
>> +	while ((d = xreaddir(dir))) {
>> +		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
>> +			continue;
> 
>   xreaddir() filters "." and "..".
> 
>   Anyway, there is a function ul_path_count_dirents() that does all the
>   work. I made the change in the code.
> 
>      Karel
> 

Hi, Karel

Thanks!

-- 
zhenwei pi
