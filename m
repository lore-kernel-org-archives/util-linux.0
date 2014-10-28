Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:46454 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932743AbaJ1Dz6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Oct 2014 23:55:58 -0400
Message-ID: <544F13CD.8000502@earthlink.net>
Date: Mon, 27 Oct 2014 23:55:57 -0400
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
References: <544E923E.6050406@gmail.com> <544E97ED.7040406@earthlink.net> <544F0C88.1080807@gmail.com>
In-Reply-To: <544F0C88.1080807@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

dE composed on 2014-10-28 08:54 (UTC+0530):

> Felix Miata wrote:

>> http://www.seagate.com/tech-insights/advanced-format-4k-sector-hard-drives-master-ti/
>> may provide some insight WRT performance issues ensuing from other start
>> sector selections.

> But that works even with multiples of 8. So we can start from sector 8 
> in MBR and 40 in GPT.

OK, as long as you know you'll never need a bootloader or other boot-time
software that requires the "wasted" space between MBR and first partition
sector. It seems M$ for Vista picked 2048 to reserve plenty of space for such
a *possibility* (not necessarily expectation), so for compat reasons and
other[1], other tools, including fdisk, decided to do the same at least by
default.

I've created partitions starting at sector 0x400 on 4k disks with no problems
observed.

> Also I'm pretty sure fdisk uses 2048 even with -b 4096, but 
> unfortunately I get --

> *** Error in `fdisk': malloc(): memory corruption: 0x0000000002507330 ***

>   with that switch.

Bug somewhere?

[1]
http://www.anchor.com.au/blog/2012/10/the-difference-between-booting-mbr-and-gpt-with-grub/
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
