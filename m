Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932128AbdDQBoO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 16 Apr 2017 21:44:14 -0400
Subject: Re: [PATCH] hwclock: fix non-linux build
To: Ruediger Meier <sweet_f_a@gmx.de>
References: <1491897955-22436-1-git-send-email-sweet_f_a@gmx.de>
 <64fc96d4-3e5f-ee6d-2ab9-bc90c8f8c5e9@gmx.com>
 <201704112107.59250.sweet_f_a@gmx.de>
 <9dc22019-6710-1195-86c6-a1b5b3579e34@gmx.com>
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <0f17a036-47aa-9696-34c3-e1f29f6b0901@gmx.com>
Date: Sun, 16 Apr 2017 21:44:00 -0400
MIME-Version: 1.0
In-Reply-To: <9dc22019-6710-1195-86c6-a1b5b3579e34@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Rudi,

I have a different solution that removes that default function test
completely. It is part of another fix in my current working branch, so I
will post it as soon as Karel accepts/rejects my current submission.

On 04/11/2017 03:27 PM, J William Piggott wrote:
> 
> 
> On 04/11/2017 03:07 PM, Ruediger Meier wrote:
>> On Tuesday 11 April 2017, J William Piggott wrote:
>>> On 04/11/2017 04:05 AM, Ruediger Meier wrote:
>>>> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>>>>
>>>> There was one missing ifdef since 336f7c5f.
>>>
>>> They were both in that 'if' test before 336f7c5f:
>>>
>>> -       if (!(show | set | systohc | hctosys | systz | adjust |
>>> getepoch -             | setepoch | predict | compare | get))
>>> -               show = 1;       /* default to show */
>>>
>>> But they were defined for all arches then:
>>>
>>> -       /* Set option defaults */
>>> -       show = set = systohc = hctosys = systz = adjust = noadjfile =
>>> predict = -           compare = get = update = FALSE;
>>> -       getepoch = setepoch = utc = local_opt = directisa = testing =
>>> debug = FALSE;
>>>
>>>
>>> I think the old way was a cleaner solution, so in
>>> sys-utils/hwclock.h:35:
>>>
>>> - #ifdef __linux__
>>>   		getepoch:1,
>>>   		setepoch:1,
>>> - #endif
>>>
>>> Should work? I do not have a way to test it.
>>
>> Yes, I've had also thought about this but was not sure and also too lazy 
>> to check possible side effects. Somehow I think we should either remove 
>> all ifdefs (__linux__, __alpha__, HAVE_LIBAUDIT) from that struct or 
>> none.
> 
> I don't expect any side effects from getepoch setepoch, because they
> were historically initialized on all arches. Alpha has already been
> removed.  The other two, rtc_dev_name and hwaudit_on, are only used
> inside of #ifdef so I think they must remain so in the struct as well.
> 
> 
> 
>>
>> cu,
>> Rudi
>> --
>> To unsubscribe from this list: send the line "unsubscribe util-linux" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
