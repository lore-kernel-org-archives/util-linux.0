Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39850 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbaJ1Odd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Oct 2014 10:33:33 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so875190pab.0
        for <util-linux@vger.kernel.org>; Tue, 28 Oct 2014 07:33:33 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.82.149])
        by mx.google.com with ESMTPSA id h3sm1061637pdl.22.2014.10.28.07.33.30
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 07:33:31 -0700 (PDT)
Message-ID: <544FA923.5080205@gmail.com>
Date: Tue, 28 Oct 2014 20:03:07 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
References: <544E923E.6050406@gmail.com> <544E97ED.7040406@earthlink.net> <544F0C88.1080807@gmail.com> <544F3B20.7090109@gmail.com>
In-Reply-To: <544F3B20.7090109@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/28/14 12:13, Bruce Dubbs wrote:
> dE wrote:
>> On 10/28/14 00:37, Felix Miata wrote:
>>> dE composed on 2014-10-28 00:13 (UTC+0530):
>>>
>>>> I was learning about GPT when I noticed this behavior of fdisk which I
>>>> never though about before.
>>>> Regardless of the partition table, fdisk always starts the first
>>>> partition at 2048. In reality, the maximum size required by the gap
>>>> between MBR and the 1st partition is a single sector, which's used by
>>>> GRUB 1.5. GPT doesn't need this space at all.
>>>> Then extended partitions too have a gap of 2048 sectors.
>>>> Why this behavior?
>>> http://www.seagate.com/tech-insights/advanced-format-4k-sector-hard-drives-master-ti/ 
>>>
>>>
>>> may provide some insight WRT performance issues ensuing from other 
>>> start
>>> sector selections.
>>
>> But that works even with multiples of 8. So we can start from sector 8
>> in MBR and 40 in GPT.
>>
>> Also I'm pretty sure fdisk uses 2048 even with -b 4096, but
>> unfortunately I get --
>>
>> *** Error in `fdisk': malloc(): memory corruption: 0x0000000002507330 
>> ***
>>
>>   with that switch.
>
> You seem to be overly concerned about the disk space below sector 
> 2048.  That's a little less than 1M -- less than a floppy disk. In the 
> era of $100/TB, does 1M matter?
>
> When formatting a drive, there are several issues to consider.  If 
> it's a boot drive, then the boot loader needs to go somewhere. Grub 
> puts it in sectors 2-63 for MSDOS style partition tables and in a 
> separate Grub partition for GPT formatted drives.
>
> Larger hard drives (2T+) require a GPT to access the entire drive.  
> They also are formatted internally as 4K sectors. Creating a partition 
> that is not aligned with the disk architecture is inefficient.
>
> IMO, all partitions should be aligned on 1MiB boundaries by default 
> for either type of partition.  It's just easier to understand.
>
>   -- Bruce
>

But if fdisk puts it at sector 8 for MBR and sector 40 for GPT, it'll 
solve the purpose.

2048 is Windows behavior ported to utils-linux. It's pointless.
