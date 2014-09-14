Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f175.google.com ([209.85.217.175]:61810 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbaINMEK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Sep 2014 08:04:10 -0400
Received: by mail-lb0-f175.google.com with SMTP id v6so3057823lbi.20
        for <util-linux@vger.kernel.org>; Sun, 14 Sep 2014 05:04:08 -0700 (PDT)
Message-ID: <54158434.6050502@linux.com>
Date: Sun, 14 Sep 2014 19:04:04 +0700
From: Boris Egorov <egorov@linux.com>
MIME-Version: 1.0
To: Andreas Henriksson <andreas@fatal.se>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: fix cppcheck warnings
References: <20140914115745.GA20978@fatal.se>
In-Reply-To: <20140914115745.GA20978@fatal.se>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Andreas Henriksson!

Indeed, you are right. My fault. Should I send another patch, or amend
this one?

On 09/14/2014 06:57 PM, Andreas Henriksson wrote:
> Hello Boris Egorov!
> 
> I spotted something in your patch that doesn't look right to me.
> 
> [...]
>> --- a/sys-utils/lscpu-dmi.c
>> +++ b/sys-utils/lscpu-dmi.c
>> @@ -161,7 +161,7 @@ static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
>>  	else if (manufacturer && strstr(manufacturer, "HITACHI") &&
>>  					product && strstr(product, "LPAR"))
>>  		rc = HYPER_HITACHI;
>> -	else if (!vendor && strcmp(vendor, "Parallels"))
>> +	else if (vendor && strcmp(vendor, "Parallels"))
>                            ^
> Shouldn't the ! be here? --^
> (alternatively: vendor && 0 == strcmp...)
> 
>>  		rc = HYPER_PARALLELS;
>>  done:
>>  	free(buf);
> [...]
> 
> 
> Regards,
> Andreas Henriksson


-- 
Best regards,

Boris Egorov
