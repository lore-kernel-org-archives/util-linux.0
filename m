Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22300 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357Ab2KEJpt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Nov 2012 04:45:49 -0500
Date: Mon, 5 Nov 2012 10:45:46 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org, grawity@gmail.com
Subject: Re: [bug] incorrect GPT entry validation?
Message-ID: <20121105094546.GA365@x2.net.home>
References: <20121103183511.GO482@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121103183511.GO482@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Nov 03, 2012 at 02:35:11PM -0400, Dave Reisner wrote:
> Hi,
> 
> A user reported problems with libblkid incorrectly reporting (or not
> reporting) tags for some partitions on a GPT formatted disk. I was able
> to reproduce it:
> 
> - created a 10G disk on a VM
> - initialized it with GPT (using gdisk), created 5 entries
> - formatted each of them with ext4
> 
> blkid correctly reads the first 2 entries on the disk, but then starts
> reporting corrupted GPT entries (seen via LIBBLKID_DEBUG=0xffff):
> 
> https://dev.archlinux.org/~dreisner/blkid_bad.txt

It would be nice to have the debug output.

Please, send me begin of the device:

    # dd if=/dev/vdd of=img count=1 bs=1Mib
    # gzip -9 img

> It's interesting to note that blkid will _always_ read 2 entries before
> reporting corruption, i.e.

Hmm... sounds like in-memory buffer corruption libblkid caches the
data from the device).

> # blkid -c /dev/null /dev/vdd{4,5,2}

Are you able to reproduce the bug by "blkid -p -o udev" ?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
