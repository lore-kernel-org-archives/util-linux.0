Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:58551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750874AbdAMBa7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 12 Jan 2017 20:30:59 -0500
Subject: Re: pull: hwclock 27 changes
To: Sami Kerola <kerolasa@iki.fi>
References: <20161231214107.8658-1-kerolasa@iki.fi>
 <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com>
 <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
 <alpine.LNX.2.20.1701072212010.9096@imuri>
 <a9d7f37b-3607-70d4-843a-7d934bd305d5@gmx.com>
 <alpine.LNX.2.20.1701112055190.2589@imuri>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ede34a46-7290-c68b-1dd8-e4fc356e5caf@gmx.com>
Date: Thu, 12 Jan 2017 20:30:26 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.1701112055190.2589@imuri>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/11/2017 04:44 PM, Sami Kerola wrote:
> On Sun, 8 Jan 2017, J William Piggott wrote:
> 
>>> @@ -655,7 +655,8 @@ display_time(const bool hclock_valid, struct timeval hwctime)
>>>   * If anything goes wrong (and many things can), we return return code 10
>>>   * and arbitrary *time_p. Otherwise, return code is 0 and *time_p is valid.
>>>   */
>>> -static int interpret_date_string(const struct hwclock_control *ctl, time_t * const time_p)
>>> +static int interpret_date_string(const struct hwclock_control *ctl,
>>> +				 time_t *const time_p)
>>
>>
>> Sorry for nitpicking. I know you didn't write this, but as long as
>> you're making a change here, shouldn't it be: const time_t *time_p?
> 
> Nope. That will make pointer value read-only, and that would cause 
> following error.
> 
> sys-utils/hwclock.c:720:11: error: assignment of read-only location '*time_p'
>    *time_p = seconds_since_epoch;
> 
> Code we have makes the pointer read-only, but leaves value writeable.
>

I'm glad Karel built this forum with #include <dumb_question.h>
Thanks for the education and patience.


>>> @@ -1031,9 +1032,7 @@ calculate_adjustment(const struct hwclock_control *ctl,
>>>  	exact_adjustment =
>>>  	    ((double)(systime - last_time)) * factor / (24 * 60 * 60)
>>>  	    + not_adjusted;
>>> -	tdrift_p->tv_sec = (int) exact_adjustment;
>>> -	if (exact_adjustment < 0)
>>> -		tdrift_p->tv_sec--;
>>> +	tdrift_p->tv_sec = (int) floor(exact_adjustment);
>>
>> Is the cast required now?
> 
> floor(3) will return double, tv_sec is time_t. Yes I should and have 
> fixed the cast from int to time_t.

Isn't the cast implied by assignment and done automatically? Isn't that
why the previous mismatch with the (int) cast worked? In the next line
of code we assign a double to tv_usec which is a mismatch also.

I built your latest branch with and without the cast and the results
were binary identical.

 8< -------
 
> ----------------------------------------------------------------
> The following changes since commit 89958178f6d6ebe0944d423feaea66be521fff43:
>   If mtab support is disabled, disable ro/rw mtab checks (2017-01-10 17:32:32 +0100)
> are available in the git repository at:
>   git://github.com/kerolasa/lelux-utiliteetit.git hwclock-jwp-reviewed
> for you to fetch changes up to d3e33557e6794446c712ca264e54fe4b186a17ca:
>   hwclock: remove --compare option (2017-01-11 21:04:36 +0000)
> ----------------------------------------------------------------
> 
> Thank you JWP for reviews, I hope I did not miss anything but if I did let 
> me know and I will follow up. Even better if everyone agrees that this is 
> now good enough to be merged, and we can move forward with other updates 
> such as adjtimex(8) work.

Thanks for all the work, Sami. I've been testing your latest branch and
haven't found any problems. I cannot test all of your changes though, for
example I don't have libaudit installed. For what it's worth, I think it
is ready.


