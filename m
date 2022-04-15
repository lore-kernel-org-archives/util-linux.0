Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA7EC433EF
	for <util-linux@archiver.kernel.org>; Fri, 15 Apr 2022 03:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349075AbiDODhd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 14 Apr 2022 23:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbiDODhc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 14 Apr 2022 23:37:32 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC02AE20
        for <util-linux@vger.kernel.org>; Thu, 14 Apr 2022 20:35:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bg9so6362196pgb.9
        for <util-linux@vger.kernel.org>; Thu, 14 Apr 2022 20:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QSPBChuEC5et2Ot8xKYz19M3Ni0XWhr2tzaJPTB1Aq0=;
        b=K8slxlyr0gKALrsvYpETfWkZuYzcgff2j+AWqxzfXgSByjAF73VNjy+CHhpjNtMbrU
         NG1WkuZgkLT/KBhPdNAhiHGHf6dMUek7lJBsDk0duKM20+sm2EbGAB5VllBgBa7BZ3PM
         e3TxhBuKSd/0iZtbVuipvA7/nq/KptHbDVNxSyB34P6qhjvxNuuHo9fuFW+lqUQycawC
         fUW2BEPcREoZYGhk8ZfSQ0uCDLmCLKxurtGPoq43kaK/KaHkyv1gq6d1UhOIrAaK6H72
         KbTTZaPKY9mdLZAxeWM6RuzCmz29FefaXqZxVvPzEfVGNxilBwSE1Egqx7zVLlSn7LL2
         JGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QSPBChuEC5et2Ot8xKYz19M3Ni0XWhr2tzaJPTB1Aq0=;
        b=Ru+Iq+SdvZpM9mi2pnPtCTlfaGtbvWYPxUWhonAmaw9lH4sQaKX9lDABP//WbhOLWt
         zDnIhGzafiJiigbA770I2C5mjYQjuyp2dT4iBILPrBmd8EwaAVHZKdinWNGDYc6Oi0lc
         jpu3TOh2EB/bs+N0slz7jWWTfAXwS63wFs+8v/arlbE2hVrjPb9a5j0EEkkWc34uAOJM
         YdqWJ9V+FUSREl3D85xowrIRsf4EIfAQT1jVBzITHwzuR0mt1Y2gtT2Uw8/vjAXjedry
         JFQ3JeIzztKICwR/uYqxg1xmXzbd4fREyGWW0lr1JOwXkNXnKs0x20U6CNhpAdwN4sJW
         N50w==
X-Gm-Message-State: AOAM533frOpxzM1vKOmC4pf9NnqZT4QQ2JUOTIorzAaLtc8FXpvCQoow
        /s8YJxdhgiS8IQZeCK1w7xTPqKzEjzTSpw==
X-Google-Smtp-Source: ABdhPJxL7niQcIX3W/qB2GSU04Ae2o/VjT0boY/S6xSUOn8GT5DwbTV2UFLL/U4E6O88n1vz23ym3Q==
X-Received: by 2002:aa7:8d54:0:b0:4e0:bd6:cfb9 with SMTP id s20-20020aa78d54000000b004e00bd6cfb9mr6895321pfe.60.1649993704528;
        Thu, 14 Apr 2022 20:35:04 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id s7-20020aa78bc7000000b005082ddeb6f8sm1208682pfd.199.2022.04.14.20.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 20:35:03 -0700 (PDT)
Message-ID: <6f22345a-8351-ae01-7df2-c2d31ccd5956@bytedance.com>
Date:   Fri, 15 Apr 2022 11:31:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] build-sys: add blkpr to gitignore
Content-Language: en-US
To:     Enze Li <lienze@kylinos.cn>, util-linux@vger.kernel.org
References: <20220415033125.3409425-1-lienze@kylinos.cn>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220415033125.3409425-1-lienze@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 4/15/22 11:31, Enze Li wrote:
> Since this commit 627428a95692 ("blkpr: add block persistent
> reservations command"), we introduced blkpr, but the compiled generated
> binary file is not added to the gitignore, so let's do it.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>   .gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 3274563ec..0effa8945 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -73,6 +73,7 @@ GSYMS
>   /addpart
>   /agetty
>   /blkdiscard
> +/blkpr
>   /blkzone
>   /blkid
>   /blockdev
Hi, Enze

Could you please reorder blkXX together to make them all in order?

-- 
zhenwei pi
