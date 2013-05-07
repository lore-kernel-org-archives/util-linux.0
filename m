Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36121 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab3EGJsu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 May 2013 05:48:50 -0400
Date: Tue, 7 May 2013 11:48:35 +0200
From: Karel Zak <kzak@redhat.com>
To: George Mitchell <george@chinilu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: umount and findmnt commands not working with btrfs labels ...
Message-ID: <20130507094835.GB7086@x2.net.home>
References: <51882EA5.9080805@chinilu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51882EA5.9080805@chinilu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi George,

On Mon, May 06, 2013 at 03:28:53PM -0700, George Mitchell wrote:
> [root@localhost ghmitch]# umount LABEL=MAGEIA3BTR-BOOT
> 
> umount: LABEL=MAGEIA3BTR-BOOT: not found

 umount --version ?

 It works for me (tested with util-linux 2.22 and 2.23):

  # mkfs.btrfs -L MAGEIA3BTR /dev/sdb1
  # mkfs.btrfs -L MAGEIA3BTR-FOO /dev/sdb2

  # mount LABEL=MAGEIA3BTR /mnt/test
  # mount LABEL=MAGEIA3BTR-FOO /mnt/test

  # findmnt LABEL=MAGEIA3BTR
  TARGET    SOURCE    FSTYPE OPTIONS
  /mnt/test /dev/sdb1 btrfs  rw,relatime,ssd,space_cache

  # findmnt LABEL=MAGEIA3BTR-FOO
  TARGET     SOURCE    FSTYPE OPTIONS
  /mnt/test2 /dev/sdb2 btrfs  rw,relatime,ssd,space_cache

  # umount LABEL=MAGEIA3BTR
  # umount LABEL=MAGEIA3BTR-FOO

  # lsblk --fs /dev/sdb
  NAME   FSTYPE LABEL          UUID                                 MOUNTPOINT
  sdb                                                               
  ├─sdb1 btrfs  MAGEIA3BTR     6dcc3293-ce27-474f-ab31-dd7a8e5bb2da 
  └─sdb2 btrfs  MAGEIA3BTR-FOO f3bb2d57-8b46-40a0-ae76-50d78268d6d9 


It would be nice to have a simple reproducible scenario rather than a
lot of mount -l outputs and some egrep tricks :-)

You can also try 

  LIBMOUNT_DEBUG=0xffff umount LABEL=MAGEIA3BTR-BOOT

to see more details.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
