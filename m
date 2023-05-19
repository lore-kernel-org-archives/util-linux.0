Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618DFC77B75
	for <util-linux@archiver.kernel.org>; Fri, 19 May 2023 22:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjESW4j (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 May 2023 18:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjESW4i (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 19 May 2023 18:56:38 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127CDD2;
        Fri, 19 May 2023 15:56:37 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-199bcf78252so2872896fac.3;
        Fri, 19 May 2023 15:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684536996; x=1687128996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01F6L2T4pjLkKQmZA6gKcdxUdxVxb3DuCpizwvjV8kc=;
        b=g12E5fXHBR2Yx6PnNk36Eurn+OLKY5+4IwwTP1Ue0WJrFUGyoIk2HUDLN+B9jDGze8
         DQk1A1KlWvm6BtMtGOPPxqXBH5RPLjciuHZOFL8C+W2feRLuoFCtrX1YxHtLf4DP198b
         g3TlUdopP28iOgpxvkwdsrs2srGxshVb4vmF0ZHi7FHKYN65LcpjTHmOzJuNKKY28sDI
         OnSlnrFxtOKEyFlkNFjR51he8O3PH/mIXZMLoScGyVc5eTPE+y42XxMM9Qmjt37JsBhs
         2TiMYkgRd27DAMrWUiXudpFuSBiF4V6/hetF2y2HKdmkP+VEv1LbwxJtSocogiEFAGx/
         rw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536996; x=1687128996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01F6L2T4pjLkKQmZA6gKcdxUdxVxb3DuCpizwvjV8kc=;
        b=X+wfmgHQ+mn5XSqDKtI7Y/GKtRNEEvoXv6zxCOgJEJxRj4gTJYuECPZ6O5fVUKLmG6
         VIx5OSDasEb3APdnoHjn5OhW+o5NBvNhlZK2sSMSPlhTqb60Enmm4ndeSuqGfCXHrXlG
         rQv+PnE/LbUv+QdJ/bHgBFj43pNZd1cjWeuidm5CN3+FQJU5tRAhMnMeSNb+exbI7Cth
         PBhpTNKJop//zQga0oCfpNSF5iXZhKYDcHm3DTM2RfftUOaqa9iFaVdt7C8lynP2gqZC
         fj5U1treGnCmTdQ49H7TamRoERqdMT4am0kse+2NI9ZulTyDQRFREuGscHnR4Ii07oTJ
         qZfw==
X-Gm-Message-State: AC+VfDyrAi5K+dO3Bx9QEN/hhrPrFKkpN8SE9aUX4EGzcAC5VzYx8jPK
        mmhyfNV6XBSlvKUNa1Psw14=
X-Google-Smtp-Source: ACHHUZ430RfMVA9lT0Ci0zMkelFDaQe3W/2SZ/z8+uKvIrDt/nPEcQn6paR3oUnFpG7TuZ2oNRkZ6g==
X-Received: by 2002:a05:6870:a344:b0:184:4117:4bc6 with SMTP id y4-20020a056870a34400b0018441174bc6mr1794676oak.30.1684536996253;
        Fri, 19 May 2023 15:56:36 -0700 (PDT)
Received: from [192.168.0.92] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id v19-20020a4a9753000000b00541854d066bsm203611ooi.10.2023.05.19.15.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 15:56:35 -0700 (PDT)
Message-ID: <2fc8421e-634a-aa7d-b023-c8d5e5fa1741@gmail.com>
Date:   Fri, 19 May 2023 17:56:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [ANNOUNCE] util-linux v2.39
Content-Language: en-US
To:     Masatake YAMATO <yamato@redhat.com>
Cc:     kzak@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        renodr2002@gmail.com
References: <20230517112242.3rubpxvxhzsc4kt2@ws.net.home>
 <652d32c5-4b33-ce3a-3de7-9ebc064bbdcb@gmail.com>
 <20230520.074311.642413213582621319.yamato@redhat.com>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
In-Reply-To: <20230520.074311.642413213582621319.yamato@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 5/19/23 17:43, Masatake YAMATO wrote:
> Bruce,
> 
>> On 5/17/23 06:22, Karel Zak wrote:
>>> The util-linux release v2.39 is available at
>>>                                        http://www.kernel.org/pub/linux/utils/util-linux/v2.39
>>>                                     Feedback and bug reports, as always, are welcomed.
>>
>> Karel, I have installed util-linux v2.39 in LFS and have run into a
>> problem with one test, test_mkfds.  Actually the test passes, but does
>> not clean up after itself. What is left over is:
>>
>> tester 32245 1 0 15:43 ?  00:00:00 /sources/util-linux-2.39/test_mkfds
>> -q udp 3 4 server-port=34567 client-port=23456 server-do-bind=1
>> client-do-bind=1 client-do-connect=1
>> tester 32247 1 0 15:43 ?  00:00:00 /sources/util-linux-2.39/test_mkfds
>> -q udp6 3 4 lite=1 server-port=34567 client-port=23456
>> server-do-bind=1 client-do-bind=1 client-do-connect=1
>>
>> It's possible it may be due to something we are doing inside our
>> chroot environment, but we've not had this type of problem with
>> earlier versions of util-linux.
>>
>> In all I do have:
>>
>>    All 261 tests PASSED
>>
>> but the left over processes interfere later when we try to remove the
>> non-root user, tester, that runs the tests.  I can work around the
>> problem by disabling test_mkfds, but thought you would like to know.
> 
> Thank you for reporting.
> Reproduced on my PC. I found two processes were not killed properly.
> 
> Could you try the following change?
> 
> diff --git a/tests/ts/lsfd/option-inet b/tests/ts/lsfd/option-inet
> index 21e66f700..70cc3798d 100755
> --- a/tests/ts/lsfd/option-inet
> +++ b/tests/ts/lsfd/option-inet
> @@ -84,14 +84,10 @@ ts_cd "$TS_OUTDIR"
>                     -o ASSOC,TYPE,NAME \
>                     -Q "(PID == $PID0) or (PID == $PID1) or (PID == $PID2) or (PID == $PID3) or (PID == $PID4)"
>   
> -    kill -CONT "${PID0}"
> -    wait "${PID0}"
> -
> -    kill -CONT "${PID1}"
> -    wait "${PID1}"
> -
> -    kill -CONT "${PID2}"
> -    wait "${PID2}"
> +    for pid in "${PID0}" "${PID1}" "${PID2}" "${PID3}" "${PID4}"; do
> +       kill -CONT "${pid}"
> +       wait "${pid}"
> +    done
>   } > "$TS_OUTPUT" 2>&1
>   
>   ts_finalize

I will do that, but will not be able to get to it until late tomorrow, but will 
report back asap.

Thanks for looking at this.

   -- Bruce


