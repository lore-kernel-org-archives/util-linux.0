Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:58436 "EHLO
	resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751797AbbBRD3o (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Feb 2015 22:29:44 -0500
From: worley@alum.mit.edu (Dale R. Worley)
To: Felix Miata <mrmazda@earthlink.net>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk -l hits floppy drive
In-Reply-To: <54E2FC9F.9060607@earthlink.net> (mrmazda@earthlink.net)
Date: Tue, 17 Feb 2015 22:29:42 -0500
Message-ID: <87y4nvq4m1.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Felix Miata <mrmazda@earthlink.net> writes:

>>>>> fdisk -l is causing the floppy drive to get hit, which reflects the 4 kernel
>>>>> messages onto the tty running fdisk. Is this expected or intended?
>
>>>> I see in the manual page:
>
>>>>        -l     List the partition tables for the  specified  devices  and  then
>>>>               exit.   If no devices are given, those mentioned in /proc/parti-
>>>>               tions (if that exists) are used.
>
>>>> Is the floppy listed in /proc/partitions?
>
>> Then the answer to your question is, "Yes, it is expected and intended."
>
> Why?

Because "fdisk -l lists the partition tables for all devices listed in
/proc/partitions", as it says in the manual page.

Your complaint is not really about the behavior of fdisk, but about the
contents of /proc/partitions, which is maintained by some other group.

>> Are you saying that you find this undesirable? 
>
> Based on my understanding of the meaning of partition, yes. From the man page:
>
> 	fdisk is a dialog-driven program for creation and manipulation of
> 	partition tables.
>
> sr0 and fd0 don't have partition tables. Are sr0 and fd0 not always invalid
> targets for fdisk? If yes, what reason is there for /proc/partitions to
> contain them?

Actually, you *can* write a partition table to fd0, though people rarely
bother to.  It makes more sense if fd0 is an LS-120 (120 MiB) device,
which I had on one computer.

Dale
