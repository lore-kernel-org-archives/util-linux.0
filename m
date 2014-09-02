Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f181.google.com ([209.85.217.181]:50140 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754931AbaIBQnc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Sep 2014 12:43:32 -0400
Received: by mail-lb0-f181.google.com with SMTP id n15so7768471lbi.26
        for <util-linux@vger.kernel.org>; Tue, 02 Sep 2014 09:43:31 -0700 (PDT)
Message-ID: <5405F446.2040202@gmail.com>
Date: Tue, 02 Sep 2014 18:45:58 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Weird behaviour with lsblk and freshly created loop device
References: <54049344.4010502@gmail.com> <20140901175609.GA21325@x2.net.home> <54056BD1.1080205@gmail.com> <20140902073020.GB21325@x2.net.home>
In-Reply-To: <20140902073020.GB21325@x2.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09/02/2014 09:30 AM, Karel Zak wrote:
> On Tue, Sep 02, 2014 at 09:03:45AM +0200, Francis Moreau wrote:
>> It seems that lsblk uses udev to get some block device metadata and asks
>> some others to the kernel. If so, it makes the whole process racy
>> because udev might not have handled the events sent by the kernel yet.
>>
>> I'm not sure why udev is used by default in the first place, what are
> 
>  * info from udev is accessible for non-root users
>  * it's better to scan devices only once on one place only
>  * udev is able to gather information from more sources (for example
>    libblkid does not provide WWN)
> 
>> the benefits ? Using libblkid, at least by default seems the right thing
>> to do.
>>
>> Otherwise maybe lsblk should do the equivalent of 'udevadm settle' to
>> handle correctly freshly created devices ?
> 
> That's question, now (because it's not hardcoded to lsblk) everyone is
> able to control this behavior, all you need is to add 'udevadm settle'
> to your use-case. 

The question is more why let the user do that ?

If lsblk reports the partitions, shouldn't it do that only when it's
sure to fully have retrieve the partition's metadata ?

BTW, is the user supposed to know that lsblk relies on udev or is this
implementation detail ?

Thanks
