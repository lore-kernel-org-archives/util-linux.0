Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18148 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757767Ab2D0M2w (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Apr 2012 08:28:52 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3RCSpvq029012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 27 Apr 2012 08:28:51 -0400
Received: from x2 (ovpn-116-57.ams2.redhat.com [10.36.116.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q3RCSovX023077
	for <util-linux@vger.kernel.org>; Fri, 27 Apr 2012 08:28:51 -0400
Date: Fri, 27 Apr 2012 14:28:49 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] findmnt: add match_by_file to do within-device
 matching
Message-ID: <20120427122849.GC8985@x2.net.home>
References: <1335400252-17929-1-git-send-email-dreisner@archlinux.org>
 <1335400252-17929-2-git-send-email-dreisner@archlinux.org>
 <20120426021651.GH938@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120426021651.GH938@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 25, 2012 at 10:16:51PM -0400, Dave Reisner wrote:
> On Wed, Apr 25, 2012 at 08:30:52PM -0400, Dave Reisner wrote:
> > Use the newly exported mnt_get_mountpoint to determine the device that a
> > given file resides on, in case the supplied source or target is not
> > explicitly a mount point.
> > 
> > http://www.spinics.net/lists/util-linux-ng/msg06081.html
> > 
> > Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> > ---
> 
> On second thought, this isn't good -- it'll return results even when
> you're searching with --fstab (which is completely undesirable, imo).

I have restricted the functionality ;-(

- search with --kernel (this is default)

- target has to be explicitly defined by --target option or if the source
  is explicitly defined by MAJ:MIN, UUID=, ...

 This restriction is required because findmnt(8) (like mount(8))
 allows

        findmnt <device>|<mountpoint>

 and for example without this restriction, command

        findmnt /dev/sdb1

 returns info about /dev tmpfs (because mnt_get_mountpoint() returns
 "/dev" as a mountpoint for path "/dev/sdb1" ;-)

 Note that source for mount(2) syscall could be whatever, including
 regular file, directory or any random string. All depends on
 filesystem driver(s). It means that we cannot make any decision about
 findmnt arguments if --target or --source are not explicitly given.

Examples:

$ findmnt /home/kzak/Pictures/
[nothing]

$ findmnt --target /home/kzak/Pictures
TARGET     SOURCE                                                FSTYPE OPTIONS
/home/kzak /dev/mapper/luks-10d813de-fa82-4f67-a86c-23d5d0e7c30e ext4  rw,relat


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
