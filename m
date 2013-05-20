Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8722 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754240Ab3ETHxd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 May 2013 03:53:33 -0400
Date: Mon, 20 May 2013 09:53:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Linda Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org, LKML <linux-lkml@vger.kernel.org>
Subject: Re: new mount is broken w/regard to devnames in /etc/fstab
Message-ID: <20130520075329.GA19935@x2.net.home>
References: <5198086A.1010903@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5198086A.1010903@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 18, 2013 at 04:02:02PM -0700, Linda Walsh wrote:
> 1) How is one supposed to get the real root device?
> It's not /dev/root -- and on my system /dev/root doesn't even exist.
> (though to be fair, it has in the past -- udev musta got sloppy this time,
> and did point to the real root device).  But how can I get /proc to display
> the real root device instead of some fake name.   
> 
> It's insecure the way it is -- as /dev/root could be "anything"...

I don't think this is util-linux issue. It's more distro specific and 
related to kernel & initramfs & udevd.

For example my Fedora 18:

$ findmnt /                                                                 
TARGET SOURCE    FSTYPE OPTIONS
/      /dev/sda4 ext4   rw,relatime,data=ordered

$ df /
Filesystem     1K-blocks     Used Available Use% Mounted on
/dev/sda4       35146488 16233036  17121452  49% /

$ grep ' / ' /proc/mounts                                
rootfs / rootfs rw 0 0
/dev/sda4 / ext4 rw,relatime,data=ordered 0 0


> 2) I'd like lvm's naming to be available through mount.  Ideally, lvm's
> naming would be available in /proc/mounts...  At least, though
> in going from /dev/VG/LV => /dev/mapper/VG-LV, that can be
> scripted reliably to get the mount device name. 

For example lsblk(8) should be able to convert to the /dev/mapper
format

   lsblk -rno NAME /dev/VG/LV

you can also use /dev/VG/LV for findmnt(8), it should be able to
convert the names for /dev/mapper/VG-LV to search for mountpoint.

.. or use /dev/mapper/<name> in your /etc/fstab ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
