Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8414 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758038AbaGOK7Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 06:59:25 -0400
Date: Tue, 15 Jul 2014 12:59:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: some comments about the new cfdisk
Message-ID: <20140715105920.GS30288@x2.net.home>
References: <1405350470.21924.141447857.78268FC5@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405350470.21924.141447857.78268FC5@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 14, 2014 at 05:07:50PM +0200, Benno Schulenberg wrote:
> Running cfdisk without an argument no longer works - it just
> blurts out the usage text, instead of picking the first and only
> hard drive in the system.

Yes, this is expected change. I think it's better to force
users to type the disk path than hardcode "sda" to the code,
but I have no strong opinion about it... no problem to change it.

(The correct way is to scan /proc/partitions and use the first
 whole-disk. The original solution with hardcoded /dev/sda and
 /dev/hda is ugly.)

> When exiting from cfdisk without having changed anything and
> without having written the table to disk, it still writes to
> standard output "Syncing disks." (with a missing newline).
> To a novice that will be an alarming message.  I think that
> when the user did not ask to write anything to disk, cfdisk
> should not be syncing disks, there is no need to, or at least
> it should not show that message.

This is bug, fixed in git tree now.

> When in the "Select partition type" submenu, it is not possible
> to exit from there with Esc.  Hitting ^C instead kills the entire
> cfdisk, which is kind of surprising and undesirable: any already
> made changes would be lost.

This is bug, fixed in git tree now. (All the menus is also sensitive
to 'g' and 'Q'.)

> I have two megabytes of free space at the tail of the disk.  If
> with the old cfdisk I delete the last partition, it will create
> a single expanse of free space.  But with the new cfdisk it will
> then have two free spaces:
> 
> >>  `-Free space      282779648 312576704  29797057  14.2G                      
>     Free space        312578048 312581807      3760   1.9M

I guess the last partition is a logical partition. It's because
the extended partition (container for logical partitions) has
explicitly specified size and the new cfdisk does not change the 
size. 

The way how the new cfdisk works with free space is different, it
follows the gaps between partition etc. So it does not magically 
merge all free space to the one pool. This solution is more generic
and usable for all disk labels.

It would be possible to add some extra optimization for MBR to
enlarge/reduce the extended partition if there is a free space behind
the partition and no possibility to create another primary partition.
Not sure... I'll think about it.

> It appears to be impossible to reuse that tailing free space.

.. because you already have allocated all primary partitions I guess.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
