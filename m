Return-Path: util-linux-owner@vger.kernel.org
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:61497 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750729AbaKXVY5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Nov 2014 16:24:57 -0500
Date: Tue, 25 Nov 2014 08:24:52 +1100
From: Dave Chinner <david@fromorbit.com>
To: Lutz Vieweg <lvml@5t9.de>
Cc: linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: fstrim on newly created filesystem tries to discard data beyond
 the last sector of a device
Message-ID: <20141124212452.GC27262@dastard>
References: <m3qnrg$5gc$1@ger.gmane.org>
 <m4f77a$ivg$1@ger.gmane.org>
 <m4nrjt$ghs$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m4nrjt$ghs$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 21, 2014 at 06:09:17PM +0100, Lutz Vieweg wrote:
> I'm experiencing a 100% reproduceable misbehaviour of
> fstrim, which seems to put data integrity on stake:
> 
> Whenever I use "fstrim" on a just newly "mkfs.xfs"ed
> filesystem on a newly installed SSD (Crucial_CT1024M550SSD1,
> firmware MU01), I get (after some activity on the device)
> this error message:
> > fitrim ioctl failed: input/output error
> 
> Looking into the dmesg output reveals:
> > [1039455.530947] sd 0:0:1:0: [sdb]
> > [1039455.533192] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > [1039455.535369] sd 0:0:1:0: [sdb]
> > [1039455.537521] Sense Key : Illegal Request [current]
> > [1039455.539684] Info fld=0x772cdab0
> > [1039455.541802] sd 0:0:1:0: [sdb]
> > [1039455.543877] Add. Sense: Logical block address out of range
> > [1039455.545966] sd 0:0:1:0: [sdb] CDB:
> > [1039455.548008] Unmap/Read sub-channel: 42 00 00 00 00 00 00 00 18 00
> > [1039455.550080] end_request: critical target error, dev sdb, sector 1999428272

So, that's a sector well within the advertised size of the device.

> (I bought 4 of the same SSD model, and the error occurs the same with
> the other exemplars, so I can assume this is not some hardware issue.)

Oh, I wouldn't bet on it. Very likely this is a firmware bug,
because...

> I've tried the same with ext4 instead of XFS, and the very same
> error occurs, just with a slightly different sector being named
> by the dmesg error output:
> > [710565.947608] end_request: critical target error, dev sdb, sector 2000158720

Even that is supposed to be within the device range.

> Here's a list of properties of the system that might be
> relevant for the issue:
> 
> According to smartctl, the capacity of this SSD is:
> > User Capacity:    1,024,209,543,168 bytes [1.02 TB]
> > Sector Sizes:     512 bytes logical, 4096 bytes physical

They make 512e SSDs now? I haven't seen one of them before. Anyway,
for a device of that size the number of logical sectors is
2000409264, which means the above errors are 500MB and 128MB from
the end of the device, respectively.

> And cat /proc/partitions tells:
> >    major minor  #blocks  name
> >    8       16 1000204632 sdb

They are also well within the end of the device as advertised by the
kernel. This doesn't look like a filesystem or kernel issue, though
you can rull that out completely with a block trace that will show
us exactly what IO errored out...

> Do we need to fear a loss of data when using fstrim in general?

In general, from a kernel perspective, no. However, from a "does my
hardware work correctly?" perspective, we have come across lots of
devices/firmwares with broken TRIM implementations over the years.
I'd suggest you upgrade your drive to the latest firmware before
testing it again...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
