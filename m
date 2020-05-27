Return-Path: <SRS0=vWqr=7J=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4B1C433DF
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 03:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8E6207CB
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 03:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsBC8AEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgE0DnM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 26 May 2020 23:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgE0DnL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 26 May 2020 23:43:11 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88052C061A0F
        for <util-linux@vger.kernel.org>; Tue, 26 May 2020 20:43:10 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id l6so20597595oic.9
        for <util-linux@vger.kernel.org>; Tue, 26 May 2020 20:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TZKPEw0loudTMTpzp4zrLXcK/YA3KvAgVW+CBALyKgo=;
        b=BsBC8AEQynzQTS7aqfh5YdNQwOXbQCLbyV+a+/UB7acJ0Rkeq0lh3rO6YtG5d4h/b5
         IRl9GRuGF4H2sCG9yENpqQAiIqOhWNS+Uh6o5Otw7LmxZE1NmY7b9StmiqvLjbUE5hQN
         iDcMsu5B9p6NMhKqlh3P9Y7c8iAHQm2PXkA+qjpJB0oVeTYErazpF7AGkAY9zMlHD6xp
         OLLN/x5FFZ+dIL2ILTPKX0/xv4n2eG8AijaxIQHNhDMGWsjLsNv71ZlOGAokIU5ocYd2
         3BUm9wBm2TSixE4ZkyorlpaJG1uB+qkj72AFRHij/Ax1rovfWtINI4lJxZH7VLxIeMyb
         7j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TZKPEw0loudTMTpzp4zrLXcK/YA3KvAgVW+CBALyKgo=;
        b=eW+wFebw7OTal4brxuVcejZM2cnL0n/wsRPv6TGQY5NxdQ9v97MRZbGc/InmG2dnQV
         BTwnSFd2UNWvLoBkmygCrMErnj8vwXOmVquZm0FgYWo+gluJu9qN31RkKYAQE2j9Fa4f
         M5XHopPJ8fPkMJHyekw+pFJ2Ht/JgvbJcOfceaUAXLsrsCMaVIDM+BVccoFzyb3FiBhT
         GQpiEs9vmNC21vrW0/YQKfpubCkenJU2o4Vfn7Z5Az13gnt4gr6J97pNfCBfIb0HfH1P
         oyyHGca0r5XhzLneH6q6gt3nNOTnqXmKfeQXz+O/es3iZxGA0znBO1BuIRUxkwtvlWrJ
         npsQ==
X-Gm-Message-State: AOAM532JywULoax+4yw4E77JA+xyUOvwSoYXTqeslW+mFg5X7KtK71f8
        AxrZ4gjTqeX86+/QD+NdbZlhVH/H
X-Google-Smtp-Source: ABdhPJzkdPzXm3F5K25P84b1C33U7RSLMnFF+caSw3Ya0vP3lyf2QqxdwV4jche1OwnNrBRxB8GvrA==
X-Received: by 2002:aca:210f:: with SMTP id 15mr1347719oiz.118.1590550989530;
        Tue, 26 May 2020 20:43:09 -0700 (PDT)
Received: from [192.168.0.91] (cpe-70-123-227-116.satx.res.rr.com. [70.123.227.116])
        by smtp.gmail.com with ESMTPSA id x143sm515600oif.58.2020.05.26.20.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 20:43:08 -0700 (PDT)
Subject: Re: util-linux-2.35.2 test failures
To:     =?UTF-8?Q?Aur=c3=a9lien_Lajoie?= <orel@melix.net>,
        Util-Linux <util-linux@vger.kernel.org>
References: <6b88784c-b130-27d4-2ec5-0d25320dd6fb@gmail.com>
 <CAA0A08W0S8ZnZXJ1D0VDnC6qZ4F0sYP_tr9qK7_7Fxi5HGOqAw@mail.gmail.com>
 <4999c47d-969a-a103-3d6a-60498f1fc959@gmail.com>
 <CAA0A08VitXbWL8A7ZP5ZaQM+dKWpwsaKzYVYeask1VfbU4LmCw@mail.gmail.com>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <a012e30b-4aad-5e6c-8e0b-2789fb2edf32@gmail.com>
