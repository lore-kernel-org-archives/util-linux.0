Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51670 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab3CRJ1G (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Mar 2013 05:27:06 -0400
Date: Mon, 18 Mar 2013 10:27:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Jeff Mahoney <jeffm@suse.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] loopdev: sync capacity after setting it
Message-ID: <20130318092700.GC2172@x2.net.home>
References: <51438CF9.7020707@suse.com>
 <5145D0B4.1070207@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5145D0B4.1070207@suse.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 17, 2013 at 10:18:28AM -0400, Jeff Mahoney wrote:
> On 03/15/2013 05:04 PM, Jeff Mahoney wrote:
> >I recently tried to mount an hfsplus file system from an image file with
> >a partition table by using the loop offset and sizelimit options to specify
> >the location of the file system.
> >
> >hfsplus stores some metadata at a set offset from the end of the partition,
> >so it's sensitive to the device size reported by the kernel.
> >
> >It worked with this:
> ># losetup -r -o 32k --sizelimit=102400000 <loopdev> <imagefile>
> ># mount -r -t hfsplus <loopdev> <mountpoint>
> >
> >But failed with this:
> ># mount -r -oloop,offset=32k,sizelimit=102400000 <imagefile> <mountpoint>
> >
> ># losetup -a
> >/dev/loop0: [0089]:2 (<imagefile>), offset 32768, sizelimit 102400000
> >/dev/loop1: [0089]:2 (<imagefile>), offset 32768, sizelimit 102400000
> >
> >/proc/partitions shows the correct number of blocks to match the sizelimit.
> >
> >But if I set a breakpoint in mount before the mount syscall, I could see:
> ># blockdev --getsize64 /dev/loop[01]
> >102400000
> >102432768
> >
> >The kernel loop driver will set the gendisk capacity of the device at
> >LOOP_SET_STATUS64 but won't sync it to the block device until one of two
> >conditions are met: All open file descriptors referring to the device are
> >closed (and it will sync when re-opened) or if the LOOP_SET_CAPACITY ioctl
> >is called to sync it. Since mount opens the device and passes it directly
> >to the mount syscall after LOOP_SET_STATUS64 without closing and reopening
> >it, the sizelimit argument is effectively ignroed. The capacity needs to
> >be synced immediately for it to work as expected.
> >
> >This patch adds the LOOP_SET_CAPACITY call to loopctx_setup_device since
> >the device isn't yet released to the user, so it's safe to sync the capacity
> >immediately.
> 
> It turns out this ioctl wasn't introduced until 2.6.30. I'll fix that up and
> resend tomorrow.

 Do you mean #ifdef LOOP_SET_CAPACITY? I can fix the patch manually.

 (It seem that we already use this ioctl in code without any extra
  care about old kernel and nobody complains :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
