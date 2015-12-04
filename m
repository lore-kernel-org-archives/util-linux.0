Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:56483 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489AbbLDSAg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 13:00:36 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1a4uem-00055j-6l
	for util-linux@vger.kernel.org; Fri, 04 Dec 2015 19:00:32 +0100
Received: from ip4d14b373.dynamic.kabel-deutschland.de ([77.20.179.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 04 Dec 2015 19:00:32 +0100
Received: from for-gmane by ip4d14b373.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 04 Dec 2015 19:00:32 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: fsck memory leak
Date: Fri, 4 Dec 2015 19:00:25 +0100
Message-ID: <n3skbp$ib8$2@ger.gmane.org>
References: <n3rei3$8l3$1@ger.gmane.org> <n3rgif$72q$1@ger.gmane.org>
 <20151204102128.GM4955@ws.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <20151204102128.GM4955@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote on 12/04/2015 11:21 AM:
> On Fri, Dec 04, 2015 at 08:49:34AM +0100, U.Mutlu wrote:
>> U.Mutlu wrote on 12/04/2015 08:15 AM:
>>> Hi,
>>> when I as root do "touch /forcefsck" and reboot, then fsck will be done.
>>> But afterwards one has less free memory available than normal.
>>> Example:
>>> used mem immediately after login:
>>>   without fsck during boot:  98 MB (this the normal level here)
>>>   with fsck during boot   : 139 MB
>>> So, there is a memory leak of about 41 MB.
>>
>> This discrepancy is reproducible here, ie. happens always.
>>
>> Not sure, but it could also be a kernel issue, because
>> the longer the system runs the more memory gets bound.
>> The source of the culprit is not easily detectable.
>> I guess it gets eaten by the kernel, probably by the ext4-driver.
>>
>>> fsck from util-linux 2.25.2
>>> Filesys: ext4, 500 MB SSD
>>
>> fix: of course 500 GB was meant
>>
>>> OS: Debian 8 X86_64, uptodate
>
> And are you talking about fsck (wrapper) or fsck.ext4 (from
> e2fsprogs)?

I don't know which one gets used in the above scenario because
it is done automatically by the system.

But the problem is solved now by setting /proc/sys/vm/drop_caches
to the value 3 as was written in the other postings.

>
>      Karel


