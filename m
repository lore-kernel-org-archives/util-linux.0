Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:54923 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbaJ1R3S (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Oct 2014 13:29:18 -0400
Message-ID: <544FCE46.2090709@tlinx.org>
Date: Tue, 28 Oct 2014 10:11:34 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>
CC: util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
References: <544E923E.6050406@gmail.com> <544E97ED.7040406@earthlink.net> <544F0C88.1080807@gmail.com> <544F3B20.7090109@gmail.com> <544FA923.5080205@gmail.com>
In-Reply-To: <544FA923.5080205@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

dE wrote:
> 2048 is Windows behavior ported to utils-linux. It's pointless.
Not if you move to any sort of RAID and want efficiency.  Then 64k or 256k
alignment is minimal.  If you start at 1M, then layering other things on
top, -- like default lvm blocks of 4M will still line up at 1M.  Then 
when you
layer RAID aware software like xfs on top of those, it can know how to do
allocations and layout to allow optimal I/O on most RAID sizes.

Anyone who uses RAID5 or RAID6 based underlying HW will appreciate
file systems with full alignment to the underlying device stripes.  Partial
writes on  those types of RAID's (or derivatives) requiring a complete
read-modify-write cycle the size of the data stripe, so any underlying
disk misalignment will really cause performance pain...

But having all the disks start at 1M, you can usually move complete
disk images around on devices and not get hurt by alignment
issues.


