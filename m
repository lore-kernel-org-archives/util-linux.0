Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f46.google.com ([209.85.215.46]:60094 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756528AbaJ1EbK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Oct 2014 00:31:10 -0400
Received: by mail-la0-f46.google.com with SMTP id hs14so679982lab.33
        for <util-linux@vger.kernel.org>; Mon, 27 Oct 2014 21:31:09 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.143.167])
        by mx.google.com with ESMTPSA id l7sm129607lah.27.2014.10.27.21.31.06
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 Oct 2014 21:31:08 -0700 (PDT)
Message-ID: <544F1BF2.3040203@gmail.com>
Date: Tue, 28 Oct 2014 10:00:42 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
References: <544E923E.6050406@gmail.com> <544E97ED.7040406@earthlink.net> <544F0C88.1080807@gmail.com> <544F13CD.8000502@earthlink.net>
In-Reply-To: <544F13CD.8000502@earthlink.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/28/14 09:25, Felix Miata wrote:
> dE composed on 2014-10-28 08:54 (UTC+0530):
>
>> Felix Miata wrote:
>>> http://www.seagate.com/tech-insights/advanced-format-4k-sector-hard-drives-master-ti/
>>> may provide some insight WRT performance issues ensuing from other start
>>> sector selections.
>> But that works even with multiples of 8. So we can start from sector 8
>> in MBR and 40 in GPT.
> OK, as long as you know you'll never need a bootloader or other boot-time
> software that requires the "wasted" space between MBR and first partition
> sector. It seems M$ for Vista picked 2048 to reserve plenty of space for such
> a *possibility* (not necessarily expectation), so for compat reasons and
> other[1], other tools, including fdisk, decided to do the same at least by
> default.
>
> I've created partitions starting at sector 0x400 on 4k disks with no problems
> observed.
>
>> Also I'm pretty sure fdisk uses 2048 even with -b 4096, but
>> unfortunately I get --
>> *** Error in `fdisk': malloc(): memory corruption: 0x0000000002507330 ***
>>    with that switch.
> Bug somewhere?
>
> [1]
> http://www.anchor.com.au/blog/2012/10/the-difference-between-booting-mbr-and-gpt-with-grub/

Yeah, I'll file that bug.

But I also think this fdisk 2048 behavior should be removed now or at 
least provide a switch for the same and document this in the man page.
