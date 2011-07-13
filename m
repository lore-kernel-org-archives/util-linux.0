Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12087 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265Ab1GMPDh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Jul 2011 11:03:37 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6DF3b1t013954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 13 Jul 2011 11:03:37 -0400
Subject: Fake block devices (Was Re: `fsck -A` and fs-specific options)
From: David Zeuthen <davidz@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Date: Wed, 13 Jul 2011 11:03:36 -0400
In-Reply-To: <20110713083214.GA3486@nb.net.home>
References: <201107112259.55340.vapier@gentoo.org>
	 <9CD6ADB9-F3AD-47EE-BF7E-251D86B7B305@mit.edu>
	 <20110713083214.GA3486@nb.net.home>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310569417.22917.9.camel@lucifer>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hey,

On Wed, 2011-07-13 at 10:32 +0200, Karel Zak wrote:
>  Good point. There is demand for a generic API to assemble block
>  devices (dm-crypt, MD, LVM, loopdev, ...). This functionality has
>  been requested by desktop guys, dracut, udev and it seems also
>  attractive for mount and fsck. I'll probably start to work on this
>  task at the end of this year (I hope with DM guys).
> 
>  The idea is to have a simple library (libblkasm ?) that provide API
>  to assemble a block device according to the configuration in
>  /etc/fstab and /etc/blkasm.d/. The library should be modular, so
>  subsystem specific modules (lvm.so, crypt.so, ...) will be maintained
>  externally by subsystem developers. It seems like a good way how to
>  keep the functionality up to date and minimize some communication
>  problems between people :-)
> 
>  Note that the original idea is from David Zeuthen
>  http://people.freedesktop.org/~david/stc-20101011/stc.conf.html, but
>  David's goal was daemon.

FWIW, I've changed my mind about this. Basically, I don't think it's
worth supporting fake block devices (except for dm-luks and maybe loop
devices). Specifically, I will not support it in the next major version
of GNOME Disk Utility (aka Palimpsest) except for showing the "friendly"
dm name (e.g. /dev/mapper/blah) instead of /dev/dm-0. Here's a
work-in-progress screenshot

http://people.freedesktop.org/~david/palimpsest-with-fake-block-devices.png

(Compare to: http://people.freedesktop.org/~david/nautilus-lvm2-b.png )

Anyway, I think it would be better if people instead worked on e.g.
btrfs and making we properly support multi-disk in btrfs... because
btrfs multi-disk is subject to exactly the same problems as you have
when activating RAID or LVM devices (except that you can't do arbitrary
trees - which is a good thing!). For example, there's a policy decision
when to start a device in degraded mode. And, IIRC, the kernel don't
even properly convey what underlying devices a btrfs fs is currently
using  (it didn't last time I checked which is ~12 months ago).

    David


