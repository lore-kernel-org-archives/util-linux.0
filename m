Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37853 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037AbaJ1HxL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Oct 2014 03:53:11 -0400
Date: Tue, 28 Oct 2014 08:53:08 +0100
From: Karel Zak <kzak@redhat.com>
To: dE <de.techno@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
Message-ID: <20141028075308.GI10134@x2.net.home>
References: <544E923E.6050406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <544E923E.6050406@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 28, 2014 at 12:13:10AM +0530, dE wrote:
> Regardless of the partition table, fdisk always starts the first partition
> at 2048. In reality, the maximum size required by the gap between MBR and
> the 1st partition is a single sector, which's used by GRUB 1.5. GPT doesn't
> need this space at all.
> 
> Then extended partitions too have a gap of 2048 sectors.
> 
> Why this behavior?

This is standard behavior for all modern partitioning tools.

 # parted -s --align optimal /dev/sdb 'mkpart primary 1 10MiB'

 # fdisk -l /dev/sdb
 Device    Start          End Size Type
 /dev/sdb1  2048        20479   9M Microsoft basic data


the goal is to start the first partition on offset which is the most
portable and the most useful on all possible disk configurations. If
you align partitions to 1MiB than it's good enough for all possible 
I/O limits  (including 4K disks, RAIDs with huge optimal I/O etc). You
can dd(1) partition table from 512-byte disk to 4K disk without care
about alignment etc.

The overhead (1MiB gap(s)) is minimal to compare to usual disk sizes.
(Note that for very small disk we use grain based on real I/O limits.)

The another advantage is that 1MiB offset also unifies all partition
tables -- from users point of view all the partition table look very
analogous.


If you don't like it, then use fdisk expert menu and move the begin of
the partition by command 'b'.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
