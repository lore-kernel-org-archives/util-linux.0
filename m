Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56158 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbaJHK4K (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 8 Oct 2014 06:56:10 -0400
Received: by mail-lb0-f174.google.com with SMTP id p9so7803222lbv.5
        for <util-linux@vger.kernel.org>; Wed, 08 Oct 2014 03:56:09 -0700 (PDT)
Message-ID: <543518DF.2060707@gmail.com>
Date: Wed, 08 Oct 2014 12:58:39 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: losetup: failed to setup loop device > 1
References: <5432C4C8.30101@gmail.com> <20141006174041.GA8057@x2.net.home> <54330294.1090908@gmail.com> <20141007091711.GB8057@x2.net.home>
In-Reply-To: <20141007091711.GB8057@x2.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/07/2014 11:17 AM, Karel Zak wrote:
> On Mon, Oct 06, 2014 at 10:59:00PM +0200, Francis Moreau wrote:
>> On 10/06/2014 07:40 PM, Karel Zak wrote:
>>> On Mon, Oct 06, 2014 at 06:35:20PM +0200, Francis Moreau wrote:
>>>> One last details is that the system uses pretty old stuff: kernel
>>>> 3.4.50, util-linux 2.21.1.
>>>
>>> $ git log --oneline v2.21.. -- lib/loopdev.c sys-utils/losetup.c | wc -l
>>> 62
>>>
>>>> Could anybody give me some help ?
>>>
>>> update, this is upstream mailing list I have doubts anyone is ready
>>> to help you with code released 2 years ago.
>>
>> well it looks like more a kernel issue since the sequence of syscalls
>> done by losetup looks correct. Maybe someone here already encountered
>> this...
>>
>> I just found that loop module was loaded with max_part=16 and
>> CONFIG_BLK_DEV_LOOP_MIN_COUNT=8. If max_part is set to 0 then the issue
>> is gone :-/
> 
> Well, if you have kernel that provides /dev/loop-control then you
> don't have to set CONFIG_BLK_DEV_LOOP_MIN_COUNT at all. I guess 
> "8" (kernel upstream default?) is mostly about backward compatibility.

BTW it not depends only on the kernel and /dev/loop-control but also on
losetup(8) to be recent enough to add a new loop device if the one
specified doesn't exist. And I don't think it's the case for losetup
shipped by util-linux 2.21.1

Thanks.
