Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:56257 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751033AbbBHHw3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Feb 2015 02:52:29 -0500
Received: from [69.22.67.43] (helo=[192.168.0.11])
	by elasmtp-mealy.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1YKMfM-0005ZO-7M
	for util-linux@vger.kernel.org; Sun, 08 Feb 2015 02:52:28 -0500
Message-ID: <54D715BB.6070406@earthlink.net>
Date: Sun, 08 Feb 2015 02:52:27 -0500
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: fdisk -l hits floppy drive
References: <87zj8pm8lo.fsf@hobgoblin.ariadne.com>
In-Reply-To: <87zj8pm8lo.fsf@hobgoblin.ariadne.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dale R. Worley composed on 2015-02-07 21:37 (UTC-0500):

> Felix Miata wrote:

>> fdisk -l is causing the floppy drive to get hit, which reflects the 4 kernel
>> messages onto the tty running fdisk. Is this expected or intended?

> I see in the manual page:
> 
>        -l     List the partition tables for the  specified  devices  and  then
>               exit.   If no devices are given, those mentioned in /proc/parti-
>               tions (if that exists) are used.

> Is the floppy listed in /proc/partitions?

Yes, as is the OM drive:
3.18.3-1-desktop #1 SMP PREEMPT Mon Jan 19 12:38:51 UTC 2015 (c3e148f) x86_64
x86_64 x86_64 GNU/Linux (openSUSE Tumbleweed)
major minor  #blocks  name

   8        0 1953514584 sda
   8        1     409600 sda1
   8        2    2048000 sda2
   8        3     409600 sda3
   8        4          1 sda4
   8        5    4245488 sda5
   8        6   49151984 sda6
   8        7     258032 sda7
   8        8   10239984 sda8
   8        9   10239984 sda9
   8       10   10239984 sda10
   8       11   10239984 sda11
   8       12    5119984 sda12
   8       13    4095984 sda13
   8       14    2047984 sda14
   8       15   24575984 sda15
 259        0   77823984 sda16
 259        1  240639984 sda17
 259        2  972799984 sda18
 259        3     450544 sda19
 259        4   49151984 sda20
   2        0          4 fd0
  11        0    1048575 sr0

Knoppix 7.4's 3.16.3 and openSUSE 13.2's 3.16.7 have fd0 in /proc/partitions
too. openSUSE 13.1's 3.12.36 lists sr0, but not fd0. Tumbleweed's hwinfo
--[cdrom|disk|ide|partition|redasd|scsi] (v21.11) all produce fd0 messages on
vttys too. hwinfo --floppy produces 6 messages instead of 4, so I suspect
this is about something exclusive to openSUSE other than util-linux, but
what? Kernel? Systemd logging? Other?

All above are on a Dell Optiplex 760 SFF (ICH10D) with BIOS A12, 4 versions
older than latest
available (A16; too big to fit on a 1.44M floppy).
http://www.dell.com/us/dfb/p/optiplex-760/pd

A similar age Biostar (NM10/ICH7) with Tumbleweed's 3.18.3 and 13.2's 3.16.7
lists fd0, sr0 & sr1, but Tumbleweed's fdisk (2.25.1) and 13.2's fdisk
(2.25.1) don't result in the floppy hits trailing output. 13.1's 3.16.7 has
sr0 & sr0 in /proc/partitions, but not fd0, same as Rawhide's 3.19.rc7.

An older Optiplex GX280 SFF (ICH6; BIOS A04) with floppy and Tumbleweed's
3.18.1 and
13.2's 3.16.7 list both sr0 and fd0 in /proc/partitions, but drop no fd0
messages on the ttys from fdisk -l or hwinfo.
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
