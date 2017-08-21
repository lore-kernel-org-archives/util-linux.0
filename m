Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752804AbdHUM45 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 21 Aug 2017 08:56:57 -0400
Subject: Re: [PATCH 5/6] hwclock: rename/refactor set_system_clock()
To: Karel Zak <kzak@redhat.com>
References: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
 <ab175fb6-72c2-c3a4-5f72-fa0600c2b13d@gmx.com>
 <20170821093158.2kmbowciuklu47yc@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <113d8ff2-e593-675b-5ef2-21e15d5cea98@gmx.com>
Date: Mon, 21 Aug 2017 08:56:41 -0400
MIME-Version: 1.0
In-Reply-To: <20170821093158.2kmbowciuklu47yc@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 08/21/2017 05:31 AM, Karel Zak wrote:
> On Fri, Aug 18, 2017 at 08:23:01PM -0400, J William Piggott wrote:
>>
>> Signed-off-by: J William Piggott <elseifthen@gmx.com>
>> ---
>>  sys-utils/hwclock.c | 24 +++++++++---------------
>>  1 file changed, 9 insertions(+), 15 deletions(-)
>>
>> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
>> index c398d60..4279931 100644
>> --- a/sys-utils/hwclock.c
>> +++ b/sys-utils/hwclock.c
>> @@ -601,12 +601,8 @@ display_time(struct timeval hwctime)
>>   *                         * only on first call after boot
>>   */
>>  static int
>> -set_system_clock(const struct hwclock_control *ctl,
>> -		 const struct timeval newtime)
>> +kernel_time_ctl(const struct hwclock_control *ctl, const struct timeval newtime)
> 
> Hmm... the new name does not make the code more readable for me.  
> 
> We have "HW-clock" (hc) and "system time", would be nice to keep
> this terminology for functions names too? 

I've been moving away from the term 'Hardware Clock' in favor of RTC
because:
 * use of /dev/rtcN is the only recommended access now
 * RTC seems more common (anecdotal observation)
 * it is more concise for usage() and docs

Some people do not like the term "Real Time Clock", but I have not seen a
consensus for any name.

> 
> IMHO set_system_clock() is not so bad :-) (Maybe use system_set_clock()
> if you want to use "system_" prefix for more functions.)

My thinking was that this function does important things besides setting
the system time. It also sets the kernel's RTC timescale and the
kernel's timezone. For systz it never sets the system time at all. So
the current name seems misleading.

It doesn't matter to me, I was changing it to help others. Do you want me
to put it back to set_system_clock?


> 
>     Karel
> 
