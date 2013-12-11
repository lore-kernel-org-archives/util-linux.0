Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qe0-f45.google.com ([209.85.128.45]:39662 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab3LKSPa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 11 Dec 2013 13:15:30 -0500
Received: by mail-qe0-f45.google.com with SMTP id 6so5670066qea.18
        for <util-linux@vger.kernel.org>; Wed, 11 Dec 2013 10:15:30 -0800 (PST)
Received: from brickies-eth0.mosers.us (d14-69-66-169.try.wideopenwest.com. [69.14.169.66])
        by mx.google.com with ESMTPSA id fc16sm43432272qeb.3.2013.12.11.10.15.27
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2013 10:15:27 -0800 (PST)
Date: Wed, 11 Dec 2013 13:15:27 -0500 (EST)
From: Scott Moser <smoser@ubuntu.com>
To: util-linux@vger.kernel.org
Message-ID: <alpine.DEB.2.02.1312111313490.4340@brickies>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It seems that for disks larger than the maximum size addressable by MBR sfdisk behaves oddly.

I would have expected:
  echo "2048,,L" | sfdisk -uS --Linux $TARGET

to put a 2TB partition on $TARGET if it was larger than 2TB.
I suspect that the issue is the end sector that its trying to write
overflowing an integer.

I'll suggest that a better action would be to just end at 2TB.

I don't think this is a terribly severe bug, or that my suggestion is the
right way to fix it.  Mostly I'm just reporting the odd/unexpected (to me)
behavior.

See below for example, the same is true on file or block device.

Scott
----

$ rm -f /tmp/foo.img; truncate --size 2500G /tmp/foo.img
$ echo "2048,,L" | sfdisk -uS --Linux /tmp/foo.img
Warning: /tmp/foo.img is not a block device
Disk /tmp/foo.img: cannot get geometry

Disk /tmp/foo.img: 326354 cylinders, 255 heads, 63 sectors/track

sfdisk: ERROR: sector 0 does not have an msdos signature
 /tmp/foo.img: unrecognized partition table type
Old situation:
No partitions found
New situation:
Units = sectors of 512 bytes, counting from 0

   Device Boot    Start       End   #sectors  Id  System
/tmp/foo.img1          2048 5242879999 5242877952  83  Linux
/tmp/foo.img2             0         -          0   0  Empty
/tmp/foo.img3             0         -          0   0  Empty
/tmp/foo.img4             0         -          0   0  Empty
Warning: no primary partition is marked bootable (active)
This does not matter for LILO, but the DOS MBR will not boot this disk.
Successfully wrote the new partition table

Re-reading the partition table ...
BLKRRPART: Inappropriate ioctl for device

If you created or changed a DOS partition, /dev/foo7, say, then use dd(1)
to zero the first 512 bytes:  dd if=/dev/zero of=/dev/foo7 bs=512 count=1
(See fdisk(8).)

$ sfdisk -uS -l /tmp/foo.img
Disk /tmp/foo.img: cannot get geometry

Disk /tmp/foo.img: 326354 cylinders, 255 heads, 63 sectors/track
Units = sectors of 512 bytes, counting from 0

   Device Boot    Start       End   #sectors  Id  System
/tmp/foo.img1          2048 947912703  947910656  83  Linux
/tmp/foo.img2             0         -          0   0  Empty
/tmp/foo.img3             0         -          0   0  Empty
/tmp/foo.img4             0         -          0   0  Empty


