Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:60896 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755887AbaJXLQE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 07:16:04 -0400
Message-ID: <544A34EB.507@gmx.com>
Date: Fri, 24 Oct 2014 07:15:55 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] hwclock: clean up messages
References: <5449BD0F.2070906@gmx.com> <20141024110803.GB10134@x2.net.home>
In-Reply-To: <20141024110803.GB10134@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 10/24/2014 07:08 AM, Karel Zak wrote:
> On Thu, Oct 23, 2014 at 10:44:31PM -0400, JWP wrote:
>> This patch set cleans up various message output.
>> It contains cosmetic changes only.
>>
>> J William Piggott (5):
>>   hwclock: Remove newline from 'date' debug output
>>   hwclock: clean up message periods/full stops
>>   hwclock: add message line breaks
>>   hwclock: Fix --date debug messages
>>   hwclock: version prints out of order
> 
> I'm going to merge these patches, but as a long term solution it would
> better to use include/debug.h stuff (see for example
> misc-utils/whereis.c or libmount/src/init.c).
> 
> The debug.h provides more elegant way for debug messages. It's
> possible to define mask to specify wanted messages and all is
> controlled by <NAME>_DEBUG= env. variable etc. 
> 
> It's probably too verbose for hwclock --debug, but let's ignore this
> problem for now. I'll make the output more user friendly ASAP.

Cool, I was not aware of debug.h. I will check it out and include it
in my hwclock refactoring todo notes.

> 
>     Karel
> 
