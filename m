Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734EAEB64DA
	for <util-linux@archiver.kernel.org>; Thu,  6 Jul 2023 00:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGFA5t (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 5 Jul 2023 20:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGFA5t (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 5 Jul 2023 20:57:49 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25314171A
        for <util-linux@vger.kernel.org>; Wed,  5 Jul 2023 17:57:46 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5634fbf0cf4so68737eaf.3
        for <util-linux@vger.kernel.org>; Wed, 05 Jul 2023 17:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688605065; x=1691197065;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzPrVdv13ZB+crHbQKlrO8mt+mU06aTf44xbkz+es0g=;
        b=MZvptezl17IJtfCmTykt/HY4ibF0dSWYiJGonhiqICoeD7a0zVg0xKEczZtbnVBQOw
         GroOvXWdMj1/+7qBsIHkWzkNQ7JU2T7xFkiI9fwRmTP0Vt7d6Qpmd0bnD2tJHb+IlBrh
         ndeZIc3gHKA8dzHaoF4uL1GgsM6YQ9ODjcgd5VDH7GEwum6vOcMrnPAcKE0bL9t5YZgk
         9CW7TgzSLqU0vewl5abH75Pi92FU/kI453UvhfQOUi4GzBzGsCeDpLBtSJrwxzWulYVj
         ogiNlpR08VvbYtAbldILpD6MIHMHjqNFXz0F0t2Y0pce6r4ZengoHY1NyG5Jwsb8ofgJ
         0o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688605065; x=1691197065;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzPrVdv13ZB+crHbQKlrO8mt+mU06aTf44xbkz+es0g=;
        b=l1HG63GBL37gJIgMIgGLi66ai2w1f96tkUPa8xt8p6cOxe9JG01rZtB2fx2BG720Kc
         pZxEiPAbD4I8amYYXsdbSKeiPv+r0fZVUxLmeJUwJFTI6nyj/76AbS3uFnglhhW/+cAs
         G4BDEmNmy4CHDl9h97K4Qh67x0ofCHDUDsark34RXKbwSVV24z6IE5tmI9XFa+pfA8rp
         XSLyRQkqoAyLuuWqwLbrcHwKHmQPQVIYvgiAZhk+Jp3cRGIxVgKiRHzi1lT4ag7SE/BZ
         NSWvMgPd4PyV2WmILDvq37BTohRf64sv8hzyEBzcXP0NpR0bSScnpPEyhY6QM63uKcrt
         9zHA==
X-Gm-Message-State: ABy/qLb3QBAgSU6NzwxvjhZ7JL9v+0yb3PX/wJwuvPxxw93jw3t+aOHj
        upnQUUQ/C0m02xgOEt4Np0B6E3VytN4=
X-Google-Smtp-Source: APBJJlHyHiQYD7ohs/OI09qok1YCdmbtP1xd/1CCgkpCW9z82LHsnK7Od9NgdnhxjGgQZgQB5eUH7A==
X-Received: by 2002:a4a:aacc:0:b0:563:49fd:e772 with SMTP id e12-20020a4aaacc000000b0056349fde772mr274103oon.4.1688605065289;
        Wed, 05 Jul 2023 17:57:45 -0700 (PDT)
Received: from [192.168.0.92] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id n4-20020a4aa7c4000000b0056623671ffcsm204148oom.24.2023.07.05.17.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 17:57:44 -0700 (PDT)
Message-ID: <fbe542bf-954c-90e9-4c7f-5e2a2aa3f786@gmail.com>
Date:   Wed, 5 Jul 2023 19:57:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: May I help you to fix the source code for util-linux?
Content-Language: en-US
To:     lyman@alum.mit.edu, util-linux@vger.kernel.org
References: <CAGLH8RSpmqZJOvcO+1so1zz4q9cs5GyEtGL9oZ8as0tAemCo8g@mail.gmail.com>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
In-Reply-To: <CAGLH8RSpmqZJOvcO+1so1zz4q9cs5GyEtGL9oZ8as0tAemCo8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 7/5/23 19:23, Lyman Opie wrote:
> Dear friends who have worked on the util-linux source code,
> 
> Thank you for the util-linux package.
> 
> I'm an M.I.T. graduate, who has been compiling linux source code for
> almost as long it has existed.  A problem has crept into the
> util-linux source code:
> 
> When I run its "configure" script, it eventually fails, reporting
>    error: C++ preprocessor "/lib/cpp" fails sanity check
> 
> The lack of sanity is not in cpp, but in the configure script, which
> calls cpp with a command line tens of thousands of characters long,
> which consists almost entirely of thousands of repetitions of the
> command-line arguments "-D _GNU_SOURCE".
> 
> I am looking into a way to fix this, but perhaps someone who is
> already familiar with the source code can tell me immediately how this
> might be fixed?
> 
> If someone has a chance to email me, I'd be pleased to hear from you.
> I thank you kindly for reading.

Wow.  A problem with no information in which to help.  What is your host 
distribution?  What is the command line? What version of util-linux? What hardware?

On my linuxfromscratch system on x86_64 I run:

tar -xf util-linux-2.39.1.tar.xz
cd util-linux-2.39.1
./configure

It runs perfectly in slightly under 7 seconds.  You are doing something wrong or
have a really unusual system, but you give far too little information to let others help.

   -- Bruce






