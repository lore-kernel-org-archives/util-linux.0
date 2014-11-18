Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:33190 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbaKRKcX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Nov 2014 05:32:23 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1Xqg58-0002x5-B7
	for util-linux@vger.kernel.org; Tue, 18 Nov 2014 11:32:22 +0100
Received: from barriere.frankfurter-softwarefabrik.de ([217.11.197.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 18 Nov 2014 11:32:22 +0100
Received: from lvml by barriere.frankfurter-softwarefabrik.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 18 Nov 2014 11:32:22 +0100
To: util-linux@vger.kernel.org
From: Lutz Vieweg <lvml@5t9.de>
Subject: fstrim tries to discard data beyond the last sector of a device
Date: Tue, 18 Nov 2014 11:32:10 +0100
Message-ID: <m4f77a$ivg$1@ger.gmane.org>
References: <m3qnrg$5gc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
In-Reply-To: <m3qnrg$5gc$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I'm kind of concerned that there was no reaction on my recent
post - maybe the subject I chose wasn't colorful enough to
draw attention on what I think is a real threat to data integrity
on persistent storage.

The "Logical block address out of range" error amongst the (cited below)
messages says no less than that fstrim issued a fitrim ioctl that
was asking the device to discard the content of sectors well beyond
the boundaries of the device. If it wasn't for the "end of the physical
device" making the SSD return an error, if instead there was another
partition behind a filesystem to trim, then valuable, live data
would have been discarded.

If email to this list is not a suitable form to report such issues,
please let me know where I can report this issue better.

Regards,

Lutz Vieweg


On 11/10/2014 05:07 PM, Lutz Vieweg wrote:
> Hi,
>
> when I use "fstrim" on a just newly "mkfs.xfs /dev/sdb"-ed
> filesystem on a newly mounted SSD (Crucial_CT1024M550SSD1,
> firmware MU01), I get (after some activity on the device)
> this error message:
>
>> fitrim ioctl failed: input/output error
>
> Looking into the dmesg output reveals:
>
>> [1039455.530947] sd 0:0:1:0: [sdb]
>> [1039455.533192] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>> [1039455.535369] sd 0:0:1:0: [sdb]
>> [1039455.537521] Sense Key : Illegal Request [current]
>> [1039455.539684] Info fld=0x772cdab0
>> [1039455.541802] sd 0:0:1:0: [sdb]
>> [1039455.543877] Add. Sense: Logical block address out of range
>> [1039455.545966] sd 0:0:1:0: [sdb] CDB:
>> [1039455.548008] Unmap/Read sub-channel: 42 00 00 00 00 00 00 00 18 00
>> [1039455.550080] end_request: critical target error, dev sdb, sector 1999428272
>
> (I bought 4 of the same SSD model, and the error occurs the same
> with the other exemplars, so I assume this is not some hardware issue.)
>
> According to smartctl, the capacity of this SSD is:
>> User Capacity:    1,024,209,543,168 bytes [1.02 TB]
>> Sector Sizes:     512 bytes logical, 4096 bytes physical
>
> And cat /proc/partitions tells:
>>    major minor  #blocks  name
>>    8       16 1000204632 sdb
>
> Kernel is mainline linux-3.17.1
>
> fstrim --version says:
>> fstrim from util-linux 2.23.2
>
> (Distribution is CentOS 7, if that matters.)
>
> Does anyone have a clue what's going wrong, here?
>
> Regards,
>
> Lutz Vieweg
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

