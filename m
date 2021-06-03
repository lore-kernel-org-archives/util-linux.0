Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59968C47082
	for <util-linux@archiver.kernel.org>; Thu,  3 Jun 2021 17:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420F0610A2
	for <util-linux@archiver.kernel.org>; Thu,  3 Jun 2021 17:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFCRnX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 3 Jun 2021 13:43:23 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42788 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFCRnX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 3 Jun 2021 13:43:23 -0400
Received: by mail-oi1-f179.google.com with SMTP id v142so6646791oie.9
        for <util-linux@vger.kernel.org>; Thu, 03 Jun 2021 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dQ2qrZHENQc+thFBRQ5RD+OoVf3B4l/T/xKz7Ts9mPU=;
        b=jf/IQLjtTPEYfd6qNf9fl+01oMYGT4eVzwP9ulWj9L+OW8eyKYI3ZbILsq6eVZrb9u
         2MYeKd9O6yfbfPfViWjnyR57DzQhZsOXc8R01p+SQprQYb3tF0gpm05fZymxTiYBJs45
         a/XTzP8irMqn0bxyY3JDAF10XbOaAiTUYMJek4kfaf1g+wIuyeceVNFDuJG672+Dcxg1
         lM1GGvsZLidHXEgSCWDGL+SSlWlXGaQ5DfDsECvJXVUNMTcb1bzYNQw+wYpkfoUuQjWi
         3MTLly5306P2HMCViIxi9+eBRhIDeHP6aLah6l1dXG/zh7T8Lgrq9hMjrJq7ue+HVLnU
         51CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dQ2qrZHENQc+thFBRQ5RD+OoVf3B4l/T/xKz7Ts9mPU=;
        b=M8msLOZa8MSkeYRo3vccxuJi1eC6mtND8hEqIyE9J40s2+Wy+2eZOnun7HlbuFSDLw
         1o0KYnZNHhzvkrUthr1/gjjG0xPQfqJQCjxr5/cvA52Cn8rt+FbZeDoo/2yYUw473SOh
         cbxCA6axWV1q/r+3O8hwLI/8znvQXSri4CxvcYwsZQU1mjJcflE5k/9inNxeaVWCaJiJ
         1y27VLWGtuzpTCDRkqRdyEj0w8Up+Yw16+3UDcOGo7JRKZ/epFOUSWeu6IMUGi/KGSwx
         Pm/eGPOE16dzX3/E5GnB+VWLSJ7h6d9X9uAkHhs+c6BpfLH+7VR0oXph5eITREu77E7D
         mklw==
X-Gm-Message-State: AOAM532WhKBb7MiUzIOeU+pZYTvwt3wSEJJiQ7sxVCSY8L18EffFlpY6
        +FlavzCEjSVslj53wHtloOrEeocKP8g=
X-Google-Smtp-Source: ABdhPJyMhNI8y9X3Prv+olkG+bDh2/1eCx/S7i+duv4IWIl7eWOVYTQTZrLaoHhs6r1treb/Iodeww==
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr243053oik.104.1622742023147;
        Thu, 03 Jun 2021 10:40:23 -0700 (PDT)
Received: from [192.168.0.92] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id 19sm838096oiy.11.2021.06.03.10.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 10:40:22 -0700 (PDT)
Subject: Re: [ANNOUNCE] util-linux v2.37
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20210601083849.niumt2zvyr3boiqw@ws.net.home>
 <e00ea8fe-e848-73c1-1314-de26ad698c90@gmail.com>
 <20210602152710.jjs2fpkcegtvlnvb@ws.net.home>
 <4a6781ff-04ad-f3e1-402e-b4cb65d1749b@gmail.com>
 <20210603101939.ltmyouadjizgw2mu@ws.net.home>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <eab7d8ef-652b-3700-0a82-2f36f22f2e97@gmail.com>
Date:   Thu, 3 Jun 2021 12:40:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603101939.ltmyouadjizgw2mu@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 6/3/21 4:19 AM, Karel Zak wrote:
> On Wed, Jun 02, 2021 at 11:25:14AM -0500, Bruce Dubbs wrote:
>> On 6/2/21 9:27 AM, Karel Zak wrote:
>>> On Tue, Jun 01, 2021 at 01:29:21PM -0500, Bruce Dubbs wrote:
>>>> On 6/1/21 2:38 AM, Karel Zak wrote:
> ...
>>>> Karel, Is there any chance you can release a tarball with rendered man
>>>> pages?  It would make things a lot easier for us.
>>>
>>> I'm not sure if duplicate content in the upstream source
>>> tarball is a good idea (it means keep there AsciiDoc as well as
>>> generated man pages).
> 
> Today morning I had time to play with it and it seems that we can
> distribute man pages as well as adoc in the same tarbal, the size
> change is not so big:
> 
> 5956904  util-linux-2.37.42-308a1-dirty.tar.xz
> 5863940  util-linux-2.37.tar.xz
> 
>   ~1.5% up, that's something we can ignore.
> 
> It also seems that autotools are smart enough to keep the man pages
> synchronized with adoc without any significant changes to our build
> system.

Much appreciated.

   -- Bruce

