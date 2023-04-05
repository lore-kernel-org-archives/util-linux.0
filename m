Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C45C76188
	for <util-linux@archiver.kernel.org>; Wed,  5 Apr 2023 15:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbjDEPcI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbjDEPcF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 5 Apr 2023 11:32:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0681702
        for <util-linux@vger.kernel.org>; Wed,  5 Apr 2023 08:32:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d22so21973179pgw.2
        for <util-linux@vger.kernel.org>; Wed, 05 Apr 2023 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1680708723; x=1683300723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9h1dadHDAH/ZvuHonhMlwFjCGdBP/smKh/+4t/p7jl8=;
        b=LaILSBh2ES/fe2iji2GVcnnB9xPzLVaWRpgYV8gN2MQ9mV6FNiNO1JbscOLkDmd/ml
         DrNgH9oH1DPKILD+q4TIQhPPgDMsn9SILzhJN2FPP5/DAmmlxtcC1VlxHca1+13o/Yxk
         jhwOSyr9UCa1KxC7iZ2ODmjW6CWKdLJjfiRJmJ3d8jU6m113Mp3K2PpKpV+tCVDSRy7S
         gvQPmH3WsQFqjF5jGk5DofAVRUiaM4mCMws3xP//q1zVCrKNAkZKFAVimhcEaAdjadO3
         eu8vDpb1W8tiGvaN7rGrlsbfD6w13NNTukwB4ULRbIlmcMuoyX4e/ajNGfOTMY34fIiE
         EoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680708723; x=1683300723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9h1dadHDAH/ZvuHonhMlwFjCGdBP/smKh/+4t/p7jl8=;
        b=DTnRAB/miPFp+3sTw36fjTDDvHHNuqqupPPrhjzuNXF6Z/F8TPK1K39Zv4fcbsekBr
         O0YJXXgyPX56KIs5O7A8SZLdKZ5acu+92aSa/z51MohnW6xBQ2kY2xnKhS8kuFuwr+gO
         UoIgWfT8UxkdVlegutAwgy12DHI+4qyS0u2J2kSe7hITzpnHTDCdzqbWwDyBIXpzLKrc
         Jg1QDGEXf+SGFrnwDC24jeHYYO+WEWSvN8LgQ2lvuaaER1Bleh0Hmm06w06fFT1MfO58
         gKaY3gaKRBh92/0vZPBInorQO30ti0Ifko58Vv5wvC14VP+tZs/5vTkieZIaPemKZBqB
         pZmw==
X-Gm-Message-State: AAQBX9fKb94VIXVPDuLNe8hbZr56K1tTCKgVTmttU1DgfLvre7fQzLLj
        0536fcX3/P/WP0pZ8/0PQLWrTIYMmf0XwiAoxbH07w==
X-Google-Smtp-Source: AKy350ZhxwRpyu+x5oKswL3ixrsRDuZ6Kul/vEBFcOP6EIQNkVKyEPOD6FJTVbYKTpPaQ9Zy56j8EA==
X-Received: by 2002:a62:1b53:0:b0:5a8:9858:750a with SMTP id b80-20020a621b53000000b005a89858750amr3116933pfb.13.1680708723521;
        Wed, 05 Apr 2023 08:32:03 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:4457:c267:5e09:481b? ([2400:4050:a840:1e00:4457:c267:5e09:481b])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0062bc045bf4fsm11293358pfb.19.2023.04.05.08.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:32:03 -0700 (PDT)
Message-ID: <4674295f-374b-2610-66b3-c2d2828a76ff@daynix.com>
Date:   Thu, 6 Apr 2023 00:32:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] lscpu: Decouple cputype and topology
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20230405061238.11888-1-akihiko.odaki@daynix.com>
 <20230405104312.lz23yp3zafcygkpr@ws.net.home>
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230405104312.lz23yp3zafcygkpr@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023/04/05 19:43, Karel Zak wrote:
> On Wed, Apr 05, 2023 at 03:12:38PM +0900, Akihiko Odaki wrote:
> w we can merge
>> Before this change, lscpu_cputype held topology information.
> 
> I do not understand why this is a problem. The topology (number of
> threads, cores, etc.) is specific to the type of CPU, right?
> 
> I guess the sibling maps in kernel describes this.
> 
>> This
>> design is incompatible with heterogenous configurations where there are
>> several CPU types.
> 
> This design has been motivated by heterogenous systems :-)
> 
>    Model name:           Cortex-A53
>      Model:              4
>      Thread(s) per core: 1
>      Core(s) per socket: 4
>      Socket(s):          1
>    Model name:           Cortex-A72
>      Model:              2
>      Thread(s) per core: 1
>      Core(s) per socket: 2
>      Socket(s):          1
> 
> How we can display "Core(s) per socket" if we will not differentiate
> between the types?

Well, I think the output is confusing in the same way the output of
""lscpu -p=CPU,Core,Cluster,Socket" is. It says "socket(s): 1" for both 
of Cortex-A53 and Cortex-A72, but they are actually in the same socket. 
If there is a separate topology section there will be no such confusion.

Regards,
Akihiko Odaki

> 
>> One problem is that logical IDs of e.g. clusters overlap across
>> different CPU types. For example, consider a
>> 1-socket/2-cluster/1-core/1-thread system. One of the clusters has
>> "P-cores", and the other has "E-cores". P-cores and E-cores have
>> different CPU types. Before this change,
>> "lscpu -p=CPU,Core,Cluster,Socket" output something like the following
>> for the system:
>> 0,0,0,0
>> 1,0,0,0
>>
>> Note that lscpu assigns the same core/cluster ID for the two CPUs
>> although they are actually in different cores and clusters.
>>
>> To fix the inconsistency and ambiguity of such IDs, move the topology
>> information from lscpu_cputype to lscpu_cxt. For the earlier example,
>> the output will change as follows:
>> 0,0,0,0
>> 1,1,1,0
> 
> Then we need to fix _this output_, but not ignore cputypes for whole
> lscpu.
> 
>> This also changes how the topology is described in the summary which
>> lscpu prints when it is executed with no arguments. Before this change,
>> the topology information was associated with CPU types, but the
>> topology information is shown in a separate section now.
> 
> I don't like it. We had this output before lscpu rewrite and was pretty
> confusing for users.
> 
>      Karel
> 
