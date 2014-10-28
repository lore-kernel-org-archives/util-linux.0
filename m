Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:48659 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbaJ1Pf7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Oct 2014 11:35:59 -0400
Date: Tue, 28 Oct 2014 11:35:57 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: dE <de.techno@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
Message-ID: <20141028153557.GA20378@thunk.org>
References: <544E923E.6050406@gmail.com>
 <20141028075308.GI10134@x2.net.home>
 <yq138a8pdxh.fsf@sermon.lab.mkp.net>
 <544FAE07.6080605@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <544FAE07.6080605@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 28, 2014 at 08:23:59PM +0530, dE wrote:
> >Not only that. It was an explicit request from IDEMA. The disk drive and
> >RAID vendors asked all operating system vendors to ensure 1MB alignment
> >by default.
> >
> 
> Ok, it's an IDEMA recommendation. That's why.

One additional reason why it's a good idea is for better compatibility
with drive-managed or host-aware SMR (Shingled Magnetic Recording)
disks, it's a really good idea if partitions are aligned on 256 MiB
boundaries.

And in the future, the hard drive vendors hope to promulgate 32k or
64k native sector size.  If we adopted the suggestion to align new
partitions at 4k after the MBR, it would be disastrous for SMR disks
(some of which will be shipping soon, or may be shipping already but
you might know it, especially for some high-capacity USB attached
storage), and for these larger sector disks.

Or if you are using very low-end flash (i.e., on SD cards) which have
a very primitive FTL, if the partitions aren't aligned on the erase
block, you will also have terrible performance --- and this is true
today.

Given the painful history of how long it took to get OS vendors to
move off of a sector 63 offset (a decade, thanks to Windows XP), it's
not surprising IDEMA has requested that all OS vendors use a 1MB
alignment for partitions going forward.

So I don't think we want to change the default.  If you're so hard up
for space that clawing back that extra 1020k with of disks on a 2T or
6T disk is significant, you can manually adjust the starting offset of
the partition.  But I really don't think it's worth it, at least for
myself....

Cheers,

						- Ted
