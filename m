Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDB2C47093
	for <util-linux@archiver.kernel.org>; Wed,  2 Jun 2021 16:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F62F61966
	for <util-linux@archiver.kernel.org>; Wed,  2 Jun 2021 16:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhFBQ1L (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 2 Jun 2021 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhFBQ1L (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 2 Jun 2021 12:27:11 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C6EC061574
        for <util-linux@vger.kernel.org>; Wed,  2 Jun 2021 09:25:15 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so2901842otc.12
        for <util-linux@vger.kernel.org>; Wed, 02 Jun 2021 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3asRA7lA2C+7A4wV2rkiC0hJmGd2rJPEi5U9ddUAzIw=;
        b=kYz7G6FiBBfxnsD0ZpD7U5Qsjeot484tlpphwlVWAQzDRPrjIHeUkFuUpzkv3ynFW3
         PY3VEG8vBHMOMkcMOO2P3sEwMXa0FJW/FJgD9a5YOv4J7Ne+fuXb78sH0YEg26pDvw26
         Ulqk2SwIrX7KeHkSiB9Tl4DeZKODYTZsdK8jwIk5BEiFPD93h1kZNYYl/Uf4ZUBXML+M
         kaBb0Mpkygch4GzUuAj8TQOst9/3q9cA3r4NXy8MEVPL5M+d2MmR0kmak+SVEqSw2OWR
         a8XMSsRebH37mid6mNN/rqFP4/7t+Ofen7BjClCCfom5vDsMadSzhxmhEyQwKj28vqya
         QtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3asRA7lA2C+7A4wV2rkiC0hJmGd2rJPEi5U9ddUAzIw=;
        b=HV5P7QiVCKjHxOLIHm4xJgOWteQsgm7Qhsv0ra9VdRsmAAsS3yyeTrHe/hTiSk5MkT
         g7csJwlyE/zlJDgmlMRenH6ESY6JjxdUUqGc+SpHEnivQjS2EZpgDys3+wk1peRXVX39
         IlZN6Z3wSMc3T8xOEimXO64n18s3+g6+lNUjhku79uKZD/cC808PnQLyXO82enioDUmR
         9PYTFmpdOBwKQLQgfjqZeHjApG9qrYi1cB24zJKdPL3UKttZIm054TzYCXIymMfnc2sy
         kmUYA2ldCpZXD3cvo1UHOD40hYGIlJd+1tzZX7xrD6cTXa3L2URxjMuvyogs3RHTaRXQ
         0zwQ==
X-Gm-Message-State: AOAM531YMR9M+FqbWckb8uWCJmtMmC5ZS5RtP4XOWUBQb7RmCDRlwXoz
        J+gGVqZ7zBSeeVNlKxSX9aUhsxoEEwE=
X-Google-Smtp-Source: ABdhPJxBZ+G4ab/RZqgvk893vsjr7epr5oydLoHUZIKLmN2TnEYNaQQHH5RmVWpyLGol6JoyG1JH1w==
X-Received: by 2002:a9d:51c7:: with SMTP id d7mr25396986oth.51.1622651115135;
        Wed, 02 Jun 2021 09:25:15 -0700 (PDT)
Received: from [192.168.0.92] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id n13sm59675oop.8.2021.06.02.09.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 09:25:14 -0700 (PDT)
Subject: Re: [ANNOUNCE] util-linux v2.37
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20210601083849.niumt2zvyr3boiqw@ws.net.home>
 <e00ea8fe-e848-73c1-1314-de26ad698c90@gmail.com>
 <20210602152710.jjs2fpkcegtvlnvb@ws.net.home>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <4a6781ff-04ad-f3e1-402e-b4cb65d1749b@gmail.com>
Date:   Wed, 2 Jun 2021 11:25:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602152710.jjs2fpkcegtvlnvb@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 6/2/21 9:27 AM, Karel Zak wrote:
> On Tue, Jun 01, 2021 at 01:29:21PM -0500, Bruce Dubbs wrote:
>> On 6/1/21 2:38 AM, Karel Zak wrote:
>>>
>>> The util-linux release v2.37 is available at
>>>
>>>     http://www.kernel.org/pub/linux/utils/util-linux/v2.37/
>>>
>>> Feedback and bug reports, as always, are welcomed.
>>>
>>>     Karel
>>
>> Karel, Is there any chance you can release a tarball with rendered man
>> pages?  It would make things a lot easier for us.
> 
> I'm not sure if duplicate content in the upstream source
> tarball is a good idea (it means keep there AsciiDoc as well as
> generated man pages).
> 
> Maybe we can create a separated tarball util-linux-man-2.37.tar.gz and
> distribute it by kernel.org FTP for users who do not want to depend on
> AsciiDoc. It would be also usable in the future when we will have the
> man pages translated to other languages.
> 
> The problem is content which depends on the configuration (variables
> like $ADJTIME_PATH, $docdir, etc.), because it's distro-specific and
> these variables are replaced by real data during conversion from
> AsciiDoc,  but I guess this is something we can fix by simple sed call
> in the Makekefile.am.
> 
> So, your work-flow will be:
> 
>   * download and extract source tar.gz
>   * download and extract man-pages tar.gz to the same directory as source
>   * ./configure [--disable-asciidoc]
>   * make
>   * make install
> 
> Does it sounds usable?

It will help, but the make install will need to be aware of the 
disable-<package> switches so man pages are not installed for skipped 
packages.

Our problem is that when we install util-linux we have a bare 
environment and do not have asciidoc or asciidoctor installed.  Adding 
those would require a long dependency tail (ruby, docbook, etc).

   -- Bruce
