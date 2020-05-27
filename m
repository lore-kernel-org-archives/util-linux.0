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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA792C433E1
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 18:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCB22075A
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 18:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4K/FgWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbgE0SHM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 May 2020 14:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387696AbgE0SHM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 May 2020 14:07:12 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72990C03E97D
        for <util-linux@vger.kernel.org>; Wed, 27 May 2020 11:07:11 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 23so21313036oiq.8
        for <util-linux@vger.kernel.org>; Wed, 27 May 2020 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I/cNeP5rl5lnQCV3O8CTV4zQeeiBerlfcz12iCluXVU=;
        b=d4K/FgWnoNfGhluQ6IvPMpfHic1MRBtQRr6wQmiK0DQWrX622B1KPOkoMXE3CseZoE
         R3nAKpp73Sv5b8mcIegXW+zT/L0ZQJIUglpUux/ETWpJHSXdZ4khmc4SidiWSqyy2HG0
         KZ//28S0YBON9Q1+y4nYj9K4XqOO6sPv5Xq7qe6MFBD7M9J8b4bXQZs8KCzPRMqwHqln
         ObfMTv/wJ1mgq0O7yGc4BaTQFyjnN1RMqWnlK+Em4vm1FfwyZsixVK2rvGeixFOD5Ov8
         pAhz80jNSWPwzA9IQkN1A+k/JYifXINnd89AbPrEtV/ar7p78kVEbV0Cx08ZmetFdoxZ
         JfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I/cNeP5rl5lnQCV3O8CTV4zQeeiBerlfcz12iCluXVU=;
        b=Ugxf6t4ao8L/T7L726wX+uRV94Ydlj5cA3DBMxu78cKY/hreOjsQx0Nws4WmcMQC97
         B8AmRW59J1HEjMr1AbEFpBHYmhV6/qC57yT5PSFWCmuQt7BExisxEJ3AMLEuIHBX/Xq5
         2LKgvthlW2bSL8MwJ9Xekmln5ebpirIEIpoRqNxSP12Yemmq5bLeSgccixhQ9se/rXWl
         6swhmK+cTk7fC6b9nL6+5rWrY/0YX1AHoamR7GLFpd4zNOf6nTQDiKScucfjyYFukAYV
         MP0kSuPWsdOi3L5B/eTsSZr1d/xfleogN/TQohd49qnaosF96PxIxykWHXJWnFuTQcm0
         0A3Q==
X-Gm-Message-State: AOAM532cSg1dWoBRHlv/fLw2wTyd8iUAqhmTQkNIngvaTrAevd4FJc3C
        E+8jjxTaPZ4F6hBIFA3Jtfxfh4wg
X-Google-Smtp-Source: ABdhPJz0l8MIC1jZZh+8KShtWHF7x0EfVwrl97Ttubm6Ix9idn0OjR+jGM4i0zY79wTRJFEzb0G/Mg==
X-Received: by 2002:aca:dc8b:: with SMTP id t133mr3569360oig.163.1590602830614;
        Wed, 27 May 2020 11:07:10 -0700 (PDT)
Received: from [192.168.0.91] (cpe-70-123-227-116.satx.res.rr.com. [70.123.227.116])
        by smtp.gmail.com with ESMTPSA id 76sm298otu.75.2020.05.27.11.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 11:07:09 -0700 (PDT)
Subject: Re: util-linux-2.35.2 test failures
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     Util-Linux <util-linux@vger.kernel.org>
References: <6b88784c-b130-27d4-2ec5-0d25320dd6fb@gmail.com>
 <20200527131154.p2rqxhcz6d56ik7m@ws.net.home>
 <d8616084-1e16-abc2-d0d6-834073d96fca@gmail.com>
Message-ID: <99d36043-9806-bd95-0630-7a920e8476d4@gmail.com>
Date:   Wed, 27 May 2020 13:07:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d8616084-1e16-abc2-d0d6-834073d96fca@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 5/27/20 10:55 AM, Bruce Dubbs wrote:
> On 5/27/20 8:11 AM, Karel Zak wrote:
>> On Tue, May 26, 2020 at 05:34:13PM -0500, Bruce Dubbs wrote:
>>> I'm getting three test failures and hope I can get someone to help.
>>>
>>> The test failures are  ipcs/mk-rm-msg, ipcs/mk-rm-sem, and 
>>> ipcs/mk-rm-shm.
>>>
>>> Concentrating on mk-rm-msg, I found on the system:
>>>
>>> ./tests/output/ipcs/mk-rm-msg
>>> ./tests/ts/ipcs/mk-rm-msg
>>> ./tests/expected/ipcs/mk-rm-msg
>>>
>>> The contents of the output and the expected files are identical:
>>>
>>> Message queue id: <was_number>
>>> 1
>>> Message queue id: <was_number>
>>>
>>> I am running the tests as a non-privileged user.
>>>
>>> If I run the commands:
>>>
>>> $ ipcmk -Q  (returns 24)
>>> $ ipcs -q -i 24
>>> $ ipcrm -q 24
>>> $ echo $?
>>> 0
>>>
>>> Everything looks OK.  Does anyone have an idea why this test (these 
>>> tests)
>>> are failing?
>>
>> I had no time to play with it yet, but according to feedback from
>> https://github.com/karelzak/util-linux/issues/1042 there is some kernel
>> regression:
>>
>>   The ipcs tests are failing due to a regression in kernels 5.6.8
>>   through 5.6.13. Or mainline commits between
>>   89163f93c6f969da5811af5377cc10173583123b and
>>   5e698222c70257d13ae0816720dde57c56f81e15 (apparently including your
>>   5.7.0-rc0).
> 
> Thanks.  I'll try 5.6.14 and report back.

Indeed updating to kernel 5.6.14 fixed the ipcs test issues.  Thanks for 
the help.

Additionally I'd like to report one minor warning when building with gcc10:

login-utils/logindefs.c: In function ‘get_hushlogin_status’:
login-utils/logindefs.c:370:20: warning: ‘%s’ directive writing likely 
15 or more bytes into a region of size between 9 and 8191 
[-Wformat-overflow=]
   370 |   sprintf(buf, "%s/%s", pwd->pw_dir, file);
       |                    ^~
login-utils/logindefs.c:370:16: note: assuming directive output of 15 bytes
   370 |   sprintf(buf, "%s/%s", pwd->pw_dir, file);
       |                ^~~~~~~
login-utils/logindefs.c:370:3: note: ‘sprintf’ output 2 or more bytes 
(assuming 8199) into a destination of size 8192
   370 |   sprintf(buf, "%s/%s", pwd->pw_dir, file);
       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   -- Bruce
