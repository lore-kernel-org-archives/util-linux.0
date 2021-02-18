Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFD9C433E0
	for <util-linux@archiver.kernel.org>; Thu, 18 Feb 2021 18:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9CB964EAD
	for <util-linux@archiver.kernel.org>; Thu, 18 Feb 2021 18:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBRSTI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhBRPjB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 18 Feb 2021 10:39:01 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDCAC061786
        for <util-linux@vger.kernel.org>; Thu, 18 Feb 2021 07:37:24 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id n19so533723ooj.11
        for <util-linux@vger.kernel.org>; Thu, 18 Feb 2021 07:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UOgL4VCE/k1/PjlGCVYaMSUYAQIGAjooITMOWfqXeII=;
        b=U66Hv2asvSBTaieN1iAogptVISGsrq0mDv7dukGX7Oxr3mEZAu7fiy5yzHzaDEE1px
         RapbVZzydxLdxpSXAAeNAOebZCtvp7UhsIg1f581N9dIn4Z8VvHkabimyuStseoyglvy
         /Zst1hTJee7KxjxiPZ6KtEjpBOQf6xDgBPZMkmMHTwlXEu08X9gBuiZY/iVxQUUWTmZt
         RJhdU6A8qKkjbEa2GH2UP9fvL5LpYJlWbdEKpaIO4o2KR1w5NKd9NFSMwky5/m3aBTFc
         dQsQtJz+fs6quVt0W1Vy4qFxGWwkC1cm7NxA7ROwG8FWLfvNvEzvWa5idz8XhSAhxX8D
         74Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UOgL4VCE/k1/PjlGCVYaMSUYAQIGAjooITMOWfqXeII=;
        b=CGekDr+tg7QaRhTmaX9y1i2C7pww6DxZycDKtDNl8sHu2QdV1bUog8M5ieOvoQHttU
         +IEkE02sDW7rrxw2+gPNyPNI4pVpdiHCxqoJ1Tjz6ticysu0W4KR8NCaiNaVvLgKdKCV
         h4oAB8Kq3D2MNeA/6VhlAAOyIiKxxQ9uDPLrSDblUNXLkCmzGGdUxZz4qHcnB9zuXXxW
         a81baLBVAKY8SydUonqz1A+OdzfMU3tHhuadULJHJg8V8220U8iyr/W3nVMN6fNwfDMp
         +Ulk5cjKtabGmkTVGW/FjXV2znMNW5HeT+zBeMGLn2u3Tx7Tyl7Figw+/GRcveFwYo6E
         3lmQ==
X-Gm-Message-State: AOAM532PWUxKFAUmMsA4aAolBE3L0tkMZgEspPCRBkF2BnpSsITP1gqY
        L70M+Zc3Ia15xqrTnI0XeO9KZURsNfM=
X-Google-Smtp-Source: ABdhPJwXusUdlaOQpMoP7rp36HVY2S8YVFWSRmGj/wVSEm8ls4iVQUxu0JJ1w1GJoeQmjE7ENGTY9g==
X-Received: by 2002:a4a:c44:: with SMTP id n4mr3412036ooe.62.1613662643822;
        Thu, 18 Feb 2021 07:37:23 -0800 (PST)
Received: from [192.168.0.91] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id m22sm1063735ooj.43.2021.02.18.07.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 07:37:22 -0800 (PST)
Subject: Re: Suggested changes to util-linux for FHS compliance.
To:     Karel Zak <kzak@redhat.com>
Cc:     Util-Linux <util-linux@vger.kernel.org>
References: <cc08c08e-81d9-f3c7-ce8b-43a27bfe1c72@gmail.com>
 <20210215091625.jzaf6ephntdwmi5w@ws.net.home>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <f8d10b77-79d9-6a62-50a4-5fb2d1d45655@gmail.com>
Date:   Thu, 18 Feb 2021 09:37:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210215091625.jzaf6ephntdwmi5w@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2/15/21 3:16 AM, Karel Zak wrote:
> On Fri, Feb 12, 2021 at 11:04:59AM -0600, Bruce Dubbs wrote:
>> I don't recall if this has come up before, but I suggest a couple of changes
>> to the default util-linux build configuuration:
>>
>> 1. Change the default ADJTIME_PATH to be /var/lib/hwclock/adjtime
> 
> Good idea. I'll do that.

Thanks.

Note: Sorry to take so long to reply.  We've been without power/internet 
for three days in Texas.


>> 2. Change the references to /var/run to just /run or at least add a
>> configure option --runstatedir=<path>.
> 
> The current default is /run if --localstatedir is NONE or /var, see
> configure.ac:
> 
>   # default for old versions without $runstatedir
>   AS_IF([test x"$runstatedir" = x], [runstatedir='${localstatedir}/run'])
>   
>   # our default if $localstatedir unchanged
>   AS_CASE([$localstatedir:$runstatedir],
>    [NONE:'${localstatedir}/run' | /var:'${localstatedir}/run' | NONE:'/run' ],
>      [runstatedir=/run; AC_MSG_NOTICE([  --runstatedir defaults to /run])]
>   )
>   
>   AC_SUBST([runstatedir])
> 
> 
> Try it without an option:
> 
>          $ ./configure
>          ...
>          configure: Default --exec-prefix detected.
>          configure:   --bindir defaults to /bin
>          configure:   --sbindir defaults to /sbin
>          configure:   --libdir defaults to /lib64
>          configure:   --runstatedir defaults to /run
> 
> the @runstatedir@ should be available since autoconf 2.70
> https://www.gnu.org/prep/standards/html_node/Directory-Variables.html
> but not sure about the option.

We have autoconf 2.71, but we are not using it for util-linux. The 
standard tarball defaults to [PREFIX/var] for localstatedir and it is 
very common to use --prefix=/usr, so that makes using --localstatedir 
required if runstatedir=/run is desired.

This is an indirect implied result.  Shouldn't it be made explicit?

Perhaps another solution would be to make the default for localstatedir 
be /var instead of PREFIX/var.

For now we are just using the environment variable runstatedir=/run.

   -- Bruce
