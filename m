Return-Path: <SRS0=c7ae=57=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AD5C2BA19
	for <util-linux@archiver.kernel.org>; Wed, 15 Apr 2020 22:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19C620784
	for <util-linux@archiver.kernel.org>; Wed, 15 Apr 2020 22:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyUqQMoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgDOWFC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727919AbgDOWFB (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Apr 2020 18:05:01 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164B8C061A0C
        for <util-linux@vger.kernel.org>; Wed, 15 Apr 2020 15:05:01 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id m18so1383753otq.9
        for <util-linux@vger.kernel.org>; Wed, 15 Apr 2020 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YdfRaJDHj138EUIQmD9gtS7YrzpATfu6OV9/jURyUdg=;
        b=JyUqQMoPgWKh3a9o41JTcwHqKQmY63zcKkYUlbuVMsvU6uPhfvXCNzVQ9g5UO6TlE4
         b3RGhsPeXDXk0gmOkJhVHojOCDFwI9lsMzYwTDWFx4QvHlgEPVj6e+GIPPGbGZmuy0c2
         pzbPoSZk8C+51DSmvyVKaGYzms6DyLbIcXArqKE1YN944uTtpqIgfJpkw1tOEp3/+h2h
         90zQNTNrAkFCz1cr+kZz+frnGeRWp+gqa5r/dhN/BiZi72ajwU1/B74j3nxotrt/Eoa8
         n7xU/sYpNS1FLhAU7igAlKnHygjEN6iqL5Rux8z8GXLFsLucouKennalz+vZgIA+EK6V
         M3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YdfRaJDHj138EUIQmD9gtS7YrzpATfu6OV9/jURyUdg=;
        b=saZQB7bS7liXc3cQMcBrfC45HeIlr7OXNsl+gNkAJZQvMbufuvUgzvjnS31fUrcIX3
         57eEdcKMjKaztLvPpGh+th2HtiD9rxdSs05jzBhZjaR5gXPvc3qZ5P2q+9Fwl0gQP9c1
         CDvBTm19O+ofIv48LfAOcFrK32u+egqggpIgqR7mdyRBZF0fYfPcSQnXn0c7aZT/LW5Z
         +6BwJDTMZMQox1fwu2sP1PyXer94LjEQwDhrPAtA4OZPx5pukB+ail9i6FY4fIaAWL90
         gp+TFYuC58MsU1YG1NvRlhD/1l6z7uziYwuqxhV/kKuWOXmvFutiXR/0ACIcCczGFl47
         waWw==
X-Gm-Message-State: AGi0PuZiPhHFrFrND7DB7wRdugWY6rxYNm+JUSJCCQUGgE0MopJCS5Iv
        5SmI09LtJq11XbPf/rGOIsSDGXM/
X-Google-Smtp-Source: APiQypLL/ueU2d43t4YLqlGZDeTojN4mNcDjFHaBXERHa4NzzPFjc8WNH93scMyLpkROEijiqaABpg==
X-Received: by 2002:a9d:6303:: with SMTP id q3mr25012890otk.296.1586988299382;
        Wed, 15 Apr 2020 15:04:59 -0700 (PDT)
Received: from [192.168.0.91] (cpe-70-123-227-116.satx.res.rr.com. [70.123.227.116])
        by smtp.gmail.com with ESMTPSA id r65sm6716916oig.0.2020.04.15.15.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 15:04:58 -0700 (PDT)
Subject: Re: cal: column mode
To:     =?UTF-8?Q?Aur=c3=a9lien_Lajoie?= <orel@melix.net>,
        Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <CAA0A08U=eWWB5eyxg4vrD_yBdVohqVT0NQfm+DG+wjbZ8HmiZg@mail.gmail.com>
 <20200414113827.xp2etrdev2oom4qc@ws.net.home>
 <CAA0A08W8JjTYx-ymnsBvbRHBW+WxucobBWVfyt4XdXh7Of8wMA@mail.gmail.com>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <00b92978-b2a8-1ebb-8ede-a7745046d460@gmail.com>
Date:   Wed, 15 Apr 2020 17:04:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAA0A08W8JjTYx-ymnsBvbRHBW+WxucobBWVfyt4XdXh7Of8wMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 4/14/20 3:18 PM, Aurélien Lajoie wrote:
> On Tue, Apr 14, 2020 at 1:38 PM Karel Zak <kzak@redhat.com> wrote:
>>
>> On Mon, Apr 13, 2020 at 10:41:34PM +0200, Aurélien Lajoie wrote:
>>> As I have announced few days ago, I have started to work on ncal like for cal.
>>> I have push a first working version on my github:
>>> https://github.com/utix/util-linux/commits/cal_column
>>
>> Is the option --column the best name? We use "column" pretty often to
>> address output in columns or number of columns, etc.
>>
>> What about --vertical?
> 
> sure, no preference for me, ( -v is not used )
> How or who decides this kind of stuff (sorry I am a newbie)
> 
>>> Does anyone know which locale can have some width issue ?
>>
>>   LC_ALL=ja_JP.utf8 cal
>>
>> or another with multibyte letters.
> ja_JP seems very compact, I think mongolian locale is a good one with month like
> Арванхоёрдугаар сар
> 
> ja_JP is:
>                                 2020
> 
>           1月                    2月                    3月
> 日 月 火 水 木 金 土   日 月 火 水 木 金 土   日 月 火 水 木 金 土
>            1  2  3  4                      1    1  2  3  4  5  6  7
>   5  6  7  8  9 10 11    2  3  4  5  6  7  8    8  9 10 11 12 13 14
> 12 13 14 15 16 17 18    9 10 11 12 13 14 15   15 16 17 18 19 20 21
> 19 20 21 22 23 24 25   16 17 18 19 20 21 22   22 23 24 25 26 27 28
> 26 27 28 29 30 31      23 24 25 26 27 28 29   29 30 31
> 
>           4月                    5月                    6月
> 日 月 火 水 木 金 土   日 月 火 水 木 金 土   日 月 火 水 木 金 土
>            1  2  3  4                   1  2       1  2  3  4  5  6
>   5  6  7  8  9 10 11    3  4  5  6  7  8  9    7  8  9 10 11 12 13
> 12 13 14 15 16 17 18   10 11 12 13 14 15 16   14 15 16 17 18 19 20
> 19 20 21 22 23 24 25   17 18 19 20 21 22 23   21 22 23 24 25 26 27
> 26 27 28 29 30         24 25 26 27 28 29 30   28 29 30
>                         31
>           7月                    8月                    9月
> 日 月 火 水 木 金 土   日 月 火 水 木 金 土   日 月 火 水 木 金 土
>            1  2  3  4                      1          1  2  3  4  5
>   5  6  7  8  9 10 11    2  3  4  5  6  7  8    6  7  8  9 10 11 12
> 12 13 14 15 16 17 18    9 10 11 12 13 14 15   13 14 15 16 17 18 19
> 19 20 21 22 23 24 25   16 17 18 19 20 21 22   20 21 22 23 24 25 26
> 26 27 28 29 30 31      23 24 25 26 27 28 29   27 28 29 30
>                         30 31
>          10月                   11月                   12月
> 日 月 火 水 木 金 土   日 月 火 水 木 金 土   日 月 火 水 木 金 土
>               1  2  3    1  2  3  4  5  6  7          1  2  3  4  5
>   4  5  6  7  8  9 10    8  9 10 11 12 13 14    6  7  8  9 10 11 12
> 11 12 13 14 15 16 17   15 16 17 18 19 20 21   13 14 15 16 17 18 19
> 18 19 20 21 22 23 24   22 23 24 25 26 27 28   20 21 22 23 24 25 26
> 25 26 27 28 29 30 31   29 30                  27 28 29 30 31
> 
>>
>>> I have tried to keep the same structure of the code between the column
>>> mode and the row mode.
>>> It is impossible to keep line width lower than 80.
>>
>> Do you mean source code line? ... 80 is not a strict rule, keep it
>> readable.
> Yes speaking about code line, with tab width set to 8, 80 is quickly reached.

Don't use a tab width of 8.  Research has shown that the most readable 
level of code indentation is between 2 and 4 characters.  Personally I 
use 3.

   -- Bruce


>>
>>> I can try to split the big function `cal_output_months` this will make
>>> it more readable, but will introduce a lot of change for no feature.
>>> Any advice on this ?
>>
>> Your cal_col_output_months() does not look like any huge monster.
>>
>> I have added one comment to your commits/cal_column at github.
> Thanks I will do the modification
>>
>>      Karel
>>
>>
>> --
>>   Karel Zak  <kzak@redhat.com>
>>   http://karelzak.blogspot.com
>>
> 

