Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:40075 "EHLO
	elasmtp-banded.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752135AbbBQIcd (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Feb 2015 03:32:33 -0500
Received: from [69.22.67.43] (helo=[192.168.0.11])
	by elasmtp-banded.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1YNda4-0002Nx-9O
	for util-linux@vger.kernel.org; Tue, 17 Feb 2015 03:32:32 -0500
Message-ID: <54E2FC9F.9060607@earthlink.net>
Date: Tue, 17 Feb 2015 03:32:31 -0500
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: fdisk -l hits floppy drive
References: <87r3tpqngz.fsf@hobgoblin.ariadne.com>
In-Reply-To: <87r3tpqngz.fsf@hobgoblin.ariadne.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

worley@alum.mit.edu (Dale R. Worley) composed on 2015-02-16 21:30 (UTC-0500):

> Felix Miata wrote:

>> Dale R. Worley composed on 2015-02-07 21:37 (UTC-0500):

>>> Felix Miata wrote:

>>>> fdisk -l is causing the floppy drive to get hit, which reflects the 4 kernel
>>>> messages onto the tty running fdisk. Is this expected or intended?

>>> I see in the manual page:

>>>        -l     List the partition tables for the  specified  devices  and  then
>>>               exit.   If no devices are given, those mentioned in /proc/parti-
>>>               tions (if that exists) are used.

>>> Is the floppy listed in /proc/partitions?

>> Yes, as is the OM drive:
>>...
>>    2        0          4 fd0
>>...

> Then the answer to your question is, "Yes, it is expected and intended."

Why?

> Are you saying that you find this undesirable? 

Based on my understanding of the meaning of partition, yes. From the man page:

	fdisk is a dialog-driven program for creation and manipulation of
	partition tables.

sr0 and fd0 don't have partition tables. Are sr0 and fd0 not always invalid
targets for fdisk? If yes, what reason is there for /proc/partitions to
contain them?

> If so, do you have a
> proposal for how "fdisk -l" should determine the list of devices that it
> should list?

AFAICT, it should list all items in /proc/partitions, which should contain
only devices that are partitionable. Including /dev/md* in /proc/partitions
also seems wrong.

How fdisk does what it does doesn't really matter to me. What matters is not
hearing unexpected attempts to access an old floppy drive that I expect to
work when I need it instead of being worn out by unwanted and useless access
attempts; and not seeing floppy access failure messages appear in the middle
of other activity.
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
