Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B32C433F5
	for <util-linux@archiver.kernel.org>; Mon, 11 Apr 2022 12:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbiDKMKt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Apr 2022 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiDKMKr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Apr 2022 08:10:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD493E5E2
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 05:08:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id md4so6781787pjb.4
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9XMkLQnhvVeZR+8kUkSaLg7skY/1BNq6RM8mMGFw+rQ=;
        b=5meZXu+Bf5u7mgE9rEu7Wht4JmklJdme/TFvUUP+AMVFi1w4QaZqAK146QywUOCwhw
         tMcDW1fWs8clKWqUQ78Lu6FvGmMbp3vHtA9p3Z4I6FHy14T6dihnuZ7kGdZSCNUzgTJW
         ZWSK4vC1KqljtV9J+Z9+vGwrAfCpVtIG9jrluy5foRFeINNS83cOYzSr7nif3iJ5V7zd
         aGBIG/gGZAsMpx632keZQBq7EIZIPvD9hpgCDMA3BfRdCiy6wNQrbfjyhkQmOXXwxlzt
         uITEdnaMrpQv4BtPTFqVg/DSYAr21dK8Vy7J5HFwoe0mk8Y69rzjQaOl5hoRS+j5KLt7
         JPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9XMkLQnhvVeZR+8kUkSaLg7skY/1BNq6RM8mMGFw+rQ=;
        b=2GdJqGCDPeebqS9EVD/ZW+aRXN3g+Elm4JrBlcJSENYC/J1eoIpZnodAhTNch/kqzp
         e6wd1iofQJWl5sthYuzWyaSgac1QRe+LWZ+EqeqsPuF7k3FwCG8p49Ltq8M/2Qfynhp6
         oNhbQzyxwsGjFcrxITUelvb/2cmYroBb4RoYu+O2Cw2NKf06ivhDiN/UFhK2LMf2KqsZ
         xbapvDtsIN0zx2mNSHwpVXIeHaeaSSDDESmy6z1/AF1i5dqwZEvqZPSQD3CDjjvJSubQ
         ssVx3gqToHnlBKBsalVR66+e2nDDnwKRKsHfbpFjZJcokioyFP2wUQWV+Eup79aCWluH
         IpFg==
X-Gm-Message-State: AOAM532pQ/lvjM38ordxOLH/X6V6r9U2HfjT5Qq4pl8EuCtbTPsyTtX6
        9C11Rxf/Iom74kBXg6RyKRBvNQ==
X-Google-Smtp-Source: ABdhPJw96fCq2VvmyC3O5lEz1oUMFkX6FFLTyhNB3KARnrs5K9tlTUteMdReJ/vGzo1DwmJjllnHkg==
X-Received: by 2002:a17:90b:3504:b0:1c6:8569:c28d with SMTP id ls4-20020a17090b350400b001c68569c28dmr35799149pjb.92.1649678912184;
        Mon, 11 Apr 2022 05:08:32 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00088d00b004e1bea9c582sm35418968pfj.43.2022.04.11.05.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 05:08:31 -0700 (PDT)
Message-ID: <d57eb94f-e947-46cb-84a4-122bcf526e7a@bytedance.com>
Date:   Mon, 11 Apr 2022 20:04:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Re: [PATCH 1/2] blkpr: rename operation to command
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, hch@infradead.org
References: <20220407034932.68323-1-pizhenwei@bytedance.com>
 <20220411105345.rre3xfxg6p7dnxso@ws.net.home>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220411105345.rre3xfxg6p7dnxso@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 4/11/22 18:53, Karel Zak wrote:
> On Thu, Apr 07, 2022 at 11:49:31AM +0800, zhenwei pi wrote:
>> Suggested by Karel, rename operation to command.
>> Thus make this more clear.
> 
> Both patches applied. Thanks!
> 
> (I did small changes to formatting to make a little bit shorter and
> usable for translators.)
> 
>      Karel
> 
I test this output, it looks better than the original version.
Thanks a lot!

-- 
zhenwei pi
