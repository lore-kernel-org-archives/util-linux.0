Return-Path: <SRS0=vWqr=7J=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5915CC433DF
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 05:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A367207E8
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 05:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvfpm2Ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgE0FNG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 May 2020 01:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgE0FNG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 May 2020 01:13:06 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24286C061A0F
        for <util-linux@vger.kernel.org>; Tue, 26 May 2020 22:13:06 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f18so18248045otq.11
        for <util-linux@vger.kernel.org>; Tue, 26 May 2020 22:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xQm+q8D3ug+d9/JkHvSnyU2k91tQeDJ49Ydaulxnjo0=;
        b=Lvfpm2OvZFsgJ+9Vq17Ml8ZOziV0lbA619byLzOsF5LQceu3ZIGHXTpCmyD3U4hXEo
         bG0ZLm8+qJfN1vpSWR3IN/feCQ35z+cnBc1Jr4ItXifwgX81o978oHjHFLXpFsTpLEW5
         O1PSg4IrG4C57KBe5u09336iw1kmwv9er6OvBEVi2wUcp8kfW49jhgrb7X+AENvyYHGc
         bLtMeZnIm5Kww8i0a5mOHSUPwDAR7/kZDIcfg9x0BakyjVC3xnDTIZhOohuGUd4uvIZ8
         l+M9nCa24pYI++FnEgNyON8oQFUAQCawyHs+j+/klzggAkSJ8oKipnw73hJvf/SHHgaw
         maKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xQm+q8D3ug+d9/JkHvSnyU2k91tQeDJ49Ydaulxnjo0=;
        b=nwvzA3WjNFMQIBPkihsCP6lHKTQ/JgbLu6XSIkCGEq6thszJwMG1j0ohKXBFEFU1Ib
         cupX3pQtk2fnwmvNDxiMzH0oEnLU+HAx7sb0/cKeBDfb1UKUz0Ca/BMzFIKwXXQE1bQs
         AnlUPjFzX3Mx7ogljWsFf6+OOr0EmaTLK4Abq3xYBqMULUwPq5VYsuw9yC7Dl3aoRTGQ
         BZJ6NqN5nfWrH6+7SrHcY0uStR0jV7dg3Y2+YwRpsWZXUuci2rCHjZByyYJAX0dhOOIk
         VdJNJ+eqQ8cIrDCrnGryvH7IquM1IaZ4eCJACMLhaKph9o/BEo/Y+YUGfPYn90UMX5ks
         bw1Q==
X-Gm-Message-State: AOAM5334Apk0oABAEGavT5cK07kYs/d3u+POMp8CIIQ+jT97iaFdh+gA
        OdWmlsZfQS1EVYt1/V5yIsoPzhnJ
X-Google-Smtp-Source: ABdhPJz3CiebyBXaAKls+YIQx2Y/m9W6btmh1rNXDlWkS51aZJuc+V4dhR+yCJs8gTXl5yndvS51CA==
X-Received: by 2002:a9d:66c6:: with SMTP id t6mr3309782otm.56.1590556385200;
        Tue, 26 May 2020 22:13:05 -0700 (PDT)
Received: from [192.168.0.91] (cpe-70-123-227-116.satx.res.rr.com. [70.123.227.116])
        by smtp.gmail.com with ESMTPSA id h11sm566784oib.57.2020.05.26.22.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 22:13:04 -0700 (PDT)
Subject: Re: util-linux-2.35.2 test failures
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
To:     =?UTF-8?Q?Aur=c3=a9lien_Lajoie?= <orel@melix.net>,
        Util-Linux <util-linux@vger.kernel.org>
References: <6b88784c-b130-27d4-2ec5-0d25320dd6fb@gmail.com>
 <CAA0A08W0S8ZnZXJ1D0VDnC6qZ4F0sYP_tr9qK7_7Fxi5HGOqAw@mail.gmail.com>
 <4999c47d-969a-a103-3d6a-60498f1fc959@gmail.com>
 <CAA0A08VitXbWL8A7ZP5ZaQM+dKWpwsaKzYVYeask1VfbU4LmCw@mail.gmail.com>
 <a012e30b-4aad-5e6c-8e0b-2789fb2edf32@gmail.com>
