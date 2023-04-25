Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05C3C6FD18
	for <util-linux@archiver.kernel.org>; Tue, 25 Apr 2023 18:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjDYS3y (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjDYS3x (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 25 Apr 2023 14:29:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB94AD3B
        for <util-linux@vger.kernel.org>; Tue, 25 Apr 2023 11:29:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so7993036b3a.2
        for <util-linux@vger.kernel.org>; Tue, 25 Apr 2023 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1682447390; x=1685039390;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZEp9+OadyASNtyX3IaRAp8zWYch/FOrRPtVp38Dur9A=;
        b=pP2bo9a7amhnGgAX4EllkFU7pqKrxjk4WBYJkxR1ISm8IMgxCwRiCZD3P+19sMxyzP
         XKnSSVcZ8JnsTgaQV22XhCXZjAeTU1abtFzrpnb8YdPnpRex1eEX20975VM8Jex8zPyb
         U6lOmq1Wd9DvZKahwHy0QV9YRaojDHh+1ZgADZpz+J7VQpLi4TOgDhlpqTJt0x15icc7
         DGXC+8PzfZy99wKSO16SemO4vSCyoFCtBJhD2ber1LjPWn/XnF7RkokqaLyCKQRr2gz0
         Z+PprnLB7XM0ocCUliWjWgS/NWiVDPVvqPbOmITBdZmh8XPLSgK7zUNJv6teYFwEZWTF
         cOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682447390; x=1685039390;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEp9+OadyASNtyX3IaRAp8zWYch/FOrRPtVp38Dur9A=;
        b=LzvrYfJhEv9BgUeXOYCBEzEBy0naOZ8fixN8YDP/C2ALj3qXVhwl0wcyPrUWpBPlA7
         JgbmHhnrWNOOJ/RjenPaVBMsw05TTe6eKvJy2+FQFP61JylJFuwZwXJNdzmqG6IiVami
         wNGCnULpquq7NtkuILrtZshOvP56UwQ2Q0SaOX8oA9Zyy6inAoLI4UTNk0DEK345MH5L
         k/s+c7V2+XwGBvawAcgcB+J1j6kjNci42TWW1+uoI/cnq/8+z1eAj67e81ltKjivOr5O
         oIX/4kQDL1FhdoM+ioChu5RdacEbbq4qXnydI72rNvkxZrf3tlWvie7wz7DmXO6hfZBp
         Bk6g==
X-Gm-Message-State: AAQBX9f2LAo5XLyDQB/2e4I05krV/bAsCnY4iwykXtNq3rXck22T9nvT
        l6uWekLJFZuDqnKKGqzxLM9ekzTUyiNDQAOaXO0=
X-Google-Smtp-Source: AKy350ZVOi909Tqq3kZANT6/zm1cgdz0ChhgLO/J+waP8aXsKoltC0THBIdHThkFUXcK16+9ZMKLpA==
X-Received: by 2002:a05:6a20:2d0a:b0:ee:d553:5cee with SMTP id g10-20020a056a202d0a00b000eed5535ceemr20136542pzl.16.1682447389732;
        Tue, 25 Apr 2023 11:29:49 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:4457:c267:5e09:481b? ([2400:4050:a840:1e00:4457:c267:5e09:481b])
        by smtp.gmail.com with ESMTPSA id o15-20020a655bcf000000b0050bc4ca9024sm7870995pgr.65.2023.04.25.11.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 11:29:49 -0700 (PDT)
Message-ID: <5092a67c-0b86-134a-df77-433a6db10900@daynix.com>
Date:   Wed, 26 Apr 2023 03:29:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] lscpu: Decouple cputype and topology
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20230405061238.11888-1-akihiko.odaki@daynix.com>
 <20230405104312.lz23yp3zafcygkpr@ws.net.home>
 <4674295f-374b-2610-66b3-c2d2828a76ff@daynix.com>
Content-Language: en-US
In-Reply-To: <4674295f-374b-2610-66b3-c2d2828a76ff@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023/04/06 0:32, Akihiko Odaki wrote:
> On 2023/04/05 19:43, Karel Zak wrote:
>> On Wed, Apr 05, 2023 at 03:12:38PM +0900, Akihiko Odaki wrote:
>> w we can merge
>>> Before this change, lscpu_cputype held topology information.
>>
>> I do not understand why this is a problem. The topology (number of
>> threads, cores, etc.) is specific to the type of CPU, right?
>>
>> I guess the sibling maps in kernel describes this.
>>
>>> This
>>> design is incompatible with heterogenous configurations where there are
>>> several CPU types.
>>
>> This design has been motivated by heterogenous systems :-)
>>
>>    Model name:           Cortex-A53
>>      Model:              4
>>      Thread(s) per core: 1
>>      Core(s) per socket: 4
>>      Socket(s):          1
>>    Model name:           Cortex-A72
>>      Model:              2
>>      Thread(s) per core: 1
>>      Core(s) per socket: 2
>>      Socket(s):          1
>>
>> How we can display "Core(s) per socket" if we will not differentiate
>> between the types?
> 
> Well, I think the output is confusing in the same way the output of
> ""lscpu -p=CPU,Core,Cluster,Socket" is. It says "socket(s): 1" for both 
> of Cortex-A53 and Cortex-A72, but they are actually in the same socket. 
> If there is a separate topology section there will be no such confusion.
> 
> Regards,
> Akihiko Odaki

