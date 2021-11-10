Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B41C433EF
	for <util-linux@archiver.kernel.org>; Wed, 10 Nov 2021 10:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8A961246
	for <util-linux@archiver.kernel.org>; Wed, 10 Nov 2021 10:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhKJK3S (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Nov 2021 05:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhKJK3S (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Nov 2021 05:29:18 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05013C061764
        for <util-linux@vger.kernel.org>; Wed, 10 Nov 2021 02:26:31 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v23so1187504pjr.5
        for <util-linux@vger.kernel.org>; Wed, 10 Nov 2021 02:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+Uoqvose24IDsa4wZteVQ4Sw0ibtJUqFTVulzrfU7Y=;
        b=iHCtn29xTr6hrdcOvzJ2m+O58N31LarLlH7XhP6cFtTikn5/lAMAaJLN28BqcRvpum
         jxf/b5+pEvOUXYTexRSw4cxbLfh4KzjlhMrCkCzL3uG70aCpzXFGePZSZlP86xe64J88
         MbFCWAWCYSiKm37wgoVlwGfNQ0dOrdPeRTW4fmNrgeZ3JwpFdbH5hsJpSrHwcWG+NVfa
         8yyBThOkSJrUt5yhA45gQmmM99Wd9pSOJjpW34ILBARsvuh5XBmj+eK1re4WOS6ojypr
         NbIyZioVsXHqDzQJYuAGAqhsXkhRRz/aMRTZIUIQKdIXiYo1iJWLEmz5Ysm9nbGR8M54
         coGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+Uoqvose24IDsa4wZteVQ4Sw0ibtJUqFTVulzrfU7Y=;
        b=DlMZn18IhYlDeES0KdKgvEIOHz6ubobjFPPYGFKchZAB+hrNU6Fjrd7AJaa49xJus/
         tVKVKacZBuszq6k2uvesV7h7r5nrbNk6xRj5ULYkykGWMOtIHWlrE1iESXjJfZNs4ihi
         uC1ZJpCPH64phwzOp32BcXvd6+WXgjktQaKEIFYr691ViugRk0Ig4DUeejj7ERI7Z0RN
         QF0qGYq00V2WgYPfV/369KTaKd2kjvYAy/OU+uGzqnterm2G9u4ucJq7t/uZt4cXJiFe
         wtcm+7fFSEBPHQJVJTQ1wIa9xj87Vmhe8gqctrEWUUMM0Gct9zUta/+6BJt6v6d0Wu3w
         R4BQ==
X-Gm-Message-State: AOAM533wT9fIMPH3psGoLTXVaBa4+48nop72InUsqwWOPwnd0jfzNP58
        7ohGD7kui7hKXww75vid7TWxR1pUrg2ApA==
X-Google-Smtp-Source: ABdhPJzE248mfKX7yJXRTyBuHFHRbEXciSwjazvoXzYwy0LPJByG/K16nKmWzGIPufSlhaOhEdUWag==
X-Received: by 2002:a17:90b:3848:: with SMTP id nl8mr15169102pjb.221.1636539990361;
        Wed, 10 Nov 2021 02:26:30 -0800 (PST)
Received: from [10.2.24.177] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id d11sm17193587pgh.87.2021.11.10.02.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:26:29 -0800 (PST)
Subject: Re: Re: [PATCH] irqtop: add -c/--cpus option
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20211110031642.141240-1-pizhenwei@bytedance.com>
 <20211110095843.lfg6c7zxhrst42xb@ws.net.home>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <0418c94c-74f3-2503-71a0-ebf457946354@bytedance.com>
Date:   Wed, 10 Nov 2021 18:24:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211110095843.lfg6c7zxhrst42xb@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 11/10/21 5:58 PM, Karel Zak wrote:
> On Wed, Nov 10, 2021 at 11:16:42AM +0800, zhenwei pi wrote:
>> Since a23aecc1bf("irqtop: add per-cpu stats"), irqtop always shows
>> per-cpu stats. Test on a modern AMD server with 2 socket(256 CPU),
>> irqtop shows like following:
> 
> Thanks! This was on my TODO list too.
> 
>> +	/* print cpus table or not by -c option */
>> +	do {
>> +		int x, y;
>> +
>> +		if (ctl->cpus == irqtop_cpus_table_disable)
>> +			break;
>> +
>> +		scols_print_table_to_string(cpus, &data);
>> +		if (ctl->cpus == irqtop_cpus_table_auto) {
>> +			/* detect window size */
>> +			getmaxyx(ctl->win, y, x);
>> +			y = y;	/* avoid build warning*/
>> +			p = strchr(data, '\n');
>> +			if (p) {
>> +				/* line is too long */
>> +				if ((p - data) > x) {
>> +					free(data);
>> +					break;
>> +				}
>> +			}
>> +		}
> 
> libsmartcols provides scols_table_enable_nowrap(), this function
> forces the library trim the output. It seems more elegant.
> 
> I have applied your patch with some changes
> https://github.com/util-linux/util-linux/commit/17f7caa45105f0cbf8bf9b562468fba2c5d4a549
> 
> (and https://github.com/util-linux/util-linux/commit/d1732bba383a95786b5ec7bc1f4a173b644fe871
>   as I forgot update bash-completion in the first commit)
> 
> Thanks again!
> 
>      Karel
> 

Tested the latest code on a server with 256 CPUs, it works fine! Thanks!

-- 
zhenwei pi
