Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57150 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754947AbdAHV2m (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 8 Jan 2017 16:28:42 -0500
Subject: Re: pull: hwclock 27 changes
To: kerolasa@gmail.com
References: <20161231214107.8658-1-kerolasa@iki.fi>
 <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com>
 <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
 <alpine.LNX.2.20.1701072212010.9096@imuri>
 <CAG27Bk11r=BM=DTLxVF8gfB34uXCOZAvfz3FymzcSyzLx7VSTA@mail.gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <f6770d97-0976-a130-e3ed-7a2604a15fc8@gmx.com>
Date: Sun, 8 Jan 2017 16:21:59 -0500
MIME-Version: 1.0
In-Reply-To: <CAG27Bk11r=BM=DTLxVF8gfB34uXCOZAvfz3FymzcSyzLx7VSTA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/08/2017 05:09 AM, Sami Kerola wrote:
> On 7 January 2017 at 23:06, Sami Kerola <kerolasa@iki.fi> wrote:
>> On Sat, 7 Jan 2017, J William Piggott wrote:
>>> commit 509ac719dbe1bcc4a761f694497493525da39e25
>>> Author: Sami Kerola <kerolasa@iki.fi>
>>> Date:   Sun Jul 17 09:09:33 2016 +0100
>>>
>>>     docs: add instructions how to avoid alpha epoc Y2020 bug
>>>
>>>     Recommend setting epoch using command line to for Alpha to avoid
>>>     autodetection that is doomed to afail after 2020.
>>>
>>>     Reference: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/alpha/kernel/rtc.c?id=85d0b3a573d8b711ee0c96199ac24a0f3283ed68
>>>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>>>
>>> diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
>>> index 9d9a42a..cf26064 100644
>>> --- a/sys-utils/hwclock-cmos.c
>>> +++ b/sys-utils/hwclock-cmos.c
>>> @@ -203,15 +203,16 @@ void set_cmos_epoch(const struct hwclock_control *ctl)
>>>  #endif
>>>
>>>       /*
>>> -      * The kernel source today says: read the year.
>>> +      * The automatic epoc determination in kernel
>>> +      * linux/arch/alpha/kernel/rtc.c
>>>        *
>>>        * If it is in  0-19 then the epoch is 2000.
>>>        * If it is in 20-47 then the epoch is 1980.
>>>        * If it is in 48-69 then the epoch is 1952.
>>>        * If it is in 70-99 then the epoch is 1928.
>>>        *
>>> -      * Otherwise the epoch is 1900.
>>> -      * TODO: Clearly, this must be changed before 2019.
>>> +      * Alpha users should explicitly define epoc using rtc kernel module
>>> +      * option rtc epoc=<year>
>>>        */
>>>       /*
>>>        * See whether we are dealing with SRM or MILO, as they have
>>> diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
>>> index 9534c19..de68e43 100644
>>> --- a/sys-utils/hwclock.8.in
>>> +++ b/sys-utils/hwclock.8.in
>>> @@ -466,6 +466,14 @@ For example, on a Digital Unix machine:
>>>  .IP "" 4
>>>  .B hwclock\ \-\-setepoch\ \-\-epoch=1952
>>>  .RE
>>> +.IP
>>> +Beginning January 1, 2020 automatic epoc determination in kernel for systems
>>> +using 1900 will fail.  In these cases it is recommended to specify epoc
>>> +explicitly with kernel module option.
>>> +.RS
>>> +.IP "" 4
>>> +.B options rtc epoch=1900
>>> +.RE
>>>  .
>>>  .TP
>>>  .B \-\-funky\-toy
>>>
>>>
>>>>
>>>> I don't like this one because:
>>>>
>>>> Despite Richard's "doomed to fail" comment, I don't think util-linux
>>>> should document that as a fact. The heuristics could be updated. If the
>>>> kernel is still supporting DEC in 2019 it seems like they should
>>>> update them. It would be more work to remove the code than to adjust
>>>> the numbers.
>>>>
>>>> Also the patch has some errors:
>>>>
>>>> * The possible failure applies to more than 'systems using 1900'.
>>>>
>>>> * The Alpha rtc driver cannot be built as a module; I believe
>>>> epoch={year} is a kernel command line argument only.
>>>>
>>>> * The heuristics in drivers/char/rtc.c are slightly different than
>>>> what the patch references in linux/arch/alpha/kernel/rtc.c. I don't
>>>> know which one wins. They both differ from how they are described in
>>>> the hwclock-cmos.c comments, from which this patch deletes the 1900
>>>> possibility.
>>>>
>>>> The Alpha auto epoch detect has nothing to do with hwclock --setepoch
>>>> --epoch {year}. That is all done via rtc and can only set it manually.
>>>> Auto detecting the epoch only affects using --directisa on Alpha
>>>> machines. Direct access requires hwclock to handle the epoch offset
>>>> internally, because we're bypassing the kernel. So hwclock-cmos.c has
>>>> to figure out what to use. It tries heuristics and, ironically, it
>>>> tries to use the kernel's auto detect via the rtc driver. Why use
>>>> direct access if you have a working rtc interface!
>>>>
>>>> It is undocumented, but when using --directisa on alpha --epoch {year}
>>>> can be used to bypass auto detect. So --epoch {year} would be used for
>>>> all functions. The man-page says it can only be used with --setepoch.
>>>> I have no way to test this, so until now I have not documented it.
>>>>
>>
>> I left the change as-is for now, making the branch in it's current state
>> not to be ready. How about if I read carefully what you said above,
>> rethink what I thought earlier, and reply later.
> 
> This change is dropped.
> 
> What comes to other comments nice to hear 'doomed to fail' is not quite
> as bad situation as it was made to sound. Maybe it would be appropriate to
> deal alpha 2020 issue separately, with kernel upstream alpha maintainers.
> 
> Right now my only recommendation is to clear out the situation this year
> (2017). After all 2020 is just round corner. We shall see whether clearning
> out means code and docs changes to kernel, hwclock, or both.
> 

I have a solution to suggest for hwclock. I will write about it, but not
today.



