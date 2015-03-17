Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55275 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbbCQDiA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 23:38:00 -0400
Message-ID: <5507A187.2020303@gmx.com>
Date: Mon, 16 Mar 2015 23:37:43 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Benno Schulenberg <bensberg@justemail.net>
CC: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/5] hwclock: remove depreciated ntpdate
References: <5503364E.6010302@gmx.com> <550337F0.3050100@gmx.com> <1426433205.3225343.240610937.5D55876F@webmail.messagingengine.com> <20150316103342.GD28925@ws.net.home>
In-Reply-To: <20150316103342.GD28925@ws.net.home>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/16/2015 06:33 AM, Karel Zak wrote:
> On Sun, Mar 15, 2015 at 04:26:45PM +0100, Benno Schulenberg wrote:
>>
>> On Fri, Mar 13, 2015, at 20:18, J William Piggott wrote:
>>> Replace references to the depreciated ntpdate with sntp.
>>
>> s/depreciated/deprecated/
>>
>>> -.BR \%ntpdate\ \-q " , or " \%date\ \-Ins
>>> +.BR \%sntp ", or " \%date\ \-Ins
>>
>> Hmm, maybe it's a bit to early to delete the mention of ntpdate?
>> My fairly recent Linux Mint doesn't have sntp yet.  Maybe add
>> sntp to the list instead of replacing ntpdate?
> 
>  Good point, it would be better to use something like "ntpdate or more
>  recent sntp".

No, it is not a good point.  I assume he means *too* early, that's the
funniest thing I've heard all day. No wait, "doesn't have sntp yet",
that's the funniest thing I've heard all day.

The sntp client and ntpdate are both from the same project and
approximately the same age. Nobody was interested in maintaining ntpdate
so it *depreciated* over many years before being officially *deprecated*
by the project.

The sntp client is in the ntp package for Mint/Debian/Ubuntu. Try
opening a terminal and typing 'sntp' or 'man sntp'.

Before I added ntpdate two months ago, the hwclock man-page had gone 20
years without it. Now there's concern over removing it?

>From the ntpdate man-page:

   Disclaimer: This program has known bugs and deficiencies and nobody has
   volunteered to fix them in a long time. The good news is the
   functionality originally intended for this program is available in the
   ntpd and sntp programs. See the [2]Deprecating ntpdate topic in the NTP
   Support wiki for a thorough discussion and analysis of the issues. See
   the -q command line option in the [3]ntpd - Network Time Protocol (NTP)
   daemon page and/or the [4]sntp - Simple Network Time Protocol (SNTP)
   Client page. After a suitable period of mourning, the ntpdate program
   will be retired from this distribution.


> 
>     Karel
> 
