Return-Path: gedakc@gmail.com
Message-ID: <52964ED3.8030504@gmail.com>
Date: Wed, 27 Nov 2013 12:58:11 -0700
From: Curtis Gedak <gedakc@gmail.com>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>, Karel Zak <kzak@redhat.com>
CC: Marc MERLIN <marc@merlins.org>, util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
References: <20131118102051.GA31813@merlins.org> <20131124135226.GH11389@merlins.org> <20131125103124.GQ5572@x2.net.home> <529605B7.3020903@ubuntu.com> <20131127145840.GB32483@x2.net.home> <52963910.60800@ubuntu.com>
In-Reply-To: <52963910.60800@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 13-11-27 11:25 AM, Phillip Susi wrote:
> On 11/27/2013 9:58 AM, Karel Zak wrote:
>> After 20 years it's feature ;-) as I'm almost sure that we cannot
>> fix it and disable all partition where is no the ID.
> While that's cute and all, I think we both know it isn't really true ;)

Unfortunately at least one company produces devices that have partitions 
with ID set to 0, yet these same partitions contain data.

An Apple iPod Shuffle is such an example as shown in the following fdisk 
output:

user@debian:~$ sudo fdisk -l /dev/sde
Note: sector size is 2048 (not 512)

Disk /dev/sde: 8120 MB, 8120172544 bytes
250 heads, 62 sectors/track, 255 cylinders
Units = cylinders of 15500 * 2048 = 31744000 bytes

    Device Boot      Start         End      Blocks   Id System
/dev/sde1               1           3       92876    0 Empty
/dev/sde2               4         255     7812000    b  W95 FAT32

This has lead some people, who wish to re-partition such a device, to 
use fdisk to temporarily set the ID to a non-zero value.  Then they can 
edit the partitions.  When the partitioning tasks are complete they use 
fdisk to set the ID back to zero again.

By doing this work-around, data loss can be avoided.

As such this "feature" of fdisk has been used and described on the 
Internet.  For example see the following post:
http://dreamlayers.blogspot.ca/2012/01/editing-ipod-partitions-with-gparted.html

Regards,
Curtis
