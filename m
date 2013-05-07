Return-Path: util-linux-owner@vger.kernel.org
Received: from atl4mhob10.myregisteredsite.com ([209.17.115.48]:53240 "EHLO
	atl4mhob10.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755138Ab3EGPK2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 May 2013 11:10:28 -0400
Received: from mailpod1.hostingplatform.com ([10.30.71.117])
	by atl4mhob10.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id r47FARL9023657
	for <util-linux@vger.kernel.org>; Tue, 7 May 2013 11:10:27 -0400
Message-ID: <51891967.7030804@chinilu.com>
Date: Tue, 07 May 2013 08:10:31 -0700
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
Just to further illustrate the complexity here:

[root@localhost ghmitch]# blkid | egrep COMMON
/dev/sdc4: LABEL="COMMON" UUID="4b0983d7-8d85-463d-85c1-c20aa3b4fa3b" 
UUID_SUB="2fed487e-c68a-4688-8ab7-526751d50e62" TYPE="btrfs"
/dev/sdd4: LABEL="COMMON" UUID="4b0983d7-8d85-463d-85c1-c20aa3b4fa3b" 
UUID_SUB="91b80d1e-1a9c-4a1a-9f5f-e396ea205085" TYPE="btrfs"
/dev/sde4: LABEL="COMMON" UUID="4b0983d7-8d85-463d-85c1-c20aa3b4fa3b" 
UUID_SUB="8e4a1292-980a-4815-9d1f-c43c312bfeb8" TYPE="btrfs"
/dev/sdf4: LABEL="COMMON" UUID="4b0983d7-8d85-463d-85c1-c20aa3b4fa3b" 
UUID_SUB="1e459a35-ed8d-4021-b6ea-161bda96305a" TYPE="btrfs"
/dev/sdg4: LABEL="COMMON" UUID="4b0983d7-8d85-463d-85c1-c20aa3b4fa3b" 
UUID_SUB="92bfb4cb-9f4b-4277-ad5e-fe6cf34d368f" TYPE="btrfs"
[root@localhost ghmitch]# mount -l | egrep COMMON
/dev/sde4 on /common type btrfs (rw,relatime,space_cache) [COMMON]

if findmnt OR umount simply search for an association between the LABEL 
and the DEVICE, how do they come up with the correct mount point when 
only ONE of the devices involved will serve as the mount point?  
Hopefully that question better describes the problem.  - George
