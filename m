Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35261 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114Ab3KSMPI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Nov 2013 07:15:08 -0500
Date: Tue, 19 Nov 2013 13:15:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: SGI disk labels show wrong device
Message-ID: <20131119121504.GE5572@x2.net.home>
References: <5285137E.60900@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5285137E.60900@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 14, 2013 at 01:16:30PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Parted lists the device name using the wrong partition number:
> 
> Disk /dev/sde: 8 MiB, 8388608 bytes, 16384 sectors
> Geometry: 8 heads, 32 sectors/track, 64 cylinders
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 32768 bytes
> Disklabel type: sgi
> 
> Pt# Device    Info Start       End Sectors Id System
>  9: /dev/sde1          0      4095    4096  0 SGI volhdr
> 11: /dev/sde2          0     16383   16384  6 SGI volume

Fixed. It seems that the original fdisk author has expected the Linux
kernel will count only valid partitions, but we always count all slots.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
