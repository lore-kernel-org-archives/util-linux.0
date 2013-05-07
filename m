Return-Path: util-linux-owner@vger.kernel.org
Received: from atl4mhob07.myregisteredsite.com ([209.17.115.45]:56008 "EHLO
	atl4mhob07.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932907Ab3EGOKo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 May 2013 10:10:44 -0400
Received: from mailpod1.hostingplatform.com ([10.30.71.115])
	by atl4mhob07.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id r47EAhwn007176
	for <util-linux@vger.kernel.org>; Tue, 7 May 2013 10:10:43 -0400
Message-ID: <51890B67.5040700@chinilu.com>
Date: Tue, 07 May 2013 07:10:47 -0700
From: George Mitchell <george@chinilu.com>
Reply-To: george@chinilu.com
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: umount and findmnt commands not working with btrfs labels ...
References: <51882EA5.9080805@chinilu.com> <20130507094835.GB7086@x2.net.home>
In-Reply-To: <20130507094835.GB7086@x2.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 05/07/2013 02:48 AM, Karel Zak wrote:
>   Hi George,
>
> On Mon, May 06, 2013 at 03:28:53PM -0700, George Mitchell wrote:
>> [root@localhost ghmitch]# umount LABEL=MAGEIA3BTR-BOOT
>>
>> umount: LABEL=MAGEIA3BTR-BOOT: not found
>   umount --version ?
>
>   It works for me (tested with util-linux 2.22 and 2.23):
>
>    # mkfs.btrfs -L MAGEIA3BTR /dev/sdb1
>    # mkfs.btrfs -L MAGEIA3BTR-FOO /dev/sdb2
>
>    # mount LABEL=MAGEIA3BTR /mnt/test
>    # mount LABEL=MAGEIA3BTR-FOO /mnt/test
>
>    # findmnt LABEL=MAGEIA3BTR
>    TARGET    SOURCE    FSTYPE OPTIONS
>    /mnt/test /dev/sdb1 btrfs  rw,relatime,ssd,space_cache
>
>    # findmnt LABEL=MAGEIA3BTR-FOO
>    TARGET     SOURCE    FSTYPE OPTIONS
>    /mnt/test2 /dev/sdb2 btrfs  rw,relatime,ssd,space_cache
>
>    # umount LABEL=MAGEIA3BTR
>    # umount LABEL=MAGEIA3BTR-FOO
>
>    # lsblk --fs /dev/sdb
>    NAME   FSTYPE LABEL          UUID                                 MOUNTPOINT
>    sdb
>    ├─sdb1 btrfs  MAGEIA3BTR     6dcc3293-ce27-474f-ab31-dd7a8e5bb2da
>    └─sdb2 btrfs  MAGEIA3BTR-FOO f3bb2d57-8b46-40a0-ae76-50d78268d6d9
>
>
> It would be nice to have a simple reproducible scenario rather than a
> lot of mount -l outputs and some egrep tricks :-)
>
> You can also try
>
>    LIBMOUNT_DEBUG=0xffff umount LABEL=MAGEIA3BTR-BOOT
>
> to see more details.
>
>      Karel
>
Thanks, and sorry for including all the garbage.  I just wanted to make 
sure I didn't leave anything out.  The version I have here is 2.22.2.  I 
retested it using the DEBUG statement and it then worked and findmnt now 
works OK as well, so I don't know what was going on.  Something seems to 
have gotten cleaned up somewhere.  Tonight I will retest it on my other 
system that I use for maintainance on the USR partition since it would 
probably be unwise to fiddle with the USR partition with the system 
running.  At that point I will repost letting you know what I find.  - 
George
