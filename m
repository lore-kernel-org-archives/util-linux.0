Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:50058 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933248AbeAKNfz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 11 Jan 2018 08:35:55 -0500
Subject: Re: [v3 PATCH 00/11] Pull Request - changelog
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
 <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
 <6635776f-9787-f05c-704f-e326808daa1d@gmx.com>
 <20180111090120.k6h5q2juw6gqemlc@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <95eb163b-218b-42ab-1b4b-4018cedd040e@gmx.com>
Date: Thu, 11 Jan 2018 08:35:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180111090120.k6h5q2juw6gqemlc@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/11/2018 04:01 AM, Karel Zak wrote:
> On Wed, Jan 10, 2018 at 09:00:23PM -0500, J William Piggott wrote:
>>
>>
>> On 01/08/2018 05:21 AM, Karel Zak wrote:
>>> On Tue, Jan 02, 2018 at 09:53:18AM -0500, J William Piggott wrote:
>>>
>>> I have no clue how many users care and read our ReleaseNotes, but
>>> important is that they have opportunity to do that and they have
>>> always time to adopt to changes. This is how I promised that this 
>>> project will be maintained. 
>>
>> Your response here puzzled me, because I could not remember you ever
>> making a pre-announcement of this nature before.
> 
> 2.14  The losetup(8) '-s' option (introduced by util-linux-ng-2.13) is deprecated
> 2.21  The udev compatible output (-o udev) from blkid(8) is deprecated.
> 2.25  The "swapon --summary" output format is deprecated ...
> 
> ... and many warnings about commands (mkfs, tailf, mount, last, ...) and
> features (cryptoloop).
> 
> The command line options are our API, we don't do such changes often.
> 
> I remember only one exception -- sfdisk, after rewrite some obscure
> DOS-era options have been removed.

We're not talking about deprecating anything, which is why I said "of
this nature". We're not changing any API or removing any options. We're
talking about changing the default output format. As was done to hwclock
without any advanced warning and, so far, without any complaints. I
could not find any past releases giving advanced warnings for changing a
default configuration.

I really expected someone to complain that we broke their script with
the hwclock change. I think it far more likely that hwclock's output be
used programmatically then cal's. If I wanted calendar related data in a
script I'd be more inclined to use date(1); it offers a lot more control
over its output. Isn't the concern for an advance warning that the
change would break the command's use programmatically? Cal's output isn't
machine friendly, I don't think. Isn't cal's intended audience human?

Anyway, it certainly doesn't hurt anything if you want to do this the
slow painful way. The end result is the same, although a bit more work.
I'm mostly trying to understand the rational, so that I know what to do
in future instances.

BTW, I also dropped 'PATCH 09/11 cal: remove the non-functional options'
from the 171229 branch.


> 
>     Karel
> 
