Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61426 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757747Ab3K0UXq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Nov 2013 15:23:46 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so12658030iec.5
        for <util-linux@vger.kernel.org>; Wed, 27 Nov 2013 12:23:45 -0800 (PST)
Message-ID: <529654CF.1010904@gmail.com>
Date: Wed, 27 Nov 2013 13:23:43 -0700
From: Curtis Gedak <gedakc@gmail.com>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>, Karel Zak <kzak@redhat.com>
CC: Marc MERLIN <marc@merlins.org>, util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
References: <20131118102051.GA31813@merlins.org> <20131124135226.GH11389@merlins.org> <20131125103124.GQ5572@x2.net.home> <529605B7.3020903@ubuntu.com> <20131127145840.GB32483@x2.net.home> <52963910.60800@ubuntu.com> <52964ED3.8030504@gmail.com> <5296515A.1070505@ubuntu.com>
In-Reply-To: <5296515A.1070505@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 13-11-27 01:08 PM, Phillip Susi wrote:
> On 11/27/2013 2:58 PM, Curtis Gedak wrote:
>> Unfortunately at least one company produces devices that have
>> partitions with ID set to 0, yet these same partitions contain
>> data.
>>
>> An Apple iPod Shuffle is such an example as shown in the following
>> fdisk output:
> Wow, what is in there?  And more hilariously, what happens when you
> plug the thing into a Windows machine and try to create a partition in
> the "free space"?
>
> Also, I thought iPods don't use the USB MASS STORAGE protocol so they
> don't show up as a block device at all; you have to use iTunes to
> access them.

IIRC, the partition with ID = 0 contains the firmware for the Apple 
iPod.  The device is recognized in GNU/Linux, and files can be copied to 
and from the FAT partition.  However, since the iPod firmware uses a 
database to keep track of songs, only songs transferred to the device 
using "iPod aware" software will be seen by the iPod music player.  
Amarok is an example of a native GNU/Linux application that is iPod aware.

IMHO Apple's choice of using an ID of zero for the firmware partition is 
a poor decision.  With that being said, these devices with this strange 
ID setting do exist in the real world.

Curtis

