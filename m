Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8764 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755738Ab3JNOmF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Oct 2013 10:42:05 -0400
Date: Mon, 14 Oct 2013 15:59:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: blkid doesn't find lvm pv when boot loader installed
Message-ID: <20131014135953.GG28914@x2.net.home>
References: <525821B6.9010304@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <525821B6.9010304@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 11, 2013 at 12:05:10PM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> When installing a boot loader into an LVM PV, blkid detects it as a
> dos partition table and does not probe the lvm superblock.

 Yes, unfortunately this is currently unsupported scenario. 
 
 The libblkid checks for collision between LVM and filesystems/partition 
 tables to avoid very common situations when users use whole-disks 
 previously used by LVM in new setups with partition tables.
 
 Unfortunately, partitioning tools usually does not wipe LVM header 
 from the device and it easy to create situation when there is 
 valid PT as well as valid LVM header.

 So.. libblkid assumes that there is only LVM header within first 8K
 of the device, because pvcreate wipes this area (try pvcreate again
 and it will silently erase your grub!). If there is anything else 
 then the previously detected LVM is ignored.

 Yes, it's really not perfect solution, but do we have any better
 solution? Maybe it would be enough to improve the blkid partition
 table parser to not interpret the boot loader with empty PT as a
 valid PT. Not sure.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
