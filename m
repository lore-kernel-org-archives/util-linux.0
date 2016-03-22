Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60685 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758449AbcCVOug (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 10:50:36 -0400
Date: Tue, 22 Mar 2016 15:50:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Serge van den Boom <serge+util-linux@vdboom.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Subject: Multiple issues with partx
Message-ID: <20160322145033.l6mus2ao7s7272ll@ws.net.home>
References: <alpine.BSF.2.00.1603151918560.60883@toad.stack.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.BSF.2.00.1603151918560.60883@toad.stack.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 22, 2016 at 01:17:42PM +0100, Serge van den Boom wrote:
> 1. 'partx --nr 1:' does not work.

Fixed.

# partx --show --nr 1: /dev/sdc
NR START   END SECTORS SIZE NAME UUID
 1  2048 22527   20480  10M      fa3974fc-40a2-402a-941a-7d26b32e126d
 2 22528 43007   20480  10M      808a2e20-7109-4f2f-9727-f474f5119231
 4 63488 83967   20480  10M      8fe134d1-af94-48d0-94f2-9b757da8731f


> 2. 'partx --nr <M:N>' does not take empty partition table entries into
>     account when using negative indexes.
...
> One might expect that 'partx --nr 1:-1' would list all partitions (i.e.
> from the first to the last partition), but this is currently not true in
> this case:
> 
>     $ partx --nr 1:-1 testfile
>     NR START   END SECTORS SIZE NAME UUID
>      1  2048 10000    7953 3.9M      4fafc399-01

Fixed. 

Note that --nr specifies partno (column NR), rather than seq.number.
Unfortunately, code mixed partno and seq.number of the partition.

# partx --show --nr 1:-1 /dev/sdc
NR START   END SECTORS SIZE NAME UUID
 1  2048 22527   20480  10M      fa3974fc-40a2-402a-941a-7d26b32e126d
 2 22528 43007   20480  10M      808a2e20-7109-4f2f-9727-f474f5119231
 4 63488 83967   20480  10M      8fe134d1-af94-48d0-94f2-9b757da8731f


> In fact, 'partx --nr -1:-1' returns no output at all.

Fixed.

# partx --show --nr -1:-1 /dev/sdc
NR START   END SECTORS SIZE NAME UUID
 4 63488 83967   20480  10M      8fe134d1-af94-48d0-94f2-9b757da8731f

> 3. It is not always clear whether a single partition table entry refers
>    to the partition table on the block device, or to a partition table
>    entry of the block device of which the specified block device is a part.
> 
> When the specified block device contains a partition table, that
> partition table is shown. When it does not contain a partition table,
> but the block device is a partition itself, its entry on its parent
> block device is shown. When you don't know whether a given block device
> contains is a full disk or a partition (because you're calling partx
> from a script) special logic would be required. Also, nested partition
> tables are theoretically possible, though unusual.

You have to always specify partition (-nr or devname), whole-disk is
optional. If you want to read partitioned partition (nested PT) then
you can use '-' instead of partition name:

  partx --show - /dev/sdc1

Anyway, my suggestion is to use sfdisk if you want complicated things
like nested partitions.

> As a work-around, something like 'partx --nr 1:65535' may be used if
> you are interested in the partitions of the specified block device
> itself. 'partx --nr 1:' would avoid the arbitrary upper bound, but does
> not work because of issue 1, and 'partx --nr 1:-1' would too, but does
> not work because of issue 2.

--nr 1: and --nr 1:-1 works now

> 4. It is possible to specify a partition by the device name of a
>    partition on another block device.
> 
> The command 'partx /dev/sdb2 /dev/sda' makes no sense, but still
> produces output, namely the second partition of /dev/sda.

 Fixed,

 # partx --show /dev/sdx1 /dev/sdc
 partx: partition and disk name do not match


I'll prepare regression test for partx....

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
