Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50646 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852Ab2K3K5D (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Nov 2012 05:57:03 -0500
Date: Fri, 30 Nov 2012 11:56:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: BUG: fdisk fails silently if EBR is outside of disk
Message-ID: <20121130105659.GA21271@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 29, 2012 at 03:37:47PM -0500, Phillip Susi wrote:
> While helping a user troubleshoot an issue, I noticed fdisk fails to
> produce any output when run on an MBR that contains an extended
> partition that starts beyond the end of the disk.  The following is a
> sample of the user's MBR:

 Fixed (I hope).

 # ./fdisk /dev/loop0
 You must set cylinders.
 You can do this from the extra functions menu.
 Failed to read extended partition table (offset=462748414)
 Warning: ignoring extra data in partition table 5
 Warning: ignoring extra data in partition table 5
 Warning: ignoring extra data in partition table 5
 Warning: invalid flag 0x1919 of partition table 5 will be corrected
 by w(rite)
 Welcome to fdisk (util-linux 2.22.269-6b3e3).

 Changes will remain in memory only, until you decide to write them.
 Be careful before using the write command.


 Command (m for help): p

 Disk /dev/loop0: 0 MB, 512 bytes, 1 sectors
 Units = sectors of 1 * 512 = 512 bytes
 Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x0002a9f0

 Device       Boot      Start         End      Blocks   Id   System
 /dev/loop0p1             256   462748159   231373952   83    Linux
 /dev/loop0p2       462748414   464843519     1047553    5 Extended
 /dev/loop0p5   ?   883823639  1304898863   210537612+  19  Unknown


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
