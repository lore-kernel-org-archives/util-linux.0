Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BF1EB64DA
	for <util-linux@archiver.kernel.org>; Mon, 26 Jun 2023 12:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjFZMCd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 26 Jun 2023 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFZMCd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 26 Jun 2023 08:02:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192741B7
        for <util-linux@vger.kernel.org>; Mon, 26 Jun 2023 05:02:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-988883b0d8fso456812866b.1
        for <util-linux@vger.kernel.org>; Mon, 26 Jun 2023 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687780950; x=1690372950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adh/yMdQAMmzIpgpb2pC8tE3VyluwB1GZiAEqDR22Vw=;
        b=ladN+56U4fnT9+lfI8kCtYX7iY/7esbR/+hK6FPybHcbB100XkcHJ4hhA6OXEOAUpt
         WzjF8ftiwvYXyVnCtVQM7L6YP4jLybVHIKnA2/PzkJREsOPVBIgxKjTs+zNFXUbhD+Lx
         VLAgpdxcsS+OoO2me7PTMhSaUQFS2NOAfdapxQg70tZSU0oCq44e4iJ9mGAuOEnb1Hw5
         7JyWz1IaRZb9EPRfrWDcEw9DQO3NdPJpMBn3CIDiAl+0JWLNAup8SyGYFhdAe3q2t5nF
         UHXyV9Zs5mcEEkfVxXPMFA8s4MP5HAxasbzCg/9m5zltwopriJ/1nFqwx/DKdCCkomA4
         d2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687780950; x=1690372950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adh/yMdQAMmzIpgpb2pC8tE3VyluwB1GZiAEqDR22Vw=;
        b=fxJh23HN3IBZmhQNnxaK/ieA5kDS0ub4AUrxOw6wyPeXGjHvBW5OL4r8Qp1rC+OaZx
         Ic0icExTUl/+9+WRH0UX8Lb/PWrR5ijV/YogDVoJOph5T5uUodzedO5inOPc0q2uLJCG
         TpN0J1r8qdrflh6jPHA6HL7rdS9tjkjsTrV0bvR5KqIU53PjvH0ObsKNIeeOA/h/OjkQ
         BhoBanieAG2XYAJUvGcqbKqznjdNjWTcobWHrhQR9qbUYAcbHJJIwkQa9InTKs1Cy73a
         5R7u9/V9CBQORPm4XiUi6UT84HTs2vHhai5c0jyXEKrkW00XcgrSH9fNqr/pYABLCZtq
         eQMA==
X-Gm-Message-State: AC+VfDwnTYmTTphSg/Lt+IJLFLihsXDYVTpMlm9DHt6Ng7skdTWb9MIo
        9cNZmPmOXUaNuYP9Os49TbY=
X-Google-Smtp-Source: ACHHUZ56sSkfkt1fj/YAA6NhuGPCWQggAhd3qX/2KgqdubDW4GhEqLO6i8OF64lUrBBBiC+leQU1wQ==
X-Received: by 2002:a17:907:3d94:b0:98c:d733:bf03 with SMTP id he20-20020a1709073d9400b0098cd733bf03mr14065825ejc.43.1687780950345;
        Mon, 26 Jun 2023 05:02:30 -0700 (PDT)
Received: from ?IPV6:2a00:6020:4892:c500:9efa:24ee:3324:f753? ([2a00:6020:4892:c500:9efa:24ee:3324:f753])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090634ce00b0098238141deasm3217450ejb.90.2023.06.26.05.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 05:02:29 -0700 (PDT)
Message-ID: <f4333bbc-5903-8729-5b88-04c1178fd418@gmail.com>
Date:   Mon, 26 Jun 2023 14:02:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] cfdisk, fix behavior after writing changes
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, 927041@bugs.debian.org
References: <CAJed8sMYhw9iYSBN5XqdJiJkiqrciT+yudDBZBRhN8pnfc6CaA@mail.gmail.com>
 <20230626113052.gzluriz2qsqmjk4a@ws.net.home>
From:   Florian Zimmermann <florian.zimmermann@gmail.com>
In-Reply-To: <20230626113052.gzluriz2qsqmjk4a@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 6/26/23 13:30, Karel Zak wrote:
> On Sun, Jun 25, 2023 at 01:31:33PM +0200, Florian Zimmermann wrote:
>> diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
>> index 2e29421d7..a05a50f3e 100644
>> --- a/disk-utils/cfdisk.c
>> +++ b/disk-utils/cfdisk.c
>> @@ -2530,6 +2530,7 @@ static int main_menu_action(struct cfdisk *cf, int key)
>>                          else
>>                                  fdisk_reread_partition_table(cf->cxt);
>>                          info = _("The partition table has been altered.");
>> +                      ui_menu_goto(cf, 2); /* after writing reset
>> next action to Quit by default */
>>                  }
> 
> It seems that 'Quit' does not have to be the second item in the menu in
> all cases. I have applied a little bit different version of  the patch:
> https://github.com/util-linux/util-linux/commit/b0d4d093796c3a3776b155e4ec7e2aa7cb09677d
> 
>   Thanks!

Thanks, your modified patch is more generic and better indeed.
CCing debian bug folks.

Florian
