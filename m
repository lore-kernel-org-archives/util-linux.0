Return-Path: elseifthen@gmx.com
Message-ID: <5508984D.2010206@gmx.com>
Date: Tue, 17 Mar 2015 17:10:37 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/5] hwclock: remove depreciated ntpdate
References: <5503364E.6010302@gmx.com> <550337F0.3050100@gmx.com> <1426433205.3225343.240610937.5D55876F@webmail.messagingengine.com> <20150316103342.GD28925@ws.net.home> <5507A187.2020303@gmx.com> <20150317092901.GS28925@ws.net.home>
In-Reply-To: <20150317092901.GS28925@ws.net.home>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

On 03/17/2015 05:29 AM, Karel Zak wrote:
> On Mon, Mar 16, 2015 at 11:37:43PM -0400, J William Piggott wrote:
>> On 03/16/2015 06:33 AM, Karel Zak wrote:
>>> On Sun, Mar 15, 2015 at 04:26:45PM +0100, Benno Schulenberg wrote:
>>>>
>>>> On Fri, Mar 13, 2015, at 20:18, J William Piggott wrote:
>>>>> Replace references to the depreciated ntpdate with sntp.
>>>>
>>>> s/depreciated/deprecated/
>>>>
>>>>> -.BR \%ntpdate\ \-q " , or " \%date\ \-Ins
>>>>> +.BR \%sntp ", or " \%date\ \-Ins
>>>>
>>>> Hmm, maybe it's a bit to early to delete the mention of ntpdate?
>>>> My fairly recent Linux Mint doesn't have sntp yet.  Maybe add
>>>> sntp to the list instead of replacing ntpdate?
>>>
>>>  Good point, it would be better to use something like "ntpdate or more
>>>  recent sntp".
>>
>> No, it is not a good point.  I assume he means *too* early, that's the
>> funniest thing I've heard all day. No wait, "doesn't have sntp yet",
>> that's the funniest thing I've heard all day.
>>
>> The sntp client and ntpdate are both from the same project and
>> approximately the same age. Nobody was interested in maintaining ntpdate
>> so it *depreciated* over many years before being officially *deprecated*
>> by the project.
> 
> You miss the point, after util-linux update, someone will read the man
> page and then type "sntp" on command line, but because he has old /
> stupid distro it will be unsuccessful. What next if there is no any
> pointer to any other alternative? 

I understand the point, Karel. I am saying it is not valid in this case
because...

> 
> You're absolutely right with ntpdate vs. sntp, but it seems reality is
> so painful that people still have systems where is no sntp.

... I do not believe such a distribution exists. Any distribution that
ships with util-linux also has an ntp package available. The sntp client
is part of the ntp package. Do you know of a non-embedded mainstream
Linux distro that doesn't offer the ntp package? It would be a very odd
thing to do I believe.

Furthermore, this section of the man-page is dealing with '11 minute
mode'; if the system does not have the ntp package installed then none
of this even applies to them.

>> Before I added ntpdate two months ago, the hwclock man-page had gone 20
>> years without it. Now there's concern over removing it?
> 
> OK :-) I'm going to apply the patches, it's nothing critical.
> 
>     Karel
> 
> 