Date:   Tue, 26 May 2020 22:43:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAA0A08VitXbWL8A7ZP5ZaQM+dKWpwsaKzYVYeask1VfbU4LmCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 5/26/20 10:11 PM, Aurélien Lajoie wrote:
> On Wed, May 27, 2020 at 1:36 AM Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
>>
>> On 5/26/20 6:07 PM, Aurélien Lajoie wrote:
>>> On Wed, May 27, 2020 at 12:34 AM Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
>>>>
>>>> I'm getting three test failures and hope I can get someone to help.
>>>>
>>>> The test failures are  ipcs/mk-rm-msg, ipcs/mk-rm-sem, and ipcs/mk-rm-shm.
>>>>
>>>> Concentrating on mk-rm-msg, I found on the system:
>>>>
>>>> ./tests/output/ipcs/mk-rm-msg
>>>> ./tests/ts/ipcs/mk-rm-msg
>>>> ./tests/expected/ipcs/mk-rm-msg
>>>>
>>>> The contents of the output and the expected files are identical:
>>>
>>> How have you checked it ?
>>
>> Yes.  cmp ./tests/output/ipcs/mk-rm-msg ./tests/expected/ipcs/mk-rm-msg
>> gives no output.
>>
>>> Can be trailing spaces, final break line or other thing like this.
>>> Can you share the files and the result of ./run.sh ipcs launch from
>>> tests directory?
>>
>> -------------------- util-linux regression tests --------------------
>>
>>                       For development purpose only.
>>                    Don't execute on production system!
>>
>>          kernel: 5.6.11-lfs-9.1
>>
>>         options: --srcdir=/sources/util-linux-2.35.2/tests/.. \
>>                  --builddir=/sources/util-linux-2.35.2/tests/..
>>
>>            ipcs: headers                        ... OK
>>            ipcs: limits overflow
>> .../sources/util-linux-2.35.2/tests/../tests/ts/ipcs/limits: line 42:
>> echo: write error: Invalid argument
>>    OK
>>            ipcs: basic limits               ... OK
>>            ipcs: mk-rm-msg                  ... FAILED (ipcs/mk-rm-msg)
>>            ipcs: mk-rm-sem                  ... FAILED (ipcs/mk-rm-sem)
>>            ipcs: mk-rm-shm                  ... FAILED (ipcs/mk-rm-shm)
>>
>> ---------------------------------------------------------------------
>>     3 tests of 6 FAILED
>>
>> I'll note that I am not running as root, line 42 of ts/ipcs/limits seems
>> to want to write to:
>>
>> $ ls -l /proc/sys/kernel/shm*
>> -rw-r--r-- 1 root root 0 May 26 18:27 /proc/sys/kernel/shm_rmid_forced
>> -rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmall
>> -rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmmax
>> -rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmmni
>>
> I get this output as a non root user
>   ./run.sh ipcs
> 
> -------------------- util-linux regression tests --------------------
> 
>                      For development purpose only.
>                   Don't execute on production system!
> 
>         kernel: 5.3.0-53-generic
> 
>        options: --srcdir=/home/aurelienl/dev/util-linux/tests/.. \
>                 --builddir=/home/aurelienl/dev/util-linux/tests/..
> 
>           ipcs: headers                        ... OK
>           ipcs: limits overflow                ... SKIPPED (no root permissions)
>           ipcs: basic limits                   ... OK
>           ipcs: mk-rm-msg                      ... OK
>           ipcs: mk-rm-sem                      ... OK
>           ipcs: mk-rm-shm                      ... OK
> 
> ---------------------------------------------------------------------
>    All 6 tests PASSED
> ---------------------------------------------------------------------

OK, thanks. Some very minor progress:


   ipcs: headers                        ... OK
   ipcs: limits overflow                ... SKIPPED (no root permissions)
   ipcs: basic limits                   ... OK
   ipcs: mk-rm-msg                      ... FAILED (ipcs/mk-rm-msg)
   ipcs: mk-rm-sem                      ... FAILED (ipcs/mk-rm-sem)
   ipcs: mk-rm-shm                      ... FAILED (ipcs/mk-rm-shm)

   3 tests of 6 FAILED

But I did find

$ cat diff/ipcs/*
--- /dev/null   2020-05-13 00:30:52.352031152 -0500
+++ /sources/util-linux-2.35.2/tests/output/ipcs/mk-rm-msg.err 
2020-05-26 22:26:15.955322405 -0500
@@ -0,0 +1,2 @@
+ipcrm: failed to parse argument: '0xa12709c3
+0xa12709c3'
--- /dev/null   2020-05-13 00:30:52.352031152 -0500
+++ /sources/util-linux-2.35.2/tests/output/ipcs/mk-rm-sem.err 
2020-05-26 22:26:15.984321830 -0500
@@ -0,0 +1,3 @@
+ipcrm: failed to parse argument: '0x1e5d8a7d
+0x1e5d8a7d
+0x1e5d8a7d'
--- /dev/null   2020-05-13 00:30:52.352031152 -0500
+++ /sources/util-linux-2.35.2/tests/output/ipcs/mk-rm-shm.err 
2020-05-26 22:26:16.012321273 -0500
@@ -0,0 +1,2 @@
+ipcrm: failed to parse argument: '0x12dec276
+0x12dec276'

I just don't know what argument it was trying to pass.

   -- Bruce
