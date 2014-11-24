Return-Path: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org
From: Lutz Vieweg <lvml@5t9.de>
Subject: Re: fstrim on newly created filesystem tries to discard data beyond
 the last sector of a device
Date: Mon, 24 Nov 2014 20:30:06 +0100
Message-ID: <5473873E.1070101@5t9.de>
References: <m3qnrg$5gc$1@ger.gmane.org> <m4f77a$ivg$1@ger.gmane.org> <m4nrjt$ghs$1@ger.gmane.org> <alpine.LFD.2.00.1411241259280.10657@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
In-Reply-To: <alpine.LFD.2.00.1411241259280.10657@localhost.localdomain>
Cc: util-linux@vger.kernel.org, linux-xfs@oss.sgi.com
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/24/2014 01:25 PM, Lukáš Czerner wrote:
 > Can you please try to reproduce the problem with the loop device ?
 >
 > # truncate -s1T /path/to/new/file
 > # losetup --show -f /path/to/new/file
 > (this will print out the new loop device for example /dev/loop0)
 >
 > # mkfs.ext4 /dev/loop0
 > # mount /dev/loop0 /mount/point
 > # fstrim -v /mount/point
 >
 > Can you see any errors or will it succeed ?

I see no errors when doing this. (But then again, do we know whether
the loop device code would complain about a discard beyond its end?)

 > Now another thing to try is rule out the file system entirely. Can
 > you try to run blkdiscard on the ssd device directly ?
 >
 > # blkdiscard /dev/sdb

This indeed also reliably triggers an Input/Output error:
 >> blkdiscard -v /dev/sdb
 > blkdiscard: /dev/sdb: BLKDISCARD ioctl failed: Input/output error
 > [971965.901014] sd 0:0:1:0: [sdb]
 > [971965.902856] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
 > [971965.904654] sd 0:0:1:0: [sdb]
 > [971965.906422] Sense Key : Illegal Request [current]
 > [971965.908182] Info fld=0x76fff120
 > [971965.909928] sd 0:0:1:0: [sdb]
 > [971965.911659] Add. Sense: Logical block address out of range
 > [971965.913402] sd 0:0:1:0: [sdb] CDB:
 > [971965.915136] Unmap/Read sub-channel: 42 00 00 00 00 00 00 00 18 00
 > [971965.916936] end_request: critical target error, dev sdb, sector 1996484896
The relevant associated part of strace output:
 > 13230 stat("/dev/sdb", {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 16), ...}) = 0
 > 13230 open("/dev/sdb", O_WRONLY)        = 3
 > 13230 ioctl(3, BLKGETSIZE64, 1024209543168) = 0
 > 13230 ioctl(3, BLKSSZGET, 512)          = 0
 > 13230 ioctl(3, BLKDISCARD, {0, 7fffa8b8dd10}) = -1 EIO (Input/output error)

Since the issue also occured with both xfs and ext4, I think we can be
sure now it's not a bug in a filesystem that triggers it.

 > Now looking at the sector that seems to be "out of range" seems to
 > be actually well in range of the file system. From the mkfs.xfs
 > output I can see that the file system has 250051158 blocks of 4096
 > Bytes which is 1024209543168 Bytes. Now the sector mentioned in that
 > error output is 1999428272 which is (1999428272 * 512 =
 > 1023707275264) which is in range of the file system. According the
 > data from /proc/partitions it is also true for the entire device.

I could envision that the block discarding happenes in
larger chunks (certainly issuing less than "one TRIM command per 4k"),
so maybe some higher granularity of such chunks would cause
the end of the chunk to be discarded extend beyond the device end?

Of course this is speculation - is there a way to tell which
size the last/failed TRIM command did actually intend to discard?

 > I can see that the device reports 4096 physical sector size so it
 > might be that there is a bug regarding 4k physical sector size
 > somewhere in block layer or a driver ?

That could sure be relevant for branching into a buggy codepath.

Then there's another idea: The device is a SATA SSD, but attached
to a SAS2 expander chip on the backplane of the server (LSI SAS2X28)
which in turn is connected to a LSI SAS HBA 9207-4i4e.
could maybe, just maybe, the TRIM command be modified wrongly
on its way through these / their respective drivers?

 >> Do we need to fear a loss of data when using fstrim in general?
 >
 > No you definitely should not be. While some bugs might appear we
 > have extensive test cases to catch that. In fact while there has
 > been several bugs in the file system fstrim implementation AFAIK it
 > was never data loss scenario. And so far I do not believe this is
 > the case here either, but we'll have to investigate first.

I was thinking about how I could setup a proof-of-concept scenario
where the effect actually discards valid data.

I tried creating two partitions on the device, one big covering
most of the SSD, one very small at its end, like:
 >    Device Boot      Start         End      Blocks   Id  System
 > /dev/sdb1            2048  2000409247  1000203600   83  Linux
 > /dev/sdb2      2000409248  2000409263           8   83  Linux
I did this for several sizes of sdb2, not just Blocks=8.

Then I did:
 > dd if=/dev/urandom of=/dev/sdb2 bs=512 oflag=direct
 > dd if=/dev/sdb2 bs=512 iflag=direct | md5sum
 > blkdiscard -v /dev/sdb1
 > sync
 > dd if=/dev/sdb2 bs=512 iflag=direct | md5sum
... and checked whether the md5sum result was still the same.

The good news is, in no case, when using partitions, would
the blkdiscard /dev/sdb1 command trigger an I/O error, and in all cases
the MD5 sums were the same.

The bad news is: blkdiscard on /dev/sdb2 consistenty triggers the Input/output error:
 > blkdiscard -v /dev/sdb2
 > blkdiscard: /dev/sdb2: BLKDISCARD ioctl failed: Input/output error

Strange, what might be so different when discarding at the end of
the physical device?

Regards,

Lutz Vieweg


