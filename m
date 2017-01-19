Return-Path: bruce.dubbs@gmail.com
Subject: Re: stable/v2.29.1
To: Karel Zak <kzak@redhat.com>, Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
References: <20170118131217.3kv7samrkbnxmqqr@ws.net.home>
 <e3ebe087-45ee-0afd-7e85-7a243be3c379@bernhard-voelker.de>
 <20170119113502.ykteazztzpd7eocs@ws.net.home>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <5880E4BA.9090703@gmail.com>
Date: Thu, 19 Jan 2017 10:09:30 -0600
MIME-Version: 1.0
In-Reply-To: <20170119113502.ykteazztzpd7eocs@ws.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Thu, Jan 19, 2017 at 11:32:20AM +0100, Bernhard Voelker wrote:
>> On 01/18/2017 02:12 PM, Karel Zak wrote:
>>> The branch stable/v2.29 contains what I want to release as v2.29.1.
>>
>> General question:
>> Is it worth dealing with maintenance branches in the upstream repo?
>> I mean, downstream projects can cherry-pick fixes and improvements
>> to their own needs anyway.  So I think having one upstream mainline
>> would be sufficient.  WDYT?
>
>   I use the branches to create maintenance releases (tarballs), e.g.
>   v2.29.1.
>
>   The goal is to minimize number of patches in downstream packages. So I
>   guess downstream are happy to have .1 and .2 releases.

That is certainly true for Linux From Scratch.

   -- Bruce
