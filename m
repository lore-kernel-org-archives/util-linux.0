Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964847AbbLOKYN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Dec 2015 05:24:13 -0500
Date: Tue, 15 Dec 2015 11:24:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk, re-eading partition table fails
Message-ID: <20151215102408.GG2353@ws.net.home>
References: <201512141311.59328.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201512141311.59328.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 14, 2015 at 01:11:59PM +0100, Ruediger Meier wrote:
> our test suite shows that many sfdisk tests fail sometimes to "Re-read
> partition table" at the end. I was able to find some systems where
> I could re-produce the problem using the script below.

Yes, the problem is probably udev, and "udevadm settle" is not always
enough.

> Seems that the problem is because of the first BLKRRPART ioctl call
> in sfdisk.c function is_device_used(). Maybe it cause udev or
> whatever to open the device and then the real BLKRRPART in
> write_changes() fails.

but the device has to be already partitioned, on disk without
partitions BLKRRPART (and is_device_used()) does not generate any
events (try "udevadm monitor").

> Removing the first BLKRRPART ioctl (or sleeping about 50ms after the first one)
> "fixes" the issue.

The is_device_used() in the sfdisk is nothing elegant, maybe
we can use --noreread sfdisk command line option in the tests.

Anyway, it would be nice to have some in-sfdisk solution, because our
users who use fdisk in scripts may be affected by the same problem.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
