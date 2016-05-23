Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35286 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbcEWXc5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 23 May 2016 19:32:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id f75so1001479wmf.2
        for <util-linux@vger.kernel.org>; Mon, 23 May 2016 16:32:56 -0700 (PDT)
Received: from [192.168.0.76] (cpe-70-123-244-133.satx.res.rr.com. [70.123.244.133])
        by smtp.gmail.com with ESMTPSA id f12sm13239178wme.13.2016.05.23.16.32.54
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2016 16:32:54 -0700 (PDT)
Subject: Re: [PATCH] cal: drop trailing blank line
To: util-linux@vger.kernel.org
References: <1464037332-21996-1-git-send-email-vapier@gentoo.org>
 <5743767D.3010904@gmail.com> <20160523225831.GQ26300@vapier.lan>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <57439324.90809@gmail.com>
Date: Mon, 23 May 2016 18:32:52 -0500
MIME-Version: 1.0
In-Reply-To: <20160523225831.GQ26300@vapier.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote:
> On 23 May 2016 16:30, Bruce Dubbs wrote:
>> Mike Frysinger wrote:
>>> There's no history to be found behind this, and the comment in the
>>> code indicates no one else knows, and it makes me angry :).
>>>
>>> --- a/misc-utils/cal.c
>>> +++ b/misc-utils/cal.c
>>> @@ -767,9 +767,6 @@ static void yearly(const struct cal_control *ctl)
>>>    		my_putstring("\n\n");
>>>    	}
>>>    	monthly(ctl);
>>> -
>>> -	/* Is empty line at the end year output really needed? */
>>> -	my_putstring("\n");
>>>    }
>>>
>>>    /*
>>
>> Personally I like the blank line. It sets off the cal output from the
>> shell prompt making it easier to read.  It is basically adding the
>> equivalent of the css property padding-bottom="1em".
>
> why should cal care ?  you could make this same exact argument for any
> other cli tool that displays things.  if you like that behavior, then
> update your PS1 to include a leading \n.

I certainly do not want to double space every bash prompt.  Your solution 
causes more problems than it solves.

>> I note that if doing a 'cal -y' that there is also a blank line between
>> the year and February.  That should stay also.
>
> that's a different issue.  cal always writes exactly 6 lines for a month
> regardless of how many weeks a month actually uses.  it makes the code
> simpler (no need to scan/remember sibling months) and the output more
> consistent -- every row is 7 lines.  pick a non-leap year like 2015 and
> see Feb take up only 4 lines but still leave 2 blank below it.  or pick
> 2019 and see Mar use all 6 lines.

Did you look at the output?

                                2016
---> blank line
        January               February                 March
Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
                 1  2       1  2  3  4  5  6          1  2  3  4  5


   -- Bruce

