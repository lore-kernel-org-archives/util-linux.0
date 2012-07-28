Return-Path: util-linux-owner@vger.kernel.org
Received: from avasout05.plus.net ([84.93.230.250]:59173 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab2G0XZa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jul 2012 19:25:30 -0400
Message-ID: <5013303E.6070404@jelmail.com>
Date: Sat, 28 Jul 2012 01:20:14 +0100
From: John Lane <util-linux@jelmail.com>
MIME-Version: 1.0
To: dave@gnu.org
CC: util-linux@vger.kernel.org
Subject: Re: fdisk geometry
References: <50109E8D.2000702@jelmail.com> <1343294980.2609.4.camel@offbook>
In-Reply-To: <1343294980.2609.4.camel@offbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 26/07/12 10:29, Davidlohr Bueso wrote:
> On Thu, 2012-07-26 at 02:34 +0100, John Lane wrote:
>> Hello, I'm in the middle of studying disk organisation to enhance my
>> understanding in this area. I have a few questions about fdisk (trying
>> to fill a gap in my knowledge if that's ok)...
> use the source, Luke :)
:)
>> In the below output of fdisk it shows (correctly) a geometry of 224
>> heads, 56 sectors/track. I'm unclear about where this information comes
>> from. Normally a disk's geometry would be reported as 255 heads and 63
>> sectors. I explicitly partitioned this disk using a 224/56 geometry, so
>> the report is correct. I'd just like to understand:
>>
>> (a) where fdisk gets the information about the geometry from in  this
>> specific case?
> fdisk gets the information from (i) user input, (ii) what the
> kernel/bios thinks the geometry is, with the HDIO_GETGEO ioctl and (iii)
> by inferring it from the partition table geometry.
Thanks, yes I was able to deduce this from the source but I wasn't 
confident I had it right.
Reading this confirms nicely what I thought was going on.
>> (b) when fdisk defaults to 255/63 is that because it's hard coded that
>> way or is there another reason?
> Correct.
>
>> I understand why it's 255/63 by default but haven't been able to
>> understand how the geometry is determined. I do know that it's all kind
>> of moot these days anyway because of sector based addressing but that
>> leads to one other question: given sector based addressing why does
>> fdisk even bother displaying a geometry any more ? Doesn't it just serve
>> to confuse?
> That's because fdisk is/was mostly legacy code, we are currently
> updating the program.
I've just seen the upcoming changes, removing the messages when
not in dos mode.
> Cheers,
> Davidlohr
>
>

