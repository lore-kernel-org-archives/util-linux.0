Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:63397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbeAYL0M (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 25 Jan 2018 06:26:12 -0500
Received: from www.gmx.com ([68.34.44.156]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MAhTr-1eTu2b1xLn-00Bufn for
 <util-linux@vger.kernel.org>; Thu, 25 Jan 2018 12:26:10 +0100
Subject: Re: [PATCH] cal: drop trailing blank line
To: util-linux@vger.kernel.org
References: <1464037332-21996-1-git-send-email-vapier@gentoo.org>
 <20180125042201.GC1718@vapier>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <52acc078-8e28-5ee4-9084-e14100ae2f35@gmx.com>
Date: Thu, 25 Jan 2018 06:26:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180125042201.GC1718@vapier>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/24/2018 11:22 PM, Mike Frysinger wrote:
> On 23 May 2016 17:02, Mike Frysinger wrote:
>> There's no history to be found behind this, and the comment in the
>> code indicates no one else knows, and it makes me angry :).
>>
>> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
>> ---
>>  misc-utils/cal.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/misc-utils/cal.c b/misc-utils/cal.c
>> index 3e20530..479c967 100644
>> --- a/misc-utils/cal.c
>> +++ b/misc-utils/cal.c
>> @@ -767,9 +767,6 @@ static void yearly(const struct cal_control *ctl)

Hi Mike,

If Karel accepts it, yearly() is removed completely in my last submission:
  [PATCH 2/4] cal: remove year top header


>>  		my_putstring("\n\n");
>>  	}
>>  	monthly(ctl);
>> -
>> -	/* Is empty line at the end year output really needed? */
>> -	my_putstring("\n");
>>  }
>>  
>>  /*
>> -- 
>> 2.8.2
> 
> ping ...
> -mike
> 