Hi,

Can you have a look at this again? My opinion here is we cannot reliably 
tell "core(s) per socket" or "socket(s)" which belongs to a CPU type 
because we do not know what separates CPU types.

For example, if you have different CPUs on different sockets, it makes 
sense to provide "core(s) per socket" and "socket(s)" values for each 
CPU type. However, if a CPU on a socket has a few clusters with 
different CPU types, they do not make sense. Of course we can have 
"core(s) per cluster" and "cluster(s)" values for each CPU type in such 
a case, but determining what distinguishes CPU types (cluster or socket, 
or possibly even something else?) introduces more complexity.

However I'm recently wondering if completely removing topology 
information from CPU types is not ideal either. Perhaps each CPU type 
can have a new value, "CPU(s) list" as the NUMA section does. It will 
not tell about topology as much as the current topology information tied 
with CPU types does, but you need something like "lscpu 
-p=CPU,Core,Cluster,Socket" for complete topological information even 
now. A CPU list is not confusing at least and concise.

It also allows to associate the CPU type information in the summary with 
the output of "lscpu -p=CPU,Core,Cluster,Socket". This information is 
also useful to run taskset to bind a process to a specific CPU type and 
e.g. to compare performance of big and LITTLE cores.

Regards,
Akihiko Odaki

> 
>>
>>> One problem is that logical IDs of e.g. clusters overlap across
>>> different CPU types. For example, consider a
>>> 1-socket/2-cluster/1-core/1-thread system. One of the clusters has
>>> "P-cores", and the other has "E-cores". P-cores and E-cores have
>>> different CPU types. Before this change,
>>> "lscpu -p=CPU,Core,Cluster,Socket" output something like the following
>>> for the system:
>>> 0,0,0,0
>>> 1,0,0,0
>>>
>>> Note that lscpu assigns the same core/cluster ID for the two CPUs
>>> although they are actually in different cores and clusters.
>>>
>>> To fix the inconsistency and ambiguity of such IDs, move the topology
>>> information from lscpu_cputype to lscpu_cxt. For the earlier example,
>>> the output will change as follows:
>>> 0,0,0,0
>>> 1,1,1,0
>>
>> Then we need to fix _this output_, but not ignore cputypes for whole
>> lscpu.
>>
>>> This also changes how the topology is described in the summary which
>>> lscpu prints when it is executed with no arguments. Before this change,
>>> the topology information was associated with CPU types, but the
>>> topology information is shown in a separate section now.
>>
>> I don't like it. We had this output before lscpu rewrite and was pretty
>> confusing for users.
>>
>>      Karel
>>
