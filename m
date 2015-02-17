Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:49349 "EHLO
	resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754228AbbBQCaH (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Feb 2015 21:30:07 -0500
From: worley@alum.mit.edu (Dale R. Worley)
To: Felix Miata <mrmazda@earthlink.net>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk -l hits floppy drive
In-Reply-To: <54D715BB.6070406@earthlink.net> (mrmazda@earthlink.net)
Date: Mon, 16 Feb 2015 21:30:04 -0500
Message-ID: <87r3tpqngz.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Felix Miata <mrmazda@earthlink.net> writes:
> Dale R. Worley composed on 2015-02-07 21:37 (UTC-0500):
>
>> Felix Miata wrote:
>
>>> fdisk -l is causing the floppy drive to get hit, which reflects the 4 kernel
>>> messages onto the tty running fdisk. Is this expected or intended?
>
>> I see in the manual page:
>> 
>>        -l     List the partition tables for the  specified  devices  and  then
>>               exit.   If no devices are given, those mentioned in /proc/parti-
>>               tions (if that exists) are used.
>
>> Is the floppy listed in /proc/partitions?
>
> Yes, as is the OM drive:
>...
>    2        0          4 fd0
>...

Then the answer to your question is, "Yes, it is expected and intended."

Are you saying that you find this undesirable?  If so, do you have a
proposal for how "fdisk -l" should determine the list of devices that it
should list?

Dale
