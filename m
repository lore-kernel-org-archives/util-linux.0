Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp2.dds.nl ([83.96.147.103]:43062 "EHLO smtp2.dds.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752553AbcHTNaG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Aug 2016 09:30:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sat, 20 Aug 2016 15:30:02 +0200
From: Xen <list@xenhideout.nl>
To: Util linux <util-linux@vger.kernel.org>
Cc: Karel Zak <kzak@redhat.com>
Subject: Re: PV on disk without partitions not recognised as LVM2_member
In-Reply-To: <20160819111429.4rsuedff24inn4gu@ws.net.home>
References: <c3d87222fe4f87eed72f61b6bc501344@dds.nl>
 <20160819111429.4rsuedff24inn4gu@ws.net.home>
Message-ID: <1a71a3e7acff35280069de29ad2b9a0a@dds.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak schreef op 19-08-2016 13:14:
> On Thu, Aug 18, 2016 at 10:39:30PM +0200, Xen wrote:
>> Would someone be will to fix the issue that a Physical Volume from 
>> LVM2 (PV)
>> when placed directly on disk (no partitions or partition tables) will 
>> not be
> 
> This is very unusual setup, but according to feedback from LVM guys
> it's supported, so I will improve blkid to support it too.

To provide a little feedback.

What is actually the case is that I am installing Grub2 on the PV which 
uses the LVM2 "--bootloaderareasize" option to pvcreate.

This creates a bootloader-area of say 1M with an offset like perhaps 
2048 sectors, I don't remember how to get that info, after which then 
the extents start.

Oh yes, it is this sort of thing:

physical_volumes {

     pv0 {
         id = "fEGbBn-tbIp-rL7y-m22b-1rQh-r9i5-Qwlqz7"
         device = "/dev/sda"     # Hint only

         status = ["ALLOCATABLE"]
         flags = []
         dev_size = 1258287104   # 599,998 Gigabytes
         pe_start = 4096
         pe_count = 153599       # 599,996 Gigabytes
         ba_start = 2048
         ba_size = 2048  # 1024 Kilobytes
     }
}

Grub would naturally create an MBR signature in the first sector, no 
partition table, but bootloader code (boot.img).

The result is this:

5182: libblkid: LOWPROBE: [16] LVM2_member:
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       magic sboff=536, kboff=0
5182: libblkid: LOWPROBE:       call probefunc()
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE: assigning UUID [superblocks]
5182: libblkid: LOWPROBE: wiper set to superblocks::LVM2_member off=0 
size=8192
5182: libblkid: LOWPROBE: assigning TYPE [superblocks]
5182: libblkid: LOWPROBE: <-- leaving probing loop (type=LVM2_member) 
[SUBLKS idx=16]
5182: libblkid: LOWPROBE: freeing values list
5182: libblkid: LOWPROBE: chain safeprobe topology DISABLED
5182: libblkid: LOWPROBE: chain safeprobe partitions ENABLED
5182: libblkid: LOWPROBE: reseting partitions values
5182: libblkid: LOWPROBE: --> starting probing loop [PARTS idx=-1]
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       magic sboff=510, kboff=0
5182: libblkid: LOWPROBE: dos: ---> call probefunc()
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       magic sboff=0, kboff=0
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x21e3160
5182: libblkid: LOWPROBE: previously wiped area modified  -- ignore 
previous results
5182: libblkid: LOWPROBE: zeroize wiper
5182: libblkid: LOWPROBE: reseting superblocks values
5182: libblkid: LOWPROBE:  free value UUID
5182: libblkid: LOWPROBE:  free value TYPE
5182: libblkid: LOWPROBE: assigning PTUUID [partitions]
5182: libblkid: LOWPROBE: dos: <--- (rc = 0)
5182: libblkid: LOWPROBE: assigning PTTYPE [partitions]
5182: libblkid: LOWPROBE: <-- leaving probing loop (type=dos) [PARTS 
idx=3]


And ...that's the real truth of it. I'm sorry, I hadn't realized it 
would be due to the bootsector.

When I wipe the bootsector actually it does find LVM2_member.

So I am sorry I didn't mention. The culprit is the Grub2 image.

5261: libblkid: LOWPROBE: [16] LVM2_member:
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE:       magic sboff=536, kboff=0
5261: libblkid: LOWPROBE:       call probefunc()
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE: assigning UUID [superblocks]
5261: libblkid: LOWPROBE: wiper set to superblocks::LVM2_member off=0 
size=8192
5261: libblkid: LOWPROBE: assigning TYPE [superblocks]
5261: libblkid: LOWPROBE: <-- leaving probing loop (type=LVM2_member) 
[SUBLKS idx=16]
5261: libblkid: LOWPROBE: freeing values list
5261: libblkid: LOWPROBE: chain safeprobe topology DISABLED
5261: libblkid: LOWPROBE: chain safeprobe partitions ENABLED
5261: libblkid: LOWPROBE: reseting partitions values
5261: libblkid: LOWPROBE: --> starting probing loop [PARTS idx=-1]
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE: gpt: ---> call probefunc()
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE: gpt: <--- (rc = 1)
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE: ultrix: ---> call probefunc()
5261: libblkid: LOWPROBE:       buffer read: off=15872 len=512 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE: ultrix: <--- (rc = 1)
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE:       buffer read: off=28672 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE:       reuse buffer: off=0 len=1024 
pr=0x1c4a0e0
5261: libblkid: LOWPROBE: <-- leaving probing loop (failed=1) [PARTS 
idx=11]
5261: libblkid: LOWPROBE: parts: start probing for partition entry
5261: libblkid: LOWPROBE: parts: end probing for partition entry 
[nothing]
5261: libblkid: LOWPROBE: partitions probe done [rc=1]
5261: libblkid: LOWPROBE: 0x1c4a0e0: end probe
5261: libblkid: LOWPROBE: zeroize wiper
5261: libblkid: LOWPROBE: returning UUID value
5261: libblkid:      TAG:     found cache tag head UUID
5261: libblkid: LOWPROBE: returning TYPE value
5261: libblkid:      TAG:     found cache tag head TYPE
5261: libblkid:    PROBE: /dev/sda: devno 0x0800, type LVM2_member

Pretty good debug output, by the way.

Anyway. Thanks to Zdenek Kabelac I found this issue. He knew what was 
going on.

Regards.
