Return-Path: <SRS0=fv9v=3Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AF9C2D0DB
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 15:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC02C214AF
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 15:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c90S2KqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgA0PX5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:23:57 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33122 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgA0PX5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Jan 2020 10:23:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so8736293otp.0;
        Mon, 27 Jan 2020 07:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8nlwuhilPDW0/7x/22YYrshV5g5ysiMXWxPDYxkkZg4=;
        b=c90S2KqCcU9Spe173RZaIaqEYULTLVtlKG6w+PsIVBG+J8dz+wLjh6/ACz0ToBkj24
         2YhVn/Wr980A4EHjWmKSqsILhHuYmE0Z6zt4dS659jj928VYpi3WpJa6pRtNZaIYztjx
         g2UF1qlLciUIlgu8G2ZR9NW2ETa5waKb8YmpWe4/njhIlhwG4ITpGcQTw1+EePs/kbsy
         QE7p2EY3rz4q3juQab91UjfNcRwUbUcVOyIaxOzEi5gfcaJkkmF3OHIQ0X7y0QVGsPBz
         lUbUIseDkP2el33eHoI0a75zK612QcQ2Znh5nk9SdNh8ltDs/232D3LZDghIElPCAoD/
         PYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8nlwuhilPDW0/7x/22YYrshV5g5ysiMXWxPDYxkkZg4=;
        b=aAPbTgohepi06brwTGOiXF4eS0qn8NhsCwlYa7KkXWJDvFHitH51pu7BuvOuZ7gkEY
         ugug7JQAbzjmRe4mrZDi63IN1VMyyoidAUcKl4Fk4KGDJXyC2d89/3/h/WBx5wMFmUty
         wE8rf/htwuqgDZEOoK9tREriyFwpx2jzqk6V/TW/Fg1YyRBcB3wLtneG7F01/aoHj9Cr
         +S/c+LotBnpGBJWk5Ro785Ibbiuy5ptTTm4S4wtt2l9qv3+52keNRWuyAINCDzJXKwcC
         h1fyRx0MBpzLsbWhcth93WJX3WsaRIjffvbc/2T/zLv+H09yUlPob8KuifS2+0dMtVn7
         j12A==
X-Gm-Message-State: APjAAAUlVp+A+DEtocbrnvbRIYF+81PYBbvv6fE23Zj95Mpdsdv62wTP
        9eUn+EMgMYaarhf2hPbKgQ==
X-Google-Smtp-Source: APXvYqyZFyiwja1wY31pnmCfRcMt47hU6OmmfiZi1qDVxRXhAdoKSMx2r0g9a9LlhpfPhYGEBRKVZA==
X-Received: by 2002:a9d:7f98:: with SMTP id t24mr7770244otp.338.1580138636743;
        Mon, 27 Jan 2020 07:23:56 -0800 (PST)
Received: from [10.236.30.189] ([165.204.77.1])
        by smtp.gmail.com with ESMTPSA id t203sm4872051oig.39.2020.01.27.07.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 07:23:56 -0800 (PST)
Subject: Re: [PATCH RFC] drivers/base/memory.c: indicate all memory blocks as
 removable
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        powerpc-utils-devel@googlegroups.com, util-linux@vger.kernel.org,
        Badari Pulavarty <pbadari@us.ibm.com>,
        Robert Jennings <rcj@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Karel Zak <kzak@redhat.com>
References: <20200124155336.17126-1-david@redhat.com>
 <ddb71703-81fa-53fe-51de-c018612f2704@gmail.com>
 <20200127092334.GB1183@dhcp22.suse.cz>
 <d2b3adaa-bd4d-d105-f8ab-0301409bbd5f@redhat.com>
From:   "Fontenot, Nathan" <ndfont@gmail.com>
Message-ID: <c5059edf-1fdd-1203-4717-2512e8c364be@gmail.com>
Date:   Mon, 27 Jan 2020 09:23:55 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d2b3adaa-bd4d-d105-f8ab-0301409bbd5f@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 1/27/2020 3:33 AM, David Hildenbrand wrote:
> On 27.01.20 10:23, Michal Hocko wrote:
>> On Fri 24-01-20 13:10:22, Fontenot, Nathan wrote:
>>> It's been awhile since I've looked at the powerpc-utils drmgr command and
>>> pseries DLPAR code but a quick scan makes and it appears that it hasn't changed
>>> too much. Given that, some thoughts.
>>>
>>> The sysfs 'removable' file was a great help when memory DLPAR was driven
>>> from userspace in the powerpc-utils drmgr command. Having this check did improve
>>> performance though I can't point to any numbers.
>>
>> Do you still have an access to the HW to give it a try?

No, I no longer have access to Power hardware.

-Nathan

>>
>>> Currently, memory DLPAR is done completely in the kernel. The request is
>>> initiated from drmgr writing to /sys/kernel/dlpar (for pHyp partitions)
>>> or from a hotplug interrupt (for guests). I don't believe the 'removable'
>>> sysfs file is used in either of these paths by drmgr. The only time it is
>>> used is on older kernels that do not support in-kernel memory DLPAR.
>>>
>>> Given this, I don't think removing the 'removable' sysfs file would cause any
>>> issues for the drmgr command. The only scenario I can think of is using an old
>>> version of drmgr that does not support in-kernel memory DLPAR on a new kernel
>>> where the 'removable' sysfs file has been removed. This doesn't seem likely
>>> though and drmgr could be updated to detect this.
>>
>> Thanks for the information!
>>
> 
> (weird, I never received the mail from Nathan - mail deliver issues
> brighten my Mondays :) )
> 
> Thanks for the information! Looks like powerpc indeed can live without
> the interface (old userspace on shiny new kernel would in the worst case
> simply be slower).
> 
> Of course, the alternative to returning always "removable" would be to
> drop the attribute completely. So, if the "removable" attribute is not
> present
> 
> - powerpc-utils will fallback to "removable"
> - lsmem will fallback to "not removable". Could be because it assumes
>   "old kernel with lacking offlining capability".
> 
> I don't know how likely it is that this could break custom scripts that
> used the returned value for any purpose (e.g., use it as an indicator if
> memory offlining is supported at all etc.).
> 
