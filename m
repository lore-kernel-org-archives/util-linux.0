Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5F1C433EF
	for <util-linux@archiver.kernel.org>; Wed,  6 Apr 2022 12:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiDFMGn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiDFMGe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2022 08:06:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89BB1B2C7F
        for <util-linux@vger.kernel.org>; Tue,  5 Apr 2022 19:16:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so4439474pjn.3
        for <util-linux@vger.kernel.org>; Tue, 05 Apr 2022 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LghO4gQVNnkmiCJTBGyiyPYZhH26qt/5kjAgyyjUHrs=;
        b=CmXcyjQ+Pdu1KtCyZgJAtA3HpwftE/N9WySPajCxOASQVXc1m4rtp6i1UrmCtpJ85K
         szS+OtAKwx0B9SFTyqjZOGoYg2r+0qv/I5WvL1Ttb2LJ0hTTt5uKVlg6qpSYOkEDTi6Z
         cO6+A4fxjOZwErauDl0y2doOaeglf6uvS2wLxCA5qrd1HrgCxpAczn1ZMs4VE9ppcr4s
         arLYAkSCP0C8nyfDbC4Zuce/QalZORD23fEdBGkl1sBXFuXuRbbkiYEyQsl+na5LIn+M
         uoy/MIouudZK8Gxsd/u3p0xJc6oyYsnX7R0nMvPmftWgfc/5tEXvXhRnj39qGGcB7E2O
         II4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LghO4gQVNnkmiCJTBGyiyPYZhH26qt/5kjAgyyjUHrs=;
        b=UbBmmQCPVxmJi0I5LMltPEKuZwMQMzCb3WhQcLKIG2Qc5cxZsUNjFDQJqrROWt8NSk
         pqUTR//RNBEWjvQGCUhU1+f7clmq3f03tx8ITXZVZGab2Pov+sgCZzOmPqgnv3KJEqTn
         jCvHh9sbSQg0HV4SeT2BNJolOYn1SWZxUpHnFcY3BU67Wxb2t6OIviscny2qnm5HCiHM
         8UaVHQVNw0O0o3IjU7yjt5UROvtxtCHAhAkvN7a5VhR0n7kkYRmKW0PDlKZfsI3NDSas
         IbpE2UE9II8nBGMGyDWfq86erLsKaCdd5hSZAjmUuUti2ZtG/PcsqjvdhVmoszsDxjpH
         HcpQ==
X-Gm-Message-State: AOAM5338jdgDGPa79zAgi/ewuHX9wiBVwztafkKNbm45aUT5Y6x03JuH
        dkIRq46inovxxJABps/kUS9gWHZPQOgzkA==
X-Google-Smtp-Source: ABdhPJzveBmYJCGcpjFzrkRZmjJ1+aynDPPM1PxGYMpFlCA5teJCHusD0RNhPvxC3Xz5Ea28FnLZoA==
X-Received: by 2002:a17:902:e882:b0:154:445d:9818 with SMTP id w2-20020a170902e88200b00154445d9818mr6463115plg.40.1649211391380;
        Tue, 05 Apr 2022 19:16:31 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id s24-20020a63af58000000b003981789eadfsm14198951pgo.21.2022.04.05.19.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 19:16:30 -0700 (PDT)
Message-ID: <f9e3fb29-a4ee-06a8-238f-ef1caade0234@bytedance.com>
Date:   Wed, 6 Apr 2022 10:13:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Re: [PATCH] blkpr: add block persistent reservations command
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, kzak@redhat.com
Cc:     util-linux@vger.kernel.org
References: <20210916032901.2189336-1-pizhenwei@bytedance.com>
 <YkvsUl9ZZOC7j70X@infradead.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <YkvsUl9ZZOC7j70X@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 4/5/22 15:14, Christoph Hellwig wrote:
> Any reason this never got picked up or commented on?
>This seems to have been ignored.

Hi Karel,
Could you please give me any hint?

> On Thu, Sep 16, 2021 at 11:29:01AM +0800, zhenwei pi wrote:
>> Linux kernel block layer supports PR (persistent reservations) ioctl
>> on a block device. Typically SCSI and NVMe disk support PR feature,
>> and blkpr could operation on them.
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   configure.ac            |  11 ++
>>   sys-utils/Makemodule.am |   8 ++
>>   sys-utils/blkpr.8.adoc  |  64 ++++++++++
>>   sys-utils/blkpr.c       | 277 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 360 insertions(+)
>>   create mode 100644 sys-utils/blkpr.8.adoc
>>   create mode 100644 sys-utils/blkpr.c
-- 
zhenwei pi
