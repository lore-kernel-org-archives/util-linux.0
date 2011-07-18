Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35873 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab1GRJwW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Jul 2011 05:52:22 -0400
Date: Mon, 18 Jul 2011 11:52:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Lennart Poettering <lennart@poettering.net>,
        Kay Sievers <kay.sievers@vrfy.org>
Cc: util-linux@vger.kernel.org
Subject: Re: dmesg(1) changes
Message-ID: <20110718095215.GJ3486@nb.net.home>
References: <20110714115231.GF3486@nb.net.home> <CAPXgP10m_1CFphdW=HTuma+u81iAJ0v3bfFK5eAMMkB8pXDqCg@mail.gmail.com> <20110714115231.GF3486@nb.net.home> <20110714124034.GB23998@tango.0pointer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110714124034.GB23998@tango.0pointer.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 14, 2011 at 02:40:34PM +0200, Lennart Poettering wrote:
> One last thing on my wishlist: "dmesg -k" as alias for "dmesg
> --facility=kern", just to make this presumably very often requested
> switch is easy to reach.

 Added:

    -u  : userspace messages
    -k  : kernel messages

On Thu, Jul 14, 2011 at 03:45:30PM +0200, Kay Sievers wrote:
> People ask since a while for an option to suppress the kernel's [...]
> timestamp from the 'dmesg' output. Maybe you can make them happy too.
> :)

 Added -t to suppress the timestamps.

 $ dmesg -u -t
 dracut: dracut-009-11.fc15
 dracut: rd.luks=0: removing cryptoluks activation
 dracut: rd.lvm=0: removing LVM activation
 udev[111]: starting version 167
 dracut: Starting plymouth daemon
 dracut: rd.dm=0: removing DM RAID activation
 dracut: rd.md=0: removing MD RAID activation
 dracut: Checking filesystems
 dracut: fsck -T -t noopts=_netdev -A -a
 dracut: /dev/sda3: clean, 194520/1921360 files, 1601560/7680000
 blocks
 dracut: Remounting
 /dev/disk/by-uuid/2cda1e08-1f22-490b-9101-c93d511bc9d9 with -o ro,
 dracut: Mounted root filesystem /dev/sda3
 dracut: Switching root
 udev[451]: starting version 167

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
