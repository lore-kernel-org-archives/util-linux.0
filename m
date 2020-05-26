Return-Path: <SRS0=W0VW=7I=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9A7C433E0
	for <util-linux@archiver.kernel.org>; Tue, 26 May 2020 23:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23CB82075F
	for <util-linux@archiver.kernel.org>; Tue, 26 May 2020 23:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVvx1PQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgEZXgu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 26 May 2020 19:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgEZXgu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 26 May 2020 19:36:50 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF38C061A0F
        for <util-linux@vger.kernel.org>; Tue, 26 May 2020 16:36:50 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s198so20229562oie.6
        for <util-linux@vger.kernel.org>; Tue, 26 May 2020 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HAvEKRrYgQjeXrn5tjx7j2PUApYkacgWuNC25w+Ta7Y=;
        b=oVvx1PQ6u6G1fN5VlFtncqmChTnp84uavag6A1+UJLWR0SJKym/lmKF4docn8i/6DJ
         Hg0hOM0ywT714DJWhgd0msOl4dorXpJoGMsw11ZWJHGIDlibvQsRJjt50k5rnzAlPxxP
         eVlnGZ5gyojkbkR4GXEADjq/W1MC12IWRDKFLm23ZYQ0JAV1AfUk49vHKltwp2xy6hg5
         AbVrr3YNITnBxRmhi92Ff/uJQAxBGja2PFt8j8ss7rSCMxF//QUyqoFi1Knf/foWimYt
         0Tt5eQU8K8jLZ2snQhC/Z+yEOjv6kbx/C6tjhS2Rnx2teeEExxZL5nMriTx0GSpV6Bu/
         2i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HAvEKRrYgQjeXrn5tjx7j2PUApYkacgWuNC25w+Ta7Y=;
        b=j7E6IqDFuMdIaM9JKYRTocVS+koiFx5VJ85/HvcBQQ7PtlCwtGqL4CePiw8QNJUDNe
         1fAPE44JEA1ZT1tjEtF2gBLAPIj9aAUxjsuPfYp+UXpkyCRUqoV1zL6NfPTRxltuUP5h
         7RwTOkA10fx6gfwJYOCuzYWpShuB2/xvQq2QkcuGrtlhFmh4H07A6q6Um+DNuddHTRbm
         yU/DAhCd/Fshu7pgcXRS/zJ0a7F7ECkNcAiEER5kIigkLTkfZRhgb6r5ZNRI49rsIEfb
         gKE2p6bpT0aE8p665olNqXH0/ArXdi6b4WWhJ11q2csu1KNCmuN4PGCOi6y2d4ZG9TCw
         9O7Q==
X-Gm-Message-State: AOAM5338qIroiETkxE0gpt27DxKBL6/qOQxOG/CqD2bSDh3SdofvTcPV
        nM070YeBeipEgXNjksdjamRZq4XC
X-Google-Smtp-Source: ABdhPJyfT31ORtQZUXMKru0LsLqxabBSbROrBDuonQB3PDhoFWXJT9zKSyXUUirnX5MrvW2iCbdYYA==
X-Received: by 2002:aca:358b:: with SMTP id c133mr882705oia.46.1590536209511;
        Tue, 26 May 2020 16:36:49 -0700 (PDT)
Received: from [192.168.0.91] (cpe-70-123-227-116.satx.res.rr.com. [70.123.227.116])
        by smtp.gmail.com with ESMTPSA id 89sm343731oth.9.2020.05.26.16.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 16:36:49 -0700 (PDT)
Subject: Re: util-linux-2.35.2 test failures
To:     =?UTF-8?Q?Aur=c3=a9lien_Lajoie?= <orel@melix.net>,
        Util-Linux <util-linux@vger.kernel.org>
References: <6b88784c-b130-27d4-2ec5-0d25320dd6fb@gmail.com>
 <CAA0A08W0S8ZnZXJ1D0VDnC6qZ4F0sYP_tr9qK7_7Fxi5HGOqAw@mail.gmail.com>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <4999c47d-969a-a103-3d6a-60498f1fc959@gmail.com>
Date:   Tue, 26 May 2020 18:36:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAA0A08W0S8ZnZXJ1D0VDnC6qZ4F0sYP_tr9qK7_7Fxi5HGOqAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 5/26/20 6:07 PM, Aurélien Lajoie wrote:
> On Wed, May 27, 2020 at 12:34 AM Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
>>
>> I'm getting three test failures and hope I can get someone to help.
>>
>> The test failures are  ipcs/mk-rm-msg, ipcs/mk-rm-sem, and ipcs/mk-rm-shm.
>>
>> Concentrating on mk-rm-msg, I found on the system:
>>
>> ./tests/output/ipcs/mk-rm-msg
>> ./tests/ts/ipcs/mk-rm-msg
>> ./tests/expected/ipcs/mk-rm-msg
>>
>> The contents of the output and the expected files are identical:
> 
> How have you checked it ?

Yes.  cmp ./tests/output/ipcs/mk-rm-msg ./tests/expected/ipcs/mk-rm-msg 
gives no output.

> Can be trailing spaces, final break line or other thing like this.
> Can you share the files and the result of ./run.sh ipcs launch from
> tests directory?

-------------------- util-linux regression tests --------------------

                     For development purpose only.
                  Don't execute on production system!

        kernel: 5.6.11-lfs-9.1

       options: --srcdir=/sources/util-linux-2.35.2/tests/.. \
                --builddir=/sources/util-linux-2.35.2/tests/..

          ipcs: headers                        ... OK
          ipcs: limits overflow 
.../sources/util-linux-2.35.2/tests/../tests/ts/ipcs/limits: line 42: 
echo: write error: Invalid argument
  OK
          ipcs: basic limits               ... OK
          ipcs: mk-rm-msg                  ... FAILED (ipcs/mk-rm-msg)
          ipcs: mk-rm-sem                  ... FAILED (ipcs/mk-rm-sem)
          ipcs: mk-rm-shm                  ... FAILED (ipcs/mk-rm-shm)

---------------------------------------------------------------------
   3 tests of 6 FAILED

I'll note that I am not running as root, line 42 of ts/ipcs/limits seems 
to want to write to:

$ ls -l /proc/sys/kernel/shm*
-rw-r--r-- 1 root root 0 May 26 18:27 /proc/sys/kernel/shm_rmid_forced
-rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmall
-rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmmax
-rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmmni


   -- Bruce




