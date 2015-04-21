Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:62716 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755202AbbDUPTN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Apr 2015 11:19:13 -0400
Message-ID: <55366A6A.7010807@gmx.com>
Date: Tue, 21 Apr 2015 11:19:06 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Alexey Galakhov <agalakhov@gmail.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: flush stdout in hwclock -c
References: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>	<5534498B.4080803@gmx.com> <20150420092824.13611c6b@aga-ws-01>
In-Reply-To: <20150420092824.13611c6b@aga-ws-01>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 04/20/2015 03:28 AM, Alexey Galakhov wrote:
> Hello William,
> 
> Am Sun, 19 Apr 2015 20:34:19 -0400
> schrieb J William Piggott <elseifthen@gmx.com>:
> 
>>  I've been advocating for the removal of the compare function. One of
>> my justifications for doing so is that it has been broken from day
>> one and therefore nobody can be using for anything.
>>
>>  So could you tell me how you are using it, and what useful purpose
>> it is serving for you?
> 
> We use it in an automated test of the Linux system time on an embedded
> system. Recently we fixed a kernel bug introduced by one of the 3rd
> party patches that caused a huge (0.01%-0.1%) drift of the
> CLOCK_REALTIME due to incorrect PLL initialization. The corresponding
> test based on hwclock's compare is now added to our automated test
> system. The test runs hwclock -c forever and fails if any drift
> anomality is discovered.
>

So you are using the Hardware Clock as a reference to detect anomalies
in the System Clock? You must have an exceptional Hardware Clock. It
sounds as though you are using NTP, why not compare NTP time directly to
your System time?

> Looks like hwclock -c works correctly at least in our case.

I assume then, that you are only using columns one and two, because
columns 3 and 4 are invalid output. If yes, then you are not using
hwclock -c for its actual 'compare' functionality, but only as a source
for timestamps. Your test could capture timestamps without hwclock's
compare function, yes?


> I think it
> could be rewritten using clock_gettime() instead of gettimeofday().
> 
> Regards,
> Alexey
> 