Message-ID: <1433cd9b-2f1a-f0e7-2f33-eeb3bbdf520e@gmail.com>
Date:   Wed, 27 May 2020 00:13:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a012e30b-4aad-5e6c-8e0b-2789fb2edf32@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 5/26/20 10:43 PM, Bruce Dubbs wrote:
> On 5/26/20 10:11 PM, Aurélien Lajoie wrote:
>> On Wed, May 27, 2020 at 1:36 AM Bruce Dubbs <bruce.dubbs@gmail.com> 
>> wrote:
>>>
>>> On 5/26/20 6:07 PM, Aurélien Lajoie wrote:
>>>> On Wed, May 27, 2020 at 12:34 AM Bruce Dubbs <bruce.dubbs@gmail.com> 
>>>> wrote:
>>>>>
>>>>> I'm getting three test failures and hope I can get someone to help.
>>>>>
>>>>> The test failures are  ipcs/mk-rm-msg, ipcs/mk-rm-sem, and 
>>>>> ipcs/mk-rm-shm.
>>>>>
>>>>> Concentrating on mk-rm-msg, I found on the system:
>>>>>
>>>>> ./tests/output/ipcs/mk-rm-msg
>>>>> ./tests/ts/ipcs/mk-rm-msg
>>>>> ./tests/expected/ipcs/mk-rm-msg
>>>>>
>>>>> The contents of the output and the expected files are identical:
>>>>
>>>> How have you checked it ?
>>>
>>> Yes.  cmp ./tests/output/ipcs/mk-rm-msg ./tests/expected/ipcs/mk-rm-msg
>>> gives no output.
>>>
>>>> Can be trailing spaces, final break line or other thing like this.
>>>> Can you share the files and the result of ./run.sh ipcs launch from
>>>> tests directory?
>>>
>>> -------------------- util-linux regression tests --------------------
>>>
>>>                       For development purpose only.
>>>                    Don't execute on production system!
>>>
>>>          kernel: 5.6.11-lfs-9.1
>>>
>>>         options: --srcdir=/sources/util-linux-2.35.2/tests/.. \
>>>                  --builddir=/sources/util-linux-2.35.2/tests/..
>>>
>>>            ipcs: headers                        ... OK
>>>            ipcs: limits overflow
>>> .../sources/util-linux-2.35.2/tests/../tests/ts/ipcs/limits: line 42:
>>> echo: write error: Invalid argument
>>>    OK
>>>            ipcs: basic limits               ... OK
>>>            ipcs: mk-rm-msg                  ... FAILED (ipcs/mk-rm-msg)
>>>            ipcs: mk-rm-sem                  ... FAILED (ipcs/mk-rm-sem)
>>>            ipcs: mk-rm-shm                  ... FAILED (ipcs/mk-rm-shm)
>>>
>>> ---------------------------------------------------------------------
>>>     3 tests of 6 FAILED
>>>
>>> I'll note that I am not running as root, line 42 of ts/ipcs/limits seems
>>> to want to write to:
>>>
>>> $ ls -l /proc/sys/kernel/shm*
>>> -rw-r--r-- 1 root root 0 May 26 18:27 /proc/sys/kernel/shm_rmid_forced
>>> -rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmall
>>> -rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmmax
>>> -rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmmni
>>>
>> I get this output as a non root user
>>   ./run.sh ipcs
>>
>> -------------------- util-linux regression tests --------------------
>>
>>                      For development purpose only.
>>                   Don't execute on production system!
>>
>>         kernel: 5.3.0-53-generic
>>
>>        options: --srcdir=/home/aurelienl/dev/util-linux/tests/.. \
>>                 --builddir=/home/aurelienl/dev/util-linux/tests/..
>>
>>           ipcs: headers                        ... OK
>>           ipcs: limits overflow                ... SKIPPED (no root 
>> permissions)
>>           ipcs: basic limits                   ... OK
>>           ipcs: mk-rm-msg                      ... OK
>>           ipcs: mk-rm-sem                      ... OK
>>           ipcs: mk-rm-shm                      ... OK
>>
>> ---------------------------------------------------------------------
>>    All 6 tests PASSED
>> ---------------------------------------------------------------------
> 
> OK, thanks. Some very minor progress:
> 
> 
>    ipcs: headers                        ... OK
>    ipcs: limits overflow                ... SKIPPED (no root permissions)
>    ipcs: basic limits                   ... OK
>    ipcs: mk-rm-msg                      ... FAILED (ipcs/mk-rm-msg)
>    ipcs: mk-rm-sem                      ... FAILED (ipcs/mk-rm-sem)
>    ipcs: mk-rm-shm                      ... FAILED (ipcs/mk-rm-shm)
> 
>    3 tests of 6 FAILED
> 
> But I did find
> 
> $ cat diff/ipcs/*
> --- /dev/null   2020-05-13 00:30:52.352031152 -0500
> +++ /sources/util-linux-2.35.2/tests/output/ipcs/mk-rm-msg.err 
> 2020-05-26 22:26:15.955322405 -0500
> @@ -0,0 +1,2 @@
> +ipcrm: failed to parse argument: '0xa12709c3
> +0xa12709c3'
> --- /dev/null   2020-05-13 00:30:52.352031152 -0500
> +++ /sources/util-linux-2.35.2/tests/output/ipcs/mk-rm-sem.err 
> 2020-05-26 22:26:15.984321830 -0500
> @@ -0,0 +1,3 @@
> +ipcrm: failed to parse argument: '0x1e5d8a7d
> +0x1e5d8a7d
> +0x1e5d8a7d'
> --- /dev/null   2020-05-13 00:30:52.352031152 -0500
> +++ /sources/util-linux-2.35.2/tests/output/ipcs/mk-rm-shm.err 
> 2020-05-26 22:26:16.012321273 -0500
> @@ -0,0 +1,2 @@
> +ipcrm: failed to parse argument: '0x12dec276
> +0x12dec276'
> 
> I just don't know what argument it was trying to pass.

I figured out what is happening.

The code in question is doing:

$TS_CMD_IPCMK -Q 2>>$TS_OUTPUT | ipcmk_output_handler $TS_OUTPUT 
$TS_OUTDIR/id-msg

$TS_CMD_IPCRM -Q "$(
         $TS_CMD_IPCS -q |
         awk -v id=$(cat $TS_OUTDIR/id-msg) '{if ($2 == id){print $1}}'
)" >> $TS_OUTPUT 2>> $TS_ERRLOG

ipcs -q gives output like:

0x96067edf 52         tester     644        0            0
0x96067edf 52         tester     644        0            0

so it is trying to run:

ipcrm -Q 0x25cee277\n0x96067edf

which gives:
ipcrm: failed to parse argument: '0x25cee277'
'0x25cee277'

The question is why there are two identical entries in the ipcs output. 
Could this be a kernel issue?  Code or configuration?  My kernel is 5.6.11.

   -- Bruce
